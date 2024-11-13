## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>")
  
library(tidyverse)


## -----------------------------------------------------------------------------
remotes::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-praj0022")

## ----setup--------------------------------------------------------------------
library(copingmethods)

## -----------------------------------------------------------------------------
head(depression_age, 2)

## -----------------------------------------------------------------------------
head(percent_copingmethods, 2)

## -----------------------------------------------------------------------------
# Filter for data from Andorra in 2019
andorra_2019 <- depression_age |>
  filter(Entity == "Andorra", Year == "2019")

print(andorra_2019)

## -----------------------------------------------------------------------------
# Filter for Brazil in 2020
brazil_coping <- percent_copingmethods |>
  filter(Entity == "Brazil")

print(brazil_coping)

## ----fig.width=14, fig.height=12, out.width="100%", cache=TRUE----------------
library(ggplot2)

# `topfive` 
topfive <- percent_copingmethods |> 
     arrange(desc(`Religious spiritual activities`)) |> 
     head()

# Create the plot
ggplot(topfive, aes(x = reorder(Entity, `Religious spiritual activities`), 
                    y  = `Religious spiritual activities`, 
                    color = `Religious spiritual activities`)) +
  geom_segment(aes(y = 0, 
                   yend = `Religious spiritual activities`,
                   x = Entity, 
                   yend = Entity), 
               linewidth = 3) +          # Line from y-axis to point
  geom_point(size = 6) +                # Point at the end of each line
  geom_text(aes(label = paste0(round(`Religious spiritual activities`, 2), "%")), 
            hjust = -0.3, size = 4.8) +                   
  scale_color_gradient(low = "lightblue", high = "darkblue") +  # Gradient from light to dark blue
  labs(y = "Religious Spiritual Activities (%)", 
       x = "Entity", 
       title = "Top 5 Entities by Religious/Spiritual Activities") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 24 ),     # Center and resize title
    axis.title.y = element_text(size = 22),                # Adjust x-axis label size
    axis.title.x = element_text(size = 22),                # Adjust y-axis label size
    axis.text.y = element_text(size = 20),                  # Adjust x-axis text size
    axis.text.x = element_text(size = 20)                   # Adjust y-axis text size
  )


