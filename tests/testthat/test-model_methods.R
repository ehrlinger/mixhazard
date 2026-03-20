test_that("var_to_english_dict maps all expected parameters", {
  expected_keys <- c(
    "a1", "a2", "beta0_1", "beta0_2",
    "t_half_early", "t_half_late",
    "eta_early", "eta_late",
    "gamma_early", "gamma_late",
    "sigma", "sigma1", "sigma2"
  )
  expect_true(all(expected_keys %in% names(var_to_english_dict)))
})

test_that("print.multimix_model prints and returns invisibly", {
  fake_model <- list(
    est = c(beta0_1 = 1.5, a1 = 0.8, t_half_early = 3.2),
    df_long = data.frame(),
    u_hat = matrix(0, nrow = 1, ncol = 2),
    logLik = -100

  )
  class(fake_model) <- "multimix_model"

  out <- capture.output(result <- print(fake_model))
  expect_identical(result, fake_model)
  expect_true(length(out) > 0)
})

test_that("print.multimix_model_lite works on lite objects", {
  fake_model <- list(
    est = c(beta0_1 = 1.5, a1 = 0.8, sigma = 1.2),
    df_long = data.frame(),
    u_hat = c(u1 = 0.1),
    logLik = -50
  )
  class(fake_model) <- "multimix_model_lite"

  out <- capture.output(result <- print(fake_model))
  expect_identical(result, fake_model)
})
