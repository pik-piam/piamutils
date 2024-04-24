test_that("deletePlus works", {
  expect_identical(deletePlus("A|+|B (EJ)"), "A|B (EJ)")
  expect_identical(deletePlus("A|+++++|B (EJ)"), "A|B (EJ)")
  expect_identical(deletePlus(c("A|+|B (EJ)", "A|+++++|B (EJ)")), c("A|B (EJ)", "A|B (EJ)"))
  expect_identical(deletePlus("A|+|+|B (EJ)"), "A|B (EJ)")
  expect_identical(deletePlus("A|+|+|+|+|+|+|+|+|B"), "A|B")
  expect_identical(deletePlus("A|B (EJ)"), "A|B (EJ)")
  expect_identical(deletePlus("A|+B (EJ)"), "A|+B (EJ)")
})
