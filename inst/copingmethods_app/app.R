#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
#
# Load necessary libraries and data from package
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)
library(bslib)
library(copingmethods)
# Load data from the package
depression_data <- copingmethods::depression_age  # Assuming the dataset is named depression_age
coping_data <- copingmethods::percent_copingmethods  # Assuming the dataset is named percent_copingmethods

# Data preparation for `depression_data`
depression_data <- depression_data %>%
  pivot_longer(cols = starts_with("Age_"),
               names_to = "AgeGroup",
               values_to = "Percentage") %>%
  mutate(AgeGroup = gsub("Age_", "", AgeGroup))  # Remove "Age_" prefix for cleaner labels

# Define a custom order for the AgeGroup factor
age_order <- c("5_14", "15_19", "20_24", "25_29", "30_34", "35_39",
               "40_44", "45_49", "50_54", "55_59", "60_64", "65_69",
               "70", "Standardised")

depression_data$AgeGroup <- factor(depression_data$AgeGroup, levels = age_order)

# Define custom theme with `bslib`
custom_theme <- bs_theme(
  bootswatch = "minty",
  primary = "#1F4E79",
  secondary = "#78A9FF",
  base_font = font_google("Lora"),
  code_font = font_google("Source Code Pro")
)

# Define UI with interactive features
ui <- fluidPage(
  theme = custom_theme,
  tags$style(HTML("
        .title { font-size: 28px; font-weight: bold; color: #1F4E79; margin-left: 15px; }
        .sidebar { background-color: #ECECEC; padding: 20px; border-radius: 8px; border: 1px solid #D3D3D3; }
    ")),

  div(class = "title", "Global Mental Health Trends"),

  sidebarLayout(
    sidebarPanel(
      div(class = "sidebar",
          h3("Explore Mental Health Data"),

          # Radio buttons to select which analysis to show
          radioButtons("analysis_type", "Select Analysis Type:",
                       choices = list("Depression by Age" = "depression",
                                      "Coping Methods Comparison" = "coping")),
          hr(),

          # Conditional panels based on selected analysis
          conditionalPanel(
            condition = "input.analysis_type == 'depression'",
            selectInput("entity", "Select Country/Entity:",
                        choices = unique(depression_data$Entity)),
            checkboxInput("show_avg", "Show Average for All Entities", value = FALSE),
            sliderInput("years", "Select Year for Comparison:",
                        min = min(depression_data$Year),
                        max = max(depression_data$Year),
                        value = c(min(depression_data$Year), min(depression_data$Year)),
                        step = 1,
                        animate = TRUE,
                        sep = "",
                        dragRange = FALSE)
          ),

          conditionalPanel(
            condition = "input.analysis_type == 'coping'",
            selectInput("country1", "Select Country:",
                        choices = unique(coping_data$Entity)),
            selectInput("country2", "Select Second Country (or None):",
                        choices = c("None", unique(coping_data$Entity))),
            numericInput("top_n", "Number of Top Coping Methods to Display:",
                         value = 5, min = 1, max = 8)  # Restrict to 8 methods
          ),

          hr(),
          h4("Field Descriptions"),
          uiOutput("field_description")  # Dynamic field description
      )
    ),

    mainPanel(
      # Main output panel for displaying the selected analysis
      conditionalPanel(
        condition = "input.analysis_type == 'depression'",
        plotlyOutput("barChart", height = "500px"),
        hr(),
        tableOutput("depressionTable"),
        hr(),
        h4("How to Interpret the Outputs"),
        p("The bar chart displays depression percentages for each age group in the selected country/entity and year.
                  If 'Show Average' is selected, a dashed yellow line shows the average depression percentage across all entities in the selected year.
                  The table below shows the change in percentage for each age group from the start year to the selected year.")
      ),

      conditionalPanel(
        condition = "input.analysis_type == 'coping'",
        plotlyOutput("copingBarChart", height = "500px"),
        hr(),
        h4("How to Interpret the Outputs"),
        p("The bar chart displays the top coping methods from most popular to least for the selected country or two countries together,
                  allowing for a visual comparison of coping method proportions.")
      )
    )
  )
)

# Define server logic with interactive features
server <- function(input, output, session) {
  # Dynamic field descriptions based on analysis type
  output$field_description <- renderUI({
    if (input$analysis_type == "depression") {
      tagList(
        p("Entity: The country or region where the data was collected."),
        p("Year: The year the data was collected."),
        p("Age: Age group of respondents."),
        p("Percentage: Percentage of respondents in the age group who reported depression.")
      )
    } else {
      tagList(
        p("Entity: The country or region where the data was collected."),
        p("Coping Method: The coping strategy used to handle mental health issues."),
        p("Percentage: Percentage of respondents who reported using each coping method.")
      )
    }
  })

  # Depression by Age Plot
  output$barChart <- renderPlotly({
    req(input$analysis_type == "depression")  # Ensure this only runs when "depression" is selected

    filtered_data <- depression_data %>%
      filter(Year == input$years[2], Entity == input$entity)

    avg_percentage <- NULL
    if (input$show_avg) {
      avg_percentage <- depression_data %>%
        filter(Year == input$years[2]) %>%
        summarize(Average = mean(Percentage, na.rm = TRUE)) %>%
        pull(Average)
    }

    p <- ggplot(filtered_data, aes(y = AgeGroup, x = Percentage, fill = Percentage)) +
      geom_col(width = 0.7) +  # Set width to avoid auto-expansion
      scale_fill_gradient(high = "#1F4E79", low = "#D3E8FF") +
      labs(x = "Depression Percentage (%)", y = "Age Group",
           title = paste("Depression by Age in", input$entity, "for", input$years[2])) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold", color = "#1F4E79"))

    if (!is.null(avg_percentage)) {
      p <- p +
        geom_vline(xintercept = avg_percentage, color = "yellow", linetype = "dashed", size = 1.2) +
        geom_text(aes(x = avg_percentage - 0.92, y = length(levels(filtered_data$AgeGroup)) / 2,
                      label = paste("Average =", round(avg_percentage, 2), "%")),
                  color = "yellow", vjust = -0.1, hjust = -0.1, size = 3.5)
    }

    ggplotly(p)
  })

  # Table to show difference in depression percentage between selected years
  output$depressionTable <- renderTable({
    req(input$analysis_type == "depression")

    start_data <- depression_data %>%
      filter(Entity == input$entity, Year == input$years[1]) %>%
      select(AgeGroup, StartPercentage = Percentage)

    end_data <- depression_data %>%
      filter(Entity == input$entity, Year == input$years[2]) %>%
      select(AgeGroup, EndPercentage = Percentage)

    difference_data <- start_data %>%
      inner_join(end_data, by = "AgeGroup") %>%
      mutate(Difference = EndPercentage - StartPercentage) %>%
      select(AgeGroup, Difference)

    names(difference_data) <- c("Age Group", paste("Difference (%) from", input$years[1], "to", input$years[2]))
    difference_data
  })

  # Coping Methods Comparison Bar Chart
  output$copingBarChart <- renderPlotly({
    req(input$analysis_type == "coping")

    # Data preparation for the first country
    country1_data <- coping_data %>%
      filter(Entity == input$country1) %>%
      select(-Entity, -Code, -Year) %>%
      pivot_longer(cols = everything(), names_to = "CopingMethod", values_to = "Percentage") %>%
      arrange(desc(Percentage)) %>%
      head(input$top_n) %>%
      mutate(Country = input$country1)

    # Data preparation for the second country if selected
    if (input$country2 != "None") {
      country2_data <- coping_data %>%
        filter(Entity == input$country2) %>%
        select(-Entity, -Code, -Year) %>%
        pivot_longer(cols = everything(), names_to = "CopingMethod", values_to = "Percentage") %>%
        arrange(desc(Percentage)) %>%
        head(input$top_n) %>%
        mutate(Country = input$country2)

      # Combine data for both countries
      combined_data <- bind_rows(country1_data, country2_data)
    } else {
      combined_data <- country1_data
    }

    # Create the bar chart for coping methods comparison
    p <- ggplot(combined_data, aes(x = reorder(CopingMethod, -Percentage), y = Percentage, fill = Country)) +
      geom_bar(stat = "identity", position = position_dodge(width = 0.7), width = 0.5) +
      labs(x = "Coping Method", y = "Percentage (%)",
           title = paste("Top Coping Methods in", input$country1,
                         if (input$country2 != "None") paste("vs", input$country2) else "")) +
      scale_fill_manual(values = c("#1F4E79", "#78A9FF")) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 17, face = "bold"),
            axis.text.x = element_text(angle = 45, hjust = 1, size = 10))

    ggplotly(p)
  })
}

# Run the app
shinyApp(ui = ui, server = server)
