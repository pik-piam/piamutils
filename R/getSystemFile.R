#' Find the path to R System Files for a given R library
#'
#' A wrapper around \link[base]{system.file} to make sure that the correct paths
#' are returned when working with devtools::load_all() during development.
#'
#' @param files character vectors, specifying subdirectory and file(s) within some package
#' @param package a character string with the name of a single package
#'
#' @importFrom pkgload is_dev_package
#' @export
getSystemFile <- function(files, package) {
  fileNames <- if (is_dev_package(package)) {
    # If <package> was attached using devtools::load_all(), system.file()
    # might or might not be shimmed with pkgload:::shim_system.file()
    # (depending on whether the package was loaded normally or
    # through devtools::load_all()), and will yield different results.
    # base::system.file() will return the directory from where <package> was
    # loaded, and we append inst/ manually.
    file.path(base::system.file(package = package, mustWork = TRUE), "inst", files)
  } else {
    # If <package> was attached normally, system.file() (shimmed or not)
    # will return correct results.
    system.file(files, package = package, mustWork = TRUE)
  }
  if (!file.exists(fileNames)) {
    stop("no file found")
  }

  return(fileNames)
}
