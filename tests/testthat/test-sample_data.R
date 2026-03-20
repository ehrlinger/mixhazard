test_that("sample_data has required columns", {
  data(sample_data, package = "multimix")
  expect_true(is.data.frame(sample_data))
  expect_true(all(c("Subject_ID", "Time", "Binary_outcome") %in% names(sample_data)))
})

test_that("sample_data has valid content", {
  data(sample_data, package = "multimix")
  expect_true(nrow(sample_data) > 0)
  expect_true(all(sample_data$Binary_outcome %in% c(0, 1)))
  expect_true(all(sample_data$Time >= 0))
  expect_true(length(unique(sample_data$Subject_ID)) > 1)
})
