import React, { useMemo } from 'react';
import { User, CreditCard } from 'lucide-react';
import { PieChart, Pie, Cell, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend } from 'recharts';

import clientesPorEntidad from '../data/clientesPorEntidad.json';
import clientesPorGenero from '../data/clientesPorGenero.json';
import clientesPorEntidadMes from '../data/clientesPorEntidadMes.json';
import generoPorEntidad from '../data/generoPorEntidad.json';

import avalLogo from '../assets/aval-logo.jpeg';
import bavvLogo from '../assets/bavv-logo.jpeg';
import bbogLogo from '../assets/bbog-logo.jpeg';
import boccLogo from '../assets/bocc-logo.jpeg';
import bpopLogo from '../assets/bpop-logo.jpeg';
import daleLogo from '../assets/dale-logo.jpeg';

const ENTITY_COLORS = {
  BBOG: '#FBBF24', BAVV: '#DC2626', BOCC: '#3B82F6', BPOP: '#10B981', DALE: '#111827',
};

const ENTITY_IMAGES = {
  BAVV: bavvLogo, BBOG: bbogLogo, BOCC: boccLogo, BPOP: bpopLogo, DALE: daleLogo,
};

const formatNumber = (n) => n?.toLocaleString('es-CO') ?? '—';

export const Clientes = () => {
  const totalAval = useMemo(() => {
    const avalEntry = clientesPorEntidad.find(e => e.entidad === 'AVAL');
    return avalEntry?.usuarios_unicos_PN ?? 0;
  }, []);

  const entitiesData = useMemo(() =>
    clientesPorEntidad.filter(e => e.entidad !== 'AVAL'), []);

  const pieData = useMemo(() =>
    entitiesData.map(e => ({
      name: e.entidad,
      value: e.usuarios_unicos_PN,
      color: ENTITY_COLORS[e.entidad] || '#9CA3AF',
    })), [entitiesData]);

  const genderKnown = useMemo(() =>
    clientesPorGenero.filter(g => g.gender === 'Masculino' || g.gender === 'Femenino'), []);
  const totalGenderKnown = useMemo(() =>
    genderKnown.reduce((acc, g) => acc + g.usuarios_unicos_PN, 0), [genderKnown]);

  const genderByEntity = useMemo(() => {
    const entities = ['BBOG', 'BAVV', 'BOCC', 'BPOP'];
    return entities.map(ent => {
      const masc = generoPorEntidad.find(g => g.entidad === ent && g.gender === 'Masculino')?.usuarios_unicos_PN || 0;
      const fem = generoPorEntidad.find(g => g.entidad === ent && g.gender === 'Femenino')?.usuarios_unicos_PN || 0;
      const total = masc + fem;
      return {
        entidad: ent, color: ENTITY_COLORS[ent],
        femPct: total > 0 ? ((fem / total) * 100).toFixed(2) : 0,
        mascPct: total > 0 ? ((masc / total) * 100).toFixed(2) : 0,
      };
    });
  }, []);

  const entities = ['BAVV', 'BBOG', 'BOCC', 'BPOP', 'DALE'];
  const lastMonths = useMemo(() => {
    const months = [...new Set(clientesPorEntidadMes.map(d => d.month))].sort().slice(-5);
    return months;
  }, []);

  return (
    <div className="page-content">
      {/* Sub-navigation */}
      <div className="sub-nav">
        <div className="sub-tabs">
          <div className="sub-tab active"><User size={18} /><span>Clientes</span></div>
          <div className="sub-tab"><CreditCard size={18} /><span>Productos y saldos</span></div>
        </div>
        <div className="filter-group" style={{ flexDirection: 'row', alignItems: 'center', gap: '0.75rem' }}>
          <label style={{ margin: 0, textTransform: 'none', fontSize: '0.8rem' }}>Filtrar por</label>
          <select defaultValue="Persona Natural">
            <option value="Persona Natural">Persona Natural</option>
            <option value="Persona Jurídica">Persona Jurídica</option>
            <option value="Total">Total</option>
          </select>
        </div>
      </div>

      {/* Section Title */}
      <section className="section-gap">
        <h2 className="section-title">¿Cómo se comportan mis clientes?</h2>
        <p className="section-subtitle">
          Distribución estratégica y evolución demográfica de la base instalada a través de las entidades del Grupo Aval.
        </p>
      </section>

      {/* Top Row: AVAL Overview + Cohort Table */}
      <section className="grid-2 section-gap">
        {/* AVAL Overview Card */}
        <div className="aval-overview animate-in">
          <div className="aval-total-section">
            <img src={avalLogo} alt="Grupo AVAL" className="aval-logo" />
            <div className="aval-total-value">{formatNumber(totalAval)}</div>
            <div className="aval-total-label">Clientes Activos</div>
          </div>
          <div className="aval-entities-section">
            {entitiesData.map(e => (
              <div key={e.entidad} className="entity-mini-card">
                <img src={ENTITY_IMAGES[e.entidad]} alt={e.entidad} className="entity-logo" />
                <div>
                  <div className="entity-mini-value">{formatNumber(e.usuarios_unicos_PN)}</div>
                  <div className="entity-mini-label">Clientes {e.entidad}</div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Cohort Table */}
        <div className="card animate-in" style={{ padding: 0, overflow: 'hidden' }}>
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
                    <span className="entity-name">
                      <span className="entity-dot" style={{ backgroundColor: ENTITY_COLORS[ent] }} />
                      <strong>{ent}</strong>
                    </span>
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

      {/* Middle Row: Donut + Line Chart */}
      <section className="grid-2-1 section-gap">
        {/* Donut Chart */}
        <div className="card animate-in">
          <div className="card-title">Cantidad de Clientes</div>
          <div className="chart-legend">
            {pieData.map(entry => (
              <span key={entry.name} className="chart-legend-item">
                <span className="chart-legend-dot" style={{ backgroundColor: entry.color }} />
                {entry.name}
              </span>
            ))}
          </div>
          <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: 220 }}>
            <PieChart width={220} height={220}>
              <Pie data={pieData} innerRadius={65} outerRadius={85} paddingAngle={3} dataKey="value"
                label={({ name, percent }) => `${name} (${(percent * 100).toFixed(1)}%)`}
                labelLine={{ stroke: '#c4c6d0', strokeWidth: 1 }}>
                {pieData.map((entry, index) => <Cell key={`cell-${index}`} fill={entry.color} />)}
              </Pie>
              <Tooltip formatter={(v) => formatNumber(v)} />
            </PieChart>
          </div>
        </div>

        {/* Line Chart */}
        <div className="card animate-in">
          <div className="card-title">Evolución en tiempos de mis clientes</div>
          <div style={{ height: 280 }}>
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={clientesPorEntidadMes} margin={{ top: 5, right: 20, left: 20, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="rgba(196,198,208,0.3)" />
                <XAxis dataKey="month" tick={{ fontSize: 10, fill: '#747780' }} />
                <YAxis tick={{ fontSize: 10, fill: '#747780' }} tickFormatter={(v) => `${(v / 1000000).toFixed(1)}M`} />
                <Tooltip formatter={(v) => formatNumber(v)} />
                <Legend />
                {Object.entries(ENTITY_COLORS).map(([name, color]) => (
                  <Line key={name} type="monotone" dataKey={name} stroke={color} strokeWidth={2.5} dot={{ r: 3, strokeWidth: 2 }} connectNulls activeDot={{ r: 5 }} />
                ))}
              </LineChart>
            </ResponsiveContainer>
          </div>
        </div>
      </section>

      {/* Bottom Row: Gender */}
      <section className="grid-1-2 section-gap">
        {/* Gender AVAL */}
        <div className="card animate-in">
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
            <div className="card-title" style={{ margin: 0 }}>Distribución de género AVAL</div>
            <div className="gender-label-row">
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}><span className="gender-dot" style={{ backgroundColor: 'var(--gender-fem)' }} /> Femenino</span>
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}><span className="gender-dot" style={{ backgroundColor: 'var(--gender-masc)' }} /> Masculino</span>
            </div>
          </div>
          <div className="gender-summary">
            {genderKnown.filter(g => g.gender === 'Femenino').map(g => (
              <div key={g.gender} className="gender-item">
                <div className="gender-value">{formatNumber(g.usuarios_unicos_PN)}</div>
                <div className="gender-bar" style={{ backgroundColor: 'var(--gender-fem)', width: `${(g.usuarios_unicos_PN / totalGenderKnown * 100).toFixed(0)}%` }} />
              </div>
            ))}
            {genderKnown.filter(g => g.gender === 'Masculino').map(g => (
              <div key={g.gender} className="gender-item">
                <div className="gender-value">{formatNumber(g.usuarios_unicos_PN)}</div>
                <div className="gender-bar" style={{ backgroundColor: 'var(--gender-masc)', width: `${(g.usuarios_unicos_PN / totalGenderKnown * 100).toFixed(0)}%` }} />
              </div>
            ))}
          </div>
        </div>

        {/* Gender by Entity */}
        <div className="card animate-in">
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
            <div className="card-title" style={{ margin: 0 }}>Distribución de género en las entidades</div>
            <div className="gender-label-row">
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}><span className="gender-dot" style={{ backgroundColor: 'var(--gender-fem)' }} /> Femenino</span>
              <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}><span className="gender-dot" style={{ backgroundColor: 'var(--gender-masc)' }} /> Masculino</span>
            </div>
          </div>
          {genderByEntity.map(row => (
            <div key={row.entidad} className="gender-entity-row">
              <div className="gender-entity-name">
                <span className="entity-dot" style={{ backgroundColor: row.color }} />
                {row.entidad}
              </div>
              <div className="gender-stacked-bar">
                <div style={{ width: `${row.femPct}%`, backgroundColor: 'var(--gender-fem)' }}>{row.femPct}%</div>
                <div style={{ width: `${row.mascPct}%`, backgroundColor: 'var(--gender-masc)' }}>{row.mascPct}%</div>
              </div>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
};
