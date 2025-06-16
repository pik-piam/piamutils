# Utilities for the piam-verse

R package **piamutils**, version **0.1.0**

[![CRAN status](https://www.r-pkg.org/badges/version/piamutils)](https://cran.r-project.org/package=piamutils) [![R build status](https://github.com/pik-piam/piamutils/workflows/check/badge.svg)](https://github.com/pik-piam/piamutils/actions) [![codecov](https://codecov.io/gh/pik-piam/piamutils/branch/master/graph/badge.svg)](https://app.codecov.io/gh/pik-piam/piamutils) [![r-universe](https://pik-piam.r-universe.dev/badges/piamutils)](https://pik-piam.r-universe.dev/builds)

## Purpose and Functionality

This package contains utilities and helpers needed in various piam libraries.


## Installation

For installation of the most recent package version an additional repository has to be added in R:

```r
options(repos = c(CRAN = "@CRAN@", pik = "https://rse.pik-potsdam.de/r/packages"))
```
The additional repository can be made available permanently by adding the line above to a file called `.Rprofile` stored in the home folder of your system (`Sys.glob("~")` in R returns the home directory).

After that the most recent version of the package can be installed using `install.packages`:

```r 
install.packages("piamutils")
```

Package updates can be installed using `update.packages` (make sure that the additional repository has been added before running that command):

```r 
update.packages()
```

## Questions / Problems

In case of questions / problems please contact Falk Benke <benke@pik-potsdam.de>.

## Citation

To cite package **piamutils** in publications use:

Benke F, Schötz C (2025). "piamutils: Utilities for the piam-verse." Version: 0.1.0, <https://github.com/pik-piam/piamutils>.

A BibTeX entry for LaTeX users is

 ```latex
@Misc{,
  title = {piamutils: Utilities for the piam-verse},
  author = {Falk Benke and Christof Schötz},
  date = {2025-06-16},
  year = {2025},
  url = {https://github.com/pik-piam/piamutils},
  note = {Version: 0.1.0},
}
```
