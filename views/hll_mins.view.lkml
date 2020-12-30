view: hll_mins {
  derived_table: {
    sql: with hll_merge as
      (SELECT
            extract( date from date_min) as dt,
            HLL_COUNT.MERGE(case when t.event='pageview' then ip_hll else null end) as pageview_ip,
            HLL_COUNT.MERGE(case when t.event='add_to_cart' then ip_hll else null end) as add_to_cart_ip,
            HLL_COUNT.MERGE(case when t.event='begin_checkout' then ip_hll else null end) as check_out_ip,
            HLL_COUNT.MERGE(case when t.event='set_shipping_address' then ip_hll else null end) as add_shipping_address_ip,
            HLL_COUNT.MERGE(case when t.event='add_payment_info' then ip_hll else null end) as add_payment_info_ip,
            HLL_COUNT.MERGE(case when t.event='place_order' then ip_hll else null end) as place_order_ip,
            FROM `admin-account-293313.HLL_scheduled.hll_mins_PvUvUsd_store_id_0915_utc_tongbin` as t
            where {% condition country %} t.country {% endcondition %}
            GROUP BY extract(date from date_min))

      select
      country,
      date_min,
      hll_merge.*
      from `admin-account-293313.HLL_scheduled.hll_mins_PvUvUsd_store_id_0915_utc_tongbin` t1
      left join hll_merge
      on extract(date from date_min)=hll_merge.dt
      where {% condition country %} t1.country {% endcondition %}
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: date_min {
    type: time
    sql: ${TABLE}.date_min ;;
    convert_tz: yes
  }

  dimension: dt {
    type: date
    datatype: date
    sql: ${TABLE}.dt ;;
    convert_tz: yes
  }

  dimension: pageview_ip {
    type: number
    sql: ${TABLE}.pageview_ip ;;
  }

  dimension: add_to_cart_ip {
    type: number
    sql: ${TABLE}.add_to_cart_ip ;;
  }

  dimension: check_out_ip {
    type: number
    sql: ${TABLE}.check_out_ip ;;
  }

  dimension: add_shipping_address_ip {
    type: number
    sql: ${TABLE}.add_shipping_add_ip ;;
  }

  dimension: add_payment_info_ip {
    type: number
    sql: ${TABLE}.add_payment_info_ip ;;
  }

  measure: place_order_ip {
    type: average
    sql: ${TABLE}.place_order_ip ;;
  }


  measure: m_pageview_ip {
    type: average
    sql: ${TABLE}.pageview_ip ;;
  }

  measure: m_add_to_cart_ip {
    type: average
    sql: ${TABLE}.add_to_cart_ip ;;
  }

  measure: m_check_out_ip {
    type: average
    sql: ${TABLE}.check_out_ip ;;
  }

  measure: m_add_shipping_address_ip {
    type: average
    sql: ${TABLE}.add_shipping_add_ip ;;
  }

  measure: m_add_payment_info_ip {
    type: average
    sql: ${TABLE}.add_payment_info_ip ;;
  }

  measure: m_place_order_ip {
    type: average
    sql: ${TABLE}.place_order_ip ;;
  }

  set: detail {
    fields: [
      country,
      date_min_time,
      dt,
      pageview_ip,
      add_to_cart_ip,
      check_out_ip,
      add_shipping_address_ip,
      add_payment_info_ip,
      place_order_ip
    ]
  }
}
