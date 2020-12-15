view: hll_test {
  derived_table: {
    sql: select prc_date,prc_hour,prc_min,store_id,theme_name,country,browser,os,
      APPROX_COUNT_DISTINCT(ip_hll) as count_distinct_ip_hll,
      APPROX_COUNT_DISTINCT(client_hll) as count_distinct_client_hll,
      from Temp_table_forBI.HLL_test01_prc_min_store_id
      group by 1,2,3,4,5,6,7,8
      limit 5000
       ;;
    persist_for: "24 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: prc_date {
    type: date
    datatype: date
    sql: ${TABLE}.prc_date ;;
  }

  dimension_group: prc_hour {
    type: time
    datatype: datetime
    sql: ${TABLE}.prc_hour ;;
  }

  dimension_group: prc_min {
    type: time
    datatype: datetime
    sql: ${TABLE}.prc_min ;;
  }

  dimension: store_id {
    type: string
    sql: ${TABLE}.store_id ;;
  }

  dimension: theme_name {
    type: string
    sql: ${TABLE}.theme_name ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: count_distinct_ip_hll {
    type: number
    sql: ${TABLE}.count_distinct_ip_hll ;;
  }

  dimension: count_distinct_client_hll {
    type: number
    sql: ${TABLE}.count_distinct_client_hll ;;
  }

  measure: m_count_distinct_ip_hll {
    type: average
    sql: ${count_distinct_ip_hll};;
  }

  measure: m_count_distinct_client_hll {
    type: average
    sql: ${count_distinct_client_hll} ;;
  }

  set: detail {
    fields: [
      prc_date,
      prc_hour_time,
      prc_min_time,
      store_id,
      theme_name,
      country,
      browser,
      os,
      count_distinct_ip_hll,
      count_distinct_client_hll
    ]
  }
}
