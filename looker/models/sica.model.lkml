connection: "adl-analytics-project"

# Include all views
include: "/views/**/*.view.lkml"

# ============================================================
# PERSONA NATURAL (PN)
# ============================================================

explore: fct_clientes_pn {
  label: "Clientes Persona Natural"
  description: "Clientes PN con métricas demográficas y de vinculación"
  join: dim_gender {
    type: left_outer
    sql_on: ${fct_clientes_pn.gender_tp_code} = ${dim_gender.gender_tp_cd} ;;
    relationship: many_to_one
  }
  join: dim_estado_civil {
    type: left_outer
    sql_on: ${fct_clientes_pn.marital_st_tp_cd} = ${dim_estado_civil.marital_st_tp_cd} ;;
    relationship: many_to_one
  }
  join: dim_nivel_educativo {
    type: left_outer
    sql_on: ${fct_clientes_pn.highest_edu_tp_cd} = ${dim_nivel_educativo.highest_edu_tp_cd} ;;
    relationship: many_to_one
  }
  join: dim_estado_cliente {
    type: left_outer
    sql_on: ${fct_clientes_pn.client_st_tp_cd} = ${dim_estado_cliente.client_st_tp_cd} ;;
    relationship: many_to_one
  }
  join: dim_ocupacion {
    type: left_outer
    sql_on: ${fct_clientes_pn.occupation_tp_cd} = ${dim_ocupacion.occupation_tp_cd} ;;
    relationship: many_to_one
  }
  join: dim_profesion {
    type: left_outer
    sql_on: ${fct_clientes_pn.profession_tp_cd} = ${dim_profesion.profession_tp_cd} ;;
    relationship: many_to_one
  }
  join: dim_seg_cat {
    type: left_outer
    sql_on: ${fct_clientes_pn.seg_cat_tp_cd} = ${dim_seg_cat.seg_cat_tp_cd} ;;
    relationship: many_to_one
  }
}

explore: fct_productos_pn {
  label: "Productos Persona Natural"
  description: "Productos PN: cantidades, márgenes, antigüedad"
  join: dim_producto {
    type: left_outer
    sql_on: ${fct_productos_pn.cod_producto} = ${dim_producto.cod_producto} ;;
    relationship: many_to_one
  }
}

explore: buro_bancos_pn {
  label: "Buró PN - Bancos"
  description: "Información de buró de crédito PN - vista sistema financiero"
}

explore: buro_aval_pn {
  label: "Buró PN - Aval"
  description: "Información de buró de crédito PN - vista Grupo Aval"
}

# ============================================================
# PERSONA JURÍDICA (PJ)
# ============================================================

explore: fct_clientes_pj {
  label: "Clientes Persona Jurídica"
  description: "Clientes PJ con métricas empresariales"
}

explore: fct_productos_pj {
  label: "Productos Persona Jurídica"
  description: "Productos PJ: cantidades, márgenes"
}

explore: buro_bancos_pj {
  label: "Buró PJ - Bancos"
  description: "Información de buró PJ - sistema financiero"
}

explore: buro_aval_pj {
  label: "Buró PJ - Aval"
  description: "Información de buró PJ - Grupo Aval"
}

# ============================================================
# TARJETAS DE CRÉDITO
# ============================================================

explore: tc_productos {
  label: "TC Productos"
  description: "Tarjetas de crédito: cupos, deudas, tarjetas"
}

explore: sfc_tc {
  label: "SFC Tarjetas de Crédito"
  description: "Benchmarks Superfinanciera de tarjetas de crédito"
}

# ============================================================
# APORTES Y NÓMINA
# ============================================================

explore: aportes_empresas {
  label: "Aportes Empresas"
  description: "Aportes de empresas, nómina y penetración por banco"
}

# ============================================================
# FINANCIEROS
# ============================================================

explore: margen_productos {
  label: "Margen por Productos"
  description: "PyG: margen financiero por productos"
}

explore: margen_clientes {
  label: "Margen por Clientes"
  description: "Margen financiero agregado por clientes"
}

explore: depositos_reporte {
  label: "Depósitos Reporte"
  description: "Reporte de depósitos y saldos"
}

explore: saldos_depositos {
  label: "Saldos Depósitos"
  description: "Saldos de depósitos a vista y término"
}

explore: flujo_dinero {
  label: "Flujo de Dinero"
  description: "Montos transaccionales"
}

# ============================================================
# VISIÓN DEL GRUPO / NIIF
# ============================================================

explore: niif_entidades {
  label: "Visión del Grupo"
  description: "KPIs financieros NIIF: ROE, ROA, NIM, market share"
}

explore: superfinanciera_captaciones {
  label: "SFC Captaciones"
  description: "Captaciones reportadas a Superfinanciera"
}

explore: superfinanciera_desembolsos {
  label: "SFC Desembolsos"
  description: "Desembolsos reportados a Superfinanciera"
}

# ============================================================
# INDICADORES Y BENCHMARKS
# ============================================================

explore: indicadores_zeus {
  label: "Indicadores Zeus"
  description: "Indicadores de seguimiento semanal Zeus"
}

explore: bench_activo {
  label: "Benchmarks Activos"
  description: "Benchmarks SFC: cartera vigente, vencida, saldos"
}

explore: saldos_clientes_pn {
  label: "Saldos Clientes PN"
  description: "Saldos de clientes PN año anterior"
}

explore: saldos_clientes_pj {
  label: "Saldos Clientes PJ"
  description: "Saldos de clientes PJ año anterior"
}
