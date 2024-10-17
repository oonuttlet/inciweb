requireNamespace("jsonlite")
requireNamespace("dplyr")
requireNamespace("stringr")
requireNamespace("sf")

iw_get_incidents <- function(geometry = TRUE){
  url = url("https://inciweb.wildfire.gov/api/map_data")
  res <- jsonlite::fromJSON(url)
  res_df <- res |>
    dplyr::mutate(lat_dd = dms_to_dd(lat_deg, lat_min, lat_sec),
                  long_dd = -dms_to_dd(long_deg, long_min, long_sec),
                  across(c(starts_with("field_incident"), "created"),
                    ~ clean_html_col(.x)),
                  created = as.Date(created),
                  event_url = paste0("https://inciweb.wildfire.gov/incident-information", urlPath),
                  percent_contained = as.numeric(field_percent_of_perimeter),
                  size = as.numeric(size),
                  last_updated = plaintext_to_date(changed)
           ) |>
    dplyr::select(!c(dplyr::ends_with(c("deg", "min", "sec")),
                     "urlPath",
                     "field_percent_of_perimeter",
                     "field_active")) |>
    dplyr::relocate(id, .before = everything())

  if(!geometry){
    return(res_df)
  }
  res_sf <- res_df |>
    sf::st_as_sf(coords = c("long_dd", "lat_dd"),
                 crs = 4269)
}
