import React from 'react';
import { ArrowUpRight, ArrowDownRight } from 'lucide-react';

const EntityRow = ({ entity }) => (
  <div className="entity-item">
    <div className="entity-name-container">
      <div className={`entity-dot dot-${entity.id}`}></div>
      <span>{entity.name}</span>
      <span className="entity-pct">{entity.val}</span>
    </div>
    <div className="entity-value-container">
      <span className={`badge ${entity.isPositive ? 'success' : 'danger'}`}>
        {entity.isPositive ? <ArrowUpRight size={12} /> : <ArrowDownRight size={12} />}
        {entity.pct}%
      </span>
    </div>
  </div>
);

export const BreakdownCard = ({ title, totalValue, totalPct, isPositive, entities }) => {
  return (
    <div className="breakdown-card">
      <div className="breakdown-header">
        <span className="breakdown-title">{title}</span>
        <a href="#" className="breakdown-link">Ver Participación de Mercado</a>
      </div>
      
      <div className="breakdown-main-value">
        <span className="kpi-value">{totalValue}</span>
        <span className={`badge ${isPositive ? 'success' : 'danger'}`}>
          {isPositive ? <ArrowUpRight size={16} /> : <ArrowDownRight size={16} />}
          {totalPct}%
        </span>
      </div>

      <div className="entity-list">
        {entities.map(e => (
          <EntityRow key={e.id} entity={e} />
        ))}
      </div>

      <button className="btn-primary">
        Ver detalle y comparar
      </button>
    </div>
  );
};
