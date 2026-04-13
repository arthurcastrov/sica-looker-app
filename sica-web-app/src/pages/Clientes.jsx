import React, { useMemo } from 'react';
import { User, CreditCard } from 'lucide-react';
import { PieChart, Pie, Cell, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend } from 'recharts';

// Real Looker data (filtered by A-Cliente Activo)
import clientesPorEntidad from '../data/clientesPorEntidad.json';
import clientesPorGenero from '../data/clientesPorGenero.json';
import clientesPorEntidadMes from '../data/clientesPorEntidadMes.json';
import generoPorEntidad from '../data/generoPorEntidad.json';

const ENTITY_COLORS = {
  BBOG: '#FBBF24',
  BAVV: '#DC2626',
  BOCC: '#3B82F6',
  BPOP: '#10B981',
  DALE: '#111827',
};

const formatNumber = (n) => n?.toLocaleString('es-CO') ?? '—';

export const Clientes = () => {
  // Total AVAL = sum of all entities
  const totalAval = useMemo(() =>
    clientesPorEntidad.reduce((acc, e) => acc + e.usuarios_unicos_PN, 0), []);

  // Pie chart data
  const pieData = useMemo(() =>
    clientesPorEntidad.map(e => ({
      name: e.entidad,
      value: e.usuarios_unicos_PN,
      color: ENTITY_COLORS[e.entidad] || '#9CA3AF',
    })), []);

  // Gender data (only M and F, excluding nulls)
  const genderKnown = useMemo(() =>
    clientesPorGenero.filter(g => g.gender === 'Masculino' || g.gender === 'Femenino'), []);
  const totalGenderKnown = useMemo(() =>
    genderKnown.reduce((acc, g) => acc + g.usuarios_unicos_PN, 0), [genderKnown]);

  // Gender by entity (only banks with known gender data)
  const genderByEntity = useMemo(() => {
    const entities = ['BBOG', 'BAVV', 'BOCC', 'BPOP'];
    return entities.map(ent => {
      const masc = generoPorEntidad.find(g => g.entidad === ent && g.gender === 'Masculino')?.usuarios_unicos_PN || 0;
      const fem = generoPorEntidad.find(g => g.entidad === ent && g.gender === 'Femenino')?.usuarios_unicos_PN || 0;
      const total = masc + fem;
      return {
        entidad: ent,
        color: ENTITY_COLORS[ent],
        femPct: total > 0 ? ((fem / total) * 100).toFixed(2) : 0,
        mascPct: total > 0 ? ((masc / total) * 100).toFixed(2) : 0,
      };
    });
  }, []);

  // Cohort table: last available month per entity
  const latestMonth = useMemo(() => {
    const sorted = [...clientesPorEntidadMes].sort((a, b) => b.month.localeCompare(a.month));
    return sorted[0]?.month || '';
  }, []);

  const entities = ['BAVV', 'BBOG', 'BOCC', 'BPOP', 'DALE'];
  const lastMonths = useMemo(() => {
    const months = [...new Set(clientesPorEntidadMes.map(d => d.month))].sort().slice(-5);
    return months;
  }, []);

  return (
    <div className="page-content">
      {/* Sub-navegación */}
      <section className="secondary-nav">
        <div className="sub-tabs">
          <div className="sub-tab active">
            <User size={20} />
            <span>Clientes</span>
          </div>
          <div className="sub-tab">
            <CreditCard size={20} />
            <span>Productos y saldos</span>
          </div>
        </div>
        <div className="filter-group" style={{ flexDirection: 'row', alignItems: 'center', gap: '1rem' }}>
          <label style={{ margin: 0 }}>Filtrar por</label>
          <select defaultValue="Persona Natural">
            <option value="Persona Natural">Persona Natural</option>
            <option value="Empresa">Empresa</option>
          </select>
        </div>
      </section>

      {/* Encabezado Clientes*/}
      <section>
        <h2 className="section-title" style={{ fontSize: '1.25rem', marginBottom: '0.5rem' }}>¿Cómo se comportan mis clientes?</h2>
        <p style={{ color: 'var(--text-muted)', marginBottom: '1.5rem', fontSize: '0.9rem' }}>
          ¿Cómo se distribuyen los clientes entre las Entidades del Grupo? A continuación podrás ver la cantidad de clientes activos de Aval y por entidad.
        </p>
      </section>

      {/* Fila Superior */}
      <section className="clientes-top-row">
        {/* Tarjeta Aval */}
        <div className="kpi-container aval-overview-card">
          <div className="aval-total-col">
            <div className="brand-logo" style={{ alignItems: 'flex-start', fontSize: '1.5rem', marginBottom: '1rem' }}>
              <small>Grupo</small>
              <span>AVAL</span>
            </div>
            <div className="kpi-value" style={{ fontSize: '1.5rem' }}>{formatNumber(totalAval)}</div>
            <div className="kpi-title" style={{ marginTop: '0.25rem' }}>Clientes Activos</div>
          </div>
          <div className="aval-entities-grid">
            {clientesPorEntidad.map(e => (
              <div key={e.entidad} className="entity-mini-card">
                <div className="entity-circle-mock" style={{ backgroundColor: ENTITY_COLORS[e.entidad] || '#E5E7EB' }} />
                <div>
                  <div className="kpi-value" style={{ fontSize: '1rem' }}>{formatNumber(e.usuarios_unicos_PN)}</div>
                  <div className="kpi-title">Clientes {e.entidad}</div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Tabla Cohorte */}
        <div className="kpi-container p-0 overflow-hidden">
          <table className="cohort-table">
            <thead>
              <tr>
                <th>Bancos</th>
                {lastMonths.map(m => <th key={m}>{m}</th>)}
              </tr>
            </thead>
            <tbody>
              {entities.map(ent => (
                <tr key={ent}>
                  <td>
                    <div className="entity-name-container">
                      <div className="entity-dot" style={{ backgroundColor: ENTITY_COLORS[ent] }}></div>
                      <strong>{ent}</strong>
                    </div>
                  </td>
                  {lastMonths.map(m => {
                    const row = clientesPorEntidadMes.find(d => d.month === m);
                    return <td key={m}>{row?.[ent] ? formatNumber(row[ent]) : '—'}</td>;
                  })}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>

      {/* Fila Media: Gráficos */}
      <section style={{ display: 'grid', gridTemplateColumns: 'minmax(300px, 350px) 1fr', gap: '1.5rem', marginBottom: '2rem' }}>
        {/* Donut */}
        <div className="kpi-container" style={{ display: 'flex', flexDirection: 'column' }}>
          <h3 style={{ fontSize: '1rem', marginBottom: '1rem', color: 'var(--text-main)' }}>Cantidad de Clientes</h3>
          <div style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap', marginBottom: '1rem', fontSize: '0.75rem', fontWeight: 600 }}>
            {pieData.map(entry => (
              <span key={entry.name} style={{ display: 'flex', alignItems: 'center', gap: '0.25rem', color: 'var(--text-muted)' }}>
                <div style={{ width: 8, height: 8, borderRadius: '50%', backgroundColor: entry.color }} />
                {entry.name}
              </span>
            ))}
          </div>
          <div style={{ flex: 1, display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
            <PieChart width={220} height={220}>
              <Pie data={pieData} innerRadius={60} outerRadius={80} paddingAngle={2} dataKey="value" label={({ name, percent }) => `${name} (${(percent * 100).toFixed(1)}%)`}>
                {pieData.map((entry, index) => <Cell key={`cell-${index}`} fill={entry.color} />)}
              </Pie>
              <Tooltip formatter={(v) => formatNumber(v)} />
            </PieChart>
          </div>
        </div>

        {/* Line Chart */}
        <div className="kpi-container" style={{ display: 'flex', flexDirection: 'column' }}>
          <h3 style={{ fontSize: '1rem', color: 'var(--text-main)', marginBottom: '1.5rem' }}>Evolución en tiempos de mis clientes</h3>
          <div style={{ flex: 1, minHeight: 280 }}>
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={clientesPorEntidadMes} margin={{ top: 5, right: 20, left: 20, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#E5E7EB" />
                <XAxis dataKey="month" tick={{ fontSize: 10 }} />
                <YAxis tick={{ fontSize: 10 }} tickFormatter={(v) => `${(v / 1000000).toFixed(1)}M`} />
                <Tooltip formatter={(v) => formatNumber(v)} />
                <Legend />
                {Object.entries(ENTITY_COLORS).map(([name, color]) => (
                  <Line key={name} type="monotone" dataKey={name} stroke={color} strokeWidth={2} dot={{ r: 2 }} connectNulls />
                ))}
              </LineChart>
            </ResponsiveContainer>
          </div>
        </div>
      </section>

      {/* Fila Inferior: Género */}
      <section style={{ display: 'grid', gridTemplateColumns: '1fr 2fr', gap: '1.5rem', marginBottom: '2rem' }}>
        {/* Distribución general */}
        <div className="kpi-container">
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
            <h3 style={{ fontSize: '1rem', color: 'var(--text-main)', margin: 0 }}>Distribución de género AVAL</h3>
            <div style={{ display: 'flex', gap: '1rem', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}><div style={{ width: 8, height: 8, borderRadius: '50%', backgroundColor: '#FCA5A5' }}/> Femenino</span>
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}><div style={{ width: 8, height: 8, borderRadius: '50%', backgroundColor: '#60A5FA' }}/> Masculino</span>
            </div>
          </div>
          <div style={{ display: 'flex', gap: '2rem' }}>
            {genderKnown.filter(g => g.gender === 'Femenino').map(g => (
              <div key={g.gender} style={{ flex: 1 }}>
                <div style={{ fontSize: '1.25rem', fontWeight: 'bold', marginBottom: '0.5rem' }}>{formatNumber(g.usuarios_unicos_PN)}</div>
                <div style={{ height: 12, backgroundColor: '#FCA5A5', width: `${(g.usuarios_unicos_PN / totalGenderKnown * 100).toFixed(0)}%`, borderRadius: 2 }}></div>
              </div>
            ))}
            {genderKnown.filter(g => g.gender === 'Masculino').map(g => (
              <div key={g.gender} style={{ flex: 1 }}>
                <div style={{ fontSize: '1.25rem', fontWeight: 'bold', marginBottom: '0.5rem' }}>{formatNumber(g.usuarios_unicos_PN)}</div>
                <div style={{ height: 12, backgroundColor: '#60A5FA', width: `${(g.usuarios_unicos_PN / totalGenderKnown * 100).toFixed(0)}%`, borderRadius: 2 }}></div>
              </div>
            ))}
          </div>
        </div>

        {/* Distribución por Entidades */}
        <div className="kpi-container">
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
            <h3 style={{ fontSize: '1rem', color: 'var(--text-main)', margin: 0 }}>Distribución de género en las entidades</h3>
            <div style={{ display: 'flex', gap: '1rem', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}><div style={{ width: 8, height: 8, borderRadius: '50%', backgroundColor: '#FCA5A5' }}/> Femenino</span>
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}><div style={{ width: 8, height: 8, borderRadius: '50%', backgroundColor: '#60A5FA' }}/> Masculino</span>
            </div>
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
            {genderByEntity.map(row => (
              <div key={row.entidad} style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                <div style={{ width: '60px', display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.8rem', fontWeight: 600 }}>
                  <div style={{ width: 6, height: 6, borderRadius: '50%', backgroundColor: row.color }} />
                  {row.entidad}
                </div>
                <div style={{ flex: 1, display: 'flex', height: 16, borderRadius: 4, overflow: 'hidden' }}>
                  <div style={{ width: `${row.femPct}%`, backgroundColor: '#FCA5A5', display: 'flex', alignItems: 'center', justifyContent: 'center', color: 'white', fontSize: '0.7rem' }}>{row.femPct}%</div>
                  <div style={{ width: `${row.mascPct}%`, backgroundColor: '#60A5FA', display: 'flex', alignItems: 'center', justifyContent: 'center', color: 'white', fontSize: '0.7rem' }}>{row.mascPct}%</div>
                </div>
              </div>
            ))}
            <div style={{ textAlign: 'center', fontSize: '0.75rem', fontWeight: 600, marginTop: '0.5rem' }}>Cantidad de clientes</div>
          </div>
        </div>
      </section>
    </div>
  );
};
