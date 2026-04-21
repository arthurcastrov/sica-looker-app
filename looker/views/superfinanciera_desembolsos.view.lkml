# ============================================================
# Vista: SFC Desembolsos
# Fuente DAX: superfinanciera_desembolsos
# displayFolder: Vision_del_grupo
# ============================================================

view: superfinanciera_desembolsos {
  sql_table_name: `adl-analytics-project.sica_analytics.superfinanciera_desembolsos` ;;

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

  measure: total_valor { type: sum sql: ${valor_dim} ;; label: "Total Desembolsos" value_format: "$#,##0" }
  measure: desembolsos_aval { type: sum sql: ${valor_dim} ;; label: "Desembolsos Aval" filters: [grupo_aval: "1"] value_format: "$#,##0" }
  measure: pct_market_share_desembolsos {
    type: number
    sql: SAFE_DIVIDE(${desembolsos_aval}, ${total_valor}) ;;
    label: "Market Share Desembolsos"
    value_format: "0.00%"
  }
}
