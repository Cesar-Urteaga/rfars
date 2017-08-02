#' Reads a delimited file into a tibble object.
#'
#' The function \code{fars_read} reads the contents of a compressed file in .bz2
#' format and returns them in a
#' \href{https://blog.rstudio.org/2016/03/24/tibble-1-0-0/}{tibble} object.
#'
#' @param filename The name of the compressed file which data are to be read
#'    from (a string value).
#'    \emph{If the file does not exist in the working directory},
#'    \bold{you should specify the whole path}.
#' @return A tibble object with the contents of the filename.
#' @export
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#' @details The function uses the algorithm of the \code{\link[readr]{read_csv}}
#'    function.
#' @section Warning:
#'    Provided that the file does not exist, the function will throw an error.
#' @examples
#' # We set the working directory where the compressed files are stored within
#' # the package.
#' WD <- setwd(system.file("extdata", package = "rfars"))
#' fars_read("accident_2013.csv.bz2")
#' setwd(WD)
fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE)
        })
        dplyr::tbl_df(data)
}

#' Creates a string filename based on a specific year.
#'
#' It creates a data filename string using the format of the US National Highway
#' Traffic Safety Administration in the Fatality Analysis Reporting System for
#' a specific year.
#'
#' @param year A numeric vector representing the years in a time period.
#' @return A character vector corresponding to the data filenames specified in
#'    the time period.
#' @export
#' @section Warning:
#'    If the \code{year} parameter cannot be coerced as an integer, the function
#'    will throw a warning that the information will not be read.
#' @examples
#' # We set the working directory where the compressed files are stored within
#' # the package.
#' WD <- setwd(system.file("extdata", package = "rfars"))
#' make_filename(2013)
#' setwd(WD)
make_filename <- function(year) {
        year <- as.integer(year)
        sprintf("accident_%d.csv.bz2", year)
}

#' Reads data from a compressed file based on a specific year.
#'
#' For the data provided by the US National Highway Traffic Safety
#' Administration in the Fatality Analysis Reporting System,
#' \code{fars_read_years} will read the data for a specific period, and it will
#' return a variable (MONTH) in the dataset.
#'
#' @param years A numeric vector representing the years of a time period.
#' @return A \href{https://blog.rstudio.org/2016/03/24/tibble-1-0-0/}{tibble}
#'    object with the data of car fatalities by month for each year in the
#'    specified period.
#' @export
#' @importFrom dplyr mutate select %>%
#' @section Warning:
#'    Provided that a file does not exist for a specific year, the function will
#'    throw a warning that the information was not read.
#' @examples
#' # We set the working directory where the compressed files are stored within
#' # the package.
#' WD <- setwd(system.file("extdata", package = "rfars"))
#' # Data with the car fatalities in 2013.
#' fars_read_years(2013)
#' # Data with the car fatalities in 2013 and 2014.
#' fars_read_years(c(2013, 2014))
#' setwd(WD)
fars_read_years <- function(years) {
        lapply(years, function(year) {
                file <- make_filename(year)
                tryCatch({
                        dat <- fars_read(file)
                        dplyr::mutate(dat, year = year) %>%
                                dplyr::select(MONTH, year)
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}

#' Creates a summary table with the counts of car fatalities.
#'
#' It creates a summary table with the tallies of the car fatalities reported
#' by the US National Highway Traffic Safety Administration in the Fatality
#' Analysis Reporting System for a specific period.
#'
#' @inheritParams fars_read_years
#' @return A \href{https://blog.rstudio.org/2016/03/24/tibble-1-0-0/}{tibble}
#'    object with the tallies of car fatalities by month for each year in the
#'    specified period.
#' @export
#' @importFrom dplyr bind_rows group_by summarize
#' @importFrom tidyr spread
#' @section Warning:
#'    Provided that a file does not exist for a specific year, the function will
#'    throw a warning that the information does not exist.
#' @examples
#' # We set the working directory where the compressed files are stored within
#' # the package.
#' WD <- setwd(system.file("extdata", package = "rfars"))
#' # Summary with the tallies of car fatalities in 2013.
#' fars_summarize_years(2013)
#' # Summary with the tallies of car fatalities in 2013 and 2014.
#' fars_summarize_years(c(2013, 2014))
#' setwd(WD)
fars_summarize_years <- function(years) {
        dat_list <- fars_read_years(years)
        dplyr::bind_rows(dat_list) %>%
                dplyr::group_by(year, MONTH) %>%
                dplyr::summarize(n = n()) %>%
                tidyr::spread(year, n)
}

#' Plots the car fatalities in a US state and in a specific year.
#'
#' It plots, in a map, the car fatalities occurred in a given US state and in a
#' specific year using the data reported by the US National Highway Traffic
#' Safety Administration in the Fatality Analysis Reporting System.
#'
#' @param state.num An integer value corresponding to a US state.
#' @inheritParams make_filename
#' @export
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
#' @section Warning:
#'    If the \code{state.num} parameter is not a valid state number or the
#'    information specified in the \code{year} parameter does not exist, the
#'    function will throw an error.
#' @examples
#' # We set the working directory where the compressed files are stored within
#' # the package.
#' WD <- setwd(system.file("extdata", package = "rfars"))
#' fars_map_state(12, 2015)
#' setwd(WD)
fars_map_state <- function(state.num, year) {
        filename <- make_filename(year)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)
        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        data.sub <- dplyr::filter(data, STATE == state.num)
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                graphics::points(LONGITUD, LATITUDE, pch = 46)
        })
}
