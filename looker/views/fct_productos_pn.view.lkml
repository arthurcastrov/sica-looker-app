# ============================================================
# Vista: Productos Persona Natural
# Fuente DAX: eco_avl_fct_productos
# displayFolder: 2. Persona PN (Productos), Productos PN
# ============================================================

view: fct_productos_pn {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_fct_productos` ;;

  # ---- DIMENSIONES ----

  dimension: cont_id {
    type: string
    sql: ${TABLE}.cont_id ;;
    hidden: yes
  }

  dimension: id_tp_cd {
    type: string
    sql: ${TABLE}.id_tp_cd ;;
    label: "Tipo Identificación"
  }

  dimension: ref_num {
    type: string
    sql: ${TABLE}.ref_num ;;
    label: "Número Referencia"
  }

  dimension: users {
    type: string
    sql: ${TABLE}.users ;;
    label: "Usuario"
  }

  dimension: client_st_tp_cd {
    type: string
    sql: ${TABLE}.client_st_tp_cd ;;
    label: "Cod Estado Cliente"
  }

  dimension: gender_tp_code {
    type: string
    sql: ${TABLE}.gender_tp_code ;;
    label: "Cod Género"
  }

  dimension: seg_tp_cd {
    type: string
    sql: ${TABLE}.seg_tp_cd ;;
    label: "Cod Segmento"
  }

  dimension: seg_cat_tp_cd {
    type: string
    sql: ${TABLE}.seg_cat_tp_cd ;;
    label: "Cod Categoría Segmento"
  }

  dimension: sub_seg_tp_cd {
    type: string
    sql: ${TABLE}.sub_seg_tp_cd ;;
    label: "Cod Sub-Segmento"
  }

  dimension: rango_edad {
    type: string
    sql: ${TABLE}.rango_edad ;;
    label: "Rango Edad"
  }

  dimension: rango_anios_vinculacion {
    type: string
    sql: ${TABLE}.rango_anios_vinculacion ;;
    label: "Rango Años Vinculación"
  }

  dimension: cod_producto {
    type: string
    sql: ${TABLE}.cod_producto ;;
    label: "Código Producto"
  }

  dimension: entidad {
    type: string
    sql: ${TABLE}.entidad ;;
    label: "Entidad"
  }

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

  dimension: cantidad_productos_dim {
    type: number
    sql: ${TABLE}.cantidad_productos ;;
    hidden: yes
  }

  dimension: antiguedad_producto_dim {
    type: number
    sql: ${TABLE}.antiguedad_producto ;;
    hidden: yes
  }

  dimension: margen_dim {
    type: number
    sql: ${TABLE}.margen ;;
    hidden: yes
  }

  dimension: costo_fondeo_dim {
    type: number
    sql: ${TABLE}.costo_fondeo ;;
    hidden: yes
  }

  # ---- MEASURES ----

  # DAX: $_num_productos = SUM(cantidad_productos)
  measure: num_productos {
    type: sum
    sql: ${cantidad_productos_dim} ;;
    label: "Cantidad Productos"
    description: "DAX: $_num_productos"
    value_format: "#,##0"
  }

  # DAX: promedioProductosCliente = DIVIDE($_num_productos, $_cant_clientes)
  measure: promedio_productos_cliente {
    type: number
    sql: SAFE_DIVIDE(${num_productos}, COUNT(DISTINCT ${users})) ;;
    label: "Promedio Productos/Cliente"
    description: "DAX: promedioProductosCliente"
    value_format: "0.00"
  }

  # DAX: $_average_antProducto = AVERAGE(antiguedad_producto)
  measure: avg_antiguedad_producto {
    type: average
    sql: ${antiguedad_producto_dim} ;;
    label: "Promedio Antigüedad Producto"
    description: "DAX: $_average_antProducto_cap1"
    value_format: "0.00"
  }

  # DAX: $_margen_pos_provison_cap1 = SUM(margen) desde productos
  measure: margen_pos_provision {
    type: sum
    sql: ${margen_dim} ;;
    label: "Margen Pos Provisión"
    value_format: "$#,##0"
  }

  # DAX: $_costo_fondeo
  measure: total_costo_fondeo {
    type: sum
    sql: ${costo_fondeo_dim} ;;
    label: "Costo Fondeo"
    value_format: "$#,##0"
  }

  # Clientes únicos con productos
  measure: cant_clientes_con_productos {
    type: count_distinct
    sql: ${users} ;;
    label: "Clientes con Productos"
    value_format: "#,##0"
  }
}
