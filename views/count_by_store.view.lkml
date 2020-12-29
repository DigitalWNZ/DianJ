view: count_by_store {
  derived_table: {
    sql: select store_id, count(*) as count_by_store from Temp_table_forBI.HLL_test01_prc_min_store_id group by store_id
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: store_id {
    type: string
    sql: ${TABLE}.store_id ;;
  }

  dimension: count_by_store {
    type: number
    sql: ${TABLE}.count_by_store ;;
  }

  set: detail {
    fields: [store_id, count_by_store]
  }
}
