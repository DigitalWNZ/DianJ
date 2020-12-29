view: count_by_store {
  derived_table: {
    sql: select store_id, date(prc_date) as dt ,count(*) as count_by_store from Temp_table_forBI.HLL_test01_prc_min_store_id group by store_id, date(prc_date)
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

  dimension: dt {
    type: date
    datatype: date
    sql: ${TABLE}.dt ;;
  }

  dimension: count_by_store {
    type: number
    sql: ${TABLE}.count_by_store ;;
  }

  set: detail {
    fields: [store_id, dt, count_by_store]
  }
}
