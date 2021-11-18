connection: "my-bq"

# include all the views
include: "/views/**/*.view"

datagroup: austin_bikeshare_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: austin_bikeshare_default_datagroup

explore: bikeshare_stations {}

explore: bikeshare_trips {
  join: bikeshare_stations {
    sql_on: ${bikeshare_stations.station_id} = ${bikeshare_trips.start_station_id} ;;
  }
}

explore: customer_success_analyst {}
explore: lessons {}
