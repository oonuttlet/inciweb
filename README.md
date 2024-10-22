
<!-- README.md is generated from README.Rmd. Please edit that file -->

# inciweb

<!-- badges: start -->
<!-- badges: end -->

The goal of `inciweb` is to allow users to programatically access data
from the National Wildfire Coordinating Group’s [Inciweb Incident
Information System](https://inciweb.wildfire.gov/). It does so through
one core function, `iw_get_incidents()`.

## Installation

You can install the development version of inciweb from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("oonuttlet/inciweb")
```

## Usage

This is a basic example which shows you how to get all incidents
available on the Inciweb map:

``` r
library(inciweb)
library(dplyr)

iw_get_incidents() |>
  glimpse()
#> Rows: 192
#> Columns: 14
#> $ id                         <chr> "291580", "310603", "311786", "312546", "31…
#> $ title                      <chr> "Southwest District BLM Prescribed Fire ", …
#> $ type                       <chr> "Prescribed Fire", "Wildfire", "Prescribed …
#> $ field_incident_description <chr> "", "", "", "", "The entire project area is…
#> $ created                    <date> 2021-09-23, 2022-08-30, 2022-10-06, 2022-1…
#> $ field_incident_overview    <chr> "The Bureau of Land Management Southwest Di…
#> $ size                       <dbl> NA, 18138, NA, NA, 6329, NA, 34242, 26048, …
#> $ measurement_type           <chr> "Acres", "Acres", "Acres", "Acres", "Acres"…
#> $ field_title_and_unit       <chr> "COSJD Southwest District BLM Prescribed Fi…
#> $ field_unit_code            <chr> "COSJD", "MTBDF", "COARF", "COSJF", "COARF"…
#> $ event_url                  <chr> "https://inciweb.wildfire.gov/incident-info…
#> $ percent_contained          <dbl> 0, 80, NA, NA, NA, NA, 93, NA, NA, NA, NA, …
#> $ last_updated               <chr> "09-28-2024 00:00:00", "09-28-2024 00:00:00…
#> $ geometry                   <POINT [°]> POINT (-108.8256 37.9025), POINT (-11…
```

The returned object includes all information available in the most
recent update of the Inciweb database.

By default, `iw_get_incidents()` returns an `sf` object. This behavior
can be changed using the argument `geometry = FALSE`. In this case,
latitude and longitude columns are still returned; conversion to `sf`
object is omitted.

``` r
foo <- iw_get_incidents()
class(foo)
#> [1] "sf"         "data.frame"

bar <- iw_get_incidents(geometry = FALSE)
class(bar)
#> [1] "data.frame"
```

## Getting Help

If you encounter an issue with accessing Inciweb data, please check to
ensure the service is online. If the issue persists, please raise a new
issue on [Github](https://github.com/oonuttlet/inciweb/issues).
