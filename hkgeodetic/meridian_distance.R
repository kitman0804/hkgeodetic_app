#================================================================#

# meridian_distance

#================================================================#

meridian_distance <- function(phi, a = 6378388, e_sq = 2/297 - 1/297^2) {
  # Constant
  A0 <- 1 - e_sq / 4 - 3 * e_sq^2 / 64
  A2 <- 3 / 8 * (e_sq + e_sq^2 / 4)
  A4 <- 15 / 256 * e_sq^2
  dist <- a * (A0 * phi - A2 * sin(2 * phi) + A4 * sin(4 * phi))
  return(dist)
}
