import React from 'react';
import { ArrowUpRight, ArrowDownRight } from 'lucide-react';

export const KpiCard = ({ title, value, pct, isPositive }) => {
  return (
    <div className="kpi-card">
      <div className="kpi-title">{title}</div>
      <div className="kpi-value-row">
        <span className="kpi-value">{value}</span>
        <span className={`badge ${isPositive ? 'success' : 'danger'}`}>
          {isPositive ? <ArrowUpRight size={14} /> : <ArrowDownRight size={14} />}
          {pct}%
        </span>
      </div>
    </div>
  );
};
