# ============================================================
# Vista: Buró PN - Bancos (Sistema Financiero)
# Fuente DAX: eco_aval_buro_bancos
# displayFolder: 3. Buro PN
# ============================================================

view: buro_bancos_pn {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_buro_bancos` ;;

  # ---- DIMENSIONES ----

  dimension: tipo_id {
    type: string
    sql: ${TABLE}.tipo_id ;;
    label: "Tipo Identificación"
  }

  dimension: num_id {
    type: string
    sql: ${TABLE}.num_id ;;
    label: "Número Identificación"
  }

  dimension: tipo_persona {
    type: string
    sql: ${TABLE}.tipo_persona ;;
    label: "Tipo Persona"
  }

  dimension: act_calificacion {
    type: string
    sql: ${TABLE}.act_calificacion ;;
    label: "Calificación"
  }

  dimension: periodo {
    type: string
    sql: ${TABLE}.periodo ;;
    label: "Periodo"
  }

  dimension: entidad_final {
    type: string
    sql: ${TABLE}.entidad_final ;;
    label: "Entidad Final"
  }

  dimension: entidad {
    type: string
    sql: ${TABLE}.entidad ;;
    label: "Entidad"
  }

  dimension: rango_edad {
    type: string
    sql: ${TABLE}.rango_edad ;;
    label: "Rango Edad"
  }

  dimension: gender_tp_code {
    type: string
    sql: ${TABLE}.gender_tp_code ;;
    label: "Cod Género"
  }

  dimension: marital_st_tp_cd {
    type: string
    sql: ${TABLE}.marital_st_tp_cd ;;
    label: "Cod Estado Civil"
  }

  dimension: rango_salario {
    type: string
    sql: ${TABLE}.rango_salario ;;
    label: "Rango Salario"
  }

  dimension: tipocotizante {
    type: string
    sql: ${TABLE}.tipocotizante ;;
    label: "Tipo Cotizante"
  }

  dimension: empleado_aval {
    type: string
    sql: ${TABLE}.empleado_aval ;;
    label: "Empleado Aval"
  }

  dimension: empleado_aval_txt {
    type: string
    sql: ${TABLE}.empleado_aval_txt ;;
    label: "Empleado Aval (Texto)"
  }

  dimension: rango_principalidad {
    type: string
    sql: ${TABLE}.rango_principalidad ;;
    label: "Rango Principalidad"
  }

  dimension: nomina_bavv {
    type: string
    sql: ${TABLE}.nomina_bavv ;;
    label: "Nómina BAVV"
  }

  dimension: nomina_bbog {
    type: string
    sql: ${TABLE}.nomina_bbog ;;
    label: "Nómina BBOG"
  }

  dimension: nomina_bocc {
    type: string
    sql: ${TABLE}.nomina_bocc ;;
    label: "Nómina BOCC"
  }

  dimension: nomina_bpop {
    type: string
    sql: ${TABLE}.nomina_bpop ;;
    label: "Nómina BPOP"
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

  # Columnas numéricas ocultas para measures
  dimension: flag_buro_dim { hidden: yes type: number sql: ${TABLE}.flag_buro ;; }
  dimension: principalidad_dim { hidden: yes type: number sql: ${TABLE}.principalidad ;; }
  dimension: salariomensual_dim { hidden: yes type: number sql: ${TABLE}.salariomensual ;; }
  dimension: aho_cant_productos_dim { hidden: yes type: number sql: ${TABLE}.aho_cant_productos ;; }
  dimension: aho_saldo_actual_dim { hidden: yes type: number sql: ${TABLE}.aho_saldo_actual ;; }
  dimension: aho_saldo_promedio_dim { hidden: yes type: number sql: ${TABLE}.aho_saldo_promedio ;; }
  dimension: cor_cant_productos_dim { hidden: yes type: number sql: ${TABLE}.cor_cant_productos ;; }
  dimension: cor_saldo_actual_dim { hidden: yes type: number sql: ${TABLE}.cor_saldo_actual ;; }
  dimension: cor_saldo_promedio_dim { hidden: yes type: number sql: ${TABLE}.cor_saldo_promedio ;; }
  dimension: cdt_cant_productos_dim { hidden: yes type: number sql: ${TABLE}.cdt_cant_productos ;; }
  dimension: cdt_saldo_actual_dim { hidden: yes type: number sql: ${TABLE}.cdt_saldo_actual ;; }
  dimension: act_max_dias_mora_dim { hidden: yes type: number sql: ${TABLE}.act_max_dias_mora ;; }
  dimension: bocc_cant_depositos_tot_dim { hidden: yes type: number sql: ${TABLE}.bocc_cant_depositos_tot ;; }
  dimension: bocc_cant_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.bocc_cant_obligaciones_tot ;; }
  dimension: bocc_saldo_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.bocc_saldo_obligaciones_tot ;; }
  dimension: bocc_saldo_depositos_tot_dim { hidden: yes type: number sql: ${TABLE}.bocc_saldo_depositos_tot ;; }
  dimension: cant_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.cant_obligaciones_tot ;; }
  dimension: cant_obligaciones_tdc_dim { hidden: yes type: number sql: ${TABLE}.cant_obligaciones_tdc ;; }
  dimension: cant_obligaciones_hip_dim { hidden: yes type: number sql: ${TABLE}.cant_obligaciones_hip ;; }
  dimension: saldo_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.saldo_obligaciones_tot ;; }
  dimension: saldo_obligaciones_tdc_dim { hidden: yes type: number sql: ${TABLE}.saldo_obligaciones_tdc ;; }
  dimension: saldo_obligaciones_hip_dim { hidden: yes type: number sql: ${TABLE}.saldo_obligaciones_hip ;; }
  dimension: act_hipotecario_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_hipotecario_saldo ;; }
  dimension: act_libranza_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_libranza_saldo ;; }
  dimension: act_libre_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_libre_saldo ;; }
  dimension: act_tc_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_tc_saldo ;; }
  dimension: act_otros_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_otros_saldo ;; }
  dimension: act_hipotecario_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_hipotecario_cant_oblig ;; }
  dimension: act_libranza_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_libranza_cant_oblig ;; }
  dimension: act_libre_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_libre_cant_oblig ;; }
  dimension: act_tc_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_tc_cant_oblig ;; }
  dimension: act_otros_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_otros_cant_oblig ;; }

  # ---- MEASURES (displayFolder: 3. Buro PN) ----

  # DAX: $_saldo_cartera_bdb_cap3 = CALCULATE(SUM(bocc_saldo_obligaciones_tot), entidad = "bbog")
  measure: saldo_cartera_bbog {
    type: sum
    sql: ${bocc_saldo_obligaciones_tot_dim} ;;
    label: "Saldo Cartera BBOG"
    description: "DAX: $_saldo_cartera_bdb_cap3"
    filters: [entidad: "bbog"]
    value_format: "$#,##0"
  }

  # DAX: $_saldo_cartera_bocc_cap3
  measure: saldo_cartera_bocc {
    type: sum
    sql: ${bocc_saldo_obligaciones_tot_dim} ;;
    label: "Saldo Cartera BOCC"
    filters: [entidad: "bocc"]
    value_format: "$#,##0"
  }

  # DAX: $_saldo_cartera_bavv_cap3
  measure: saldo_cartera_bavv {
    type: sum
    sql: ${bocc_saldo_obligaciones_tot_dim} ;;
    label: "Saldo Cartera BAVV"
    filters: [entidad: "bavv"]
    value_format: "$#,##0"
  }

  # DAX: $_saldo_cartera_bpop_cap3
  measure: saldo_cartera_bpop {
    type: sum
    sql: ${bocc_saldo_obligaciones_tot_dim} ;;
    label: "Saldo Cartera BPOP"
    filters: [entidad: "bpop"]
    value_format: "$#,##0"
  }

  # DAX: %_part_cartera_bdb
  measure: pct_part_cartera_bbog {
    type: number
    sql: SAFE_DIVIDE(${saldo_cartera_bbog},
      SUM(CASE WHEN ${entidad} = 'bbog' THEN ${saldo_obligaciones_tot_dim} ELSE 0 END)
    ) ;;
    label: "% Part. Cartera BBOG"
    value_format: "0.00%"
  }

  # DAX: %_part_cartera_bocc
  measure: pct_part_cartera_bocc {
    type: number
    sql: SAFE_DIVIDE(${saldo_cartera_bocc},
      SUM(CASE WHEN ${entidad} = 'bocc' THEN ${saldo_obligaciones_tot_dim} ELSE 0 END)
    ) ;;
    label: "% Part. Cartera BOCC"
    value_format: "0.00%"
  }

  # DAX: %_part_cartera_bavv
  measure: pct_part_cartera_bavv {
    type: number
    sql: SAFE_DIVIDE(${saldo_cartera_bavv},
      SUM(CASE WHEN ${entidad} = 'bavv' THEN ${saldo_obligaciones_tot_dim} ELSE 0 END)
    ) ;;
    label: "% Part. Cartera BAVV"
    value_format: "0.00%"
  }

  # DAX: %_part_cartera_bpop
  measure: pct_part_cartera_bpop {
    type: number
    sql: SAFE_DIVIDE(${saldo_cartera_bpop},
      SUM(CASE WHEN ${entidad} = 'bpop' THEN ${saldo_obligaciones_tot_dim} ELSE 0 END)
    ) ;;
    label: "% Part. Cartera BPOP"
    value_format: "0.00%"
  }

  # DAX: %_participación_cant_cartera_bancos = DIVIDE(bocc_cant_obligaciones, cant_obligaciones_tot)
  measure: pct_participacion_cant_cartera {
    type: number
    sql: SAFE_DIVIDE(SUM(${bocc_cant_obligaciones_tot_dim}), SUM(${cant_obligaciones_tot_dim})) ;;
    label: "% Part. Cant. Cartera Bancos"
    description: "DAX: %_participación_cant_cartera_bancos"
    value_format: "0.00%"
  }

  # DAX: $_average_antProducto_tdcSF_bancos = AVERAGE(cant_obligaciones_tdc)
  measure: avg_cant_obligaciones_tdc {
    type: average
    sql: ${cant_obligaciones_tdc_dim} ;;
    label: "Promedio Obligaciones TDC (SF)"
    description: "DAX: $_average_antProducto_tdcSF_bancos"
    value_format: "0.00"
  }

  # DAX: $_saldo_tdc_sf_cap3_bancos = SUM(saldo_obligaciones_tdc)
  measure: saldo_tdc_sf {
    type: sum
    sql: ${saldo_obligaciones_tdc_dim} ;;
    label: "Saldo TDC (SF)"
    description: "DAX: $_saldo_tdc_sf_cap3_bancos"
    value_format: "$#,##0"
  }

  # DAX: $_saldo_act_tc_aval_banco = SUM(act_tc_saldo)
  measure: saldo_act_tc_aval {
    type: sum
    sql: ${act_tc_saldo_dim} ;;
    label: "Saldo TC Aval (Bancos)"
    value_format: "$#,##0"
  }

  # DAX: %_part_rotativo_avalSF_bancos = DIVIDE(saldo_act_tc, saldo_tdc_sf)
  measure: pct_part_rotativo_aval_sf {
    type: number
    sql: SAFE_DIVIDE(${saldo_act_tc_aval}, ${saldo_tdc_sf}) ;;
    label: "% Part. Rotativo Aval/SF"
    description: "DAX: %_part_rotativo_avalSF_bancos"
    value_format: "0%"
  }

  # DAX: %_part_cartera_general = saldo_obligaciones_tot filtered bavv
  measure: saldo_obligaciones_tot_bavv {
    type: sum
    sql: ${saldo_obligaciones_tot_dim} ;;
    label: "Saldo Obligaciones BAVV"
    filters: [entidad: "bavv"]
    value_format: "$#,##0"
  }

  # Saldos por tipo de producto - Aval
  measure: saldo_act_hipotecario {
    type: sum
    sql: ${act_hipotecario_saldo_dim} ;;
    label: "Saldo Hipotecario Aval"
    value_format: "$#,##0"
  }

  measure: saldo_act_libranza {
    type: sum
    sql: ${act_libranza_saldo_dim} ;;
    label: "Saldo Libranza Aval"
    value_format: "$#,##0"
  }

  measure: saldo_act_libre {
    type: sum
    sql: ${act_libre_saldo_dim} ;;
    label: "Saldo Libre Inversión Aval"
    value_format: "$#,##0"
  }

  measure: saldo_act_otros {
    type: sum
    sql: ${act_otros_saldo_dim} ;;
    label: "Saldo Otros Aval"
    value_format: "$#,##0"
  }

  # Cantidades de obligaciones
  measure: total_cant_obligaciones {
    type: sum
    sql: ${cant_obligaciones_tot_dim} ;;
    label: "Total Cant. Obligaciones"
    value_format: "#,##0"
  }

  measure: total_saldo_obligaciones {
    type: sum
    sql: ${saldo_obligaciones_tot_dim} ;;
    label: "Total Saldo Obligaciones"
    value_format: "$#,##0"
  }

  # Depósitos
  measure: total_cant_depositos_bocc {
    type: sum
    sql: ${bocc_cant_depositos_tot_dim} ;;
    label: "Cant. Depósitos BOCC"
    value_format: "#,##0"
  }

  measure: total_saldo_depositos_bocc {
    type: sum
    sql: ${bocc_saldo_depositos_tot_dim} ;;
    label: "Saldo Depósitos BOCC"
    value_format: "$#,##0"
  }

  # Ahorros
  measure: saldo_ahorros {
    type: sum
    sql: ${aho_saldo_actual_dim} ;;
    label: "Saldo Ahorros"
    value_format: "$#,##0"
  }

  measure: cant_ahorros {
    type: sum
    sql: ${aho_cant_productos_dim} ;;
    label: "Cant. Ahorros"
    value_format: "#,##0"
  }

  # Corriente
  measure: saldo_corriente {
    type: sum
    sql: ${cor_saldo_actual_dim} ;;
    label: "Saldo Corriente"
    value_format: "$#,##0"
  }

  measure: cant_corriente {
    type: sum
    sql: ${cor_cant_productos_dim} ;;
    label: "Cant. Corriente"
    value_format: "#,##0"
  }

  # CDT
  measure: saldo_cdt {
    type: sum
    sql: ${cdt_saldo_actual_dim} ;;
    label: "Saldo CDT"
    value_format: "$#,##0"
  }

  measure: cant_cdt {
    type: sum
    sql: ${cdt_cant_productos_dim} ;;
    label: "Cant. CDT"
    value_format: "#,##0"
  }

  # Promedio salario
  measure: avg_salario {
    type: average
    sql: ${salariomensual_dim} ;;
    label: "Promedio Salario Mensual"
    value_format: "$#,##0"
  }

  # Principalidad
  measure: avg_principalidad {
    type: average
    sql: ${principalidad_dim} ;;
    label: "Promedio Principalidad"
    value_format: "0.00"
  }

  measure: count_clientes {
    type: count_distinct
    sql: ${num_id} ;;
    label: "Clientes Únicos Buró"
    value_format: "#,##0"
  }
}
