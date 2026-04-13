import React from 'react';
import { LayoutDashboard, BarChart2, FileText, Calculator } from 'lucide-react';

export const Sidebar = () => {
  return (
    <aside className="sidebar">
      <div className="sidebar-logo">
        S.I.C.A
      </div>
      <div className="sidebar-menu">
        <div className="sidebar-item active">
          <LayoutDashboard size={24} />
        </div>
        <div className="sidebar-item">
          <BarChart2 size={24} />
        </div>
        <div className="sidebar-item">
          <FileText size={24} />
        </div>
        <div className="sidebar-item">
          <Calculator size={24} />
        </div>
      </div>
    </aside>
  );
};
