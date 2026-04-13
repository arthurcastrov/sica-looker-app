import React from 'react';
import { KpiCard } from '../components/KpiCard';
import { BreakdownCard } from '../components/BreakdownCard';

export const Dashboard = () => {
  const kpiDataRates = [
    { title: 'Ingresos', value: '$34.725.766', pct: '22,38', isPositive: true },
    { title: 'Costo de Fondeo', value: '6,58%', pct: '0,07', isPositive: true },
    { title: 'NIM (Margen de Interés Neto)', value: '$34.725.766', pct: '22,38', isPositive: true },
    { title: 'Tasa de Colocación', value: '$34.725.766', pct: '22,38', isPositive: false },
  ];

  const kpiDataEfficiency = [
    { title: 'ROE (Return on Equity)', value: '6,02%', pct: '22,38', isPositive: true },
    { title: 'ROA (Retorno sobre activos)', value: '0,60%', pct: '0,07', isPositive: true },
    { title: 'Margen Financiero', value: '$34.725.766', pct: '22,38', isPositive: true },
    { title: 'Ratio Eficiencia', value: '$34.725.766', pct: '22,38', isPositive: false },
  ];

  const breakdownEntities = [
    { id: 'BAVV', name: 'BAVV', val: '2,30%', pct: '0.01', isPositive: true },
    { id: 'BBOG', name: 'BBOG', val: '12,51%', pct: '0.10', isPositive: false },
    { id: 'BOCC', name: 'BOCC', val: '7,02%', pct: '0.04', isPositive: false },
    { id: 'BPOP', name: 'BPOP', val: '3,17%', pct: '0.01', isPositive: false },
  ];

  const breakdownData = [
    { 
      title: 'Cartera', 
      totalValue: '$173.391.598', 
      totalPct: '0,82', 
      isPositive: true,
      entities: breakdownEntities 
    },
    { 
      title: 'Captaciones', 
      totalValue: '$172.520.469.484', 
      totalPct: '0,68', 
      isPositive: false,
      entities: breakdownEntities 
    },
    { 
      title: 'Desembolsos', 
      totalValue: '$172.520.469.484', 
      totalPct: '0,68', 
      isPositive: false,
      entities: breakdownEntities 
    }
  ];

  return (
    <div className="page-content">
      
      {/* Sección 1: KPIs */}
      <section>
        <h2 className="section-title">¿Cómo están mis indicadores claves de negocio y mis indicadores de Rentabilidad? (Período 2025-09)</h2>
        <div className="kpi-container">
          
          <div className="kpi-row">
            <h3 className="kpi-row-title">Tasas (Definir)</h3>
            <div className="kpi-grid">
              {kpiDataRates.map((d, i) => (
                <KpiCard key={i} {...d} />
              ))}
              <a href="#" className="compare-link">Comparar</a>
            </div>
          </div>

          <div className="kpi-row" style={{ marginBottom: 0 }}>
            <h3 className="kpi-row-title">Indicadores de eficiencia</h3>
            <div className="kpi-grid">
              {kpiDataEfficiency.map((d, i) => (
                <KpiCard key={i} {...d} />
              ))}
              <a href="#" className="compare-link">Comparar</a>
            </div>
          </div>

        </div>
      </section>

      {/* Sección 2: Desgloses */}
      <section>
        <h2 className="section-title">¿Cómo esta mi cartera, captaciones y desembolso? ¿Cuál es mi participación en el mercado? (Período 2025-09)</h2>
        <div className="breakdown-grid">
          {breakdownData.map((b, i) => (
            <BreakdownCard key={i} {...b} />
          ))}
        </div>
      </section>

    </div>
  );
};
