test_that("setting values", {

  des <- get_design(4, 5)

  p_1 <- 1:5
  p_2 <- seq(10, 12, length.out = 5)
  p_3 <- letters[1:5]
  p_4 <- factor(p_3)

  vals_1 <- update_values(des, list(p_1, p_2, p_3, p_4))

  expect_equal(vals_1$X1, p_1)
  expect_equal(sort(vals_1$X2), p_2)
  expect_equal(sort(vals_1$X3), p_3)
  expect_equal(sort(vals_1$X4), p_4)

  expect_snapshot(
    update_values(des, p_1),
    error = TRUE
  )
  expect_snapshot(
    update_values(des, list(p_1, p_2, p_3)),
    error = TRUE
  )
  expect_snapshot(
    update_values(des, list(p_1, p_2, p_3, p_4[1])),
    error = TRUE
  )
})
