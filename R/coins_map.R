
#' Get Coinmarketcap Coin Map
#'
#' Uses the *map* API that returns header information from Coinmarketcap.
#' For more details see the [documentation](https://coinmarketcap.com/api/documentation/v1/#operation/getV1CryptocurrencyMap).
#'
#' You should use this function once at the beginning, save the file somewhere and then never
#' re-run this function again, to save on API calls.
#'
#'
#'
#' @return A data frame containing the ID information for all cryptocurrencies available.
#' @export
#' @import httr jsonlite data.table
#' @importFrom magrittr "%>%"
#'
#' @param listing_status Character vector containing the type of currencies you want to include. Can be "active", "inactive" or
#' "untracked". Defaults to all the three.
#' @param aux Character vector with auxiliary information. Defaults to all possible info.
#' @param exportfile If output path is included, will save data to that file.
#'
#' @examples
coins_map = function(listing_status = c("active", "inactive", "untracked"),
                   aux = c( 'platform','first_historical_data','last_historical_data','is_active,status'),
                   exportfile = NULL){

  parameters = list( listing_status = paste(listing_status, collapse =","),
                     aux = paste(aux, collapse = ",") )

  key = Sys.getenv("COINMARKETCAP_API_KEY")

  endpoint = 'v1/cryptocurrency/map'

  apicall = httr::GET(url = domain,
                      path = endpoint,
                      add_headers( c('X-CMC_PRO_API_KEY' = key  )  ),
                      query = parameters )

  json = apicall %>% content("text") %>% jsonlite::fromJSON()

  data = json %>% purrr::pluck("data") %>% tibble::as_tibble() %>% data.table::as.data.table()

  if ( !is.null(exportfile) ){
    try(data.table::fwrite( data, file = exportfile ) )

  }

  return(data)



}
