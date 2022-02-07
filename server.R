library(shiny)
library(ggplot2)
library(ambient)
library(svglite)

gen_noise <- function(nrows, ncols, n_scl = 0.01) {
  noise_2d <- noise_perlin(
    c(nrows, ncols),
    frequency = n_scl,
    octaves = 5
  )
  noise_2d_df <- data.frame(noise_2d)
  names(noise_2d_df) <- c("x", "y")
  noise_2d_df$y <- sample(noise_2d_df$y)
  noise_2d_df
}


server <- function(input, output, session) {
  noise_df <- reactive({
    input$regen_button

    gen_noise(
      nrows = 100,
      ncols = 2,
      n_scl = input$n_scl
    )
  })

  contour_plot <- reactive({
    ggplot(noise_df(), aes(x, y)) +
      geom_density_2d(
        bins = input$bins,
        linejoin = "round",
        colour = input$line_color
      ) +
      theme_void()
  })

  output$contour_plot <- renderPlot({
    contour_plot()
  })

  output$downloadPlot <- downloadHandler(
    filename = function() paste0("saved_contour_plot.", input$file_type),
    content = function(file) {
      ggsave(file, plot = contour_plot(), device = input$file_type)
    }
  )
}
