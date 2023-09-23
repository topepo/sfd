#' Update the Values of a Design
#'
#' For a set of values, this function inserts the actual values of the design
#' produced by [get_design()].
#'
#' @param design A tibble produced by [get_design()]. The column values should
#' be unmodified.
#' @param values A list of vectors containing the possible values for each
#' parameter. There should be as many values (of any type) as there are rows in
#' `design`. For numeric data, it is preferable that the values are equally
#' spaced.
#' @return An updated tibble.
#' @export
#' @examples
#' des <- get_design(3, 6)
#' des
#'
#' vals <- list(1:6, letters[1:6], seq(20, 21, length.out = 6))
#'
#' des_2 <- update_values(des, vals)
#' des_2
update_values <- function(design, values) {
  n <- nrow(design)
  p <- ncol(design)
  values <- check_values(n, p, values)
  for (i in 1:p) {
    design[[i]] <- values[[i]][ design[[i]] ]
  }
  design
}

check_values <- function(n, p, values) {
  if (!is.list(values)) {
    rlang::abort("'values' should be a list.")
  }

  if (length(values) != p) {
    rlang::abort(glue::glue("The list of values should have {p} elements."))
  }

  values <- lapply(values, function(x) sort(x))
  num_vals <- vapply(values, length, integer(1))
  if (any(num_vals != n)) {
    rlang::abort(glue::glue("Some elements of 'values' do not have {n} values."))
  }
  values
}
