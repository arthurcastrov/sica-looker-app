# ============================================================
# Vista: SFC Tarjetas de Crédito (Benchmarks Superfinanciera)
# Fuente DAX: eco_aval_sfc_tc
# displayFolder: 6. Bench
# ============================================================

view: sfc_tc {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_sfc_tc` ;;

  dimension: descripcion { type: string sql: ${TABLE}.descripcion ;; label: "Descripción" }
  dimension: grupo_aval { type: number sql: ${TABLE}.grupo_aval ;; label: "Grupo Aval" }
  dimension: persona_natural_dim { hidden: yes type: number sql: ${TABLE}.persona_natural ;; }
  dimension: persona_juridica_dim { hidden: yes type: number sql: ${TABLE}.persona_juridica ;; }
  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: codigo_banco { type: string sql: ${TABLE}.codigo_banco ;; label: "Código Banco" }
  dimension_group: fecha_corte {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha_corte ;;
    label: "Fecha Corte"
    datatype: date
  }

  # ---- MEASURES ----

  # DAX: $Saldo_Aval = CALCULATE(SUM(persona_natural), grupo_aval=1, descripcion="Saldo de la cartera por tarjeta de crédito")
  measure: saldo_aval_pn {
    type: sum
    sql: ${persona_natural_dim} ;;
    label: "Saldo Aval PN"
    description: "DAX: $Saldo_Aval"
    filters: [grupo_aval: "1", descripcion: "Saldo de la cartera por tarjeta de crédito"]
    value_format: "#,##0"
  }

  # DAX: $Saldo_Aval_PJ
  measure: saldo_aval_pj {
    type: sum
    sql: ${persona_juridica_dim} ;;
    label: "Saldo Aval PJ"
    description: "DAX: $Saldo_Aval_PJ"
    filters: [grupo_aval: "1", descripcion: "Saldo de la cartera por tarjeta de crédito"]
    value_format: "#,##0"
  }

  # DAX: $_valor_bench_saldoCartera_PN
  measure: saldo_cartera_pn {
    type: sum
    sql: ${persona_natural_dim} ;;
    label: "Saldo Cartera PN (SF)"
    description: "DAX: $_valor_bench_saldoCartera_PN"
    filters: [descripcion: "Saldo de la cartera por tarjeta de crédito"]
    value_format: "$#,##0"
  }

  # DAX: $_valor_bench_saldoCartera_PJ
  measure: saldo_cartera_pj {
    type: sum
    sql: ${persona_juridica_dim} ;;
    label: "Saldo Cartera PJ (SF)"
    description: "DAX: $_valor_bench_saldoCartera_PJ"
    filters: [descripcion: "Saldo de la cartera por tarjeta de crédito"]
    value_format: "$#,##0"
  }

  # DAX: $_valor_bench_cupo_no_utilizado_PN
  measure: cupo_no_utilizado_pn {
    type: sum
    sql: ${persona_natural_dim} ;;
    label: "Cupo No Utilizado PN (SF)"
    description: "DAX: $_valor_bench_cupo_no_utilizado_PN"
    filters: [descripcion: "Total cupo de crédito no utilizado por todos los tarjetahabientes"]
    value_format: "$#,##0"
  }

  # DAX: $_valor_bench_cupo_no_utilizado_PJ
  measure: cupo_no_utilizado_pj {
    type: sum
    sql: ${persona_juridica_dim} ;;
    label: "Cupo No Utilizado PJ (SF)"
    description: "DAX: $_valor_bench_cupo_no_utilizado_PJ"
    filters: [descripcion: "Total cupo de crédito no utilizado por todos los tarjetahabientes"]
    value_format: "$#,##0"
  }

  # DAX: %_part_aval_PN = DIVIDE(Saldo_Aval, saldoCartera_PN)
  measure: pct_part_aval_pn {
    type: number
    sql: SAFE_DIVIDE(${saldo_aval_pn}, ${saldo_cartera_pn}) ;;
    label: "% Part. Aval PN"
    description: "DAX: %_part_aval_PN"
    value_format: "0.0%"
  }

  # DAX: %_part_aval_PJ = DIVIDE(Saldo_Aval_PJ, saldoCartera_PJ)
  measure: pct_part_aval_pj {
    type: number
    sql: SAFE_DIVIDE(${saldo_aval_pj}, ${saldo_cartera_pj}) ;;
    label: "% Part. Aval PJ"
    description: "DAX: %_part_aval_PJ"
    value_format: "0.0%"
  }

  # DAX: $_ratio_bench_saldoCartera_num_tarjetas_PN
  measure: ratio_saldo_tarjetas_pn {
    type: number
    sql: SAFE_DIVIDE(
      SUM(CASE WHEN ${TABLE}.descripcion = 'Saldo de la cartera por tarjeta de crédito' THEN ${TABLE}.persona_natural ELSE 0 END),
      SUM(CASE WHEN ${TABLE}.descripcion LIKE 'Número total de tarjetas de crédito vigentes%' THEN ${TABLE}.persona_natural ELSE 0 END)
    ) ;;
    label: "Ratio Saldo/Tarjetas PN"
    description: "DAX: $_ratio_bench_saldoCartera_num_tarjetas_PN"
    value_format: "$#,##0"
  }

  # DAX: $_ratio_bench_saldoCartera_num_tarjetas_PJ
  measure: ratio_saldo_tarjetas_pj {
    type: number
    sql: SAFE_DIVIDE(
      SUM(CASE WHEN ${TABLE}.descripcion = 'Saldo de la cartera por tarjeta de crédito' THEN ${TABLE}.persona_juridica ELSE 0 END),
      SUM(CASE WHEN ${TABLE}.descripcion LIKE 'Número total de tarjetas de crédito vigentes%' THEN ${TABLE}.persona_juridica ELSE 0 END)
    ) ;;
    label: "Ratio Saldo/Tarjetas PJ"
    description: "DAX: $_ratio_bench_saldoCartera_num_tarjetas_PJ"
    value_format: "$#,##0"
  }

  # DAX: $_ratio_bench_cupo_no_utilizado_num_tarjetas_PN
  measure: ratio_cupo_tarjetas_pn {
    type: number
    sql: SAFE_DIVIDE(
      SUM(CASE WHEN ${TABLE}.descripcion = 'Total cupo de crédito no utilizado por todos los tarjetahabientes' THEN ${TABLE}.persona_natural ELSE 0 END),
      SUM(CASE WHEN ${TABLE}.descripcion LIKE 'Número total de tarjetas de crédito vigentes%' THEN ${TABLE}.persona_natural ELSE 0 END)
    ) ;;
    label: "Ratio Cupo NP/Tarjetas PN"
    value_format: "$#,##0"
  }

  # DAX: $_ratio_bench_cupo_no_utilizado_num_tarjetas_PJ
  measure: ratio_cupo_tarjetas_pj {
    type: number
    sql: SAFE_DIVIDE(
      SUM(CASE WHEN ${TABLE}.descripcion = 'Total cupo de crédito no utilizado por todos los tarjetahabientes' THEN ${TABLE}.persona_juridica ELSE 0 END),
      SUM(CASE WHEN ${TABLE}.descripcion LIKE 'Número total de tarjetas de crédito vigentes%' THEN ${TABLE}.persona_juridica ELSE 0 END)
    ) ;;
    label: "Ratio Cupo NP/Tarjetas PJ"
    value_format: "$#,##0"
  }
}
