# ============================================================
# Vista: Aportes Empresas (Nómina y Penetración)
# Fuente DAX: eco_aval_ael_clientes_aval
# displayFolder: 7. aportes empresas
# ============================================================

view: aportes_empresas {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_ael_clientes_aval` ;;

  dimension: tipoidaportante_id { type: string sql: ${TABLE}.tipoidaportante_id ;; label: "Tipo ID Aportante" }
  dimension: numeroidaportante { type: string sql: ${TABLE}.numeroidaportante ;; label: "Número ID Aportante" }
  dimension: razonsocialaportante { type: string sql: ${TABLE}.razonsocialaportante ;; label: "Razón Social Aportante" }
  dimension: tipoidempleado_id { type: string sql: ${TABLE}.tipoidempleado_id ;; label: "Tipo ID Empleado" }
  dimension: numeroidempleado { type: string sql: ${TABLE}.numeroidempleado ;; label: "Número ID Empleado" }
  dimension: nombre_empleado { type: string sql: ${TABLE}.nombre_empleado ;; label: "Nombre Empleado" }
  dimension: tipocotizante { type: string sql: ${TABLE}.tipocotizante ;; label: "Tipo Cotizante" }
  dimension: nombreadministradoraccf { type: string sql: ${TABLE}.nombreadministradoraccf ;; label: "Administradora CCF" }
  dimension: nombreadministradoraeps { type: string sql: ${TABLE}.nombreadministradoraeps ;; label: "Administradora EPS" }
  dimension: nombreadministradoraafp { type: string sql: ${TABLE}.nombreadministradoraafp ;; label: "Administradora AFP" }
  dimension: ciudad { type: string sql: ${TABLE}.ciudad ;; label: "Ciudad" }
  dimension: ciudadempleado { type: string sql: ${TABLE}.ciudadempleado ;; label: "Ciudad Empleado" }
  dimension: departamentoempleado { type: string sql: ${TABLE}.departamentoempleado ;; label: "Departamento Empleado" }
  dimension: codigoactividadeconomica { type: string sql: ${TABLE}.codigoactividadeconomica ;; label: "Código Act. Económica" }
  dimension: descripcionclaseaportante { type: string sql: ${TABLE}.descripcionclaseaportante ;; label: "Clase Aportante" }
  dimension: anio_mes { type: string sql: ${TABLE}.anio_mes ;; label: "Año-Mes" }
  dimension: rango_salario { type: string sql: ${TABLE}.rango_salario ;; label: "Rango Salario" }
  dimension: cuenta_aho_cte { type: string sql: ${TABLE}.cuenta_aho_cte ;; label: "Cuenta Ahorro/Corriente" }
  dimension: nomina_aval_pn { type: string sql: ${TABLE}.nomina_aval_pn ;; label: "Nómina Aval PN" }
  dimension: nomina_bavv { type: string sql: ${TABLE}.nomina_bavv ;; label: "Nómina BAVV" }
  dimension: nomina_bbog { type: string sql: ${TABLE}.nomina_bbog ;; label: "Nómina BBOG" }
  dimension: nomina_bocc { type: string sql: ${TABLE}.nomina_bocc ;; label: "Nómina BOCC" }
  dimension: nomina_bpop { type: string sql: ${TABLE}.nomina_bpop ;; label: "Nómina BPOP" }
  dimension: cuentas_aho_cte_pj_bavv { type: string sql: ${TABLE}.cuentas_aho_cte_pj_bavv ;; label: "Cuenta PJ BAVV" }
  dimension: cuentas_aho_cte_pj_bbog { type: string sql: ${TABLE}.cuentas_aho_cte_pj_bbog ;; label: "Cuenta PJ BBOG" }
  dimension: cuentas_aho_cte_pj_bocc { type: string sql: ${TABLE}.cuentas_aho_cte_pj_bocc ;; label: "Cuenta PJ BOCC" }
  dimension: cuentas_aho_cte_pj_bpop { type: string sql: ${TABLE}.cuentas_aho_cte_pj_bpop ;; label: "Cuenta PJ BPOP" }
  dimension_group: fecha {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha ;;
    label: "Fecha"
    datatype: date
  }
  dimension_group: date_cruce {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.date_cruce ;;
    label: "Fecha Cruce"
    datatype: date
  }
  dimension_group: fecha_carga {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha_carga ;;
    label: "Fecha Carga"
  }

  # Flags numéricos ocultos
  dimension: flag_bocc_pn_dim { hidden: yes type: number sql: ${TABLE}.flag_bocc_pn ;; }
  dimension: flag_bavv_pn_dim { hidden: yes type: number sql: ${TABLE}.flag_bavv_pn ;; }
  dimension: flag_bpop_pn_dim { hidden: yes type: number sql: ${TABLE}.flag_bpop_pn ;; }
  dimension: flag_bbog_pn_dim { hidden: yes type: number sql: ${TABLE}.flag_bbog_pn ;; }
  dimension: flag_bocc_pj_dim { hidden: yes type: number sql: ${TABLE}.flag_bocc_pj ;; }
  dimension: flag_bavv_pj_dim { hidden: yes type: number sql: ${TABLE}.flag_bavv_pj ;; }
  dimension: flag_bpop_pj_dim { hidden: yes type: number sql: ${TABLE}.flag_bpop_pj ;; }
  dimension: flag_bbog_pj_dim { hidden: yes type: number sql: ${TABLE}.flag_bbog_pj ;; }
  dimension: flag_aval_pn_dim { hidden: yes type: number sql: ${TABLE}.flag_aval_pn ;; }
  dimension: flag_aval_pj_dim { hidden: yes type: number sql: ${TABLE}.flag_aval_pj ;; }
  dimension: salariomensual_dim { hidden: yes type: number sql: ${TABLE}.salariomensual ;; }
  dimension: numeroempleados_dim { hidden: yes type: number sql: ${TABLE}.numeroempleados ;; }

  # ---- MEASURES ----

  # DAX: $_aportes_empresas_aval = DISTINCTCOUNT(numeroidaportante) WHERE flag_aval_pj=1
  measure: aportes_empresas_aval {
    type: count_distinct
    sql: CASE WHEN ${flag_aval_pj_dim} = 1 THEN ${numeroidaportante} END ;;
    label: "Empresas Aval"
    description: "DAX: $_aportes_empresas_aval"
    value_format: "#,##0"
  }

  # DAX: $_aportes_empresas_no = DISTINCTCOUNT(numeroidaportante)
  measure: aportes_empresas_total {
    type: count_distinct
    sql: ${numeroidaportante} ;;
    label: "Total Empresas"
    description: "DAX: $_aportes_empresas_no"
    value_format: "#,##0"
  }

  # DAX: $_aportes_personas_no = DISTINCTCOUNT(numeroidempleado)
  measure: aportes_personas_total {
    type: count_distinct
    sql: ${numeroidempleado} ;;
    label: "Total Personas"
    description: "DAX: $_aportes_personas_no"
    value_format: "#,##0"
  }

  # DAX: $_aportes_personas_aval = DISTINCTCOUNT(empleado) WHERE any_flag_pn=1
  measure: aportes_personas_aval {
    type: count_distinct
    sql: CASE WHEN ${flag_bavv_pn_dim} = 1 OR ${flag_bbog_pn_dim} = 1 OR ${flag_bocc_pn_dim} = 1 OR ${flag_bpop_pn_dim} = 1
      THEN ${numeroidempleado} END ;;
    label: "Personas Aval"
    description: "DAX: $_aportes_personas_aval"
    value_format: "#,##0"
  }

  # DAX: $_aportes_personas_nomina = DISTINCTCOUNT(empleado) WHERE nomina_aval_pn='1'
  measure: aportes_personas_nomina {
    type: count_distinct
    sql: CASE WHEN ${nomina_aval_pn} = '1' THEN ${numeroidempleado} END ;;
    label: "Personas con Nómina"
    description: "DAX: $_aportes_personas_nomina"
    value_format: "#,##0"
  }

  # DAX: %_part_aval = DIVIDE(personas_aval, personas_total)
  measure: pct_part_aval {
    type: number
    sql: SAFE_DIVIDE(${aportes_personas_aval}, ${aportes_personas_total}) ;;
    label: "% Part. Aval"
    description: "DAX: %_part_aval"
    value_format: "0.00%"
  }

  # DAX: %_part_aval_empresas = DIVIDE(empresas_aval, empresas_total)
  measure: pct_part_aval_empresas {
    type: number
    sql: SAFE_DIVIDE(${aportes_empresas_aval}, ${aportes_empresas_total}) ;;
    label: "% Part. Aval Empresas"
    description: "DAX: %_part_aval_empresas"
    value_format: "0.00%"
  }

  # Participación por banco - Personas
  measure: pct_part_bbog {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${flag_bbog_pn_dim} = 1 THEN ${numeroidempleado} END),
      ${aportes_personas_aval}
    ) ;;
    label: "% Part. BBOG (Personas)"
    description: "DAX: %_part_bbog"
    value_format: "0.00%"
  }

  measure: pct_part_bavv {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${flag_bavv_pn_dim} = 1 THEN ${numeroidempleado} END),
      ${aportes_personas_aval}
    ) ;;
    label: "% Part. BAVV (Personas)"
    value_format: "0.00%"
  }

  measure: pct_part_bocc {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${flag_bocc_pn_dim} = 1 THEN ${numeroidempleado} END),
      ${aportes_personas_aval}
    ) ;;
    label: "% Part. BOCC (Personas)"
    value_format: "0.00%"
  }

  measure: pct_part_bpop {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${flag_bpop_pn_dim} = 1 THEN ${numeroidempleado} END),
      ${aportes_personas_aval}
    ) ;;
    label: "% Part. BPOP (Personas)"
    value_format: "0.00%"
  }

  # Participación por banco - Empresas
  measure: pct_part_bbog_empresas {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${flag_bbog_pj_dim} = 1 THEN ${numeroidaportante} END),
      ${aportes_empresas_aval}
    ) ;;
    label: "% Part. BBOG (Empresas)"
    value_format: "0.00%"
  }

  measure: pct_part_bavv_empresas {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${flag_bavv_pj_dim} = 1 THEN ${numeroidaportante} END),
      ${aportes_empresas_aval}
    ) ;;
    label: "% Part. BAVV (Empresas)"
    value_format: "0.00%"
  }

  measure: pct_part_bocc_empresas {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${flag_bocc_pj_dim} = 1 THEN ${numeroidaportante} END),
      ${aportes_empresas_aval}
    ) ;;
    label: "% Part. BOCC (Empresas)"
    value_format: "0.00%"
  }

  measure: pct_part_bpop_empresas {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${flag_bpop_pj_dim} = 1 THEN ${numeroidaportante} END),
      ${aportes_empresas_aval}
    ) ;;
    label: "% Part. BPOP (Empresas)"
    value_format: "0.00%"
  }

  # Participación nómina
  measure: pct_part_nomina {
    type: number
    sql: SAFE_DIVIDE(${aportes_personas_nomina}, ${aportes_personas_total}) ;;
    label: "% Nómina / Total"
    description: "DAX: %_part_nomina"
    value_format: "0.00%"
  }

  # Nómina por banco
  measure: pct_part_bbog_nomina {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${nomina_bbog} = '1' THEN ${numeroidempleado} END),
      ${aportes_personas_nomina}
    ) ;;
    label: "% Part. BBOG (Nómina)"
    description: "DAX: %_part_bbog_nom"
    value_format: "0.00%"
  }

  measure: pct_part_bavv_nomina {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${nomina_bavv} = '1' THEN ${numeroidempleado} END),
      ${aportes_personas_nomina}
    ) ;;
    label: "% Part. BAVV (Nómina)"
    value_format: "0.00%"
  }

  measure: pct_part_bocc_nomina {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${nomina_bocc} = '1' THEN ${numeroidempleado} END),
      ${aportes_personas_nomina}
    ) ;;
    label: "% Part. BOCC (Nómina)"
    value_format: "0.00%"
  }

  measure: pct_part_bpop_nomina {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN ${nomina_bpop} = '1' THEN ${numeroidempleado} END),
      ${aportes_personas_nomina}
    ) ;;
    label: "% Part. BPOP (Nómina)"
    value_format: "0.00%"
  }

  # Salarios
  measure: avg_salario {
    type: average
    sql: CASE WHEN ${salariomensual_dim} != 0 THEN ${salariomensual_dim} END ;;
    label: "Promedio Salario"
    description: "DAX: $_avg_aportes_salarios"
    value_format: "$#,##0"
  }

  measure: total_salarios {
    type: sum
    sql: ${salariomensual_dim} ;;
    label: "Total Salarios"
    description: "DAX: $_toal_aportes_salarios"
    value_format: "$#,##0"
  }

  measure: max_empleados {
    type: max
    sql: ${numeroempleados_dim} ;;
    label: "Max Empleados"
    value_format: "#,##0"
  }
}
