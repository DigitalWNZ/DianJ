view: problem_3 {
  derived_table: {
    sql: select
        date(date_min,"Asia/Shanghai") as prc_date,
        store_id,
        hll_count.merge(ip_hll) as client_id_num
        from `admin-account-293313.HLL_scheduled.hll_mins_PvUvUsd_store_id_0915_utc_tongbin`
        where {% condition prc_date %} date(date_min) {% endcondition %}
        and  event = {% parameter event %}
        and country= {% parameter country %}
        group by 1,2;;
  }


  parameter: country {
    description: "country"
    type: string
  }

  parameter: event {
    description: "event"
    type: string
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

  # dimension: country {
  #   type: string
  #   sql: ${TABLE}.country ;;
  # }

  # dimension: event {
  #   type: string
  #   sql: ${TABLE}.event ;;
  # }

  set: detail {
    fields: [prc_date, client_id_num, country, event]
  }
}
