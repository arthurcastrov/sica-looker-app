# ============================================================
# Vista: Flujo de Dinero
# Fuente DAX: eco_aval_flujo_dinero
# displayFolder: Flujo de Dinero
# ============================================================

view: flujo_dinero {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_flujo_dinero` ;;

  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension: tipo_flujo { type: string sql: ${TABLE}.tipo_flujo ;; label: "Tipo Flujo" }
  dimension: monto_dim { hidden: yes type: number sql: ${TABLE}.monto ;; }
  dimension: cantidad_dim { hidden: yes type: number sql: ${TABLE}.cantidad ;; }
  dimension_group: date_cruce {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.date_cruce ;;
    label: "Fecha Cruce"
    datatype: date
  }

  # DAX: $_flujo_dinero_monto = SUM(monto)
  measure: total_monto {
    type: sum
    sql: ${monto_dim} ;;
    label: "Total Monto"
    description: "DAX: $_flujo_dinero_monto"
    value_format: "$#,##0"
  }

  # DAX: $_flujo_dinero_cantidad = SUM(cantidad)
  measure: total_cantidad {
    type: sum
    sql: ${cantidad_dim} ;;
    label: "Total Cantidad"
    description: "DAX: $_flujo_dinero_cantidad"
    value_format: "#,##0"
  }

  measure: avg_monto_transaccion {
    type: number
    sql: SAFE_DIVIDE(${total_monto}, ${total_cantidad}) ;;
    label: "Promedio Monto/Transacción"
    value_format: "$#,##0"
  }
}
