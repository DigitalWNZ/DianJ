view: csv_import {
  sql_table_name: `admin-account-293313.Temp_table_forBI.csv_import`
    ;;

  dimension_group: date_field_0 {
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
    sql: ${TABLE}.date_field_0 ;;
  }

  dimension_group: date_field_2 {
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
    sql: ${TABLE}.date_field_2 ;;
  }

  dimension: string_field_1 {
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }

  dimension: string_field_3 {
    type: string
    sql: ${TABLE}.string_field_3 ;;
  }

  measure: count_order {
    type: count
    drill_fields: []
  }

  measure: count_return {
    type: count
    filters: [date_field_2_date: "NOT NULL"]
  }

  measure: count_return_1 {
    type: sum
    sql:
      case
        when ${date_field_2_date} is not null then 1 else 0 end;;
  }
}
