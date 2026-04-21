# ============================================================
# Vista: Buró PJ - Bancos
# Fuente DAX: eco_aval_buro_bancos_pj
# displayFolder: Buro_PJ
# ============================================================

view: buro_bancos_pj {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_buro_bancos_pj` ;;

  dimension: num_id { type: string sql: ${TABLE}.num_id ;; label: "Número ID" }
  dimension: tipo_id { type: string sql: ${TABLE}.tipo_id ;; label: "Tipo ID" }
  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: entidad_final { type: string sql: ${TABLE}.entidad_final ;; label: "Entidad Final" }
  dimension: periodo { type: string sql: ${TABLE}.periodo ;; label: "Periodo" }
  dimension: act_calificacion { type: string sql: ${TABLE}.act_calificacion ;; label: "Calificación" }
  dimension_group: date_cruce {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.date_cruce ;;
    label: "Fecha Cruce"
    datatype: date
  }

  dimension: aho_saldo_actual_dim { hidden: yes type: number sql: ${TABLE}.aho_saldo_actual ;; }
  dimension: aho_cant_productos_dim { hidden: yes type: number sql: ${TABLE}.aho_cant_productos ;; }
  dimension: cor_saldo_actual_dim { hidden: yes type: number sql: ${TABLE}.cor_saldo_actual ;; }
  dimension: cor_cant_productos_dim { hidden: yes type: number sql: ${TABLE}.cor_cant_productos ;; }
  dimension: cdt_saldo_actual_dim { hidden: yes type: number sql: ${TABLE}.cdt_saldo_actual ;; }
  dimension: cdt_cant_productos_dim { hidden: yes type: number sql: ${TABLE}.cdt_cant_productos ;; }
  dimension: banco_act_total_saldo_dim { hidden: yes type: number sql: ${TABLE}.banco_act_total_saldo ;; }
  dimension: banco_act_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.banco_act_cant_oblig ;; }
  dimension: banco_saldo_dep_tot_dim { hidden: yes type: number sql: ${TABLE}.banco_saldo_dep_tot ;; }
  dimension: banco_cant_dep_tot_dim { hidden: yes type: number sql: ${TABLE}.banco_cant_dep_tot ;; }
  dimension: sistema_saldo_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.sistema_saldo_obligaciones_tot ;; }
  dimension: act_cartera_ord_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_cartera_ord_saldo ;; }
  dimension: act_cartera_ord_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_cartera_ord_cant_oblig ;; }
  dimension: act_leasing_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_leasing_saldo ;; }
  dimension: act_leasing_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_leasing_cant_oblig ;; }
  dimension: act_factoring_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_factoring_saldo ;; }
  dimension: act_factoring_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_factoring_cant_oblig ;; }
  dimension: act_sobregiro_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_sobregiro_saldo ;; }
  dimension: act_sobregiro_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_sobregiro_cant_oblig ;; }
  dimension: act_tdc_rotativo_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_tdc_rotativo_saldo ;; }
  dimension: act_tdc_rotativo_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.act_tdc_rotativo_cant_oblig ;; }

  # ---- MEASURES ----

  # DAX: $_cant_clientes_bancos_pj = DISTINCTCOUNT(num_id)
  measure: cant_clientes_bancos_pj {
    type: count_distinct
    sql: ${num_id} ;;
    label: "Clientes Buró PJ"
    description: "DAX: $_cant_clientes_bancos_pj"
    value_format: "#,##0"
  }

  # DAX: $_saldo_cartera_pj = SUM(banco_act_total_saldo)
  measure: saldo_cartera_pj {
    type: sum
    sql: ${banco_act_total_saldo_dim} ;;
    label: "Saldo Cartera PJ"
    description: "DAX: $_saldo_cartera_pj"
    value_format: "$#,##0"
  }

  # DAX: $_average_cartera_pj = DIVIDE(saldo_cartera, cant_clientes)
  measure: avg_cartera_pj {
    type: number
    sql: SAFE_DIVIDE(${saldo_cartera_pj}, ${cant_clientes_bancos_pj}) ;;
    label: "Promedio Cartera PJ"
    description: "DAX: $_average_cartera_pj"
    value_format: "$#,##0"
  }

  # Saldo cartera por entidad
  measure: saldo_cartera_pj_bbog { type: sum sql: ${banco_act_total_saldo_dim} ;; filters: [entidad: "bbog"] label: "Saldo Cartera PJ BBOG" value_format: "$#,##0" }
  measure: saldo_cartera_pj_bocc { type: sum sql: ${banco_act_total_saldo_dim} ;; filters: [entidad: "bocc"] label: "Saldo Cartera PJ BOCC" value_format: "$#,##0" }
  measure: saldo_cartera_pj_bavv { type: sum sql: ${banco_act_total_saldo_dim} ;; filters: [entidad: "bavv"] label: "Saldo Cartera PJ BAVV" value_format: "$#,##0" }
  measure: saldo_cartera_pj_bpop { type: sum sql: ${banco_act_total_saldo_dim} ;; filters: [entidad: "bpop"] label: "Saldo Cartera PJ BPOP" value_format: "$#,##0" }

  # Participación cartera por entidad vs sistema
  measure: pct_part_cartera_bbog_pj {
    type: number
    sql: SAFE_DIVIDE(${saldo_cartera_pj_bbog},
      SUM(CASE WHEN ${entidad} = 'bbog' THEN ${sistema_saldo_obligaciones_tot_dim} ELSE 0 END)) ;;
    label: "% Part. Cartera BBOG PJ"
    value_format: "0.00%"
  }

  measure: pct_part_cartera_bocc_pj {
    type: number
    sql: SAFE_DIVIDE(${saldo_cartera_pj_bocc},
      SUM(CASE WHEN ${entidad} = 'bocc' THEN ${sistema_saldo_obligaciones_tot_dim} ELSE 0 END)) ;;
    label: "% Part. Cartera BOCC PJ"
    value_format: "0.00%"
  }

  measure: pct_part_cartera_bavv_pj {
    type: number
    sql: SAFE_DIVIDE(${saldo_cartera_pj_bavv},
      SUM(CASE WHEN ${entidad} = 'bavv' THEN ${sistema_saldo_obligaciones_tot_dim} ELSE 0 END)) ;;
    label: "% Part. Cartera BAVV PJ"
    value_format: "0.00%"
  }

  measure: pct_part_cartera_bpop_pj {
    type: number
    sql: SAFE_DIVIDE(${saldo_cartera_pj_bpop},
      SUM(CASE WHEN ${entidad} = 'bpop' THEN ${sistema_saldo_obligaciones_tot_dim} ELSE 0 END)) ;;
    label: "% Part. Cartera BPOP PJ"
    value_format: "0.00%"
  }

  # Depósitos PJ
  measure: total_saldo_deposito_pj { type: sum sql: ${banco_saldo_dep_tot_dim} ;; label: "Saldo Depósitos PJ" value_format: "$#,##0" }
  measure: total_cant_depositos_pj { type: sum sql: ${banco_cant_dep_tot_dim} ;; label: "Cant. Depósitos PJ" value_format: "#,##0" }

  # Obligaciones PJ
  measure: total_saldo_obligaciones_pj { type: sum sql: ${banco_act_total_saldo_dim} ;; label: "Saldo Obligaciones PJ" value_format: "$#,##0" }
  measure: total_cant_obligaciones_pj { type: sum sql: ${banco_act_cant_oblig_dim} ;; label: "Cant. Obligaciones PJ" value_format: "#,##0" }

  # Productos por tipo
  measure: saldo_ahorros_pj { type: sum sql: ${aho_saldo_actual_dim} ;; label: "Saldo Ahorros PJ" value_format: "$#,##0" }
  measure: cant_ahorros_pj { type: sum sql: ${aho_cant_productos_dim} ;; label: "Cant. Ahorros PJ" value_format: "#,##0" }
  measure: saldo_corriente_pj { type: sum sql: ${cor_saldo_actual_dim} ;; label: "Saldo Corriente PJ" value_format: "$#,##0" }
  measure: cant_corriente_pj { type: sum sql: ${cor_cant_productos_dim} ;; label: "Cant. Corriente PJ" value_format: "#,##0" }
  measure: saldo_cdt_pj { type: sum sql: ${cdt_saldo_actual_dim} ;; label: "Saldo CDT PJ" value_format: "$#,##0" }
  measure: cant_cdt_pj { type: sum sql: ${cdt_cant_productos_dim} ;; label: "Cant. CDT PJ" value_format: "#,##0" }

  # Tipos de activo
  measure: saldo_cartera_ord_pj { type: sum sql: ${act_cartera_ord_saldo_dim} ;; label: "Saldo Cartera Ordinaria PJ" value_format: "$#,##0" }
  measure: cant_cartera_ord_pj { type: sum sql: ${act_cartera_ord_cant_oblig_dim} ;; label: "Cant. Cartera Ordinaria PJ" value_format: "#,##0" }
  measure: saldo_leasing_pj { type: sum sql: ${act_leasing_saldo_dim} ;; label: "Saldo Leasing PJ" value_format: "$#,##0" }
  measure: cant_leasing_pj { type: sum sql: ${act_leasing_cant_oblig_dim} ;; label: "Cant. Leasing PJ" value_format: "#,##0" }
  measure: saldo_factoring_pj { type: sum sql: ${act_factoring_saldo_dim} ;; label: "Saldo Factoring PJ" value_format: "$#,##0" }
  measure: cant_factoring_pj { type: sum sql: ${act_factoring_cant_oblig_dim} ;; label: "Cant. Factoring PJ" value_format: "#,##0" }
  measure: saldo_sobregiro_pj { type: sum sql: ${act_sobregiro_saldo_dim} ;; label: "Saldo Sobregiro PJ" value_format: "$#,##0" }
  measure: cant_sobregiro_pj { type: sum sql: ${act_sobregiro_cant_oblig_dim} ;; label: "Cant. Sobregiro PJ" value_format: "#,##0" }
  measure: saldo_tdc_pj { type: sum sql: ${act_tdc_rotativo_saldo_dim} ;; label: "Saldo TDC PJ" value_format: "$#,##0" }
  measure: cant_tdc_pj { type: sum sql: ${act_tdc_rotativo_cant_oblig_dim} ;; label: "Cant. TDC PJ" value_format: "#,##0" }

  # Sistema total
  measure: saldo_sistema_obligaciones_pj { type: sum sql: ${sistema_saldo_obligaciones_tot_dim} ;; label: "Saldo Obligaciones Sistema PJ" value_format: "$#,##0" }
}
