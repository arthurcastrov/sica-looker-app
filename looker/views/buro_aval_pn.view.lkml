# ============================================================
# Vista: Buró PN - Aval
# Fuente DAX: eco_aval_buro_aval
# displayFolder: 3. Buro PN (sección Aval)
# ============================================================

view: buro_aval_pn {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_buro_aval` ;;

  # ---- DIMENSIONES ----
  dimension: tipo_id { type: string sql: ${TABLE}.tipo_id ;; label: "Tipo ID" }
  dimension: num_id { type: string sql: ${TABLE}.num_id ;; label: "Número ID" }
  dimension: tipo_persona { type: string sql: ${TABLE}.tipo_persona ;; label: "Tipo Persona" }
  dimension: act_calificacion { type: string sql: ${TABLE}.act_calificacion ;; label: "Calificación" }
  dimension: periodo { type: string sql: ${TABLE}.periodo ;; label: "Periodo" hidden: yes }
  dimension: rango_edad { type: string sql: ${TABLE}.rango_edad ;; label: "Rango Edad" }
  dimension: gender_tp_code { type: string sql: ${TABLE}.gender_tp_code ;; label: "Cod Género" }
  dimension: marital_st_tp_cd { type: string sql: ${TABLE}.marital_st_tp_cd ;; label: "Cod Estado Civil" }
  dimension: rango_salario { type: string sql: ${TABLE}.rango_salario ;; label: "Rango Salario" }
  dimension: tipocotizante { type: string sql: ${TABLE}.tipocotizante ;; label: "Tipo Cotizante" }
  dimension: empleado_aval { type: string sql: ${TABLE}.empleado_aval ;; label: "Empleado Aval" }
  dimension: empleado_aval_txt { type: string sql: ${TABLE}.empleado_aval_txt ;; label: "Empleado Aval (Texto)" }
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

  # Dims numéricas ocultas
  dimension: bocc_cant_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.bocc_cant_obligaciones_tot ;; }
  dimension: bocc_saldo_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.bocc_saldo_obligaciones_tot ;; }
  dimension: bocc_saldo_depositos_tot_dim { hidden: yes type: number sql: ${TABLE}.bocc_saldo_depositos_tot ;; }
  dimension: bocc_cant_depositos_tot_dim { hidden: yes type: number sql: ${TABLE}.bocc_cant_depositos_tot ;; }
  dimension: cant_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.cant_obligaciones_tot ;; }
  dimension: cant_obligaciones_tdc_dim { hidden: yes type: number sql: ${TABLE}.cant_obligaciones_tdc ;; }
  dimension: cant_obligaciones_hip_dim { hidden: yes type: number sql: ${TABLE}.cant_obligaciones_hip ;; }
  dimension: saldo_obligaciones_tot_dim { hidden: yes type: number sql: ${TABLE}.saldo_obligaciones_tot ;; }
  dimension: saldo_obligaciones_tdc_dim { hidden: yes type: number sql: ${TABLE}.saldo_obligaciones_tdc ;; }
  dimension: saldo_obligaciones_hip_dim { hidden: yes type: number sql: ${TABLE}.saldo_obligaciones_hip ;; }
  dimension: aho_cant_productos_dim { hidden: yes type: number sql: ${TABLE}.aho_cant_productos ;; }
  dimension: aho_saldo_actual_dim { hidden: yes type: number sql: ${TABLE}.aho_saldo_actual ;; }
  dimension: aho_saldo_promedio_dim { hidden: yes type: number sql: ${TABLE}.aho_saldo_promedio ;; }
  dimension: cor_cant_productos_dim { hidden: yes type: number sql: ${TABLE}.cor_cant_productos ;; }
  dimension: cor_saldo_actual_dim { hidden: yes type: number sql: ${TABLE}.cor_saldo_actual ;; }
  dimension: cor_saldo_promedio_dim { hidden: yes type: number sql: ${TABLE}.cor_saldo_promedio ;; }
  dimension: cdt_cant_productos_dim { hidden: yes type: number sql: ${TABLE}.cdt_cant_productos ;; }
  dimension: cdt_saldo_actual_dim { hidden: yes type: number sql: ${TABLE}.cdt_saldo_actual ;; }
  dimension: act_tc_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_tc_saldo ;; }
  dimension: act_hipotecario_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_hipotecario_saldo ;; }
  dimension: act_libranza_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_libranza_saldo ;; }
  dimension: act_libre_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_libre_saldo ;; }
  dimension: act_otros_saldo_dim { hidden: yes type: number sql: ${TABLE}.act_otros_saldo ;; }

  # ---- MEASURES ----

  # DAX: %_participación_cant_cartera_aval = DIVIDE(bocc_cant, total_cant)
  measure: pct_participacion_cant_cartera_aval {
    type: number
    sql: SAFE_DIVIDE(SUM(${bocc_cant_obligaciones_tot_dim}), SUM(${cant_obligaciones_tot_dim})) ;;
    label: "% Part. Cant. Cartera Aval"
    description: "DAX: %_participación_cant_cartera_aval"
    value_format: "0.00%"
  }

  # DAX: $_average_antProducto_tdcSF_aval = AVERAGE(cant_obligaciones_tdc)
  measure: avg_cant_obligaciones_tdc_aval {
    type: average
    sql: ${cant_obligaciones_tdc_dim} ;;
    label: "Promedio Obligaciones TDC Aval"
    description: "DAX: $_average_antProducto_tdcSF_aval"
    value_format: "#,##0.00"
  }

  # DAX: $_saldo_tdc_sf_cap3_aval = SUM(saldo_obligaciones_tdc)
  measure: saldo_tdc_sf_aval {
    type: sum
    sql: ${saldo_obligaciones_tdc_dim} ;;
    label: "Saldo TDC SF Aval"
    description: "DAX: $_saldo_tdc_sf_cap3_aval"
    value_format: "$#,##0"
  }

  # DAX: $_saldo_act_tc_aval_aval = SUM(act_tc_saldo)
  measure: saldo_act_tc_aval {
    type: sum
    sql: ${act_tc_saldo_dim} ;;
    label: "Saldo TC Aval"
    value_format: "$#,##0"
  }

  # DAX: %_part_rotativo_avalSF_aval = DIVIDE(saldo_tc, saldo_tdc)
  measure: pct_part_rotativo_aval_sf_aval {
    type: number
    sql: SAFE_DIVIDE(${saldo_act_tc_aval}, ${saldo_tdc_sf_aval}) ;;
    label: "% Part. Rotativo Aval/SF (Aval)"
    description: "DAX: %_part_rotativo_avalSF_aval"
    value_format: "0.00%"
  }

  # Totales saldo obligaciones
  measure: total_saldo_obligaciones {
    type: sum
    sql: ${saldo_obligaciones_tot_dim} ;;
    label: "Total Saldo Obligaciones"
    value_format: "$#,##0"
  }

  measure: total_cant_obligaciones {
    type: sum
    sql: ${cant_obligaciones_tot_dim} ;;
    label: "Total Cant. Obligaciones"
    value_format: "#,##0"
  }

  measure: count_clientes {
    type: count_distinct
    sql: ${num_id} ;;
    label: "Clientes Únicos Buró Aval"
    value_format: "#,##0"
  }
}
