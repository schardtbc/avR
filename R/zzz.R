


#readRenviron(".env")
#env<-Sys.getenv();
#avEnv <- env[grep("^ALPHA_VANTAGE",names(env))];


#theenv <- function(){
#  env
#}

#baseURL <- avEnv[["ALPHA_VANTAGE_BASE_URL"]];





config <- new.env(parent = emptyenv())

#' returns package configuration
#' @export
getConfig <- function(){
  config
}

addToken <- function(endpoint){
  paste0(endpoint, "&apikey=", config$token)
};

#' set the AlphaVantage API token
#' @param token iex cloud token
#' @export
setToken <- function(token){
  config$token <- token;
}

#' retrieve the AlphaVantage API token
#' @export
getToken <- function(){
  config$token;
}

.onLoad <- function(libname, pkgname) {
#  if (file.exists(".env")){
#    readRenviron(".env");
#  }
  env<-Sys.getenv();
  avEnv <- as.list(env[grep("^ALPHA_VANTAGE",names(env))]);
  config$baseURL <- "https://www.alphavantage.co/query?function=";
  config$rate <- coalesce(avEnv$ALPHA_VANTAGE_RATE,120)
  config$limit <- coalesce(avEnv$ALPHA_VANTAGE_LIMIT,0)
  token <- avEnv$ALPHA_VANTAGE_API_KEY;
  if (is.null(token)) {
    warning('ALPHA_VANTAGE_API_KEY in environment file to access AlphaVantage API')
  }
  config$token <- token;
  invisible(config)
}

#' get AlphaVantage base url
#' @export
get_base_url<-function(){
  config$baseURL;
}



#' get AlphaVantage API tokens
#' @export
get_credentials <- function() {
  token = config$token;
  if (is.null(token)) {
    stop('ALPHA_VANTAGE_API_KEY must be given to access AlphaVantage API')
  }

  return (list(token = token))
}

#' get the Alpaca API version
#' @export
get_api_version<- function(){
  config$apiVersion;
}
