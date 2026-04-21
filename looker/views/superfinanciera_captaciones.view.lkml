# ============================================================
# Vista: SFC Captaciones
# Fuente DAX: superfinanciera_captaciones
# displayFolder: Vision_del_grupo, 8. Iniciativas
# ============================================================

view: superfinanciera_captaciones {
  sql_table_name: `adl-analytics-project.sica_analytics.superfinanciera_captaciones` ;;

  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: concepto { type: string sql: ${TABLE}.concepto ;; label: "Concepto" }
  dimension: grupo_aval { type: number sql: ${TABLE}.grupo_aval ;; label: "Grupo Aval" }
  dimension: codigo_banco { type: string sql: ${TABLE}.codigo_banco ;; label: "Código Banco" }
  dimension: valor_dim { hidden: yes type: number sql: ${TABLE}.valor ;; }
  dimension_group: fecha_corte {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha_corte ;;
    label: "Fecha Corte"
    datatype: date
  }

  measure: total_valor { type: sum sql: ${valor_dim} ;; label: "Total Captaciones" value_format: "$#,##0" }

  # Captaciones Aval
  measure: captaciones_aval {
    type: sum
    sql: ${valor_dim} ;;
    label: "Captaciones Aval"
    filters: [grupo_aval: "1"]
    value_format: "$#,##0"
  }

  # Market share
  measure: pct_market_share_captaciones {
    type: number
    sql: SAFE_DIVIDE(${captaciones_aval}, ${total_valor}) ;;
    label: "Market Share Captaciones"
    value_format: "0.00%"
  }
}
