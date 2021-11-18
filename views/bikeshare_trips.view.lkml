view: bikeshare_trips {
  derived_table: {
    sql: SELECT * FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips` WHERE {% condition start_date %} start_time {% endcondition %} AND {% condition start_year %} start_time {% endcondition %};;
  }

  dimension: bikeid {
    type: string
    description: "ID of bike used"
    sql: ${TABLE}.bikeid ;;
  }
##
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

# Used as lookup tables for specific Looker roles
# Andrew Searson 2017-05-25

view: account_manager {
  sql_table_name: salesforce.user ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: am_name {
    alias: [account_manager.name]
    label: "CSM Name"
    group_label: "Account Owners"
    sql: ${TABLE}.name ;;
  }

  dimension: csm_picture {
    sql: ${TABLE}.name ;;
    group_label: "Account Owners"
    html: <a href="/dashboards/913?Customer%20Success%20Manager={{value}}">
      {% if {{value}} == 'Alejandro Aguilera-Ruiz' %}
      <img src="https://wwwstatic.lookercdn.com/people/team/alejandro_aguilera_ruiz_v0002.jpg" height=100 width=100></a>
      {% elsif {{value}} == 'Clara Vaknin' %}
      <img src="https://wwwstatic.lookercdn.com/people/team/clara_hersh_v0001.jpg" height=100 width=100></a>
      {% elsif {{value}} == 'Drew Kells' %}
      <img src="https://wwwstatic.lookercdn.com/people/team/drew_kells_v0001.png" height=100 width=100></a>
      {% elsif {{value}} == 'Ryan Lee' %}
      <img src="https://wwwstatic.lookercdn.com/people/team/ryan_lee_v0002.jpg" height=100 width=100></a>
      {% elsif {{value}} == 'Jean Louise Manalo' %}
      <img src="https://wwwstatic.lookercdn.com/people/team/jean_louis_manalo_v0002.jpg" height=100 width=100></a>
      {% else %}
      <img src="https://wwwstatic.lookercdn.com/people/team/{{ lower_am_first_name._value }}_{{ lower_am_last_name._value }}_v0001.jpg" height=100 width=100></a>
      {% endif %}
      ;;
  }

  dimension: title {
    label: "Course Title"
    type: string
    sql: ${TABLE}.course_title ;;
    link: {
      label: "Link to Course in Skilljar"
      url: "{{ url._value}}"
    }
    link: {
      label: "External eLearning Dashboard"
      url: "/dashboards/3187?Course%20Name={{ value }}&Course%20Type=eLearning"
    }
    link: {
      label: "General Bootcamp/Webinar Dashboard"
      url: "/dashboards/3169?Date%20range=2018&Course%20Title={{ value }}"
    }
    link: {
      label: "Lessons Started but not Finished"
      url: "/explore/meta/student?fields=lesson.order,lesson.title&f[student_lesson_progress.has_completed_lesson]=No&f[enrollment._fivetran_deleted]=No&f[course.title]={{value}}&f[student.full_name]={{ _filters['student.student_name_filter'] | url_encode }}&sorts=lesson.order&limit=500&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22type%22%3A%22table%22%2C%22series_types%22%3A%7B%7D%2C%22show_view_names%22%3Atrue%2C%22show_row_numbers%22%3Atrue%2C%22truncate_column_names%22%3Afalse%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22table_theme%22%3A%22editable%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Atrue%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22conditional_formatting%22%3A%5B%7B%22type%22%3A%22equal+to%22%2C%22value%22%3A0%2C%22background_color%22%3A%22%23F36254%22%2C%22font_color%22%3Anull%2C%22palette%22%3A%7B%22name%22%3A%22Red+to+Yellow+to+Green%22%2C%22colors%22%3A%5B%22%23F36254%22%2C%22%23FCF758%22%2C%22%234FBC89%22%5D%7D%2C%22bold%22%3Afalse%2C%22italic%22%3Afalse%2C%22strikethrough%22%3Afalse%2C%22fields%22%3Anull%7D%2C%7B%22type%22%3A%22less+than%22%2C%22value%22%3A1%2C%22background_color%22%3A%22%23fcf75d%22%2C%22font_color%22%3Anull%2C%22palette%22%3A%7B%22name%22%3A%22Red+to+Yellow+to+Green%22%2C%22colors%22%3A%5B%22%23F36254%22%2C%22%23FCF758%22%2C%22%234FBC89%22%5D%7D%2C%22bold%22%3Afalse%2C%22italic%22%3Afalse%2C%22strikethrough%22%3Afalse%2C%22fields%22%3Anull%7D%2C%7B%22type%22%3A%22equal+to%22%2C%22value%22%3A1%2C%22background_color%22%3A%22%234FBC89%22%2C%22font_color%22%3Anull%2C%22palette%22%3A%7B%22name%22%3A%22Red+to+Yellow+to+Green%22%2C%22colors%22%3A%5B%22%23F36254%22%2C%22%23FCF758%22%2C%22%234FBC89%22%5D%7D%2C%22bold%22%3Afalse%2C%22italic%22%3Afalse%2C%22strikethrough%22%3Afalse%2C%22fields%22%3Anull%7D%5D%2C%22hidden_fields%22%3A%5B%22lesson.order%22%5D%7D"
    }
  }


  dimension: am_first_name {
    alias: [account_manager.first_name]
    label: "CSM First Name"
    group_label: "Account Owners"
    sql: ${TABLE}.first_name ;;
  }

  dimension: lower_am_first_name {
    hidden: yes
    alias: [account_manager.first_name]
    label: "CSM First Name"
    group_label: "Account Owners"
    sql: LOWER(${TABLE}.first_name) ;;
  }

  dimension: lower_am_last_name {
    hidden:  yes
    alias: [account_manager.first_name]
    label: "CSM First Name"
    group_label: "Account Owners"
    sql: LOWER(${TABLE}.last_name) ;;
  }

  dimension: am_email {
    alias: [account_manager.email]
    label: "CSM Email"
    group_label: "Account Owners"
    sql: ${TABLE}.email ;;
  }
}

view: account_executive {
  sql_table_name: salesforce.user ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: ae_name {
    alias: [account_owner.name, ae.name, account.account_owner]
    label: "AE Name"
    group_label: "Account Owners"
    sql: ${TABLE}.name ;;
  }

  dimension: ae_first_name {
    alias: [account_owner.first_name, ae.first_name]
    label: "AE First Name"
    group_label: "Account Owners"
    sql: ${TABLE}.first_name ;;
  }

  dimension: ae_email {
    alias: [account_owner.email, ae.email]
    label: "AE Email"
    group_label: "Account Owners"
    sql: ${TABLE}.email ;;
  }
}

view: sales_engineer {
  sql_table_name: salesforce.analysts_c ;;

  dimension: account_id {
    hidden: yes
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: id {
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    group_label: "Account Owners"
    label: "SE Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: first__name___c {
    group_label: "Account Owners"
    label: "SE First Name"
    type: string
    sql: ${TABLE}.first__name___c ;;
  }

  dimension: last__name___c {
    group_label: "Account Owners"
    label: "SE Last Name"
    type: string
    sql: ${TABLE}.last__name___c ;;
  }

  dimension: github__username___c {
    hidden: yes
    type: string
    sql: ${TABLE}.github__username___c ;;
  }

#   dimension: se_comparitor {
#     view_label: "SE comparisons"
#     description: "Use in conjunction with se select filter to compare to other se's"
#     sql: CASE
#         WHEN {% condition se_select %} ${name} {% endcondition %}
#           THEN ${name}
#       ELSE 'Rest of Sales Team'
#       END
#        ;;
#   }

}

view: customer_success_analyst {
  sql_table_name: salesforce.user ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: csa_name {
    alias: [analyst.name]
    label: "CSA Name"
    group_label: "Account Owners"
    sql: ${TABLE}.name ;;
  }

  dimension: csa_first_name {
    label: "CSA First Name"
    group_label: "Account Owners"
    sql: ${TABLE}.first_name ;;
  }

  dimension: csa_email {
    label: "CSA Email"
    group_label: "Account Owners"
    sql: ${TABLE}.email ;;
  }
}

view: account_engagement_manager {
  sql_table_name: salesforce.user ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: em_name {
    label: "EM Name"
    group_label: "Account Owners"
    sql: ${TABLE}.name ;;
  }

  dimension: em_email {
    label: "EM Email"
    group_label: "Account Owners"
    sql: ${TABLE}.email ;;
  }
}

view: account_pro_services_analyst {
  sql_table_name: salesforce.analysts_c ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: psa_name {
    label: "PSA Name"
    group_label: "Account Owners"
    sql: ${TABLE}.name ;;
  }

  dimension: psa_email {
    label: "PSA Email"
    group_label: "Account Owners"
    sql: ${TABLE}.email___c ;;
  }
}
