/**
 * Script para extraer datos de clientes ACTIVOS desde BigQuery
 * y generar los archivos JSON usados por la página de Clientes.
 *
 * Filtra por: eco_aval_dim_estado_cliente.client_st_tp_ds = 'A-Cliente Activo'
 *
 * Uso:
 *   1. Instalar dependencia:  npm install @google-cloud/bigquery
 *   2. Autenticarse:          gcloud auth application-default login
 *   3. Ejecutar:              node scripts/fetch-active-clients.mjs
 */

import { BigQuery } from '@google-cloud/bigquery';
import { writeFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const DATA_DIR = join(__dirname, '..', 'src', 'data');

const bigquery = new BigQuery({ projectId: 'adl-analytics-project' });

// ─── Helpers ────────────────────────────────────────────────────────────────
async function runQuery(sql) {
  const [rows] = await bigquery.query({ query: sql, location: 'US' });
  return rows;
}

function save(filename, data) {
  const path = join(DATA_DIR, filename);
  writeFileSync(path, JSON.stringify(data, null, 2) + '\n', 'utf-8');
  console.log(`✅  ${filename}  (${data.length} registros)`);
}

// ─── 1. Clientes por Entidad ────────────────────────────────────────────────
async function fetchClientesPorEntidad() {
  const sql = `
    SELECT
      c.entidad,
      COUNT(DISTINCT c.users) AS usuarios_unicos_PN
    FROM \`adl-analytics-project.sica_analytics.eco_aval_fct_clientes\` c
    INNER JOIN \`adl-analytics-project.sica_analytics.eco_aval_dim_estado_cliente\` e
      ON c.client_st_tp_cd = e.client_st_tp_cd
    WHERE e.client_st_tp_ds = 'A-Cliente Activo'
    GROUP BY c.entidad
    ORDER BY usuarios_unicos_PN DESC
  `;
  const rows = await runQuery(sql);
  save('clientesPorEntidad.json', rows);
}

// ─── 2. Clientes por Género ─────────────────────────────────────────────────
async function fetchClientesPorGenero() {
  const sql = `
    SELECT
      COALESCE(g.gender_tp_ds, 'Sin información') AS gender,
      COUNT(DISTINCT c.users) AS usuarios_unicos_PN
    FROM \`adl-analytics-project.sica_analytics.eco_aval_fct_clientes\` c
    INNER JOIN \`adl-analytics-project.sica_analytics.eco_aval_dim_estado_cliente\` e
      ON c.client_st_tp_cd = e.client_st_tp_cd
    LEFT JOIN \`adl-analytics-project.sica_analytics.eco_aval_dim_gender\` g
      ON c.gender_tp_code = g.gender_tp_code
    WHERE e.client_st_tp_ds = 'A-Cliente Activo'
    GROUP BY gender
    ORDER BY usuarios_unicos_PN DESC
  `;
  const rows = await runQuery(sql);
  save('clientesPorGenero.json', rows);
}

// ─── 3. Clientes por Entidad y Mes ──────────────────────────────────────────
async function fetchClientesPorEntidadMes() {
  const sql = `
    SELECT
      FORMAT_DATE('%Y-%m', c.date_cruce) AS month,
      c.entidad,
      COUNT(DISTINCT c.users) AS usuarios_unicos_PN
    FROM \`adl-analytics-project.sica_analytics.eco_aval_fct_clientes\` c
    INNER JOIN \`adl-analytics-project.sica_analytics.eco_aval_dim_estado_cliente\` e
      ON c.client_st_tp_cd = e.client_st_tp_cd
    WHERE e.client_st_tp_ds = 'A-Cliente Activo'
    GROUP BY month, c.entidad
    ORDER BY month, c.entidad
  `;
  const rows = await runQuery(sql);

  // Pivotear: de filas (month, entidad, count) a objetos { month, BBOG, BAVV, ... }
  const pivoted = {};
  for (const row of rows) {
    if (!pivoted[row.month]) pivoted[row.month] = { month: row.month };
    pivoted[row.month][row.entidad] = row.usuarios_unicos_PN;
  }
  const result = Object.values(pivoted).sort((a, b) => a.month.localeCompare(b.month));
  save('clientesPorEntidadMes.json', result);
}

// ─── 4. Género por Entidad ──────────────────────────────────────────────────
async function fetchGeneroPorEntidad() {
  const sql = `
    SELECT
      c.entidad,
      COALESCE(g.gender_tp_ds, 'Sin información') AS gender,
      COUNT(DISTINCT c.users) AS usuarios_unicos_PN
    FROM \`adl-analytics-project.sica_analytics.eco_aval_fct_clientes\` c
    INNER JOIN \`adl-analytics-project.sica_analytics.eco_aval_dim_estado_cliente\` e
      ON c.client_st_tp_cd = e.client_st_tp_cd
    LEFT JOIN \`adl-analytics-project.sica_analytics.eco_aval_dim_gender\` g
      ON c.gender_tp_code = g.gender_tp_code
    WHERE e.client_st_tp_ds = 'A-Cliente Activo'
    GROUP BY c.entidad, gender
    ORDER BY c.entidad, usuarios_unicos_PN DESC
  `;
  const rows = await runQuery(sql);
  save('generoPorEntidad.json', rows);
}

// ─── Main ───────────────────────────────────────────────────────────────────
async function main() {
  console.log('🔄  Extrayendo datos de clientes ACTIVOS desde BigQuery...\n');
  console.log('   Filtro: eco_aval_dim_estado_cliente.client_st_tp_ds = "A-Cliente Activo"\n');

  try {
    await fetchClientesPorEntidad();
    await fetchClientesPorGenero();
    await fetchClientesPorEntidadMes();
    await fetchGeneroPorEntidad();
    console.log('\n🎉  Todos los archivos JSON han sido actualizados con datos de clientes activos.');
  } catch (err) {
    console.error('\n❌  Error:', err.message);
    console.error('\nAsegúrate de:');
    console.error('  1. Tener instalado @google-cloud/bigquery:  npm install @google-cloud/bigquery');
    console.error('  2. Estar autenticado:  gcloud auth application-default login');
    console.error('  3. Tener permisos sobre el proyecto adl-analytics-project');
    process.exit(1);
  }
}

main();
