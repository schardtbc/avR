#' avR: A wrapper for the Alpha Vantage API
#'
#' ##What is Alpha Vantage?
#'
#' Alpha Vantage Inc. is a leading provider of free APIs for realtime and historical data on stocks,
#' forex (FX), and digital/crypto currencies. Our success is driven by rigorous research, cutting edge
#' technology, and a disciplined focus on democratizing access to data.
#'
#' https://www.alphavantage.co/documentation/
#'
#' This wrapper only implements TIME_SERIES_DAILY_ADJUSTED and TIME_SERIES_INTRADAY endpoints
#'
#' The data is returned as a data frame with column names modified for uploading to a database
#'
#'
#' ## Security Tokens
#'
#' During resistration at icloud.io you were given security tokens required to access this API.
#' This wrapper will read those tokens from the .env file. The .env file must include the
#' following four key pairs: note(put .env in your .gitignore file)
#'
#' ```
#' ALPHA_VANTAGE_API_KEY = "..."
#' ```
#'
#' @docType package
#' @name avR
#' @author Bruce C. Schardt, \email{schardt.bruce.curtis@@gmail.com}
NULL
