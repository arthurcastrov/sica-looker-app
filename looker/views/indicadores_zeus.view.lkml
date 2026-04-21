# ============================================================
# Vista: Indicadores Zeus (Seguimiento Semanal)
# Fuente DAX: indicadores_zeus_seguimiento
# displayFolder: Indicadores Zeus
# ============================================================

view: indicadores_zeus {
  sql_table_name: `adl-analytics-project.sica_analytics.indicadores_zeus_seguimiento` ;;

  dimension: indicador { type: string sql: ${TABLE}.indicador ;; label: "Indicador" }
  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: tipo { type: string sql: ${TABLE}.tipo ;; label: "Tipo" }
  dimension: semana { type: string sql: ${TABLE}.semana ;; label: "Semana" }
  dimension: periodo { type: string sql: ${TABLE}.periodo ;; label: "Periodo" }
  dimension: valor_dim { hidden: yes type: number sql: ${TABLE}.valor ;; }
  dimension: meta_dim { hidden: yes type: number sql: ${TABLE}.meta ;; }
  dimension: cumplimiento_dim { hidden: yes type: number sql: ${TABLE}.cumplimiento ;; }
  dimension_group: fecha_corte {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha_corte ;;
    label: "Fecha Corte"
    datatype: date
  }

  # ---- MEASURES ----

  measure: total_valor {
    type: sum
    sql: ${valor_dim} ;;
    label: "Valor"
    value_format: "#,##0.00"
  }

  measure: total_meta {
    type: sum
    sql: ${meta_dim} ;;
    label: "Meta"
    value_format: "#,##0.00"
  }

  measure: avg_cumplimiento {
    type: average
    sql: ${cumplimiento_dim} ;;
    label: "% Cumplimiento"
    value_format: "0.00%"
  }

  measure: pct_cumplimiento {
    type: number
    sql: SAFE_DIVIDE(${total_valor}, ${total_meta}) ;;
    label: "Cumplimiento vs Meta"
    value_format: "0.00%"
  }

  measure: count_indicadores {
    type: count_distinct
    sql: ${indicador} ;;
    label: "Cant. Indicadores"
    value_format: "#,##0"
  }
}
