avR Package
-----------

A simple client to access the Alpha Vantage Market Data Api. Only the
TIME\_SERIES\_DAILY\_ADJUSTED and TIME\_SERIES\_INTRADAY endpoints are
exposed.

Daily Market Data
-----------------

    aapl <- time_series_daily_adjusted("AAPL",outputsize="full")
    aapl

    ## # A tibble: 5,356 x 18
    ##    symbol date  sourceName sequenceID datetime             epoch  open
    ##    <chr>  <chr> <chr>           <dbl> <dttm>               <dbl> <dbl>
    ##  1 AAPL   2019… AV                  0 2019-04-16 09:30:00 1.56e9  199.
    ##  2 AAPL   2019… AV                  0 2019-04-15 09:30:00 1.56e9  199.
    ##  3 AAPL   2019… AV                  0 2019-04-12 09:30:00 1.56e9  199.
    ##  4 AAPL   2019… AV                  0 2019-04-11 09:30:00 1.55e9  201.
    ##  5 AAPL   2019… AV                  0 2019-04-10 09:30:00 1.55e9  199.
    ##  6 AAPL   2019… AV                  0 2019-04-09 09:30:00 1.55e9  200.
    ##  7 AAPL   2019… AV                  0 2019-04-08 09:30:00 1.55e9  196.
    ##  8 AAPL   2019… AV                  0 2019-04-05 09:30:00 1.55e9  196.
    ##  9 AAPL   2019… AV                  0 2019-04-04 09:30:00 1.55e9  195.
    ## 10 AAPL   2019… AV                  0 2019-04-03 09:30:00 1.55e9  193.
    ## # … with 5,346 more rows, and 11 more variables: high <dbl>, low <dbl>,
    ## #   volume <dbl>, close <dbl>, aOpen <dbl>, aHigh <dbl>, aLow <dbl>,
    ## #   aClose <dbl>, aVolume <dbl>, dividendAmount <dbl>,
    ## #   splitCoefficient <dbl>

Intraday Market Data
--------------------

    aapl_id <- time_series_intraday("AAPL",outputsize="full")
    aapl_id

    ## # A tibble: 1,950 x 15
    ##    symbol date  minute sourceName sequenceID datetime             epoch
    ##    <chr>  <chr>  <dbl> <chr>           <dbl> <dttm>               <dbl>
    ##  1 AAPL   2019…    390 AV                  0 2019-04-16 16:00:00 1.56e9
    ##  2 AAPL   2019…    389 AV                  0 2019-04-16 15:59:00 1.56e9
    ##  3 AAPL   2019…    388 AV                  0 2019-04-16 15:58:00 1.56e9
    ##  4 AAPL   2019…    387 AV                  0 2019-04-16 15:57:00 1.56e9
    ##  5 AAPL   2019…    386 AV                  0 2019-04-16 15:56:00 1.56e9
    ##  6 AAPL   2019…    385 AV                  0 2019-04-16 15:55:00 1.56e9
    ##  7 AAPL   2019…    384 AV                  0 2019-04-16 15:54:00 1.56e9
    ##  8 AAPL   2019…    383 AV                  0 2019-04-16 15:53:00 1.56e9
    ##  9 AAPL   2019…    382 AV                  0 2019-04-16 15:52:00 1.56e9
    ## 10 AAPL   2019…    381 AV                  0 2019-04-16 15:51:00 1.56e9
    ## # … with 1,940 more rows, and 8 more variables: average <dbl>, open <dbl>,
    ## #   high <dbl>, low <dbl>, close <dbl>, volume <dbl>, notional <dbl>,
    ## #   numberOfTrades <dbl>

Note that the data is returned as a tibble (dataframe)

    ggplot2::ggplot(aapl %>%filter(datetime>"2018-06-01"),aes(x = datetime)) +
      geom_candlestick(aes(open = aOpen, high=aHigh, low= aLow, close = aClose)) + ggplot2::ggtitle("APPLE DAILY",subtitle = "from ALPHA VANTAGE")

![](README_files/figure-markdown_strict/apple%20daily-1.png)

    ggplot2::ggplot(aapl_id ,aes(x = minute,y=close,colour=date)) +
      geom_line() +
      ggplot2::ggtitle("APPLE Intraday",subtitle = "from ALPHA VANTAGE")

![](README_files/figure-markdown_strict/apple%20intraday-1.png)
