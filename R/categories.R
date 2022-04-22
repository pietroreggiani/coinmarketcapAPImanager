
#' Get Coinmarketcap Categories
#'
#' Uses the *categories* API that returns the coin categories available in Coinmarketcap.
#' For more details see the [documentation](https://coinmarketcap.com/api/documentation/v1/#operation/getV1CryptocurrencyCategories).
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
#' @param ids vector of ids
#' @param id_type one of 'id', 'slug' or 'symbol' depending on which coin idendifier you want to filter your coins by.
#' @param exportfile file path of where to save the data.
#'
#' @examples
categories = function(ids , id_type = 'id',
                     exportfile = NULL){

  ids = paste(ids, collapse = ",")

  parameters = list( ids  )
  names(parameters)[1] <- id_type

  key = Sys.getenv("COINMARKETCAP_API_KEY")

  endpoint = 'v1/cryptocurrency/categories'

  apicall = httr::GET(url = domain,
                      path = endpoint,
                      add_headers( c('X-CMC_PRO_API_KEY' = key  )  ),
                      query = parameters )

  json = apicall %>% httr::content("text") %>% jsonlite::fromJSON()

  data = json %>% purrr::pluck("data") %>% tibble::as_tibble() %>% data.table::as.data.table()

  if ( !is.null(exportfile) ){
    try(data.table::fwrite( data, file = exportfile ) )

  }

  return(data)



}
