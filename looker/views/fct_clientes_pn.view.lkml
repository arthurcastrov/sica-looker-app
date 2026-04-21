# ============================================================
# Vista: Clientes Persona Natural
# Fuente DAX: eco_avl_fct_clientes
# displayFolder: 2. Persona PN
# ============================================================

view: fct_clientes_pn {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_fct_clientes` ;;

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
    primary_key: yes
  }

  dimension: client_st_tp_cd {
    type: string
    sql: ${TABLE}.client_st_tp_cd ;;
    label: "Cod Estado Cliente"
  }

  dimension: marital_st_tp_cd {
    type: string
    sql: ${TABLE}.marital_st_tp_cd ;;
    label: "Cod Estado Civil"
  }

  dimension: highest_edu_tp_cd {
    type: string
    sql: ${TABLE}.highest_edu_tp_cd ;;
    label: "Cod Nivel Educativo"
  }

  dimension: gender_tp_code {
    type: string
    sql: ${TABLE}.gender_tp_code ;;
    label: "Cod Género"
  }

  dimension: profession_tp_cd {
    type: string
    sql: ${TABLE}.profession_tp_cd ;;
    label: "Cod Profesión"
  }

  dimension: occupation_tp_cd {
    type: string
    sql: ${TABLE}.occupation_tp_cd ;;
    label: "Cod Ocupación"
  }

  dimension: housing_tp_cd {
    type: string
    sql: ${TABLE}.housing_tp_cd ;;
    label: "Cod Tipo Vivienda"
  }

  dimension: birthplace_tp_cd {
    type: string
    sql: ${TABLE}.birthplace_tp_cd ;;
    label: "Cod Lugar Nacimiento"
  }

  dimension: birth_city_tp_cd {
    type: string
    sql: ${TABLE}.birth_city_tp_cd ;;
    label: "Cod Ciudad Nacimiento"
  }

  dimension: birth_state_tp_cd {
    type: string
    sql: ${TABLE}.birth_state_tp_cd ;;
    label: "Cod Departamento Nacimiento"
  }

  dimension: ciiu_tp_cd {
    type: string
    sql: ${TABLE}.ciiu_tp_cd ;;
    label: "Cod CIIU"
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
    label: "Cod Sub-segmento"
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

  dimension: rango_salario {
    type: string
    sql: ${TABLE}.rango_salario ;;
    label: "Rango Salario"
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

  dimension: children_ct {
    type: number
    sql: ${TABLE}.children_ct ;;
    label: "Cantidad Hijos"
  }

  dimension: margen {
    type: number
    sql: ${TABLE}.margen ;;
    label: "Margen (dim)"
    hidden: yes
  }

  dimension: costo_fondeo {
    type: number
    sql: ${TABLE}.costo_fondeo ;;
    label: "Costo Fondeo (dim)"
    hidden: yes
  }

  dimension: ingresos {
    type: number
    sql: ${TABLE}.ingresos ;;
    label: "Ingresos (dim)"
    hidden: yes
  }

  # ---- MEASURES (displayFolder: 2. Persona PN) ----

  # DAX: $_cant_clientes = DISTINCTCOUNT('1. eco_avl_fct_clientes'[users])
  measure: cant_clientes {
    type: count_distinct
    sql: ${users} ;;
    label: "Cantidad Clientes"
    description: "DAX: $_cant_clientes - Clientes únicos PN"
    value_format: "#,##0"
  }

  # DAX: $_cant_clientes_bdb_cap1 = CALCULATE(DISTINCTCOUNT(...), entidad = "BBOG")
  measure: cant_clientes_bbog {
    type: count_distinct
    sql: ${users} ;;
    label: "Clientes BBOG"
    description: "DAX: $_cant_clientes_bdb_cap1"
    filters: [entidad: "BBOG"]
    value_format: "#,##0"
  }

  # DAX: $_cant_clientes_bocc
  measure: cant_clientes_bocc {
    type: count_distinct
    sql: ${users} ;;
    label: "Clientes BOCC"
    description: "DAX: $_cant_clientes_bocc"
    filters: [entidad: "BOCC"]
    value_format: "#,##0"
  }

  # DAX: $_cant_clientes_bpop_cap1
  measure: cant_clientes_bpop {
    type: count_distinct
    sql: ${users} ;;
    label: "Clientes BPOP"
    description: "DAX: $_cant_clientes_bpop_cap1"
    filters: [entidad: "BPOP"]
    value_format: "#,##0"
  }

  # DAX: $_cant_clientes_bavv_cap1
  measure: cant_clientes_bavv {
    type: count_distinct
    sql: ${users} ;;
    label: "Clientes BAVV"
    description: "DAX: $_cant_clientes_bavv_cap1"
    filters: [entidad: "BAVV"]
    value_format: "#,##0"
  }

  # DAX: %_bdb_partClientes = DIVIDE(total, bdb)
  measure: pct_bdb_part_clientes {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT ${ref_num}),
      COUNT(DISTINCT CASE WHEN ${entidad} = 'BDB' THEN ${ref_num} END)
    ) ;;
    label: "% Part. Clientes BDB"
    description: "DAX: %_bdb_partClientes"
    value_format: "0.0%"
  }

  # DAX: %_bocc_partClientes
  measure: pct_bocc_part_clientes {
    type: number
    sql: SAFE_DIVIDE(
      COUNT(DISTINCT ${ref_num}),
      COUNT(DISTINCT CASE WHEN ${entidad} = 'BOCC' THEN ${ref_num} END)
    ) ;;
    label: "% Part. Clientes BOCC"
    description: "DAX: %_bocc_partClientes"
    value_format: "0.00%"
  }

  # DAX: $_margen_pos_provison_cap1 = SUM(margen)
  measure: margen_pos_provision {
    type: sum
    sql: ${margen} ;;
    label: "Margen Pos Provisión"
    description: "DAX: $_margen_pos_provison_cap1"
    value_format: "$#,##0"
  }

  # DAX: %_mujer_participacion = DIVIDE(CALCULATE(margen, gender=Femenino), margen)
  measure: pct_mujer_participacion {
    type: number
    sql: SAFE_DIVIDE(
      SUM(CASE WHEN ${gender_tp_code} = 'F' THEN ${margen} ELSE 0 END),
      SUM(${margen})
    ) ;;
    label: "% Participación Mujer"
    description: "DAX: %_mujer_participacion - participación en margen"
    value_format: "0%"
  }

  # DAX: %_masculino_participacion = DIVIDE(CALCULATE(margen, gender<>Femenino), margen)
  measure: pct_masculino_participacion {
    type: number
    sql: SAFE_DIVIDE(
      SUM(CASE WHEN ${gender_tp_code} != 'F' THEN ${margen} ELSE 0 END),
      SUM(${margen})
    ) ;;
    label: "% Participación Masculino"
    description: "DAX: %_masculino_participacion"
    value_format: "0%"
  }

  # DAX: $_costo_fondeo = SUM(costo_fondeo)
  measure: total_costo_fondeo {
    type: sum
    sql: ${costo_fondeo} ;;
    label: "Costo Fondeo"
    description: "DAX: $_costo_fondeo_cap1"
    value_format: "$#,##0"
  }

  # DAX: $_ingresos_totales = SUM(ingresos)
  measure: total_ingresos {
    type: sum
    sql: ${ingresos} ;;
    label: "Ingresos Totales"
    description: "DAX: ingresos totales PN"
    value_format: "$#,##0"
  }

  # DAX: count total de registros
  measure: total_registros {
    type: count
    label: "Total Registros"
  }
}
