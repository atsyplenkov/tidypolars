test_that("count works", {
  test <- polars::as_polars_df(mtcars)

  expect_is_tidypolars(count(test))

  expect_equal(
    count(test) |> pull(n),
    32
  )

  expect_equal(
    count(test, cyl) |> pull(n),
    c(11, 7, 14)
  )

  expect_equal(
    count(test, cyl, am) |> pull(n),
    c(3, 8, 4, 3, 12, 2)
  )
})

test_that("arguments name and sort work", {
  test <- polars::as_polars_df(mtcars)

  expect_equal(
    count(test, cyl, am, sort = TRUE, name = "count") |> pull(count),
    c(12, 8, 4, 3, 3, 2)
  )

  expect_equal(
    count(test, name = "count") |> pull(count),
    32
  )
})

test_that("count works on grouped data", {
  test <- polars::as_polars_df(mtcars)
  test_grp <- group_by(test, am)

  expect_equal(
    count(test_grp) |> pull(n),
    c(19, 13)
  )

  expect_equal(
    count(test_grp, cyl) |> pull(n),
    c(3, 4, 12, 8, 3, 2)
  )
})

test_that("add_count works", {
  test <- polars::as_polars_df(mtcars)

  expect_colnames(
    add_count(test, cyl),
    c(names(mtcars), "n")
  )
})

test_that("arguments name and sort work", {
  test <- polars::as_polars_df(mtcars)

  expect_colnames(
    add_count(test, cyl, am, sort = TRUE, name = "count"),
    c(names(mtcars), "count")
  )

  expect_dim(
    add_count(test, cyl, am, sort = TRUE, name = "count"),
    c(32, 12)
  )

  expect_dim(
    add_count(test, name = "count"),
    c(32, 12)
  )
})

test_that("add_count works on grouped data", {
  test <- polars::as_polars_df(mtcars)
  test_grp <- group_by(test, am, maintain_order = TRUE)

  expect_equal(
    attr(count(test_grp), "pl_grps"),
    "am"
  )

  expect_equal(
    attr(add_count(test_grp), "pl_grps"),
    "am"
  )

  expect_true(attr(count(test_grp), "maintain_grp_order"))

  expect_true(attr(add_count(test_grp), "maintain_grp_order"))
})

test_that("message if overwriting variable", {
  test <- polars::as_polars_df(mtcars)

  test2 <- test |>
    mutate(n = 1)

  test3 <- test2 |>
    mutate(nn = 1)

  expect_message(
    test2 |> count(n),
    "Storing counts in `nn`, as `n` already present in input."
  )

  expect_message(
    test2 |> add_count(cyl),
    "Storing counts in `nn`, as `n` already present in input."
  )

  expect_message(
    test3 |> add_count(cyl),
    "Storing counts in `nnn`, as `n` already present in input."
  )

  expect_equal(
    test2 |>
      add_count(cyl, name = "n") |>
      pull(n),
    test |>
      add_count(cyl, name = "n") |>
      pull(n)
  )
})
