# ============================================================
# Vista: Productos Persona Jurídica
# Fuente DAX: eco_aval_fct_productos_pj
# displayFolder: 5. Persona PJ, Productos PJ
# ============================================================

view: fct_productos_pj {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_fct_productos_pj` ;;

  dimension: cont_id { type: string sql: ${TABLE}.cont_id ;; hidden: yes }
  dimension: id_tp_cd { type: string sql: ${TABLE}.id_tp_cd ;; label: "Tipo ID" }
  dimension: ref_num { type: string sql: ${TABLE}.ref_num ;; label: "Número Referencia" }
  dimension: users { type: string sql: ${TABLE}.users ;; label: "Usuario" }
  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension: client_st_tp_cd { type: string sql: ${TABLE}.client_st_tp_cd ;; label: "Cod Estado Cliente" }
  dimension: seg_tp_cd { type: string sql: ${TABLE}.seg_tp_cd ;; label: "Cod Segmento" }
  dimension: seg_cat_tp_cd { type: string sql: ${TABLE}.seg_cat_tp_cd ;; label: "Cod Categoría Segmento" }
  dimension: sub_seg_tp_cd { type: string sql: ${TABLE}.sub_seg_tp_cd ;; label: "Cod Sub-Segmento" }
  dimension: rango_edad { type: string sql: ${TABLE}.rango_edad ;; label: "Rango Edad" }
  dimension: rango_anios_vinculacion { type: string sql: ${TABLE}.rango_anios_vinculacion ;; label: "Rango Años Vinculación" }
  dimension: cod_producto { type: string sql: ${TABLE}.cod_producto ;; label: "Código Producto" }
  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: xciiu_tp_cd { type: string sql: ${TABLE}.xciiu_tp_cd ;; label: "Cod CIIU" }
  dimension: xsociety_tp_cd { type: string sql: ${TABLE}.xsociety_tp_cd ;; label: "Cod Tipo Sociedad" }
  dimension: xeco_sect_tp_cd { type: string sql: ${TABLE}.xeco_sect_tp_cd ;; label: "Cod Sector Económico" }
  dimension: org_tp_cd { type: string sql: ${TABLE}.org_tp_cd ;; label: "Cod Tipo Organización" }
  dimension: xnum_of_empl { type: string sql: ${TABLE}.xnum_of_empl ;; label: "Número Empleados" }
  dimension_group: date_cruce {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.date_cruce ;;
    label: "Fecha Cruce"
    datatype: date
  }
  dimension_group: fecha_carga {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha_carga ;;
    label: "Fecha Carga"
  }
  dimension: cantidad_productos_dim { hidden: yes type: number sql: ${TABLE}.cantidad_productos ;; }
  dimension: antiguedad_producto_dim { hidden: yes type: number sql: ${TABLE}.antiguedad_producto ;; }
  dimension: margen_dim { hidden: yes type: number sql: ${TABLE}.margen ;; }
  dimension: costo_fondeo_dim { hidden: yes type: number sql: ${TABLE}.costo_fondeo ;; }

  # ---- MEASURES ----

  # DAX: $_num_productos_pj = SUM(cantidad_productos)
  measure: num_productos_pj {
    type: sum
    sql: ${cantidad_productos_dim} ;;
    label: "Cantidad Productos PJ"
    description: "DAX: $_num_productos_pj"
    value_format: "#,##0"
  }

  # DAX: $_average_antProducto_pj = AVERAGE(antiguedad_producto)
  measure: avg_antiguedad_producto_pj {
    type: average
    sql: ${antiguedad_producto_dim} ;;
    label: "Promedio Antigüedad Producto PJ"
    description: "DAX: $_average_antProducto_pj"
    value_format: "0.00"
  }

  # DAX: $_average_ProductoCliente_pj = DIVIDE(SUM(cant), DISTINCTCOUNT(ref_num))
  measure: avg_productos_cliente_pj {
    type: number
    sql: SAFE_DIVIDE(SUM(${cantidad_productos_dim}), COUNT(DISTINCT ${ref_num})) ;;
    label: "Promedio Productos/Cliente PJ"
    description: "DAX: $_average_ProductoCliente_pj"
    value_format: "0.00"
  }

  measure: margen_pos_provision_pj {
    type: sum
    sql: ${margen_dim} ;;
    label: "Margen Pos Provisión PJ"
    value_format: "$#,##0"
  }

  measure: cant_clientes_pj {
    type: count_distinct
    sql: ${ref_num} ;;
    label: "Clientes con Productos PJ"
    value_format: "#,##0"
  }
}
