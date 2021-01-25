
[![doi](https://img.shields.io/badge/doi-10.1016%2Fj.compositesb.2019.107171-brightgreen.svg)](https://doi.org/10.1016/j.compositesb.2019.107171)

## Description

This project aims to provide functions created to calculate some mechanical properties of unidirectional composites. These functions were created using artificial neural networks (__ANN__) based on data collected from the literature. For more details see the following articles:

https://doi.org/10.1016/j.compositesb.2019.107171 (_G<sub>12</sub>_ and _X<sub>t</sub>_)

https://doi.org/10.1016/j.compositesb.2011.04.042 (_E<sub>2</sub>_)

The highlighted properties are: longitudinal shear modulus (_G<sub>12</sub>_), ultimate longitudinal tensile strength (_X<sub>t</sub>_), transverse elastic modulus (_E<sub>2</sub>_) and the ultimate transverse tensile strength (_Y<sub>t</sub>_) (very soon).

## How to use
The functions have the same principle of use, first it is necessary to provide the input data which vary according to each property. As an example, we can consider the function that calculates the value of _G<sub>12</sub>_, in it we need three input values, they are: volumetric fraction of fiber (_V<sub>f</sub>_), shear modulus of fiber (_G<sub>f</sub>_) and shear modulus of matrix (_G<sub>m</sub>_). 

Considering a laminate with 0.6 of volumetric fraction of fiber, made of glass fiber (_G<sub>f</sub>_  = 35 GPa) and with an epoxy resin (_G<sub>m</sub>_ = 2 GPa). In MATLAB display for instance, one can type: 

```
[G12, ~] = G12_M_ANN(0.6, 35, 2)
```
So one gets:
```
G12 = 7.2867
```
This is the _G<sub>12</sub>_ value of the unidirectional composite, in Gigapascal (GPa).

Update: the current release is version 1.0, a new release with new functions is coming soon.

