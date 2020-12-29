view: demo_for_tongbin {
  derived_table: {
    sql: select * from HLL_scheduled.hll_mins_PvUvUsd_store_id_0915_utc_tongbin limit 100
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension_group: date_min {
    type: time
    sql: ${TABLE}.date_min ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: store_id {
    type: string
    sql: ${TABLE}.store_id ;;
  }

  dimension: client_hll {
    type: string
    sql: ${TABLE}.client_hll ;;
  }

  dimension: client_pv {
    type: number
    sql: ${TABLE}.client_pv ;;
  }

  dimension: ip_hll {
    type: string
    sql: ${TABLE}.ip_hll ;;
  }

  dimension: ip_pv {
    type: number
    sql: ${TABLE}.ip_pv ;;
  }

  dimension: usd_total {
    type: number
    sql: ${TABLE}.usd_total ;;
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

  dimension: fx_os {
    type: string
    sql: ${TABLE}.fx_os ;;
  }

  dimension: fx_channel {
    type: string
    sql: ${TABLE}.fx_channel ;;
  }

  set: detail {
    fields: [
      date,
      date_min_time,
      event,
      store_id,
      client_hll,
      client_pv,
      ip_hll,
      ip_pv,
      usd_total,
      theme_name,
      country,
      browser,
      fx_os,
      fx_channel
    ]
  }
}
