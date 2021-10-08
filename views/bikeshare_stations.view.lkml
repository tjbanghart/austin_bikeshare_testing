view: bikeshare_stations {
  sql_table_name: `bigquery-public-data.austin_bikeshare.bikeshare_stations`
    ;;

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: alternate_name {
    type: string
    sql: ${TABLE}.alternate_name ;;
  }

  dimension: city_asset_number {
    type: number
    sql: ${TABLE}.city_asset_number ;;
  }

  dimension: council_district {
    type: number
    sql: ${TABLE}.council_district ;;
  }

  dimension: footprint_length {
    type: number
    sql: ${TABLE}.footprint_length ;;
  }

  dimension: footprint_width {
    type: number
    sql: ${TABLE}.footprint_width ;;
  }

  dimension_group: modified {
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
    sql: ${TABLE}.modified_date ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: number_of_docks {
    type: number
    sql: ${TABLE}.number_of_docks ;;
  }

  dimension: power_type {
    type: string
    sql: ${TABLE}.power_type ;;
  }

  dimension: property_type {
    type: string
    sql: ${TABLE}.property_type ;;
  }

  dimension: station_id {
    type: number
    sql: ${TABLE}.station_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
    drill_fields: [alternate_name, name]
  }
}
