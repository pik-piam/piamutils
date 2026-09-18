#' readGdxToDf
#'
#' Read data for a given symbol from a gdx file and return it as a dataframe using
#' gamstransfer::readGDX
#'
#' @param symbolName The name of a symbol to be extracted from gdx.
#' @param pathToGdx Path to a gdx file.
#' @param ... Additional arguments passed to gamstransfer::readGDX.
#' @return A data frame with data about symbolName from the given gdx file.
#' @author Falk Benke
#'
#' @export
readGdxToDf <- function(symbolName, pathToGdx, ...) {
  x <- gamstransfer::readGDX(pathToGdx, symbolName, ...)
  stopifnot(length(x) == 1)
  result <- x[[1]]$records
  result <- data.frame(lapply(result, as.character), stringsAsFactors = FALSE)
  result <- utils::type.convert(result, as.is = TRUE)
  colnames(result)[length(colnames(result))] <- symbolName
  return(result)
}
