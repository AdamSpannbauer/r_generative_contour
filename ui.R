library(shiny)
library(colourpicker)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      align = "center",
      sliderInput(
        inputId = "n_scl",
        label = "Turbulence",
        min = 0.001,
        max = 0.499,
        value = 0.01,
        step = 0.001
      ),
      sliderInput(
        inputId = "bins",
        label = "Number of bins",
        min = 2,
        max = 200,
        value = 50,
        step = 1
      ),
      colourpicker::colourInput(
        "line_color",
        label = "Line color",
        value = "#000000"
      ),
      actionButton(
        inputId = "regen_button",
        label = "Regenerate"
      ),
      downloadButton(
        outputId = "downloadPlot",
        label = "Save"
      ),
      radioButtons(
        inputId = "file_type",
        label = "File type",
        choices = c("svg", "png"),
        inline = TRUE
      )
    ),
    mainPanel(
      plotOutput("contour_plot")
    )
  )
)
