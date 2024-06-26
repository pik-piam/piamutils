test_that("matchDim works", {
  region <- c("AAA", "BBB", "CCC")
  t <- paste0("y", c(2000, 2005, 2010))
  name <- c("foo", "bar", "bazz")

  mp <- new.magpie(
    cells_and_regions = region, years = t, names = name, fill = 1,
    sets = c("region", "t", "name")
  )

  # spatial ----
  ## x smaller then ref ----
  expect_equal(
    matchDim(mp[region[-2], , ], mp),
    `mselect<-`(mp, region = region[2], value = 0)
  )

  ## x larger then ref ----
  expect_equal(
    matchDim(mp, mp[region[-2], , ]),
    mp[region[-2], , ]
  )

  # temporal ----
  ## x smaller then ref ----
  expect_equal(
    matchDim(mp[, t[-2], ], mp),
    `mselect<-`(mp, t = t[2], value = 0)
  )

  ## x larger then ref ----
  expect_equal(
    matchDim(x = mp, ref = mp[, t[-2], ]),
    mp[, t[-2], ]
  )

  # names ----
  ## x smaller then ref ----
  expect_equal(
    matchDim(mp[, , name[-2]], mp),
    `mselect<-`(mp, name = name[2], value = 0)
  )

  ## x larger then ref ----
  expect_equal(
    matchDim(mp, mp[, , name[-2]]),
    mp[, , name[-2]]
  )
})
