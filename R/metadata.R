
#' Get Coinmarketcap Coin Metadata.
#'
#' Uses the *info* API that returns header information from Coinmarketcap.
#' For more details see the [documentation](https://coinmarketcap.com/api/documentation/v1/#operation/getV2CryptocurrencyInfo).
#'
#' You should use this function once at the beginning, save the file somewhere and then never
#' re-run this function again, to save on API calls.
#'
#'
#'
#' @return A data frame containing the metadata information for all cryptocurrencies available.
#' @export
#' @import httr jsonlite data.table
#' @importFrom magrittr "%>%"
#'
#' @param type Type of identifiers used to search the coins. Can be one of 'id', 'slug', 'symbol' or 'address'. Defaults to Coinmarketcap id.
#' @param identifiers Vector containing the list of currencies you want to include.
#' @param exportfile If output path is included, will save data to that file.
#'
#' @examples
metadata = function(type = 'id',
                     identifiers,
                     exportfile = NULL){

  parameters = list( ids = paste(identifiers, collapse =","))
  names(parameters) <- type


  key = Sys.getenv("COINMARKETCAP_API_KEY")

  endpoint = 'v2/cryptocurrency/info'

  apicall = httr::GET(url = domain,
                      path = endpoint,
                      add_headers( c('X-CMC_PRO_API_KEY' = key  )  ),
                      query = parameters )

  json = apicall %>% httr::content("text") %>% jsonlite::fromJSON()

  data = json %>% purrr::pluck("data")

  .varnames = names( data[[1]]  )

  data = data %>% tibble::as_tibble() %>% data.table::as.data.table()

  data = data %>% t() %>% data.table::as.data.table()

  names(data) = .varnames


  if ( !is.null(exportfile) ){
    try(data.table::fwrite( data, file = exportfile ) )

  }

  return(data)



}
