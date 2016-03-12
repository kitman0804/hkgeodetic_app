# Appendix

## Conversion of coordinates

### Latitude, longitude on HK80 Datum and WGS84 Datum

$\text{Longitude}_{\text{HK80}} = \text{Longitude}_{\text{WGS84}} - 8.8"$ (corrected to nearest $0.1"$)

$\text{Latitude}_{\text{HK80}} = \text{Latitude}_{\text{WGS84}} + 5.5"$ (corrected to nearest $0.1"$)



## Projection Formulae

### $\phi$, $\lambda$ to Grid coordinates

Equation 1: $N = N_0 + m_0((M - M_0) + \upsilon_s (\sin \phi)(\frac{\Delta \lambda^2}{2})(\cos \phi))$

Equation 2: $E = E_0 + m_0(\upsilon_s \Delta \lambda \cos \phi + \upsilon_s \frac{\Delta \lambda^3}{6} (\cos \phi)^3 (\psi_s - t^2))$




###Meridiance distance, $M$

Equation 3: $M = a(A_0 \phi - A_2 \sin(2\phi) + A_4 \sin(4\phi))$

where

$A_0 = 1 - \frac{e^2}{4} - \frac{3e^4}{64}$

$A_2 = \frac{3}{8} (e^2 + \frac{e^4}{4})$

$A_4 = \frac{15}{256} e^4$




### Grid coordinates to $\phi$, $\lambda$

Equation 4: $\lambda = \lambda_0 + \sec \phi_p (\frac{\Delta E}{m_0 v_p}) - \sec \phi_p (\frac{\Delta E^3}{6 m_0^3 v_p^3})(\psi_p + 2 t_p^2)$

Equation 5: $\phi = \phi_p - (\frac{t_p}{m_0 \rho_p})(\frac{\Delta E^2}{2 m_0 v_p})$

where 

$\Delta N = N - N_0$

$\Delta E = E - E_0$




Be noted that,

$M_0$ can be computed using Eqt. 3 by putting $\phi = \phi_0$ (Latitude of the projection origin.).

$\phi$ and $\lambda$ are in radian.

$\phi_p$ is the latitude for which $M = \frac{\Delta N + M_0}{m_0}$ which are computed by iteration using Eqt. 3.




---

## Reference

1. <https://www.geodetic.gov.hk/smo/gsi/data/pdf/explanatorynotes.pdf>

2. <https://www.geodetic.gov.hk/smo/gsi/data/pdf/explanatorynotes_c.pdf> (Chinese version)
