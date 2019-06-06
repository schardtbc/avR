
#' returns market end of day adjusted data for a specified symbol
#'
#' @param symbol string, a market data symbol such as "AMZN"
#' @param outputsize "full"; full returns ~ 20 years worth of data; compact returns last 100 data points
#' @param interval "1min"; choices are  1min, 5min, 15min, 30min, 60min
#' @param lastN 0; if >0 lastN species how many of the most recent trading days will be returned
#' @return dataframe
#' @export
time_series_daily_adjusted <- function(symbol,outputsize = "compact", lastN=0){
  endpoint <- glue::glue("TIME_SERIES_DAILY_ADJUSTED&symbol={symbol}&outputsize={outputsize}");
  res <- avGet(endpoint);
  if (res$status) return (tibble::as_tibble(list()))
  data <- res$content[[2]];
  d0 <- lapply(data,function(x){lapply(x, function(y) {ifelse(is.null(y),NA,as.numeric(y))})})
  df <- tibble::as_tibble(do.call(rbind,d0),rownames="date") %>%
        dplyr::mutate(symbol = res[[1]]$`2. Symbol`) %>%
        tidyr::unnest() %>%
        dplyr::rename( open = `1. open`, high = `2. high`, low = `3. low`, close = `4. close`,
                       aClose = `5. adjusted close`, volume = `6. volume`, dividendAmount = `7. dividend amount`,
                       splitCoefficient = `8. split coefficient`) %>%
        dplyr::mutate( aOpen = open*aClose/close, aHigh = high*aClose/close, aLow = low*aClose/close,
                       sourceName="AV", sequenceID = 0, aVolume = ifelse(volume == 0,1,volume),
                       datetime = lubridate::as_datetime(paste0(date," 09:30:00"),tz = "America/New_York"),
                       epoch = as.numeric(lubridate::seconds(datetime))) %>%
        dplyr::select(symbol,date,sourceName,sequenceID,datetime,epoch,open,high,low,volume,close,aOpen,aHigh,aLow,aClose,aVolume,dividendAmount,splitCoefficient)
  if (lastN >0) {
    df <- dplyr::top_n(df,lastN,date)
  }
  return (df)
}


#' returns intraday market data for a specified symbol
#' @param symbol string, a market data symbol such as "AMZN"
#' @param outputsize "full"; full returns ~ 5 days worth of data; compact returns last 100 data points
#' @param interval "1min"; choices are  1min, 5min, 15min, 30min, 60min
#' @param lastday FALSE; if TRUE only most recent trading days days will be returned
#' @return dataframe
#' @export
time_series_intraday <- function(symbol,outputsize = "full", interval = "1min", lastday = FALSE){
  endpoint <- glue::glue("TIME_SERIES_INTRADAY&symbol={symbol}&interval={interval}&outputsize={outputsize}");
  res <- avGet(endpoint);
  if (res$status) return (tibble::as_tibble(list()))
  data <- res$content[[2]];
  d0 <- lapply(data,function(x){lapply(x, function(y) {ifelse(is.null(y),NA,as.numeric(y))})})
  df <- tibble::as_tibble(do.call(rbind,d0),rownames="date") %>%
    dplyr::mutate(symbol = res[[1]]$`2. Symbol`) %>%
    tidyr::unnest() %>%
    dplyr::rename( open = `1. open`, high = `2. high`, low = `3. low`, close = `4. close`,
                   volume = `5. volume`) %>%
    dplyr::mutate( sourceName="AV", sequenceID = 0,
                   datetime = lubridate::as_datetime(date, tz = "America/New_York"),
                   epoch = as.numeric(lubridate::seconds(datetime)),
                   average = 0,
                   notional = 0,
                   numberOfTrades = 0,
                   date = stringr::str_sub(date,1,10),
                   tref = lubridate::as_datetime(paste0(date," 09:30:00"),tz = "America/New_York"),
                   interval = lubridate::interval(tref,datetime),
                   minute = lubridate::int_length(lubridate::interval(tref,datetime))/60) %>%
    dplyr::select(symbol,date,minute,sourceName,sequenceID,datetime,epoch,average,open,high,low,close,volume,notional,numberOfTrades)
  if (lastday){
    lastDate = df$date[[1]];
    df <- dplyr::filter(df,date == lastDate);
  }
  return (df)
}
