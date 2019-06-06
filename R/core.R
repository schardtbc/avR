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
  resp <- httr::GET(url);

  parsed <- list()
  if (httr::http_error(resp)) {
    warning(
      sprintf(
        "ALPHA VANTAGE API request failed [%s]\n%s\n%s\n%s",
        httr::status_code(resp),
        httr::content(resp, "text"),
        "endpoint requested:",
        endpoint
      ),
      call. = FALSE
    )
  } else {

    if (httr::http_type(resp) != "application/json") {
      warning(
        sprintf(
          "ALPHA VANTAGE API did not return json\n%s",
          httr::content(resp, "text")
        ),
        call. = FALSE
      );
      parsed <- list();
    } else {
      parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)
    }
  }

  structure(
    list(
      status = httr::http_error(resp),
      content = parsed,
      endpoint = endpoint,
      response = resp
    ),
    class = "alpha_vantage_api"
  )

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
