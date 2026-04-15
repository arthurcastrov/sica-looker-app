import React from 'react';
import { NavLink } from 'react-router-dom';
import avalLogo from '../assets/aval-logo.jpeg';

export const Navbar = () => {
  return (
    <header className="top-header">
      <div className="header-top-row">
        <div className="header-title-container">
          <h1 className="header-title">Resumen Gerencial Visión Aval</h1>
          <span className="header-badge">Executive Briefing</span>
        </div>
        <img src={avalLogo} alt="Grupo AVAL" className="header-logo" />
      </div>

      <div className="filters-row">
        <div className="filter-group">
          <label>Año</label>
          <select defaultValue="2026">
            <option value="2026">2026</option>
            <option value="2025">2025</option>
          </select>
        </div>
        <div className="filter-group">
          <label>Períodos</label>
          <select defaultValue="2026-3">
            <option value="2026-3">2026-03</option>
            <option value="2026-2">2026-02</option>
          </select>
        </div>
        <div className="filter-group">
          <label>Entidad</label>
          <select defaultValue="Todas">
            <option value="Todas">Todas</option>
            <option value="BAVV">BAVV</option>
            <option value="BBOG">BBOG</option>
            <option value="BOCC">BOCC</option>
            <option value="BPOP">BPOP</option>
            <option value="DALE">DALE</option>
          </select>
        </div>
      </div>

      <div className="tabs-container">
        <NavLink to="/" end className={({ isActive }) => `tab-button ${isActive ? 'active' : ''}`}>Indicadores Negocio</NavLink>
        <button className="tab-button">Indicadores Riesgo</button>
        <NavLink to="/clientes" className={({ isActive }) => `tab-button ${isActive ? 'active' : ''}`}>Indicadores Clientes</NavLink>
      </div>
    </header>
  );
};
