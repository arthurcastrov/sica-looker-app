# ============================================================
# Vista: Margen por Clientes
# Fuente DAX: eco_aval_fct_margen_agg_clientes
# displayFolder: PyG
# ============================================================

view: margen_clientes {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_fct_margen_agg_clientes` ;;

  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension: ref_num { type: string sql: ${TABLE}.ref_num ;; label: "Número Referencia" }
  dimension_group: date_cruce {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.date_cruce ;;
    label: "Fecha Cruce"
    datatype: date
  }
  dimension: margen_dim { hidden: yes type: number sql: ${TABLE}.margen ;; }
  dimension: ingresos_dim { hidden: yes type: number sql: ${TABLE}.ingresos ;; }
  dimension: costos_dim { hidden: yes type: number sql: ${TABLE}.costos ;; }
  dimension: provisiones_dim { hidden: yes type: number sql: ${TABLE}.provisiones ;; }
  dimension: costo_fondeo_dim { hidden: yes type: number sql: ${TABLE}.costo_fondeo ;; }

  measure: total_margen { type: sum sql: ${margen_dim} ;; label: "Margen Total" value_format: "$#,##0" }
  measure: total_ingresos { type: sum sql: ${ingresos_dim} ;; label: "Ingresos" value_format: "$#,##0" }
  measure: total_costos { type: sum sql: ${costos_dim} ;; label: "Costos" value_format: "$#,##0" }
  measure: total_provisiones { type: sum sql: ${provisiones_dim} ;; label: "Provisiones" value_format: "$#,##0" }
  measure: total_costo_fondeo { type: sum sql: ${costo_fondeo_dim} ;; label: "Costo Fondeo" value_format: "$#,##0" }
  measure: avg_margen_cliente {
    type: number
    sql: SAFE_DIVIDE(${total_margen}, COUNT(DISTINCT ${ref_num})) ;;
    label: "Margen Promedio/Cliente"
    value_format: "$#,##0"
  }
  measure: cant_clientes_margen {
    type: count_distinct
    sql: ${ref_num} ;;
    label: "Clientes con Margen"
    value_format: "#,##0"
  }
}
