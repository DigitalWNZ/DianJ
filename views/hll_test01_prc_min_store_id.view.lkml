view: hll_test01_prc_min_store_id {
  sql_table_name: `Temp_table_forBI.HLL_test01_prc_min_store_id`
    ;;

  parameter: time_granularity {
    allowed_value: {value: "Day"}
    allowed_value: {value: "Week"}
    allowed_value: {value: "Month"}
    allowed_value: {value: "Quarter"}
    allowed_value: {value: "Year"}
    allowed_value: {value: "Hour"}
    allowed_value: {value: "Minute"}
  }


  parameter: num_of_minutes {
    description: "the number of minutes"
    type: unquoted
    default_value: "1"
  }

  dimension: timekey {
    label_from_parameter: num_of_minutes
    type: string
    sql:
      safe_cast(TIMESTAMP_SECONDS({% parameter num_of_minutes %}*60 * DIV(UNIX_SECONDS(timestamp(${prc_min_time})), {% parameter num_of_minutes %}*60)) as string);;
  }

  dimension: time_dimension {
    label_from_parameter: time_granularity
    sql:
      case
        when {% parameter time_granularity %} = 'Day' THEN safe_cast(${prc_min_date} as string)
        when {% parameter time_granularity %} = 'Week' THEN safe_cast(${prc_min_week}  as string)
        when {% parameter time_granularity %} = 'Month' THEN safe_cast(${prc_min_month} as string)
        when {% parameter time_granularity %} = 'Quarter' THEN safe_cast(${prc_min_quarter} as string)
        when {% parameter time_granularity %} = 'Year' THEN safe_cast(${prc_min_year} as string)
        when {% parameter time_granularity %} = 'Hour' THEN safe_cast(${prc_min_hour} as string)
        when {% parameter time_granularity %} = 'Minute' THEN ${timekey}
      end;;
  }

  # dimension_group: timekey_test {
  #   label_from_parameter: num_of_minutes   --- label from parameter is not applicable to dimension group
  #   type: time
  #   timeframes: [raw, time, date, hour,hour_of_day, day_of_week,
  #     day_of_week_index, time_of_day, week,month_num, month, year, quarter,quarter_of_year]
  #   sql:TIMESTAMP_SECONDS({% parameter num_of_minutes %}*60 * DIV(UNIX_SECONDS(timestamp(${prc_min_time})), {% parameter num_of_minutes %}*60));;
  # }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: client_hll {
    type: string
    sql: ${TABLE}.client_hll ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: ip_hll {
    type: string
    sql: ${TABLE}.ip_hll ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension_group: prc {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.prc_date ;;
  }

  dimension_group: prc_hour {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: safe_cast(${TABLE}.prc_hour as TIMESTAMP) ;;
  }

  dimension_group: prc_min {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: safe_cast(${TABLE}.prc_min as TIMESTAMP) ;;
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



 measure: hll_count_test {
   type: number
   sql: (select hll_count.merge(${TABLE}.client_hll) from `admin-account-293313.Temp_table_forBI.hll_test01_prc_min_store_id` where ${TABLE}.event = 'PageView');;
 }
 measure: count_distinct_ip_hll {
    # type: number
    # sql: APPROX_COUNT_DISTINCT(ip_hll) ;;
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${ip_hll} ;;
  }




  # measure: percent_of_change_count_distince_ip {
  #   type: percent_of_previous
  #   sql: ${count_distinct_ip_hll} ;;
  # }

  measure: count_distinct_client_hll {
    # type: number
    # sql: APPROX_COUNT_DISTINCT(client_hll) ;;
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${client_hll} ;;
  }

  measure: count {
    type: count
    drill_fields: [theme_name]
  }
}
