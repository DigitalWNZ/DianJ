view: rolling_test {
  derived_table: {
    sql: with initial_group as(
      SELECT
        CAST(safe_cast(hll_test01_prc_min_store_id.prc_hour as TIMESTAMP)  AS DATE) AS hll_test01_prc_min_store_id_prc_hour_date,
        EXTRACT(HOUR FROM safe_cast(hll_test01_prc_min_store_id.prc_hour as TIMESTAMP) ) AS hll_test01_prc_min_store_id_prc_hour_hour_of_day,
        (COUNT(DISTINCT hll_test01_prc_min_store_id.ip_hll ))  AS hll_test01_prc_min_store_id_count
      FROM `Temp_table_forBI.HLL_test01_prc_min_store_id`
           AS hll_test01_prc_min_store_id
      GROUP BY 1,2)
      select
      hll_test01_prc_min_store_id_prc_hour_date,
      hll_test01_prc_min_store_id_prc_hour_hour_of_day,
      hll_test01_prc_min_store_id_count,
      sum(hll_test01_prc_min_store_id_count) over
      (partition by hll_test01_prc_min_store_id_prc_hour_date
      order by  hll_test01_prc_min_store_id_prc_hour_hour_of_day
      rows between UNBOUNDED PRECEDING AND CURRENT ROW) as hll_test01_prc_min_store_id_count_rolling
      from initial_group
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hll_test01_prc_min_store_id_prc_hour_date {
    type: date
    datatype: date
    sql: ${TABLE}.hll_test01_prc_min_store_id_prc_hour_date ;;
  }

  dimension: hll_test01_prc_min_store_id_prc_hour_hour_of_day {
    type: number
    sql: ${TABLE}.hll_test01_prc_min_store_id_prc_hour_hour_of_day ;;
  }

  dimension: hll_test01_prc_min_store_id_count {
    type: number
    sql: ${TABLE}.hll_test01_prc_min_store_id_count ;;
  }

  dimension: hll_test01_prc_min_store_id_count_rolling {
    type: number
    sql: ${TABLE}.hll_test01_prc_min_store_id_count_rolling ;;
  }

  measure: test_rolling {
    type: average
    sql: ${hll_test01_prc_min_store_id_count_rolling};;
  }

  set: detail {
    fields: [hll_test01_prc_min_store_id_prc_hour_date, hll_test01_prc_min_store_id_prc_hour_hour_of_day, hll_test01_prc_min_store_id_count, hll_test01_prc_min_store_id_count_rolling]
  }
}
