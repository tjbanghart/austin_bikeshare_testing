view: lessons {
  sql_table_name: skilljar.lessons ;;

  dimension: pk {
    primary_key: yes
    type: string
    sql: ${TABLE}.pk ;;
  }

  dimension: lesson_id {
    hidden: yes
    type: string
    sql: ${TABLE}.lesson_id ;;
  }
##
  dimension: course_id {
    hidden: yes
    type: string
    sql: trim(${TABLE}.course_id) ;;
  }

  dimension: course_type {
    description: "Indicates if eLearning, Webinar, or Classroom"
    type: string
    sql: CASE
            WHEN ${course_id} = '3d3n6nr9yigpz'
              THEN 'Webinar'
            WHEN ${course_id} = '2bdx52bkwfkty'
              THEN 'Webinar'
            WHEN ${course_id} = '2t1l035dzg6hg'
              THEN 'Classroom'
            WHEN ${course_id} = '1lzxmu4l3k010'
              THEN 'Classroom'
            WHEN ${course_id} = '10n8cqcj304ih'
              THEN 'Classroom'
            ELSE 'eLearning'
          END
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

  dimension: curriculum {
    type: string
    description: "Which curriculum this course is a part of, if any"
    sql: CASE WHEN ${title} LIKE '%Git SME%' THEN 'Git'
          ELSE 'None'
          END
          ;;
  }

  dimension: domain_id {
    hidden: yes
    type: string
    sql: ${TABLE}.domain_id ;;
  }

  dimension: domain_name {
#     hidden: yes
  label: "Domain Name"
  type: string
  sql: ${TABLE}.domain_name ;;
}

dimension: is_live {
  type: yesno
  sql: ${TABLE}.is_live ;;
}

dimension: is_section {
  hidden: yes
  # group_label: "Session information"  # This is currently grouped with the session information, but this may need to change
  type: yesno
  sql: ${TABLE}.is_section ;;
}

dimension: order {
  # hidden: yes
  view_label: "Lesson"
  description: "Order that lessons appear in."
  type: number
  sql: ${TABLE}.lesson_order ;;
}

dimension: lesson_title {
  label: "Lesson Title"
  #group_label: "Lesson information"
  description: "The name of the session, e.g. Data Explorer Webinar"
  type: string
  sql: ${TABLE}.lesson_title ;;
}

dimension: lesson_type {
  label: "Lesson Type"
  description: "Is this VILT or other"
  #group_label: "Lesson information"
  type: string
  sql: ${TABLE}.lesson_type ;;
}

dimension: published_course_id {
  type: string
  sql: ${TABLE}.published_course_id ;;
}

dimension: quiz_id {
  hidden: yes
  type: string
  sql: ${TABLE}.quiz_id ;;
}

dimension: url {
  type: string
  sql: ${TABLE}.url ;;
}

measure: lesson_count {
  label: "Number of Lessons"
  #group_label: "Lesson information"  # This is currently grouped with the session information, but this may need to change
  type: count_distinct
  sql: ${lesson_id} ;;
  drill_fields: [lesson_id, course.course_id, student_lesson_progress.count, vilt_session.count]
}

measure: course_count {
  label: "Number of Courses"
  type: count_distinct
  sql: ${course_id} ;;
  drill_fields: [detail*]
}

measure: domain_count {
  label: "Number of Domains"
  type: count_distinct
  sql: ${domain_id} ;;
}

# ----- Sets of fields for drilling ------
set: detail {
  fields: [
    lesson_id,
    domain_name,
    quiz.quiz_id,
    quiz.name,
    student_lesson_progress.count,
    student_registration.count
  ]
}
}
