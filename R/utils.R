dms_to_dd <- function(deg, min, sec) {
  deg_dd <- abs(as.numeric(deg))
  min_dd <- as.numeric(min) / 60
  sec_dd <- as.numeric(sec) / 3600
  dd <- deg_dd + min_dd + sec_dd
}

clean_html_col <- function(x) {
  stringr::str_squish(gsub("<[^>]+>|\\n|&nbsp;", "", x))
}

plaintext_to_date <- function(x) {
  y <- gsub(" ago", "", x)
  p <- lubridate::period(y)
  ifelse(as.numeric(p) > 86400,
         format(as.POSIXct(Sys.Date() - p), "%m-%d-%Y %H:%M:%S"),
         format(as.POSIXct(Sys.time() - p), "%m-%d-%Y %H:%M:%S"))
}
