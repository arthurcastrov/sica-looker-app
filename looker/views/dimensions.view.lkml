# ============================================================
# Dimensiones compartidas
# ============================================================

# Dimensión: Género
view: dim_gender {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_dim_gender` ;;
  dimension: gender_tp_cd { type: string sql: ${TABLE}.gender_tp_cd ;; primary_key: yes hidden: yes }
  dimension: gender_tp_ds { type: string sql: ${TABLE}.gender_tp_ds ;; label: "Género" }
}

# Dimensión: Estado Civil
view: dim_estado_civil {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_dim_estado_civil` ;;
  dimension: marital_st_tp_cd { type: string sql: ${TABLE}.marital_st_tp_cd ;; primary_key: yes hidden: yes }
  dimension: marital_st_tp_ds { type: string sql: ${TABLE}.marital_st_tp_ds ;; label: "Estado Civil" }
}

# Dimensión: Nivel Educativo
view: dim_nivel_educativo {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_dim_nivel_educativo` ;;
  dimension: highest_edu_tp_cd { type: string sql: ${TABLE}.highest_edu_tp_cd ;; primary_key: yes hidden: yes }
  dimension: highest_edu_tp_ds { type: string sql: ${TABLE}.highest_edu_tp_ds ;; label: "Nivel Educativo" }
}

# Dimensión: Estado Cliente
view: dim_estado_cliente {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_dim_estado_cliente` ;;
  dimension: client_st_tp_cd { type: string sql: ${TABLE}.client_st_tp_cd ;; primary_key: yes hidden: yes }
  dimension: client_st_tp_ds { type: string sql: ${TABLE}.client_st_tp_ds ;; label: "Estado Cliente" }
}

# Dimensión: Ocupación
view: dim_ocupacion {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_dim_ocupacion` ;;
  dimension: occupation_tp_cd { type: string sql: ${TABLE}.occupation_tp_cd ;; primary_key: yes hidden: yes }
  dimension: occupation_tp_ds { type: string sql: ${TABLE}.occupation_tp_ds ;; label: "Ocupación" }
}

# Dimensión: Profesión
view: dim_profesion {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_dim_profesion` ;;
  dimension: profession_tp_cd { type: string sql: ${TABLE}.profession_tp_cd ;; primary_key: yes hidden: yes }
  dimension: profession_tp_ds { type: string sql: ${TABLE}.profession_tp_ds ;; label: "Profesión" }
}

# Dimensión: Segmento Categoría
view: dim_seg_cat {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_dim_seg_cat` ;;
  dimension: seg_cat_tp_cd { type: string sql: ${TABLE}.seg_cat_tp_cd ;; primary_key: yes hidden: yes }
  dimension: seg_cat_tp_ds { type: string sql: ${TABLE}.seg_cat_tp_ds ;; label: "Categoría Segmento" }
}

# Dimensión: CIIU
view: dim_ciiu {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_dim_ciiu` ;;
  dimension: ciiu_tp_cd { type: string sql: ${TABLE}.ciiu_tp_cd ;; primary_key: yes hidden: yes }
  dimension: ciiu_tp_ds { type: string sql: ${TABLE}.ciiu_tp_ds ;; label: "Actividad Económica (CIIU)" }
}

# Dimensión: Producto
view: dim_producto {
  sql_table_name: `adl-analytics-project.sica_analytics.eco_aval_dim_producto` ;;
  dimension: cod_producto { type: string sql: ${TABLE}.cod_producto ;; primary_key: yes hidden: yes }
  dimension: producto_ds { type: string sql: ${TABLE}.producto_ds ;; label: "Producto" }
}

# Dimensión: Bancos
view: dim_bancos {
  sql_table_name: `adl-analytics-project.sica_analytics.tabla_bancos` ;;
  dimension: entidad { type: string sql: ${TABLE}.entidad ;; primary_key: yes label: "Entidad" }
  dimension: nombre_banco { type: string sql: ${TABLE}.nombre_banco ;; label: "Nombre Banco" }
}
