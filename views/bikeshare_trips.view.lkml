view: bikeshare_trips {
  derived_table: {
    sql: SELECT * FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips` WHERE {% condition start_date %} start_time {% endcondition %} AND {% condition start_year %} start_time {% endcondition %};;
  }

  dimension: bikeid {
    type: string
    description: "ID of bike used"
    sql: ${TABLE}.bikeid ;;
  }

  dimension: duration_minutes {
    type: number
    description: "Time of trip in minutes"
    sql: ${TABLE}.duration_minutes ;;
  }

  dimension: end_station_id {
    type: string
    description: "Numeric reference for end station"
    sql: ${TABLE}.end_station_id ;;
  }

  dimension: end_station_name {
    type: string
    description: "Station name for end station"
    sql: ${TABLE}.end_station_name ;;
  }

  dimension: start_station_id {
    type: number
    description: "Numeric reference for start station"
    sql: ${TABLE}.start_station_id ;;
  }

  dimension: start_station_name {
    type: string
    description: "Station name for start station"
    sql: ${TABLE}.start_station_name ;;
  }

  dimension_group: start {
    type: time
    description: "Start timestamp of trip"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
  }

  dimension: subscriber_type {
    type: string
    description: "Type of the Subscriber"
    sql: ${TABLE}.subscriber_type ;;
  }

  dimension: trip_id {
    type: number
    description: "Numeric ID of bike trip"
    sql: ${TABLE}.trip_id ;;
  }

  measure: count {
    type: count
    drill_fields: [start_station_name, end_station_name]
  }
}
