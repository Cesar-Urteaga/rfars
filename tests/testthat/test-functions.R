context("classes")

# Sets up the working directory where the sample files are stored.
WD <- setwd(system.file("extdata", package = "rfars"))

test_that("class is correct", {
          expect_is(fars_read("accident_2013.csv.bz2"), c("tbl_df", "tbl", "data.frame"))
          expect_is(fars_summarize_years(2013), c("tbl_df", "tbl", "data.frame"))
          expect_is(fars_read_years(2013), "list")
          expect_is(make_filename(2013), "character")
          expect_is(fars_map_state(12, 2015), "NULL")
          })

# Restores the working directory.
setwd(WD)
