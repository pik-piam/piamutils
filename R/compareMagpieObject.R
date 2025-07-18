#' compareMagpieObject
#'
#' A helper to analyze two magpie objects for differences.
#'
#' @param x a magpie object or a string referring to a file that can be read in as a mapgie object
#' @param y a magpie object or a string referring to a file that can be read in as a mapgie object
#' @param tol optional value between 0 and 1 to restrict value differences between the
#' two magpie objects to be listed, a data entry must exceed `tol` percent of the maximum
#' value difference observed in the data to be listed
#'
#' @author Falk Benke
#' @importFrom dplyr mutate arrange desc
#' @importFrom magclass magpply getYears getItems read.magpie
#' @export
compareMagpieObject <- function(x, y, tol = 0) {

  if (is.character(x) && is.character(y)) {
    x <- read.magpie(x)
    y <- read.magpie(y)
  }

  # compare dimensions names ----

  if (!identical(dim(x), dim(y))) {
    message("# Dimension names are not identical")
    message(paste0("## Dimension ",
      which(dim(x) != dim(y)), ": ",
      dim(x)[dim(x) != dim(y)], " != ",
      dim(y)[dim(x) != dim(y)],
      collapse = ", "
    ))
  } else {
    message("# Dimensions are identical (/)")
  }

  # compare dimension values ----

  same <- TRUE
  for (i in 1:3) {
    if (!setequal(dimnames(x)[[i]], dimnames(y)[[i]])) {
      message("# Values in dimension ", i, " are not identical")
      same <- FALSE
      onlyX <- setdiff(dimnames(x)[[i]], dimnames(y)[[i]])
      onlyY <- setdiff(dimnames(y)[[i]], dimnames(x)[[i]])

      if (length(onlyX) > 0) {
        message(paste0("## Values only in x: ", paste0(onlyX, collapse = ", ")))
      }

      if (length(onlyY) > 0) {
        message(paste0("## Values only in y: ", paste0(onlyY, collapse = ", ")))
      }
    }
  }

  if (same) {
    message("# All dimension names are identical (/)")
  }

  # continue with the subset of identical values ----

  x <- x[
    intersect(getItems(x, dim = 1), getItems(y, dim = 1)),
    intersect(getYears(x), getYears(y)),
    intersect(getNames(x), getNames(y))
  ]

  y <- y[
    intersect(getItems(x, dim = 1), getItems(y, dim = 1)),
    intersect(getYears(x), getYears(y)),
    intersect(getNames(x), getNames(y))
  ]

  if (length(x) == 0) {
    message("# No overlapping data to identify.")
    return()
  }

  # compare NA values ----

  if (length(x[is.na(x)]) != length(y[is.na(y)])) {
    message(paste0("# Number of NAs differs: ", length(x[is.na(x)]), " != ", length(y[is.na(y)])))
  } else {
    message("# Number of NAs is identical (/)")
  }

  naX <- magpply(x, function(y) any(is.na(y)), MARGIN = 3)
  naX <- x[, , naX]
  naY <- magpply(y, function(y) any(is.na(y)), MARGIN = 3)
  naY <- y[, , naY]

  if (length(setdiff(getNames(naX), getNames(naY))) > 0) {
    message(paste0(
      "## Items with NA values only in x: ",
      paste0(setdiff(getNames(naX), getNames(naY)), collapse = ", ")
    ))
  }

  if (length(setdiff(getNames(naY), getNames(naX))) > 0) {
    message(paste0(
      "## Items with NA values only in y: ",
      paste0(setdiff(getNames(naY), getNames(naX)), collapse = ", ")
    ))
  }

  # compare non-NA values ----
  diff <- abs(x - y)
  maxDiff <- max(diff, na.rm = TRUE)

  if (maxDiff != 0) {
    message(paste0("# Maximum value difference in common values: ", round(maxDiff, digits = 2)))
    minDiff <- min(diff, na.rm = TRUE)
    diffScaled <- (diff - minDiff) / (maxDiff - minDiff)
    gaps <- magclass::where(diffScaled > tol)

    message(paste0("## Variables with differences: ", paste0(gaps$true$data, collapse = "\n ")))

    df <- gaps$true$individual %>%
      as.data.frame() %>%
      mutate("x" = NA, "y" = NA)

    for (i in seq(1, nrow(df))) {

      # a hack for getYears(x) == NULL

      if (df[i, 2] == "dummy") {
        df[i, "x"] <- x[df[i, 1], , df[i, 3]]
        df[i, "y"] <- y[df[i, 1], , df[i, 3]]
      } else {
        df[i, "x"] <- x[df[i, 1], df[i, 2], df[i, 3]]
        df[i, "y"] <- y[df[i, 1], df[i, 2], df[i, 3]]
      }
    }

    df <- df %>%
      mutate(
        diff = abs(.data$x - .data$y),
        factor = .data$y / .data$x
      ) %>%
      arrange(desc(diff))

    message("# Largest differences")
    cat("\n")
    print(df)
  } else {
    message(paste0("# Values are identical (/)"))
  }
}
