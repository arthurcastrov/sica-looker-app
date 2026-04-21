# ============================================================
# Vista: Buró PJ - Aval
# Fuente DAX: eco_aval_buro_aval_pj
# displayFolder: Buro_PJ (sección aval)
# ============================================================

view: buro_aval_pj {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_buro_aval_pj` ;;

  dimension: num_id { type: string sql: ${TABLE}.num_id ;; label: "Número ID" }
  dimension: tipo_id { type: string sql: ${TABLE}.tipo_id ;; label: "Tipo ID" }
  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: periodo { type: string sql: ${TABLE}.periodo ;; label: "Periodo" }
  dimension_group: date_cruce {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.date_cruce ;;
    label: "Fecha Cruce"
    datatype: date
  }

  dimension: banco_act_total_saldo_dim { hidden: yes type: number sql: ${TABLE}.banco_act_total_saldo ;; }
  dimension: banco_act_cant_oblig_dim { hidden: yes type: number sql: ${TABLE}.banco_act_cant_oblig ;; }
  dimension: sistema_saldo_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.sistema_saldo_obligaciones_tot ;; }

  # ---- MEASURES ----

  # DAX: $_cant_clientes_aval_pj = DISTINCTCOUNT(num_id)
  measure: cant_clientes_aval_pj {
    type: count_distinct
    sql: ${num_id} ;;
    label: "Clientes Aval PJ"
    description: "DAX: $_cant_clientes_aval_pj"
    value_format: "#,##0"
  }

  # DAX: $_saldo_total_obligaciones_b_aval_pj = SUM(banco_act_total_saldo)
  measure: saldo_obligaciones_aval_pj {
    type: sum
    sql: ${banco_act_total_saldo_dim} ;;
    label: "Saldo Obligaciones Aval PJ"
    description: "DAX: $_saldo_total_obligaciones_b_aval_pj"
    value_format: "$#,##0"
  }

  # DAX: $_saldo_total_obligaciones_sistema_aval_pj = SUM(sistema_saldo_obligaciones_tot)
  measure: saldo_sistema_aval_pj {
    type: sum
    sql: ${sistema_saldo_obligaciones_tot_dim} ;;
    label: "Saldo Obligaciones Sistema PJ"
    description: "DAX: $_saldo_total_obligaciones_sistema_aval_pj"
    value_format: "$#,##0"
  }

  # DAX: %_part_cartera_pj = DIVIDE(saldo_cartera, sistema)
  measure: pct_part_cartera_pj {
    type: number
    sql: SAFE_DIVIDE(${saldo_obligaciones_aval_pj}, ${saldo_sistema_aval_pj}) ;;
    label: "% Part. Cartera PJ"
    description: "DAX: %_part_cartera_pj"
    value_format: "0.00%"
  }

  # DAX: $_average_carteraCliente_aval_PJ = DIVIDE(cant_oblig, clientes)
  measure: avg_cartera_cliente_aval_pj {
    type: number
    sql: SAFE_DIVIDE(SUM(${banco_act_cant_oblig_dim}), COUNT(DISTINCT ${num_id})) ;;
    label: "Promedio Cartera/Cliente PJ"
    description: "DAX: $_average_carteraCliente_aval_PJ"
    value_format: "0.00"
  }

  measure: total_cant_obligaciones_pj {
    type: sum
    sql: ${banco_act_cant_oblig_dim} ;;
    label: "Cant. Obligaciones Aval PJ"
    value_format: "#,##0"
  }
}
