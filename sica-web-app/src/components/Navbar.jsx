import React from 'react';
import { FileText } from 'lucide-react';
import { NavLink } from 'react-router-dom';
import avalLogo from '../assets/aval-logo.jpeg';

export const Navbar = () => {
  return (
    <header className="top-header">
      {/* Título y Logo */}
      <div className="header-top-row">
        <div className="header-title-container">
          <FileText size={28} color="#111827" />
          <h1 className="header-title">Resumen Gerencial Visión Aval</h1>
        </div>
        <img src={avalLogo} alt="Grupo AVAL" style={{ width: '80px', objectFit: 'contain' }} />
      </div>

      {/* Filtros */}
      <div className="filters-row">
        <div className="filter-group">
          <label>Año</label>
          <select defaultValue="2025">
            <option value="2026">2026</option>
            <option value="2025">2025</option>
          </select>
        </div>
        <div className="filter-group">
          <label>Períodos</label>
          <select defaultValue="2025-9">
            <option value="2026-3">2026-03</option>
            <option value="2026-2">2026-02</option>
          </select>
        </div>
        <div className="filter-group">
          <label>Entidad</label>
          <select defaultValue="Todas">
            <option value="Todas">Todas</option>
            <option value="Bogota">BAVV</option>
            <option value="Bogota">BBOG</option>
            <option value="Bogota">BOCC</option>
            <option value="Bogota">BPOP</option>
            <option value="Bogota">DALE</option>
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
