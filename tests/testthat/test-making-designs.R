test_that("accessing designs", {

  set.seed(1)
  combos <- expand.grid(n = sample.int(100, 10) + 1, p = 2:10)

  for (i in 1:nrow(combos)) {
    tmp <- get_design(combos$p[i], combos$n[i])
    expect_equal(prod(dim(tmp)), combos$p[i] * combos$n[i])
  }

  expect_snapshot(
    get_design(1, 5),
    error = TRUE
  )

  expect_snapshot(
    get_design(11, 5),
    error = TRUE
  )
  expect_snapshot(
    get_design(2, 5000),
    error = TRUE
  )
  expect_snapshot(
    get_design(3, 69, type = "max_min_l1"),
    error = TRUE
  )
})

test_that("looking for designs", {
  has_des <- vapply(499:501, function(x) sfd_available(2, x), logical(1))
  expect_equal(has_des, c(TRUE, TRUE, FALSE))
})


