view: time_granularity {
  derived_table: {
    sql: select extract(time from timestamp('2020-12-31 16:30:39')) as date_1
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: date_1 {
    type: time
    sql: ${TABLE}.date_1 ;;
  }

  set: detail {
    fields: [date_1_time]
  }
}

view: date_granularity {
  derived_table: {
    sql: select extract(date from timestamp('2020-12-31 16:30:39')) as date_1
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: date_1 {
    type: time
    sql: ${TABLE}.date_1 ;;
  }

  set: detail {
    fields: [date_1_time]
  }
}


view: my_view {
  sql_table_name:
    { % if time_param._parameter_value == "date" % }
      ${date_granularity.SQL_TABLE_NAME}
    { % else % }
      ${time_granularity.SQL_TABLE_NAME}
    { % endif % } ;;


    parameter: time_param {
      type: unquoted
      allowed_value: {
        label: "date"
        value: "date"
      }
      allowed_value: {
        label: "time"
        value: "time"
      }
      # add as many allowed_values as you have tables
    }

  dimension_group: date_1 {
    type: time
    sql: ${TABLE}.date_1 ;;
  }

  # measure: count{
  #   type: count
  # }

  }
