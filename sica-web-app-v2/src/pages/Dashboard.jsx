import React from 'react';
import { TrendingUp, TrendingDown, ArrowRight } from 'lucide-react';

const KpiCard = ({ title, value, pct, isPositive }) => (
  <div className="kpi-card animate-in">
    <div className="kpi-label">{title}</div>
    <div className="kpi-value">{value}</div>
    <span className={`kpi-badge ${isPositive ? 'positive' : 'negative'}`}>
      {isPositive ? <TrendingUp size={12} /> : <TrendingDown size={12} />}
      {isPositive ? '+' : ''}{pct}%
    </span>
  </div>
);

const ENTITY_COLORS = {
  BAVV: '#DC2626', BBOG: '#FBBF24', BOCC: '#3B82F6', BPOP: '#10B981', DALE: '#111827',
};

const breakdownEntities = [
  { id: 'BAVV', val: '2,30%', pct: '0.01', isPositive: true },
  { id: 'BBOG', val: '12,51%', pct: '0.10', isPositive: false },
  { id: 'BOCC', val: '7,02%', pct: '0.04', isPositive: false },
  { id: 'BPOP', val: '3,17%', pct: '0.01', isPositive: false },
];

const BreakdownCard = ({ title, totalValue, totalPct, isPositive, accentColor }) => (
  <div className="breakdown-card animate-in">
    <div className="breakdown-card-accent" style={{ background: accentColor }} />
    <div style={{ paddingLeft: '0.75rem' }}>
      <div className="kpi-label">{title}</div>
      <div className="breakdown-total">{totalValue}</div>
      <span className={`kpi-badge ${isPositive ? 'positive' : 'negative'}`}>
        {isPositive ? '+' : '-'}{totalPct}%
      </span>
      <div style={{ marginTop: '1.25rem' }}>
        {breakdownEntities.map(e => (
          <div className="entity-row" key={e.id}>
            <span className="entity-name">
              <span className="entity-dot" style={{ backgroundColor: ENTITY_COLORS[e.id] }} />
              {e.id}
            </span>
            <span className="entity-val">{e.val}</span>
            <span className={`kpi-badge ${e.isPositive ? 'positive' : 'negative'}`} style={{ fontSize: '0.65rem' }}>
              {e.isPositive ? '+' : '-'}{e.pct}%
            </span>
          </div>
        ))}
      </div>
      <button className="btn-primary">
        Ver detalle y comparar
      </button>
    </div>
  </div>
);

export const Dashboard = () => {
  const kpiRates = [
    { title: 'Ingresos', value: '$34.725.766', pct: '22,38', isPositive: true },
    { title: 'Costo de Fondeo', value: '6,58%', pct: '0,07', isPositive: true },
    { title: 'NIM (Margen de Interés Neto)', value: '$34.725.766', pct: '22,38', isPositive: true },
    { title: 'Tasa de Colocación', value: '$34.725.766', pct: '22,38', isPositive: false },
  ];

  const kpiEfficiency = [
    { title: 'ROE (Return on Equity)', value: '6,02%', pct: '22,38', isPositive: true },
    { title: 'ROA (Retorno sobre activos)', value: '0,60%', pct: '0,07', isPositive: true },
    { title: 'Margen Financiero', value: '$34.725.766', pct: '22,38', isPositive: true },
    { title: 'Ratio Eficiencia', value: '$34.725.766', pct: '22,38', isPositive: false },
  ];

  return (
    <div className="page-content">
      {/* Section 1: KPIs */}
      <section className="section-gap">
        <h2 className="section-title">¿Cómo están mis indicadores claves de negocio y de Rentabilidad?</h2>
        <div className="section-period">📅 Período Reportado: Marzo, 2026</div>

        <div className="card" style={{ marginBottom: '1.5rem' }}>
          <div className="kpi-row">
            <div className="kpi-row-header">
              <h3 className="kpi-row-title">Tasas</h3>
            </div>
            <div className="kpi-grid">
              {kpiRates.map((d, i) => <KpiCard key={i} {...d} />)}
            </div>
          </div>

          <div className="kpi-row" style={{ marginBottom: 0 }}>
            <div className="kpi-row-header">
              <h3 className="kpi-row-title">Indicadores de eficiencia</h3>
            </div>
            <div className="kpi-grid">
              {kpiEfficiency.map((d, i) => <KpiCard key={i} {...d} />)}
            </div>
          </div>
        </div>
      </section>

      {/* Section 2: Breakdowns */}
      <section className="section-gap">
        <h2 className="section-title">¿Cómo está mi cartera, captaciones y desembolso?</h2>
        <p className="section-subtitle">Análisis detallado por entidad financiera del grupo.</p>
        <div className="breakdown-grid">
          <BreakdownCard title="Cartera" totalValue="$173.391.598" totalPct="0,82" isPositive={true} accentColor="var(--bbog)" />
          <BreakdownCard title="Captaciones" totalValue="$172.520.469.484" totalPct="0,68" isPositive={false} accentColor="var(--bocc)" />
          <BreakdownCard title="Desembolsos" totalValue="$172.520.469.484" totalPct="0,68" isPositive={false} accentColor="var(--bpop)" />
        </div>
      </section>

    </div>
  );
};
