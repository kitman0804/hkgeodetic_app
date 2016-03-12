sec <- function(r, unit = c("r", "d")) {
  if (!unit[[1]] %in% c("r", "d")) stop("\n The unit is not valid.\n 'r' for radian, 'd' for degree")
  1 / cos(r * (pi / 180)^(unit[[1]] == "d"))
}

csc <- function(r, unit = c("r", "d")) {
  if (!unit[[1]] %in% c("r", "d")) stop("\n The unit is not valid.\n 'r' for radian, 'd' for degree")
  1 / sin(r * (pi / 180)^(unit[[1]] == "d"))
}

cot <- function(r, unit = c("r", "d")) {
  if (!unit[[1]] %in% c("r", "d")) stop("\n The unit is not valid.\n 'r' for radian, 'd' for degree")
  1 / tan(r * (pi / 180)^(unit[[1]] == "d"))
}