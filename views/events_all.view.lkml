view: events_all {
  sql_table_name: `shoplaza.shoplaza_analysis_staging.events_all`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: browser_version {
    type: string
    sql: ${TABLE}.browser_version ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: client {
    type: string
    sql: ${TABLE}.client ;;
  }

  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: os_version {
    type: string
    sql: ${TABLE}.os_version ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: properties {
    hidden: yes
    sql: ${TABLE}.properties ;;
  }

  dimension: province {
    type: string
    sql: ${TABLE}.province ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: store_id {
    type: string
    sql: ${TABLE}.store_id ;;
  }

  dimension_group: time {
    type: time
    timeframes: [
      raw,
      hour,
      minute,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

  measure:count_distinct_ip{
    type: count_distinct
    sql: ${ip} ;;
  }

  measure: count_distinct_client {
    type: count_distinct
    sql: ${client_id} ;;
  }
}

view: events_all__properties {
  dimension: bool_value {
    type: yesno
    sql: ${TABLE}.bool_value ;;
  }

  dimension: float_value {
    type: number
    sql: ${TABLE}.float_value ;;
  }

  dimension: int_value {
    type: number
    sql: ${TABLE}.int_value ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: string_value {
    type: string
    sql: ${TABLE}.string_value ;;
  }
}
