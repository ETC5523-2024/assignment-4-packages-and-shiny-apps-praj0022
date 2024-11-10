## code to prepare `percent-copingmethods` dataset goes here


percent_copingmethods <- read.csv("data-raw/dealing-with-anxiety-depression-comparison.csv") |>
  dplyr::rename(Religious_spiritual_activities =  Share...Question..mh8b...Engaged.in.religious.spiritual.activities.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         Improved_healthy_lifestyle_behaviors = Share...Question..mh8e...Improved.healthy.lifestyle.behaviors.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         Made_a_change_to_work_situation = Share...Question..mh8f...Made.a.change.to.work.situation.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         Made_a_change_to_personal_relationships = Share...Question..mh8g...Made.a.change.to.personal.relationships.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         Talked_to_friends_or_family = Share...Question..mh8c...Talked.to.friends.or.family.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         Took_prescribed_medication = Share...Question..mh8d...Took.prescribed.medication.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         Spent_time_in_nature = Share...Question..mh8h...Spent.time.in.nature.the.outdoors.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         Talked_to_mental_health_professional = Share...Question..mh8a...Talked.to.mental.health.professional.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all)


usethis::use_data(percent_copingmethods, overwrite = TRUE)
