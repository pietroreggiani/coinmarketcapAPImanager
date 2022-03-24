
library(data.table)
library(tidyverse)
library(purrr)

library(here)

devtools::install_github( "pietroreggiani/coinmarketcapr" )
library(coinmarketcapr)

library(httr)
library(jsonlite)



domain = 'https://pro-api.coinmarketcap.com'

endpoint = 'v1/key/info'

apicall = httr::GET(url = domain, 
                 path = endpoint, 
                 add_headers( c('X-CMC_PRO_API_KEY' = Sys.getenv("COINMARKETCAP_API_KEY") )  )   ) 

json = apicall %>% content("text") %>% jsonlite::fromJSON() 

data = json %>% purrr::pluck("data", "usage") %>% as_tibble(rownames = NA)

headers(test)
test

dati = test %>% 
  httr::content(as = "parsed") 

