# ============================================================
# Vista: Depósitos Reporte
# Fuente DAX: eco_aval_fct_depositos_reporte
# displayFolder: Saldos
# ============================================================

view: depositos_reporte {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_fct_depositos_reporte` ;;

  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: tipo_deposito { type: string sql: ${TABLE}.tipo_deposito ;; label: "Tipo Depósito" }
  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension_group: date_cruce {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.date_cruce ;;
    label: "Fecha Cruce"
    datatype: date
  }
  dimension: saldo_dim { hidden: yes type: number sql: ${TABLE}.saldo ;; }
  dimension: cantidad_dim { hidden: yes type: number sql: ${TABLE}.cantidad ;; }

  measure: total_saldo { type: sum sql: ${saldo_dim} ;; label: "Saldo Depósitos" value_format: "$#,##0" }
  measure: total_cantidad { type: sum sql: ${cantidad_dim} ;; label: "Cant. Depósitos" value_format: "#,##0" }
  measure: avg_saldo_deposito {
    type: number
    sql: SAFE_DIVIDE(${total_saldo}, ${total_cantidad}) ;;
    label: "Promedio Saldo/Depósito"
    value_format: "$#,##0"
  }
}
