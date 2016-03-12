#================================================================#

# Geodetic coordinates Transformation
# HK80G (HK 1980 Grid) <-> WGS84

#================================================================#
source("hkgeodetic/as.dms.R", local = TRUE)
source("hkgeodetic/trigonometric.R", local = TRUE)
source("hkgeodetic/meridian_distance.R", local = TRUE)


convert_hk80g_wgs84 <- function(E, N, E0 = 836694.05, N0 = 819069.80, m0 = 1, upsilon = 6381480.500, rho = 6359840.760, psi = 1.003402560) {

  lambda0 <- as.numeric(as.dms("114 10 42.80", "%d %m %s")) / 180 * pi
  phi0 <- as.numeric(as.dms("22 18 43.68", "%d %m %s")) / 180 * pi
  M0 <- meridian_distance(phi = phi0) # M0 <- 2468395.723
  phi_p <- optimize(function(phi) {(meridian_distance(phi) - (N - N0 + M0) / m0)^2}, interval = c(-pi, pi), tol = 1E-15)$minimum

  lambda <- lambda0 + sec(phi_p) * (E - E0) / (m0 * upsilon) - sec(phi_p) * (E - E0)^3 / (6 * m0^3 * upsilon^3) * (psi + 2 * tan(phi_p)^2)
  phi <- phi_p - tan(phi_p) / (m0 * rho) * (E - E0)^2 / (2 * m0 * upsilon)
  c(lng = lambda, lat = phi) / pi *180
}



#================================================================#

# HK1980 Grid to HK1980 Geographic Co-ordinate

#================================================================#

# as.dms(convert_hk80g_wgs84(E = 836055, N = 832699))
# as.dms(eqt4(E = 836055, N = 832699) / pi * 180)
# as.dms(eqt5(E = 836055, N = 832699) / pi * 180)
# 836055m E, 832699m N == 114°10'20.45"E, 22°26'06.76"N # http://www.geodetic.gov.hk/smo/gsi/data/pdf/explanatorynotes.pdf

# as.dms(eqt4(E = 836694.05, N = 819069.80) / pi * 180)
# as.dms(eqt5(E = 836694.05, N = 819069.80) / pi * 180)
# 836694.05m E, 819069.80mN == 114°10'42.80"E, 22°18'43.68"N # http://www.geodetic.gov.hk/smo/gsi/data/parameter/7P_ITRF96_HK80_V1.pdf

# as.dms(eqt4(E = 832591.320, N = 820351.389) / pi * 180)
# as.dms(eqt5(E = 832591.320, N = 820351.389) / pi * 180)
# 832591.320m E, 820351.389m N == 114.08 19 44596, 22.19 25 32636 # http://www.geodetic.gov.hk/smo/tform/tform.aspx



#================================================================#

# Reference

#================================================================#

# http://ailin.phychembio.com/miscellany/1387/
# http://cs2cs.mygeodata.eu/ ****Very good****
# http://blog.tiger-workshop.com/hk1980-grid-to-wgs84/
# http://www.geodetic.gov.hk/smo/tform/tform.aspx
# http://www.hydro.gov.hk/eng/datumnew.php
# https://www.geodetic.gov.hk/smo/gsi/data/pdf/explanatorynotes_c.pdf
# http://www.geodetic.gov.hk/smo/gsi/data/parameter/SchematicDiagram.pdf
# https://en.wikipedia.org/wiki/World_Geodetic_System

