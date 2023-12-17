#' Retrieve a Space-Filling Design
#'
#' Obtain a space-filling design (if possible) based on how many characteristics
#' (i.e. parameters) and size (i.e., number of grid points).
#'
#' @param num_param An integer between two and ten for the number of
#' characteristics/factors/parameters in the design.
#' @param num_points An integer for the number of grid points requested. If
#' there is no corresponding design, an error is given (when using
#' `get_design()`)
#' @param type A character string with possible values> `"any"`,
#' `"audze_eglais"`, `"max_min_l1"`, `"max_min_l2"`, and `"uniform"`. A value
#' of `"any"` will choose the first design available (in alphabetical order).
#' @return A tibble (data frame) with columns named `X1` to `X{num_param}`.
#' Each column is an integer for the ordered value of the real parameter values.
#' @details
#' The `"audze_eglais"`, `"max_min_l1"`, and `"max_min_l2"` designs are from
#' [`https://www.spacefillingdesigns.nl/`](https://www.spacefillingdesigns.nl/).
#'
#' The uniform designs were pre-computed using [mixtox::unidTab()] using the
#' method of Wang and Fang (2005) using the C2 criterion.
#'
#' @references
#' [`https://www.spacefillingdesigns.nl/`](https://www.spacefillingdesigns.nl/),
#' Husslage, B. G., Rennen, G., Van Dam, E. R., & Den Hertog, D. (2011).
#' Space-filling Latin hypercube designs for computer experiments. _Optimization
#' and Engineering_, 12, 611-630.
#' Wang, Y., & Fang, K. (2005). Uniform design of experiments with mixtures.
#' In _Selected Papers Of Wang Yuan_, 468-479.

#' @examples
#' if (rlang::is_installed("ggplot2")) {
#'  library(ggplot2)
#'
#'  two_param_l2 <- get_design(2, 100, type = "audze_eglais")
#'
#'  ggplot(two_param_l2, aes(X1, X2)) +
#'    geom_point() +
#'    coord_equal()
#' }
#'
#' no_design <- try(get_design(2, 1000), silent = TRUE)
#' cat(as.character(no_design))
#' @export
get_design <- function(num_param, num_points, type = "any") {

  type <- rlang::arg_match(type, c("any", "audze_eglais", "max_min_l1", "max_min_l2", "uniform"))
  if (num_param < 2 | num_param > 15) {
    rlang::abort("Number of parameters must be in [2, 15]")
  }
  x <- sfd::sfd_lib[[num_param - 1]]
  nearest <- closest_design(x, num_points)
  x <- x[x$num_points == num_points, ]
  if (nrow(x) == 0) {
    cli::cli_abort("No design with {num_points} points. The closest has {nearest} points.")
  }
  types <- sort(unique(x$type))
  if (type == "any") {
    type <- types[1]
  } else {
    if (!(type %in% types)) {
      cli::cli_abort("There were no {.val {type}} designs with {num_points}
                      design points. Try using {.code type = 'any'}.")
    }
  }
  x <- x[x$type == type,]
  x$type <- NULL
  x$num_points <- NULL
  x
}

closest_design <- function(x, num_points) {
  avail <- unique(x$num_points)
  avail[which.min(abs(avail - num_points))]
}

#' Is a Space-Filling Design Available?
#'
#' Determine if a design from
#' [`https://www.spacefillingdesigns.nl/`](https://www.spacefillingdesigns.nl/)
#' is available in this package based on how many characteristics (i.e.
#' parameters), size (i.e., number of grid points), and type.
#' @inheritParams get_design
#' @return A logical
#' @examples
#' sfd_available(2, 10)
#' sfd_available(2, 10^5)
#' @export
sfd_available <- function(num_param, num_points, type = "any") {
  res <- try(get_design(num_param, num_points, type), silent = TRUE)
  !inherits(res, "try-error")
}
