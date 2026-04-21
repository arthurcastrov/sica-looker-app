# ============================================================
# Vista: Saldos Depósitos
# Fuente DAX: eco_aval_saldos_depositos
# displayFolder: Saldos
# ============================================================

view: saldos_depositos {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_saldos_depositos` ;;

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

  measure: total_saldo { type: sum sql: ${saldo_dim} ;; label: "Saldo" value_format: "$#,##0" }
  measure: total_cantidad { type: sum sql: ${cantidad_dim} ;; label: "Cantidad" value_format: "#,##0" }
  measure: avg_saldo {
    type: number
    sql: SAFE_DIVIDE(${total_saldo}, ${total_cantidad}) ;;
    label: "Promedio Saldo"
    value_format: "$#,##0"
  }
}
