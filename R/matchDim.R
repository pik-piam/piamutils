#' match object dimensions of a magclass object
#'
#' A helper that restricts and expands a magclass object x to the size of a
#' magclass object ref.
#'
#' @param x a magclass object to be modified
#' @param ref a magclass object used as a reference for the modification
#' @param fill value to be set in new dimensions
#' @importFrom magclass ndim new.magpie getItems getYears getNames mselect<-
#'
#' @export
matchDim <- function(x, ref, fill = 0) {
  if (ndim(x, dim = 3) != ndim(ref, dim = 3)) {
    stop(
      "Unsupported case: magclass objects x and ref have different number of ",
      "subdimensions in third dimension."
    )
  }

  # extend the object to the union of both objects
  r <- new.magpie(
    cells_and_regions = union(getItems(x, dim = 1), getItems(ref, dim = 1)),
    years = union(getYears(x), getYears(ref)),
    names = union(getNames(x), getNames(ref)),
    fill = fill,
    sets = names(dimnames(ref))
  )

  # copy over values from x
  r[getItems(x, dim = 1), getYears(x), getNames(x)] <- x

  # restrict object to dimensions of ref
  r <- r[getItems(ref, dim = 1), getYears(ref), getNames(ref)]

  return(r)
}

#' match spatial dimension of a magclass object
#'
#' A helper that restricts and expands a magclass object x to the size of a
#' magclass object ref in the spatial dimension.
#'
#' @param x a magclass object to be modified
#' @param ref a magclass object used as a reference for the modification
#' @param fill value to be set in new dimensions
#' @importFrom magclass ndim
#'
#' @export
matchRegions <- function(x, ref, fill = 0) {
  r <- new.magpie(
    cells_and_regions = union(getItems(x, dim = 1), getItems(ref, dim = 1)),
    years = getYears(x),
    names = getNames(x),
    fill = fill,
    sets = names(dimnames(x))
  )

  # copy over values from x
  r[getItems(x, dim = 1), , ] <- x

  # restrict object to dimensions of ref
  r <- r[getItems(ref, dim = 1), , ]

  return(r)
}

#' match temporal dimension of a magclass object
#'
#' A helper that restricts and expands a magclass object x to the size of a
#' magclass object ref in the temporal dimension.
#'
#' @param x a magclass object to be modified
#' @param ref a magclass object used as a reference for the modification
#' @param fill value to be set in new dimensions
#' @importFrom magclass ndim
#'
#' @export
matchYears <- function(x, ref, fill = 0) {
  r <- new.magpie(
    cells_and_regions = getItems(x, dim = 1),
    years = union(getYears(x), getYears(ref)),
    names = getNames(x),
    fill = fill,
    sets = names(dimnames(x))
  )

  # copy over values from x
  r[, getYears(x), ] <- x

  # restrict object to dimensions of ref
  r <- r[, getYears(ref), ]

  return(r)
}
