# ============================================================
# Vista: Saldos Clientes PN (Año Anterior)
# Fuente DAX: sica_saldos_clientes_pn_aa
# displayFolder: Saldos
# ============================================================

view: saldos_clientes_pn {
  sql_table_name: `adl-analytics-project.sica_analytics.sica_saldos_clientes_pn_aa` ;;

  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension: ref_num { type: string sql: ${TABLE}.ref_num ;; label: "Número Referencia" }
  dimension: periodo { type: string sql: ${TABLE}.periodo ;; label: "Periodo" }
  dimension_group: date_cruce {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.date_cruce ;;
    label: "Fecha Cruce"
    datatype: date
  }
  dimension: saldo_dim { hidden: yes type: number sql: ${TABLE}.saldo ;; }
  dimension: margen_dim { hidden: yes type: number sql: ${TABLE}.margen ;; }

  measure: total_saldo { type: sum sql: ${saldo_dim} ;; label: "Saldo PN AA" value_format: "$#,##0" }
  measure: total_margen { type: sum sql: ${margen_dim} ;; label: "Margen PN AA" value_format: "$#,##0" }
  measure: cant_clientes_pn {
    type: count_distinct
    sql: ${ref_num} ;;
    label: "Clientes PN AA"
    value_format: "#,##0"
  }
}

# ============================================================
# Vista: Saldos Clientes PJ (Año Anterior)
# Fuente DAX: sica_saldos_clientes_pj_aa
# displayFolder: Saldos
# ============================================================

view: saldos_clientes_pj {
  sql_table_name: `adl-analytics-project.sica_analytics.sica_saldos_clientes_pj_aa` ;;

  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension: ref_num { type: string sql: ${TABLE}.ref_num ;; label: "Número Referencia" }
  dimension: periodo { type: string sql: ${TABLE}.periodo ;; label: "Periodo" }
  dimension_group: date_cruce {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.date_cruce ;;
    label: "Fecha Cruce"
    datatype: date
  }
  dimension: saldo_dim { hidden: yes type: number sql: ${TABLE}.saldo ;; }
  dimension: margen_dim { hidden: yes type: number sql: ${TABLE}.margen ;; }

  measure: total_saldo { type: sum sql: ${saldo_dim} ;; label: "Saldo PJ AA" value_format: "$#,##0" }
  measure: total_margen { type: sum sql: ${margen_dim} ;; label: "Margen PJ AA" value_format: "$#,##0" }
  measure: cant_clientes_pj {
    type: count_distinct
    sql: ${ref_num} ;;
    label: "Clientes PJ AA"
    value_format: "#,##0"
  }
}
