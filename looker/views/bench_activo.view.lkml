# ============================================================
# Vista: Benchmarks Activos
# Fuente DAX: bench_activo
# displayFolder: 6. Bench
# ============================================================

view: bench_activo {
  sql_table_name: `adl-analytics-project.sica_analytics.bench_activo` ;;

  dimension: concepto { type: string sql: ${TABLE}.concepto ;; label: "Concepto" }
  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: codigo_banco { type: string sql: ${TABLE}.codigo_banco ;; label: "Código Banco" }
  dimension: grupo_aval { type: number sql: ${TABLE}.grupo_aval ;; label: "Grupo Aval" }
  dimension: valor_dim { hidden: yes type: number sql: ${TABLE}.valor ;; }
  dimension_group: fecha_corte {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha_corte ;;
    label: "Fecha Corte"
    datatype: date
  }

  # ---- MEASURES ----

  # DAX: $_valor_bench_vigente = SUM(valor) WHERE concepto="Vigente"
  measure: valor_bench_vigente {
    type: sum
    sql: ${valor_dim} ;;
    label: "Vigente"
    description: "DAX: $_valor_bench_vigente"
    filters: [concepto: "Vigente"]
    value_format: "$#,##0"
  }

  # DAX: $_valor_bench_carteraVencida
  measure: valor_bench_cartera_vencida {
    type: sum
    sql: ${valor_dim} ;;
    label: "Cartera Vencida"
    description: "DAX: $_valor_bench_carteraVencida"
    filters: [concepto: "Cartera Vencida"]
    value_format: "$#,##0"
  }

  # DAX: $_valor_bench_saldoCartera
  measure: valor_bench_saldo_cartera {
    type: sum
    sql: ${valor_dim} ;;
    label: "Saldo Cartera"
    description: "DAX: $_valor_bench_saldoCartera"
    filters: [concepto: "Saldo Cartera"]
    value_format: "$#,##0"
  }

  # DAX: $Saldo_Otros = CALCULATE(SUM(valor), grupo_aval=0, codigo_banco<>'1-999', codigo_banco<>'36')
  measure: saldo_otros {
    type: sum
    sql: CASE WHEN ${grupo_aval} = 0 AND ${codigo_banco} != '1-999' AND ${codigo_banco} != '36'
      THEN ${valor_dim} ELSE 0 END ;;
    label: "Saldo Otros"
    description: "DAX: $Saldo_Otros"
    value_format: "#,##0"
  }

  # DAX: $Ind_Mora_AVAL = DIVIDE(Cartera Vencida Aval, Saldo Cartera Aval)
  measure: indicador_mora_aval {
    type: number
    sql: SAFE_DIVIDE(
      SUM(CASE WHEN ${concepto} = 'Cartera Vencida' THEN ${valor_dim} ELSE 0 END),
      SUM(CASE WHEN ${concepto} = 'Saldo Cartera' THEN ${valor_dim} ELSE 0 END)
    ) ;;
    label: "Indicador Mora Aval"
    description: "DAX: $Ind_Mora_AVAL"
    value_format: "0.00%"
  }

  measure: total_valor {
    type: sum
    sql: ${valor_dim} ;;
    label: "Total Valor"
    value_format: "$#,##0"
  }
}
