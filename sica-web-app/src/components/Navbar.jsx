import React from 'react';
import { FileText } from 'lucide-react';
import { NavLink } from 'react-router-dom';

export const Navbar = () => {
  return (
    <header className="top-header">
      {/* Título y Logo */}
      <div className="header-top-row">
        <div className="header-title-container">
          <FileText size={28} color="#111827" />
          <h1 className="header-title">Resumen Gerencial Visión Aval</h1>
        </div>
        <div className="brand-logo">
          <small>Grupo</small>
          <span>AVAL</span>
        </div>
      </div>

      {/* Filtros */}
      <div className="filters-row">
        <div className="filter-group">
          <label>Año</label>
          <select defaultValue="2025">
            <option value="2025">2025</option>
            <option value="2024">2024</option>
          </select>
        </div>
        <div className="filter-group">
          <label>Períodos</label>
          <select defaultValue="2025-9">
            <option value="2025-9">2025-9</option>
            <option value="2025-8">2025-8</option>
          </select>
        </div>
        <div className="filter-group">
          <label>Entidad</label>
          <select defaultValue="Todas">
            <option value="Todas">Todas</option>
            <option value="Bogota">Bogotá</option>
          </select>
        </div>
      </div>

      {/* Tabs */}
      <div className="tabs-container">
        <NavLink to="/" end className={({ isActive }) => (isActive ? "tab-button active" : "tab-button")}>Indicadores Negocio</NavLink>
        <button className="tab-button">Indicadores Riesgo</button>
        <NavLink to="/clientes" className={({ isActive }) => (isActive ? "tab-button active" : "tab-button")}>Indicadores Clientes</NavLink>
      </div>
    </header>
  );
};
