test_that("default_init_example has correct parameter names", {
  expected_names <- c(
    "beta0_1", "beta0_2", "a1", "a2",
    "log_sigma1", "log_sigma2",
    "log_t_half_early", "log_t_half_late",
    "eta_early", "eta_late", "gamma_early", "gamma_late"
  )
  expect_named(default_init_example, expected_names)
})

test_that("default_init_example_lite has correct parameter names", {
  expected_names <- c(
    "beta0_1", "beta0_2", "a1", "a2",
    "log_sigma",
    "log_t_half_early", "log_t_half_late",
    "eta_early", "eta_late", "gamma_early", "gamma_late"
  )
  expect_named(default_init_example_lite, expected_names)
})

test_that("bounds have same names as defaults", {
  expect_equal(names(lower_bounds_example), names(default_init_example))
  expect_equal(names(upper_bounds_example), names(default_init_example))
  expect_equal(
    names(lower_bounds_example_lite), names(default_init_example_lite)
  )
  expect_equal(
    names(upper_bounds_example_lite), names(default_init_example_lite)
  )
})

test_that("lower bounds are less than upper bounds", {
  expect_true(all(lower_bounds_example < upper_bounds_example))
  expect_true(all(lower_bounds_example_lite < upper_bounds_example_lite))
})

test_that("generate_random_init_from_bounds produces valid init", {
  set.seed(42)
  init <- generate_random_init_from_bounds(
    lower_bounds_example, upper_bounds_example
  )

  expect_named(init, names(lower_bounds_example))
  expect_true(all(init >= lower_bounds_example))
  expect_true(all(init <= upper_bounds_example))

  # Should not have both eta and gamma negative for either phase
  expect_false(init["eta_early"] < 0 && init["gamma_early"] < 0)
  expect_false(init["eta_late"] < 0 && init["gamma_late"] < 0)

  # eta values should have |eta| >= 0.1
  expect_true(abs(init["eta_early"]) >= 0.1)
  expect_true(abs(init["eta_late"]) >= 0.1)
})

test_that("generate_random_init_from_bounds works for lite bounds", {
  set.seed(42)
  init <- generate_random_init_from_bounds(
    lower_bounds_example_lite, upper_bounds_example_lite
  )

  expect_named(init, names(lower_bounds_example_lite))
  expect_true(all(init >= lower_bounds_example_lite))
  expect_true(all(init <= upper_bounds_example_lite))
})
