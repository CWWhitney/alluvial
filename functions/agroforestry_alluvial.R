agroforestry_alluvial <- function (data,
                                   alpha = 0,
                                   colors = NULL)
{
  {
    if (!requireNamespace("reshape2", quietly = TRUE)) {
      stop("Package \"reshape2\" needed for this function to work. Please install it.",
           call. = FALSE)
    }
    if (!requireNamespace("dplyr", quietly = TRUE)) {
      stop("Package \"dplyr\" needed for this function to work. Please install it.",
           call. = FALSE)
    }
    if (!requireNamespace("ggalluvial", quietly = TRUE)) {
      stop(
        "Package \"ggalluvial\" needed for this function to work. Please install it.",
        call. = FALSE
      )
    }
    if (!requireNamespace("magrittr", quietly = TRUE)) {
      stop("Package \"magrittr\" needed for this function to work. Please install it.",
           call. = FALSE)
    }
  }
  if (any(is.na(data))) {
    warning(
      "Some of your observations included \"NA\" and were removed. Consider using \"0\" instead."
    )
    data <- data[stats::complete.cases(data),]
  }

  # change to Null
Intervention <- Scale <- Outcome <- outcome <- scale_name <- variable <- value <- strwidth <- stratum <- NULL
  
  shaped_data <-
    reshape2::melt(data, id = c("outcome", "scale_name")) %>%
    dplyr::filter(value >= 1)
  
  plot_data <-
    shaped_data %>% dplyr::rename(Intervention = "variable",
                                  Scale = "scale_name",
                                  Outcome = "outcome") %>% 
    dplyr::arrange(Intervention)
  
  if (is.null(colors)) {
    colors <- rainbow(n = ncol(plot_data))
  }
  ggplot2::ggplot(as.data.frame(plot_data),
    ggplot2::aes(y = value,
      axis1 = Intervention,
      axis2 = Scale,
      axis3 = Outcome)) +
    ggalluvial::geom_alluvium(ggplot2::aes(fill = Scale),
      show.legend = TRUE) + 
    ggalluvial::geom_stratum(alpha = alpha,
          color = "grey") + 
    ggplot2::geom_text(stat = "stratum", size = 4, min.y = 100) +
    geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
    ggplot2::scale_x_discrete(
            limits = c("Intervention","Scale", "Outcome"),
              expand = c(0.01, 0.02)) + 
    ggplot2::labs(y = "AF Interventions") +
    ggplot2::theme_minimal() + 
    ggplot2::theme(legend.position = "none") +
    ggplot2::scale_fill_manual(values = colors)
}
