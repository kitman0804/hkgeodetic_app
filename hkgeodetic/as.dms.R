as.dms <- function(x, ...) UseMethod("as.dms", x)

as.dms.numeric <- function(x, format = "%d\u00b0%m'%s\"") {
  out <- x
  class(out) <- append("dms", class(out))
  if (!grepl("%d|%m|%s", format)) stop("At least one of {'%d', '%m', '%s'} is missing in 'format'.")
  attr(out, "format") <- format
  return(out)
}

as.dms.character <- function(x, fromformat, toformat = "%d\u00b0%m'%s\"") {
  if (missing(fromformat)) stop("\n Please provide the fromformat of the inputted value.")
  if (!grepl("%d|%m|%s", fromformat)) stop("At least one of {'%d', '%m', '%s'} is missing in 'fromformat'.")
  if (!grepl("%d|%m|%s", toformat)) stop("At least one of {'%d', '%m', '%s'} is missing in 'fromformat'.")
  # Preparation
  fromformat <- gsub("%d|%m", "([0-9]*)", fromformat)
  fromformat <- gsub("%s", "([0-9]*\\.?[0-9]*)", fromformat)
  fromformat <- paste0("^", fromformat, "$")
  deg <- gsub(fromformat, "\\1", x)
  min <- gsub(fromformat, "\\2", x)
  sec <- gsub(fromformat, "\\3", x)
  out <- as.numeric(deg) + as.numeric(min) / 60 + as.numeric(sec) / 3600
  class(out) <- append("dms", class(out))
  attr(out, "format") <- toformat
  return(out)
}


# print
print.dms <- function(x) {
  deg <- trunc(x)
  min <- trunc(60 * (x - deg))
  sec <- 3600 * (x - deg - min / 60)
  digits <- options()$digits
  sec <- sign(sec) * trunc(abs(sec) * 10^digits + 0.5) / (10^digits)
  out <- rep(attr(x, "format"), length(x))
  for (i in 1:length(x)) {
    out[i] <- gsub("%d", deg[i], out[i])
    out[i] <- gsub("%m", min[i], out[i])
    out[i] <- gsub("%s", sec[i], out[i])
  }
  out <- noquote(out)
  print(out)
}