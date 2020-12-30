view: hll_mins_pv_uv_usd_store_id_0915_utc_tongbin {
  sql_table_name: `admin-account-293313.HLL_scheduled.hll_mins_PvUvUsd_store_id_0915_utc_tongbin`
    ;;

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: client_hll {
    type: string
    sql: ${TABLE}.client_hll ;;
  }

  dimension: client_pv {
    type: number
    sql: ${TABLE}.client_pv ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: yes
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension_group: date_min {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_min ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: fx_channel {
    type: string
    sql: ${TABLE}.fx_channel ;;
  }

  dimension: fx_os {
    type: string
    sql: ${TABLE}.fx_os ;;
  }

  dimension: ip_hll {
    type: string
    sql: ${TABLE}.ip_hll ;;
  }

  dimension: pageview_ip_hll {
    type: string
    sql: case when ${event}='pageview' then ${ip_hll} else null end ;;
  }

  dimension: addcart_ip_hll {
    type: string
    sql: case when ${event}='add_to_cart' then ${ip_hll} else null end ;;
  }

  dimension: checkout_ip_hll {
    type: string
    sql: case when ${event}='begin_checkout' then ${ip_hll} else null end ;;
  }

  dimension: shipaddr_ip_hll {
    type: string
    sql: case when ${event}='set_shipping_address' then ${ip_hll} else null end ;;
  }

  dimension: payment_ip_hll {
    type: string
    sql: case when ${event}='add_payment_info' then ${ip_hll} else null end ;;
  }

  dimension: order_ip_hll {
    type: string
    sql: case when ${event}='place_order' then ${ip_hll} else null end ;;
  }


  measure: sum_pageview {
    type: number
    sql: hll_count.merge(${pageview_ip_hll}) ;;
  }

  measure: sum_addcart {
    type: number
    sql: hll_count.merge(${addcart_ip_hll}) ;;
  }

  measure: sum_checkout{
    type: number
    sql: hll_count.merge(${checkout_ip_hll}) ;;
  }

  measure: sum_shipaddr {
    type: number
    sql: hll_count.merge(${shipaddr_ip_hll}) ;;
  }

  measure: sum_payment {
    type: number
    sql: hll_count.merge(${payment_ip_hll}) ;;
  }

  measure: sum_order {
    type: number
    sql: hll_count.merge(${order_ip_hll}) ;;
  }

  dimension: ip_pv {
    type: number
    sql: ${TABLE}.ip_pv ;;
  }

  dimension: payment_channel {
    type: string
    sql: ${TABLE}.payment_channel ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: store_id {
    type: string
    sql: ${TABLE}.store_id ;;
  }

  dimension: theme_name {
    type: string
    sql: ${TABLE}.theme_name ;;
  }

  dimension: theme_version {
    type: string
    sql: ${TABLE}.theme_version ;;
  }

  dimension: usd_total {
    type: number
    sql: ${TABLE}.usd_total ;;
  }

  measure: count {
    type: count
    drill_fields: [theme_name]
  }

  measure: count_ip_hll {
    type: number
    sql: hll_count.merge(${ip_hll}) ;;
  }
}
