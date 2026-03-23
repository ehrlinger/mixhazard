test_that("check_df_long accepts valid data", {
  df <- data.frame(
    Subject_ID = c(1, 1, 2, 2),
    Time = c(1, 2, 1, 2),
    Binary_outcome = c(0, 1, 1, 0)
  )
  expect_true(check_df_long(df))
})

test_that("check_df_long rejects non-data.frame", {
  expect_error(check_df_long("not a df"), "must be a data frame")
})

test_that("check_df_long rejects empty data frame", {
  df <- data.frame(
    Subject_ID = integer(), Time = numeric(), Binary_outcome = integer()
  )
  expect_error(check_df_long(df), "empty")
})

test_that("check_df_long rejects missing columns", {
  df <- data.frame(Subject_ID = 1, Time = 1)
  expect_error(check_df_long(df), "missing required columns")
})

test_that("check_df_long rejects constant outcome", {
  df <- data.frame(
    Subject_ID = c(1, 2), Time = c(1, 2), Binary_outcome = c(1, 1)
  )
  expect_error(check_df_long(df), "constant")
})
