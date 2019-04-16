# avR core.R



readRenviron(".env")
env<-Sys.getenv();
avEnv <- env[grep("^ALPHA_VANTAGE",names(env))];


theenv <- function(){
  env
}

baseURL <- avEnv[["ALPHA_VANTAGE_BASE_URL"]];


addToken <- function(endpoint){
  paste0(endpoint, "&apikey=", avEnv[["ALPHA_VANTAGE_API_KEY"]])
};


prefix <- function() {
  v<-"https://www.alphavantage.co/query?function="
  return (v)
}

constructURL <- function(endpoint) {
  paste0(prefix(),addToken(endpoint))
}

#' Perform a get request to an endpoint on the alpha_vantage server
#'
#' @param endpoint a string which will form the variable are of the endpoint URL
#' @return parsed response data, this will usually be a list of key:value pairs from parsed json object
#' @export
avGet <- function(endpoint) {
  url <- constructURL(endpoint);
  # show(url);
  res <- httr::GET(url);
  httr::content(res);
};


#' Perform a get request to an endpoint on the iexcloud server, will show the complete url
#' including security token being sent to the server for debug
#'
#' @param endpoint a string which will form the variable are of the endpoint URL
#' @return parsed response data, this will usually be a list of key:value pairs from parsed json object
avDebug <- function(endpoint) {
  url <- addToken(paste0(baseURL,endpoint));
  show(url);
  res <- httr::GET(url);
  httr::content(res);
};

#' Perform a get request to an endpoint on the alphaVantage server
#'
#' @param endpoint a string which will form the variable are of the endpoint URL
#' #' @return raw response object
#' @export
avRaw <- function(endpoint) {
  url <- constructURL(endpoint);
  httr::GET(url);
};
#
