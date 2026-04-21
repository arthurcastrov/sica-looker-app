# ============================================================
# Vista: NIIF Entidades (Visión del Grupo)
# Fuente DAX: sica_niif_entidades
# displayFolder: Vision_del_grupo
# ============================================================

view: niif_entidades {
  sql_table_name: `adl-analytics-project.sica_analytics.sica_niif_entidades` ;;

  dimension: entidad { type: string sql: ${TABLE}.entidad ;; label: "Entidad" }
  dimension: concepto { type: string sql: ${TABLE}.concepto ;; label: "Concepto" }
  dimension: grupo_aval { type: number sql: ${TABLE}.grupo_aval ;; label: "Grupo Aval" }
  dimension: cuenta { type: string sql: ${TABLE}.cuenta ;; label: "Cuenta" }
  dimension: subcuenta { type: string sql: ${TABLE}.subcuenta ;; label: "Subcuenta" }
  dimension: periodo { type: string sql: ${TABLE}.periodo ;; label: "Periodo" }
  dimension: valor_dim { hidden: yes type: number sql: ${TABLE}.valor ;; }
  dimension_group: fecha_corte {
    type: time
    timeframes: [raw, date, month, quarter, year]
    sql: ${TABLE}.fecha_corte ;;
    label: "Fecha Corte"
    datatype: date
  }

  # ---- MEASURES (displayFolder: Vision_del_grupo) ----

  # Valores base
  measure: total_valor {
    type: sum
    sql: ${valor_dim} ;;
    label: "Total Valor"
    value_format: "$#,##0"
  }

  # DAX: $_activos = SUM(valor) WHERE concepto="Activos"
  measure: activos {
    type: sum
    sql: ${valor_dim} ;;
    label: "Activos"
    filters: [concepto: "Activos"]
    value_format: "$#,##0"
  }

  # DAX: $_patrimonio = SUM(valor) WHERE concepto="Patrimonio"
  measure: patrimonio {
    type: sum
    sql: ${valor_dim} ;;
    label: "Patrimonio"
    filters: [concepto: "Patrimonio"]
    value_format: "$#,##0"
  }

  # DAX: $_utilidad_neta = SUM(valor) WHERE concepto="Utilidad Neta"
  measure: utilidad_neta {
    type: sum
    sql: ${valor_dim} ;;
    label: "Utilidad Neta"
    filters: [concepto: "Utilidad Neta"]
    value_format: "$#,##0"
  }

  # DAX: $_ingresos_interes = SUM(valor) WHERE concepto="Ingresos Intereses"
  measure: ingresos_interes {
    type: sum
    sql: ${valor_dim} ;;
    label: "Ingresos Intereses"
    filters: [concepto: "Ingresos Intereses"]
    value_format: "$#,##0"
  }

  # DAX: $_gastos_interes = SUM(valor) WHERE concepto="Gastos Intereses"
  measure: gastos_interes {
    type: sum
    sql: ${valor_dim} ;;
    label: "Gastos Intereses"
    filters: [concepto: "Gastos Intereses"]
    value_format: "$#,##0"
  }

  # DAX: $_cartera_bruta = SUM(valor) WHERE concepto="Cartera Bruta"
  measure: cartera_bruta {
    type: sum
    sql: ${valor_dim} ;;
    label: "Cartera Bruta"
    filters: [concepto: "Cartera Bruta"]
    value_format: "$#,##0"
  }

  # DAX: $_depositos = SUM(valor) WHERE concepto="Depositos"
  measure: depositos {
    type: sum
    sql: ${valor_dim} ;;
    label: "Depósitos"
    filters: [concepto: "Depositos"]
    value_format: "$#,##0"
  }

  # DAX: $_provisiones = SUM(valor) WHERE concepto="Provisiones"
  measure: provisiones {
    type: sum
    sql: ${valor_dim} ;;
    label: "Provisiones"
    filters: [concepto: "Provisiones"]
    value_format: "$#,##0"
  }

  # DAX: $_cartera_vencida = SUM(valor) WHERE concepto="Cartera Vencida"
  measure: cartera_vencida {
    type: sum
    sql: ${valor_dim} ;;
    label: "Cartera Vencida"
    filters: [concepto: "Cartera Vencida"]
    value_format: "$#,##0"
  }

  # KPI: ROE = Utilidad Neta / Patrimonio
  measure: roe {
    type: number
    sql: SAFE_DIVIDE(${utilidad_neta}, ${patrimonio}) ;;
    label: "ROE"
    description: "Return on Equity = Utilidad Neta / Patrimonio"
    value_format: "0.00%"
  }

  # KPI: ROA = Utilidad Neta / Activos
  measure: roa {
    type: number
    sql: SAFE_DIVIDE(${utilidad_neta}, ${activos}) ;;
    label: "ROA"
    description: "Return on Assets = Utilidad Neta / Activos"
    value_format: "0.00%"
  }

  # KPI: NIM = (Ingresos Intereses - Gastos Intereses) / Activos
  measure: nim {
    type: number
    sql: SAFE_DIVIDE(${ingresos_interes} - ${gastos_interes}, ${activos}) ;;
    label: "NIM"
    description: "Net Interest Margin"
    value_format: "0.00%"
  }

  # KPI: Indicador calidad cartera = Cartera Vencida / Cartera Bruta
  measure: indicador_calidad_cartera {
    type: number
    sql: SAFE_DIVIDE(${cartera_vencida}, ${cartera_bruta}) ;;
    label: "Indicador Calidad Cartera"
    description: "Cartera Vencida / Cartera Bruta"
    value_format: "0.00%"
  }

  # KPI: Cobertura = Provisiones / Cartera Vencida
  measure: cobertura {
    type: number
    sql: SAFE_DIVIDE(${provisiones}, ${cartera_vencida}) ;;
    label: "Cobertura"
    description: "Provisiones / Cartera Vencida"
    value_format: "0.00%"
  }

  # KPI: Eficiencia = Gastos / Ingresos
  measure: eficiencia {
    type: number
    sql: SAFE_DIVIDE(${gastos_interes}, ${ingresos_interes}) ;;
    label: "Eficiencia"
    description: "Gastos Intereses / Ingresos Intereses"
    value_format: "0.00%"
  }

  # ---- YTD ----
  # Cuando filtras por un mes (ej: fecha_corte_month = "2025-11"),
  # este measure calcula el promedio desde Enero hasta ese mes (2025-01 → 2025-11).
  # Usa un subquery correlacionado: no requiere parámetro, funciona directo con filtros de API.

  measure: promedio_ytd_valor {
    type: number
    sql: (
      SELECT AVG(sub.valor)
      FROM `adl-analytics-project.sica_analytics.sica_niif_entidades` sub
      WHERE sub.fecha_corte >= DATE_TRUNC(${TABLE}.fecha_corte, YEAR)
        AND sub.fecha_corte <= LAST_DAY(${TABLE}.fecha_corte, MONTH)
    ) ;;
    label: "Promedio YTD Valor"
    description: "Promedio del valor YTD. Filtra un mes (ej: 2025-11) y calcula el promedio desde Enero hasta ese mes."
    value_format: "$#,##0.00"
  }
}
