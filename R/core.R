# avR core.R



addToken <- function(endpoint){
  paste0(endpoint, "&apikey=", getCredentials()$token)
};


prefix <- function() {
  get_base_url()
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
  res <- httr::GET(url);
  httr::content(res);
};


#' Perform a get request to an endpoint on the iexcloud server, will show the complete url
#' including security token being sent to the server for debug
#'
#' @param endpoint a string which will form the variable are of the endpoint URL
#' @return parsed response data, this will usually be a list of key:value pairs from parsed json object
#' @export
avDebug <- function(endpoint) {
  url <- constructURL(endpoint);
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
