view: problem_2 {
  derived_table: {
    sql: with pre_group as (select
        date(date_min) as prc_date,
        store_id,
        country,
        event,
        hll_count.merge(ip_hll) as client_id_num
        from `admin-account-293313.HLL_scheduled.hll_mins_PvUvUsd_store_id_0915_utc_tongbin`
        where {% condition prc_date %} date(date_min) {% endcondition %}
        and  {% condition event %} event {% endcondition %}
        and  {% condition country %} country {% endcondition %}
        group by 1,2,3,4
      )
      select
        prc_date,
        client_id_num,
        country,
        event
      from pre_group
       ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: sum_client_num {
    type: sum
    sql: ${client_id_num} ;;
  }

  dimension: prc_date {
    type: date
    datatype: date
    sql: ${TABLE}.prc_date ;;
  }

  dimension: client_id_num {
    type: number
    sql: ${TABLE}.client_id_num ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  set: detail {
    fields: [prc_date, client_id_num, country, event]
  }
}
