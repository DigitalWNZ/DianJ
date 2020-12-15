view: csv_test {
  derived_table: {
    sql: select date_field_0,string_field_1,date_field_2,string_field_3 from Temp_table_forBI.csv_import

      ;;
  }
  #where (date_field_0 between extract(DATE from {% parameter order_start_date %}) and extract(DATE from {% parameter order_end_date %}))

  # parameter: order_start_date {
  #   type: date
  # }

  # parameter: order_end_date {
  #   type: date
  # }

  parameter: return_start_date {
    type: date
  }

  parameter: return_end_date {
    type: date
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_order {
    type: count
    drill_fields: []
  }

  # measure: count_return {
  #   type: count
  #   filters: [date_field_2: "NOT NULL"]
  # }

  dimension: return_in_range{
    type: number
  }
  measure: count_return_1 {
    type: sum
    sql:
      case
        when (${date_field_2_date}>extract(DATE from {% parameter return_start_date %}) and ${date_field_2_date}<=extract(DATE from {% parameter return_end_date %})) then 1 else 0 end;;
  }

  measure: return_rate {
    type: number
    sql: if(${count_order}=0,0,${count_return_1}/${count_order}) ;;
    value_format_name: percent_2

  }

  dimension: date_field_0 {
    type: date
    datatype: date
    sql: ${TABLE}.date_field_0 ;;
  }

  dimension: string_field_1 {
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }

  # dimension: date_field_2 {
  #   type: date
  #   datatype: date
  #   sql: ${TABLE}.date_field_2 ;;
  # }

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

  dimension: string_field_3 {
    type: string
    sql: ${TABLE}.string_field_3 ;;
  }

  set: detail {
    fields: [date_field_0, string_field_1, string_field_3]
  }
}
