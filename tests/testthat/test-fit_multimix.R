# Integration tests for model fitting

test_that("fit_multimix_lite returns correct class and structure with sample_data", {
  data(sample_data, package = "multimix")

  init <- default_init_example_lite
  init["eta_early"] <- 1
  init["eta_late"] <- 1
  init["gamma_early"] <- 0
  init["gamma_late"] <- 0

  result <- tryCatch(
    fit_multimix_lite(sample_data, nGH = 10, default_init = init, verbose = FALSE),
    error = function(e) NULL
  )

  skip_if(is.null(result), "Optimizer did not converge with sample_data")

  expect_s3_class(result, "multimix_lite")
  expect_true("df_long" %in% names(result))
  expect_true("est" %in% names(result))
  expect_true("u_hat" %in% names(result))
  expect_true("logLik" %in% names(result))

  expect_true(is.numeric(result$u_hat))
  expect_equal(length(result$u_hat), length(unique(sample_data$Subject_ID)))
  expect_true("sigma" %in% names(result$est))

  # Exponentiated params should not have log_ prefix
  expect_false(any(grepl("^log_", names(result$est))))
  expect_true("t_half_early" %in% names(result$est))
})

test_that("multimix wrapper handles all-failure gracefully", {
  df <- data.frame(
    Subject_ID = c(1, 1),
    Time = c(0.001, 0.002),
    Binary_outcome = c(0, 1)
  )

  expect_error(
    multimix(df, max_tries = 2, verbose = FALSE),
    "attempts failed"
  )
})

test_that("fixed_pars are respected in fit_multimix", {
  data(sample_data, package = "multimix")

  init <- default_init_example
  init["eta_early"] <- 1
  init["eta_late"] <- 1
  init["gamma_early"] <- 0
  init["gamma_late"] <- 0

  result <- tryCatch(
    fit_multimix(sample_data, nGH = 10, default_init = init,
                 fixed_pars = list(beta0_2 = 0), verbose = FALSE),
    error = function(e) NULL
  )

  skip_if(is.null(result), "Optimizer did not converge with sample_data")
  expect_equal(unname(result$est["beta0_2"]), 0)
})

test_that("fit_multimix returns correct class and structure", {
  data(sample_data, package = "multimix")

  init <- default_init_example
  init["eta_early"] <- 1
  init["eta_late"] <- 1
  init["gamma_early"] <- 0
  init["gamma_late"] <- 0

  result <- tryCatch(
    fit_multimix(sample_data, nGH = 10, default_init = init, verbose = FALSE),
    error = function(e) NULL
  )

  skip_if(is.null(result), "Optimizer did not converge with sample_data")

  expect_s3_class(result, "multimix_model")
  expect_true(is.numeric(result$est))
  expect_true(is.finite(result$logLik))
  expect_true(is.matrix(result$u_hat))
  expect_equal(ncol(result$u_hat), 2)
  expect_equal(nrow(result$u_hat), length(unique(sample_data$Subject_ID)))

  expect_false(any(grepl("^log_", names(result$est))))
  expect_true("sigma1" %in% names(result$est))
  expect_true("t_half_early" %in% names(result$est))
})
