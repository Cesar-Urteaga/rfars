
<!-- 
  README.md is generated from README.Rmd, so you should edit that file.
-->
rfars <img src="man/figures/logo.png" align="right" width="120"/>
=================================================================

Workflow to create an R package
-------------------------------

In order to create this package, I followed the next steps:

1.  Follow the steps described in [the check lists of Roger D. Peng](https://github.com/rdpeng/daprocedures/blob/master/README.md).
2.  Fill the [DESCRIPTION](DESCRIPTION) file with the information of your package.
3.  Document the code in the folder [R](./R) with roxygen2-style documentation.
4.  Delete the [NAMESPACE](NAMESPACE) file when you create the package's project and allow that `devtools` creates this file with the function `document()`.
5.  If you want to create an Rmarkdown vignette, use the function `devtools::use_vignette("vignette-name")`; then, modify the vignette and press Ctrl/Cmd + Shift + K to knit it.
6.  You can distribute the documentation in pdf format executing the command `R CMD Rd2pdf package_name` in the parent folder of the package.
7.  In case you want to include external data (e.g., `.bz2` files), you should store it in the [inst\\extdata](./inst/extdata) folder (please refer to the section of [raw data](http://r-pkgs.had.co.nz/data.html#data-extdata) of the book "R packages" by *Hadley Wickham*); moreover, use the function `system.file` to know where the external files are stored once the package is installed (see the examples in the documentation).
8.  So as to include a battery of test, run the command `devtools::use_testthat()` and include the tests in the [testthat](./tests/testhat) folder. Once you have added the tests, execute `devtools::test()` to perform each one. Please review the chapter of [testing](http://r-pkgs.had.co.nz/tests.html) in the Hadley's book.
9.  To check if your package pass the CRAN's battery of tests, click the `Check` button in the `Build` tab of `RStudio`. N.B.: It is possible that you could get the following note: "no visible binding for global variable \[variable name\]". To get around of it, see the [suggested solution](https://stackoverflow.com/a/17807914) in stackoverflow.
10. Finally, to use the continuous integration service of Travis, run `devtools::use_travis()` and activate the package's repository in your Travis account; then, add, commit, and push your changes in Github.
