# ============================================================
# Vista: TC Productos
# Fuente DAX: eco_aval_tc_productos
# displayFolder: TC Productos
# ============================================================

view: tc_productos {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_tc_productos` ;;

  dimension: franquicia { type: string sql: ${TABLE}.franquicia ;; label: "Franquicia" }
  dimension: bin { type: string sql: ${TABLE}.bin ;; label: "BIN" }
  dimension: estado { type: string sql: ${TABLE}.estado ;; label: "Estado" }
  dimension: cod_bloqueo { type: string sql: ${TABLE}.cod_bloqueo ;; label: "Código Bloqueo" }
  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension_group: fecha_corte {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha_corte ;;
    label: "Fecha Corte"
    datatype: date
  }
  dimension_group: fecha_carga {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha_carga ;;
    label: "Fecha Carga"
  }

  dimension: avg_num_dias_mora_dim { hidden: yes type: number sql: ${TABLE}.avg_num_dias_mora ;; }
  dimension: avg_cupo_dim { hidden: yes type: number sql: ${TABLE}.avg_cupo ;; }
  dimension: avg_deuda_actual_dim { hidden: yes type: number sql: ${TABLE}.avg_deuda_actual ;; }
  dimension: avg_cupo_disponible_dim { hidden: yes type: number sql: ${TABLE}.avg_cupo_disponible ;; }
  dimension: sum_cupo_dim { hidden: yes type: number sql: ${TABLE}.sum_cupo ;; }
  dimension: sum_deuda_actual_dim { hidden: yes type: number sql: ${TABLE}.sum_deuda_actual ;; }
  dimension: sum_cupo_disponible_dim { hidden: yes type: number sql: ${TABLE}.sum_cupo_disponible ;; }
  dimension: cantidad_tarjetas_dim { hidden: yes type: number sql: ${TABLE}.cantidad_tarjetas ;; }
  dimension: cantidad_usuarios_dim { hidden: yes type: number sql: ${TABLE}.cantidad_usuarios ;; }

  # ---- MEASURES ----

  # DAX: $_tc_cantTarjetas = SUM(cantidad_tarjetas)
  measure: total_tarjetas {
    type: sum
    sql: ${cantidad_tarjetas_dim} ;;
    label: "Total Tarjetas"
    description: "DAX: $_tc_cantTarjetas"
    value_format: "#,##0"
  }

  # DAX: $_tc_cantUsuarios = SUM(cantidad_usuarios)
  measure: total_usuarios {
    type: sum
    sql: ${cantidad_usuarios_dim} ;;
    label: "Total Usuarios TC"
    description: "DAX: $_tc_cantUsuarios"
    value_format: "#,##0"
  }

  # DAX: $_tc_sumCupo = SUM(sum_cupo)
  measure: total_cupo {
    type: sum
    sql: ${sum_cupo_dim} ;;
    label: "Total Cupo"
    description: "DAX: $_tc_sumCupo"
    value_format: "$#,##0"
  }

  # DAX: $_tc_sumDeuda = SUM(sum_deuda_actual)
  measure: total_deuda {
    type: sum
    sql: ${sum_deuda_actual_dim} ;;
    label: "Total Deuda Actual"
    description: "DAX: $_tc_sumDeuda"
    value_format: "$#,##0"
  }

  # DAX: $_tc_sumCupoDisponible = SUM(sum_cupo_disponible)
  measure: total_cupo_disponible {
    type: sum
    sql: ${sum_cupo_disponible_dim} ;;
    label: "Total Cupo Disponible"
    description: "DAX: $_tc_sumCupoDisponible"
    value_format: "$#,##0"
  }

  # DAX: $_tc_avgCupo = AVERAGE(avg_cupo)
  measure: promedio_cupo {
    type: average
    sql: ${avg_cupo_dim} ;;
    label: "Promedio Cupo"
    value_format: "$#,##0"
  }

  # DAX: $_tc_avgDeuda = AVERAGE(avg_deuda_actual)
  measure: promedio_deuda {
    type: average
    sql: ${avg_deuda_actual_dim} ;;
    label: "Promedio Deuda"
    value_format: "$#,##0"
  }

  # DAX: $_tc_avgCupoDisponible = AVERAGE(avg_cupo_disponible)
  measure: promedio_cupo_disponible {
    type: average
    sql: ${avg_cupo_disponible_dim} ;;
    label: "Promedio Cupo Disponible"
    value_format: "$#,##0"
  }

  # DAX: $_tc_avgDiasMora = AVERAGE(avg_num_dias_mora)
  measure: promedio_dias_mora {
    type: average
    sql: ${avg_num_dias_mora_dim} ;;
    label: "Promedio Días Mora"
    value_format: "0.0"
  }

  # DAX: %_tc_uso_cupo = DIVIDE(deuda, cupo)
  measure: pct_uso_cupo {
    type: number
    sql: SAFE_DIVIDE(${total_deuda}, ${total_cupo}) ;;
    label: "% Uso Cupo"
    description: "DAX: %_tc_uso_cupo"
    value_format: "0.00%"
  }

  # DAX: $_tc_promTarjetas_usuario = DIVIDE(tarjetas, usuarios)
  measure: promedio_tarjetas_usuario {
    type: number
    sql: SAFE_DIVIDE(${total_tarjetas}, ${total_usuarios}) ;;
    label: "Promedio Tarjetas/Usuario"
    value_format: "0.00"
  }
}
