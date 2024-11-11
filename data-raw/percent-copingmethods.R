## code to prepare `percent-copingmethods` dataset goes here


percent_copingmethods <- read.csv("data-raw/dealing-with-anxiety-depression-comparison.csv") |>
  dplyr::rename('Religious spiritual activities' =  Share...Question..mh8b...Engaged.in.religious.spiritual.activities.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         'Improved healthy lifestyle behaviors' = Share...Question..mh8e...Improved.healthy.lifestyle.behaviors.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         'Made a change to work situation' = Share...Question..mh8f...Made.a.change.to.work.situation.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         'Made a change to personal relationships' = Share...Question..mh8g...Made.a.change.to.personal.relationships.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         'Talked to friends or family' = Share...Question..mh8c...Talked.to.friends.or.family.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         'Took prescribed medication' = Share...Question..mh8d...Took.prescribed.medication.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         'Spent time in nature' = Share...Question..mh8h...Spent.time.in.nature.the.outdoors.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all,
         'Talked to mental health professional' = Share...Question..mh8a...Talked.to.mental.health.professional.when.anxious.depressed...Answer..Yes...Gender..all...Age.group..all)


usethis::use_data(percent_copingmethods, overwrite = TRUE)
