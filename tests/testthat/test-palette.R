test_that("logo mode starts with the three logo colours", {
  suppressWarnings(p <- coalesce_pal(6))
  expect_equal(p[1:3], unname(coalesce_brand))
  expect_length(p, 6)
})

test_that("all colours are valid hex codes", {
  expect_true(all(grepl("^#[0-9A-F]{6}$", coalesce_all)))
  for (m in c("logo", "screen", "print")) {
    for (n in 2:6) {
      suppressWarnings(p <- coalesce_pal(n, m))
      expect_length(p, n)
      expect_true(all(grepl("^#[0-9A-F]{6}$", p)))
    }
  }
})

test_that("sand and salmon trigger a warning outside print mode", {
  expect_warning(coalesce_pal(3), "Sand and salmon")
  expect_silent(coalesce_pal(2))
  expect_silent(coalesce_pal(4, "print"))
  expect_silent(coalesce_pal(5, "screen"))
  withr_quiet <- options(coalesce.quiet = TRUE)
  on.exit(options(withr_quiet))
  expect_silent(coalesce_pal(3))
})

test_that("invalid n is rejected", {
  expect_error(coalesce_pal(1), "2 to 6")
  expect_error(coalesce_pal(7), "2 to 6")
})
