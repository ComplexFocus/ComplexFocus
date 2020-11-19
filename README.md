ComplexFocus: Non-paraxial vector beams in Mathematica
======================================================

© Rodrigo Gutiérrez-Cuevas and Emilio Pisanty, 2020

ComplexFocus is a Mathematica package that implements the Complex Focus fields, a family of vector beam solutions in nonparaxial optics, as described in the papers

 - Scalar and electromagnetic nonparaxial bases composed as superpositions of simple vortex fields with complex foci. R. Gutiérrez-Cuevas and M.A. Alonso. [*Optics Express* **25**, 14856 (2017)](https://doi.org/10.1364/OE.25.014856).
 - Optical polarization skyrmionic fields in free space. R. Gutiérrez-Cuevas and E. Pisanty. In preparation (2020).


In short, Complex Focus fields are built by:

 - using the scalar multipolar solutions of the Helmholtz equation, Λ<sub>*ℓ,m*</sub>(***r***) = *j*<sub>*ℓ*</sub>(kr) *Y*<sub>*ℓ,m*</sub>(*θ,ϕ*);
 - using suitable vector differential operators to produce transversal vector solutions of the Helmholtz equation; and then
 - introducing an imaginary offset (***r***→***r***-*iq***e**<sub>*z*</sub>) to the Cartesian coordinate along the optical axis.

The resulting solutions approach a focused Gaussian beam (for Λ<sub>0,0</sub>) and the Laguerre-Gauss solutions without radial nodes (for Λ<sub>*ℓ,ℓ*</sub>) in the limit of *q*→∞. For finite *q*, this parameter takes the role of the Rayleigh range.
 

### Licensing

This code is dual-licensed under the GPL and CC-BY-SA licenses; you are free to use, modify, and redistribute it, but you must abide by the terms in either of those licenses.

In addition to that legal obligation, if you use this code in calculations for an academic publication, you have an academic obligation to cite it correctly. For that purpose, please cite either of the papers listed above, or use a direct citation to the code such as

 - R. Gutiérrez-Cuevas and E. Pisanty. LISSAFIRE: Lissajous-figure Reconstruction for nonlinear polarization tomography of bichromatic fields. https://github.com/episanty/LISSAFIRE, [doi:10.5281/zenodo.nnnnnnn](https://doi.org/10.5281/zenodo.nnnnnnn) (2020).

If you wish to use a DOI for a specific version, please use one of the numbered-version releases (indexed in the [Zenodo](https://doi.org/10.5281/zenodo.nnnnnnn) listing page).
