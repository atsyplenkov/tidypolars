% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slice.R
\name{slice_tail.RPolarsDataFrame}
\alias{slice_tail.RPolarsDataFrame}
\alias{slice_tail.RPolarsLazyFrame}
\alias{slice_head.RPolarsDataFrame}
\alias{slice_head.RPolarsLazyFrame}
\alias{slice_sample.RPolarsDataFrame}
\title{Subset rows of a Data/LazyFrame}
\usage{
\method{slice_tail}{RPolarsDataFrame}(.data, ..., n, by = NULL)

\method{slice_tail}{RPolarsLazyFrame}(.data, ..., n, by = NULL)

\method{slice_head}{RPolarsDataFrame}(.data, ..., n, by = NULL)

\method{slice_head}{RPolarsLazyFrame}(.data, ..., n, by = NULL)

\method{slice_sample}{RPolarsDataFrame}(.data, ..., n = NULL, prop = NULL, by = NULL, replace = FALSE)
}
\arguments{
\item{.data}{A Polars Data/LazyFrame}

\item{...}{Dots which should be empty.}

\item{n}{The number of rows to select from the start or the end of the data.
Cannot be used with \code{prop}.}

\item{by}{Optionally, a selection of columns to group by for just this
operation, functioning as an alternative to \code{group_by()}. The group order
is not maintained, use \code{group_by()} if you want more control over it.}

\item{prop}{Proportion of rows to select. Cannot be used with \code{n}.}

\item{replace}{Perform the sampling with replacement (\code{TRUE}) or without
(\code{FALSE}).}
}
\description{
Subset rows of a Data/LazyFrame
}
\section{Unknown arguments}{


Arguments that are supported by the original implementation in the tidyverse
but are not listed above will throw a warning by default if they are
specified. To change this behavior to error instead, use
\code{options(tidypolars_unknown_args = "error")}.
}

\examples{
\dontshow{if (require("dplyr", quietly = TRUE) && require("tidyr", quietly = TRUE)) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
pl_test <- polars::as_polars_df(iris)
slice_head(pl_test, n = 3)
slice_tail(pl_test, n = 3)
slice_sample(pl_test, n = 5)
slice_sample(pl_test, prop = 0.1)
\dontshow{\}) # examplesIf}
}
