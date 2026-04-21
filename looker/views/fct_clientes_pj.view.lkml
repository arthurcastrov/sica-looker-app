# ============================================================
# Vista: Clientes Persona Jurídica
# Fuente DAX: eco_aval_fct_clientes_pj
# displayFolder: 5. Persona PJ
# ============================================================

view: fct_clientes_pj {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_fct_clientes_pj` ;;

  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension: cont_id { type: string sql: ${TABLE}.cont_id ;; hidden: yes }
  dimension: id_tp_cd { type: string sql: ${TABLE}.id_tp_cd ;; label: "Tipo ID" }
  dimension: ref_num { type: string sql: ${TABLE}.ref_num ;; label: "Número Referencia" }
  dimension: users { type: string sql: ${TABLE}.users ;; label: "Usuario" primary_key: yes }
  dimension: client_st_tp_cd { type: string sql: ${TABLE}.client_st_tp_cd ;; label: "Cod Estado Cliente" }
  dimension: seg_tp_cd { type: string sql: ${TABLE}.seg_tp_cd ;; label: "Cod Segmento" }
  dimension: seg_cat_tp_cd { type: string sql: ${TABLE}.seg_cat_tp_cd ;; label: "Cod Categoría Segmento" }
  dimension: sub_seg_tp_cd { type: string sql: ${TABLE}.sub_seg_tp_cd ;; label: "Cod Sub-Segmento" }
  dimension: rango_edad { type: string sql: ${TABLE}.rango_edad ;; label: "Rango Edad" }
  dimension: rango_anios_vinculacion { type: string sql: ${TABLE}.rango_anios_vinculacion ;; label: "Rango Años Vinculación" }
  dimension: xciiu_tp_cd { type: string sql: ${TABLE}.xciiu_tp_cd ;; label: "Cod CIIU" }
  dimension: xsociety_tp_cd { type: string sql: ${TABLE}.xsociety_tp_cd ;; label: "Cod Tipo Sociedad" }
  dimension: xeco_sect_tp_cd { type: string sql: ${TABLE}.xeco_sect_tp_cd ;; label: "Cod Sector Económico" }
  dimension: org_tp_cd { type: string sql: ${TABLE}.org_tp_cd ;; label: "Cod Tipo Organización" }
  dimension: xnum_of_empl { type: string sql: ${TABLE}.xnum_of_empl ;; label: "Número Empleados" }
  dimension: segmento_ventas { type: string sql: ${TABLE}.segmento_ventas ;; label: "Segmento Ventas" }
  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
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
  dimension: margen_dim { hidden: yes type: number sql: ${TABLE}.margen ;; }
  dimension: costo_fondeo_dim { hidden: yes type: number sql: ${TABLE}.costo_fondeo ;; }

  # ---- MEASURES (displayFolder: 5. Persona PJ) ----

  # DAX: $_clientes_unicos_PJ = DISTINCTCOUNT(users)
  measure: clientes_unicos_pj {
    type: count_distinct
    sql: ${users} ;;
    label: "Clientes Únicos PJ"
    description: "DAX: $_clientes_unicos_PJ"
    value_format: "#,##0"
  }

  # DAX: $_bbog_clientes_pj
  measure: clientes_pj_bbog {
    type: count_distinct
    sql: ${users} ;;
    label: "Clientes PJ BBOG"
    filters: [entidad: "BBOG"]
    value_format: "#,##0"
  }

  # DAX: $_bocc_clientes_pj
  measure: clientes_pj_bocc {
    type: count_distinct
    sql: ${ref_num} ;;
    label: "Clientes PJ BOCC"
    filters: [entidad: "BOCC"]
    value_format: "#,##0"
  }

  # DAX: $_bpop_clientes_pj
  measure: clientes_pj_bpop {
    type: count_distinct
    sql: ${ref_num} ;;
    label: "Clientes PJ BPOP"
    filters: [entidad: "BPOP"]
    value_format: "#,##0"
  }

  # DAX: $_bavv_clientes_pj
  measure: clientes_pj_bavv {
    type: count_distinct
    sql: ${ref_num} ;;
    label: "Clientes PJ BAVV"
    filters: [entidad: "BAVV"]
    value_format: "#,##0"
  }

  # DAX: $_margen_pos_provison_pj = SUM(margen)
  measure: margen_pos_provision_pj {
    type: sum
    sql: ${margen_dim} ;;
    label: "Margen Pos Provisión PJ"
    description: "DAX: $_margen_pos_provison_pj"
    value_format: "$#,##0"
  }

  measure: total_costo_fondeo_pj {
    type: sum
    sql: ${costo_fondeo_dim} ;;
    label: "Costo Fondeo PJ"
    value_format: "$#,##0"
  }
}
