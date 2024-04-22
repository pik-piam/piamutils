#' Find the path to R System Files for a given R library
#'
#' A wrapper around \link[base]{system.file} to make sure that the correct path
#' to the package on the local machine is returned. Built for stability when
#' working with devtools::load_all() during development.
#'
#' @param packageName a character string with the name of a single package
#'
#' @importFrom pkgload is_dev_package
#' @export
getPackageLocation <- function(packageName) {
  packageLocation <- if (is_dev_package(packageName)) {
    # If <packageName> was attached using devtools::load_all(), system.file()
    # might or might not be shimmed with pkgload:::shim_system.file()
    # (depending on whether the package was loaded normally or
    # through devtools::load_all()), and will yield different results.
    # base::system.file() will return the directory from where <packageName> was
    # loaded, and we append inst/ manually.
    file.path(base::system.file(package = packageName), "inst")
  } else {
    # If <packageName> was attached normally, system.file() (shimmed or not)
    # will return correct results.
    system.file(package = packageName)
  }

  return(packageLocation)
}
