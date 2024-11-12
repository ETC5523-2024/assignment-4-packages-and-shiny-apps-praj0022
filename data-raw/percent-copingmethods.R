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

depression_age <- read.csv("data-raw/depressive-disorders-prevalence-by-age.csv") |>
  dplyr::rename( Age_5_14 = Depressive.disorders..share.of.population....Sex..Both...Age..5.14.years,
          Age_15_19 = Depressive.disorders..share.of.population....Sex..Both...Age..15.19.years,
          Age_20_24 = Depressive.disorders..share.of.population....Sex..Both...Age..20.24.years,
          Age_25_29 = Depressive.disorders..share.of.population....Sex..Both...Age..25.29.years,
          Age_30_34 = Depressive.disorders..share.of.population....Sex..Both...Age..30.34.years,
          Age_35_39 = Depressive.disorders..share.of.population....Sex..Both...Age..35.39.years,
          Age_40_44 = Depressive.disorders..share.of.population....Sex..Both...Age..40.44.years,
          Age_45_49 = Depressive.disorders..share.of.population....Sex..Both...Age..45.49.years,
          Age_50_54 = Depressive.disorders..share.of.population....Sex..Both...Age..50.54.years,
          Age_55_59 = Depressive.disorders..share.of.population....Sex..Both...Age..55.59.years,
          Age_60_64 = Depressive.disorders..share.of.population....Sex..Both...Age..60.64.years,
          Age_65_69 = Depressive.disorders..share.of.population....Sex..Both...Age..65.69.years,
          Age_70 = Depressive.disorders..share.of.population....Sex..Both...Age..70..years,
          All_Ages = Depressive.disorders..share.of.population....Sex..Both...Age..All.ages ,
          Age_Standardised = Depressive.disorders..share.of.population....Sex..Both...Age..Age.standardized)

usethis::use_data(depression_age, overwrite = TRUE)
