
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coinmarketcapAPImanager

<!-- badges: start -->
<!-- badges: end -->

The goal of coinmarketcapAPImanager is to provide a client for the
Coinmarketcap API. The full documentation for the API can be found on
[their website](https://coinmarketcap.com/api/documentation/v1/).

## Installation

You can install the development version of coinmarketcapAPImanager from
Pietro’s Github page with:

``` r
devtools::install_github("pietroreggiani/coinmarketcapAPImanager")
```

### API key

In order to communicate with the API, the user should create an
environment variable containing the API key, exactly with the name
below.

``` r
Sys.setenv(COINMARKETCAP_API_KEY = "myApiKey")
```
