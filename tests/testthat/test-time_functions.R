test_that("decompos returns list with required components", {
  result <- decompos(time = 1:5, thalf = 3, nu = 1, m = 1, complet = 1)
  expect_type(result, "list")
  expect_named(result, c("capgt", "gt", "ht"))
  expect_length(result$capgt, 5)
  expect_length(result$gt, 5)
  expect_length(result$ht, 5)
})

test_that("decompos handles all valid sign combinations", {
  times <- 1:3

  # Case 1: m > 0, nu > 0
  r1 <- decompos(times, thalf = 3, nu = 2, m = 1, complet = 1)
  expect_true(all(is.finite(r1$gt)))
  expect_true(all(r1$capgt >= 0 & r1$capgt <= 1))


  # Limiting Case 1: m = 0, nu > 0
  r2 <- decompos(times, thalf = 3, nu = 2, m = 0, complet = 1)
  expect_true(all(is.finite(r2$gt)))

  # Case 2: m < 0, nu > 0
  r3 <- decompos(times, thalf = 3, nu = 2, m = -1, complet = 1)
  expect_true(all(is.finite(r3$gt)))

  # Limiting Case 2: m < 0, nu = 0
  r4 <- decompos(times, thalf = 3, nu = 0, m = -1, complet = 1)
  expect_true(all(is.finite(r4$gt)))

  # Case 3: m > 0, nu < 0
  r5 <- decompos(times, thalf = 3, nu = -2, m = 1, complet = 1)
  expect_true(all(is.finite(r5$gt)))

  # Limiting Case 3: m = 0, nu < 0
  r6 <- decompos(times, thalf = 3, nu = -2, m = 0, complet = 1)
  expect_true(all(is.finite(r6$gt)))
})

test_that("decompos errors when both m and nu are negative", {
  expect_error(
    decompos(1:3, thalf = 3, nu = -1, m = -1, complet = 1),
    "undefined"
  )
})

test_that("get_early_phase returns finite values", {
  result <- get_early_phase(time = 1:5, thalf = 3, eta = 1, gamma = 0)
  expect_length(result, 5)
  expect_true(all(is.finite(result)))
  expect_true(all(result > 0))
})

test_that("get_late_phase returns finite values", {
  result <- get_late_phase(time = 1:5, thalf = 3, eta = 1, gamma = 0)
  expect_length(result, 5)
  expect_true(all(is.finite(result)))
  expect_true(all(result > 0))
})

test_that("early phase decreases over time for default parameters", {
  times <- seq(0.5, 10, by = 0.5)
  vals <- get_early_phase(times, thalf = 3, eta = 1, gamma = 0)
  # Generally decreasing trend (density of early phase)
  expect_true(vals[1] > vals[length(vals)])
})

test_that("half-life parameter affects timing", {
  times <- 1:5
  short <- get_early_phase(times, thalf = 1, eta = 1, gamma = 0)
  long <- get_early_phase(times, thalf = 10, eta = 1, gamma = 0)
  # Shorter half-life should have smaller values at later times
  expect_true(short[5] < long[5])
})
