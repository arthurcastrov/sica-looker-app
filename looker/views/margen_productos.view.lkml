# ============================================================
# Vista: Margen por Productos (PyG)
# Fuente DAX: eco_aval_fct_margen_agg_productos
# displayFolder: PyG
# ============================================================

view: margen_productos {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_fct_margen_agg_productos` ;;

  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: cod_producto { type: string sql: ${TABLE}.cod_producto ;; label: "Código Producto" }
  dimension: tipo_producto { type: string sql: ${TABLE}.tipo_producto ;; label: "Tipo Producto" }
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

  # ---- MEASURES ----

  # DAX: $_margen = SUM(margen)
  measure: total_margen {
    type: sum
    sql: ${margen_dim} ;;
    label: "Margen Total"
    description: "DAX: $_margen - Margen neto financiero"
    value_format: "$#,##0"
  }

  # DAX: $_ingresos = SUM(ingresos)
  measure: total_ingresos {
    type: sum
    sql: ${ingresos_dim} ;;
    label: "Ingresos"
    value_format: "$#,##0"
  }

  # DAX: $_costos = SUM(costos)
  measure: total_costos {
    type: sum
    sql: ${costos_dim} ;;
    label: "Costos"
    value_format: "$#,##0"
  }

  # DAX: $_provisiones = SUM(provisiones)
  measure: total_provisiones {
    type: sum
    sql: ${provisiones_dim} ;;
    label: "Provisiones"
    value_format: "$#,##0"
  }

  # DAX: $_costo_fondeo = SUM(costo_fondeo)
  measure: total_costo_fondeo {
    type: sum
    sql: ${costo_fondeo_dim} ;;
    label: "Costo Fondeo"
    value_format: "$#,##0"
  }

  # DAX: %_margen_ingresos = DIVIDE(margen, ingresos)
  measure: pct_margen_ingresos {
    type: number
    sql: SAFE_DIVIDE(${total_margen}, ${total_ingresos}) ;;
    label: "% Margen/Ingresos"
    value_format: "0.00%"
  }
}
