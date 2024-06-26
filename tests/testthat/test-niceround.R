test_that("niceround works", {
  expect_identical(niceround(1234), "1234")
  expect_identical(niceround(1234.4), "1234")
  expect_identical(niceround(1234.5678), "1235")
  expect_identical(niceround(0.000123), "0.000123")
  expect_identical(niceround(0.000123456789), "0.000123")
  expect_identical(niceround(-1234), "-1234")
  expect_identical(niceround(-1234.4), "-1234")
  expect_identical(niceround(-1234.5678), "-1235")
  expect_identical(niceround(-0.000123), "-0.000123")
  expect_identical(niceround(-0.000123456789), "-0.000123")
  expect_identical(niceround(0), "0")
  expect_identical(niceround(0000), "0")
  expect_identical(niceround(.000), "0")
  expect_identical(niceround("4.4"), "4.4")
  expect_identical(niceround("1e-3"), "0.001")
  expect_identical(niceround(1234, digits = 1), "1234")
  expect_identical(niceround(1234.4, digits = 1), "1234")
  expect_identical(niceround(1234.5678, digits = 1), "1235")
  expect_identical(niceround(0.000123, digits = 1), "0.0001")
  expect_identical(niceround(0.000123456789, digits = 1), "0.0001")
  expect_identical(niceround(-1234, digits = 1), "-1234")
  expect_identical(niceround(-1234.4, digits = 1), "-1234")
  expect_identical(niceround(-1234.5678, digits = 1), "-1235")
  expect_identical(niceround(-0.000123, digits = 1), "-0.0001")
  expect_identical(niceround(-0.000123456789, digits = 1), "-0.0001")
  expect_identical(niceround(0, digits = 1), "0")
  expect_identical(niceround(0000, digits = 1), "0")
  expect_identical(niceround(.000, digits = 1), "0")
  expect_identical(niceround("4.4", digits = 1), "4")
  expect_identical(niceround("1e-3", digits = 1), "0.001")
  test <- c(1234, 0.000312340897, "-112.1234")
  for (d in seq_along(10)) {
    expect_identical(niceround(test, digits = d),
                     sapply(test, niceround, digits = d, USE.NAMES = FALSE))
  }
  qe <- quitte::quitte_example_dataAR6
  qenr <- niceround(qe)
  expect_equal(colnames(qe), colnames(qenr))
  expect_equal(nrow(qe), nrow(qenr))
  expect_equal(niceround(qe$value), qenr$value)
})
