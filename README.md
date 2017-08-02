
<!-- 
  README.md is generated from README.Rmd, so you should edit that file.
-->
rfars <img src="man/figures/logo.png" align="right" width="120"/>
=================================================================

Workflow to create an R package
-------------------------------

In order to create this package, I followed the following steps:

1.  Follow the steps described in [the check lists of Roger D. Peng](https://github.com/rdpeng/daprocedures/blob/master/README.md).
2.  Fill the DESCRIPTION file with the information of your package.
3.  Document the code in the folder [R](./R) with roxygen2-style documentation.
4.  Delete the NAMESPACE file when you create the package's project and allow that `devtools` creates this file with the function `document()`.
5.  If you want to create a vignette, use the following function `devtools::use_vignette("vignette-name")`; then, modify the vignette and press Ctrl/Cmd + Shift + K to knit it.
6.  In case you want to include external data (e.g., `.bz2` files), you should store it in the [inst\\extdata](.\inst\extdata) folder (please refer to the section of [raw data](http://r-pkgs.had.co.nz/data.html#data-extdata) of the book "R packages" by *Hadley Wickham*); moreover, use the function `system.file` function to know where the external files are stored once the package is installed (see the examples in the documentation).
