import React from 'react';
import { NavLink } from 'react-router-dom';
import { LayoutDashboard, BarChart2, FileText, Calculator } from 'lucide-react';

export const Sidebar = () => {
  return (
    <aside className="sidebar">
      <div className="sidebar-logo">S.I.C.A</div>
      <nav className="sidebar-menu">
        <NavLink to="/" end className={({ isActive }) => `sidebar-item ${isActive ? 'active' : ''}`}>
          <LayoutDashboard size={22} />
        </NavLink>
        <NavLink to="/clientes" className={({ isActive }) => `sidebar-item ${isActive ? 'active' : ''}`}>
          <BarChart2 size={22} />
        </NavLink>
        <div className="sidebar-item">
          <FileText size={22} />
        </div>
        <div className="sidebar-item">
          <Calculator size={22} />
        </div>
      </nav>
    </aside>
  );
};
