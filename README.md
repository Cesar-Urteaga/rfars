
<!-- 
  README.md is generated from README.Rmd, so you should edit that file.
-->
rfars <img src="man/figures/logo.png" align="right" width="120"/>
=================================================================

[![Travis Build Status](https://travis-ci.org/Cesar-Urteaga/rfars.svg?branch=master)](https://travis-ci.org/Cesar-Urteaga/rfars) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/Cesar-Urteaga/rfars?branch=master&svg=true)](https://ci.appveyor.com/project/Cesar-Urteaga/rfars) [![codecov](https://codecov.io/gh/Cesar-Urteaga/rfars/branch/master/graph/badge.svg)](https://codecov.io/gh/Cesar-Urteaga/rfars)

Overview
--------

rfars is an [R](https://www.r-project.org/) package with a set of functions that makes easier to analyze the data from the US National Highway Traffic Safety Administration's [Fatality Analysis Reporting System (FARS)](https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars).

Installation
------------

``` r
# Install the package from GitHub without the vignette:
devtools::install_github("Cesar-Urteaga/rfars")

# Or you can include it:
devtools::install_github("Cesar-Urteaga/rfars", build_vignettes = TRUE)
```

Purpose
-------

The aim of this project was to **combine the skills of creating, writing, and testing an R package**, using the R files provided in the course [Building R Packages](https://www.coursera.org/learn/r-packages) offered by the Johns Hopkins University through the Coursera's platform.

For this assessment, it was required to perform the following tasks:

1.  Write a vignette to be included in the package using [knitr](https://cran.r-project.org/web/packages/knitr/index.html) and [R Markdown](http://rmarkdown.rstudio.com/);
2.  Formulate at least one test using the [testthat](https://cran.r-project.org/web/packages/testthat/index.html) package;
3.  Put the package on Github;
4.  Set up the package's repository so that can be checked and built on [Travis](https://travis-ci.org/);
5.  Add the Travis badge to the package's README.md file, as soon as your package has built on Travis and the build is passing without errors, warnings, or notes.

Workflow
--------

In order to create this package, I followed this path:

1.  Consider the steps set forth in [the check lists of Roger D. Peng](https://github.com/rdpeng/daprocedures/blob/master/README.md).
2.  Create a README file with R Markdown (use the template `Github Document (Markdown`)).
3.  Set up a Github repository and change the `Project Options` within the `Tools` menu and `Git/SVN` tab; select Git as `version control system`. Thereupon, add the remote through the Git browser using the shell. Later, edit the `.gitignore` and `.Rbuildignore` files.
4.  Add and commit the files using the Git browser and push the first commit with the shell: `git push -u origin master` (subsequent commits can be pushed in RStudio's Git browser).
5.  Delete the [NAMESPACE](NAMESPACE) file when you create the package's project (allow that `devtools` creates this file with the function `document()`).
6.  Document the code in the [R](./R) folder using roxygen2-style documentation, and execute `devtools::document()` (or press Ctrl/Cmd + Shift + D in RStudio) in order to create the `.Rd` files. Later, press the RStudio's `Build & Reload` button (Ctrl/Cmd + Shift + B) and review the help files with `?`.
7.  Fill the [DESCRIPTION](DESCRIPTION) file with the information of your package. Take into account the libraries in the `@importFrom` sections of the roxygen2-style documentation to fill the `Imports` section.
8.  If you want to create an [R Markdown vignette](./vignettes/using-rfars.Rmd), use the function `devtools::use_vignette("vignette-name")`; then, modify the vignette and press Ctrl/Cmd + Shift + K to knit it.
9.  Optional: You can distribute the documentation in pdf format executing the command `R CMD Rd2pdf package-name` in the parent folder of the package.
10. In case you want to include external data (e.g., `.bz2` files), you should store them in the [inst\\extdata](./inst/extdata) folder (please refer to the section of [raw data](http://r-pkgs.had.co.nz/data.html#data-extdata) of the book "R packages" by *Hadley Wickham*); moreover, use the function `system.file` to know where the external files are stored once the package is installed (see the [examples in the documentation](https://raw.githubusercontent.com/Cesar-Urteaga/rfars/master/R/fars_functions.R)).
11. So as to include a battery of tests, run the command `devtools::use_testthat()` and include the tests in the [testthat](./tests/testthat) folder. Once you have added the tests, execute `devtools::test()` (Ctrl/Cmd + Shift + T) to carry out each one. Please review the chapter of [testing](http://r-pkgs.had.co.nz/tests.html) in the Hadley's book.
12. To check if your package pass the CRAN's battery of tests, click the `Check` button in the `Build` tab of `RStudio`. N.B.: It is possible that you could get the following note: "no visible binding for global variable variable-name". To get around of it, see the [suggested solution](https://stackoverflow.com/a/17807914) in stackoverflow.
13. Finally, you can include the continuous integration service of [Travis](https://travis-ci.org/) to your package by running the `devtools::use_travis()` command and activating the package's repository in your Travis account; thereupon, add, commit, and push your changes in Github and insert the Travis badge into the README file. N.B.: For the [AppVeyor](https://www.appveyor.com/) service use `devtools::use_appveyor()` and check the [AppVeyor's documentation](https://www.appveyor.com/docs/status-badges/#badges-for-projects-with-public-repositories-on-github-and-bitbucket) to add the badge into the README file.
14. Optional: In case you desire to include the LICENSE file into the Github's repository, you may want to see [this post](https://stackoverflow.com/a/37895659) in Stackoverflow. **N.B.: Please, do not forget to include the reference of the LICENSE file into the DESCRIPTION archive** (e.g., `License: GPL-3 | file LICENSE`).
15. Optional: In order to include a [code coverage](https://en.wikipedia.org/wiki/Code_coverage) measure to the package using [codecov](https://codecov.io), you must need to add the package's repository to this service, include [this code](https://github.com/Cesar-Urteaga/rnoaa/blob/master/.travis.yml) in the [.travis/yml](.travis.yml) file (change the package's name), and execute the command `covr::codecov(token = "YOUR_TOKEN_GOES_HERE")` with the ascribed token. N.B.: Do not forget to include the `codecov` badge into the README file.

R session
---------

The session in which I have created this package was the following:

``` r
sessionInfo()
R version 3.4.1 (2017-06-30)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.2 LTS

Matrix products: default
BLAS: /usr/lib/libblas/libblas.so.3.6.0
LAPACK: /usr/lib/lapack/liblapack.so.3.6.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=es_MX.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=es_MX.UTF-8    LC_MESSAGES=en_US.UTF-8   
 [7] LC_PAPER=es_MX.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=es_MX.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
 [1] compiler_3.4.1  backports_1.1.0 magrittr_1.5    rprojroot_1.2  
 [5] tools_3.4.1     htmltools_0.3.6 yaml_2.1.14     Rcpp_0.12.12   
 [9] stringi_1.1.5   rmarkdown_1.6   knitr_1.17      stringr_1.2.0  
[13] digest_0.6.12   evaluate_0.10.1
```
