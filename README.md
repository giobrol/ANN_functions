
[![doi](https://img.shields.io/badge/doi-10.1016%2Fj.compositesb.2019.107171-brightgreen.svg)](https://doi.org/10.1016/j.compositesb.2019.107171)

[![doi](https://img.shields.io/badge/doi-10.1016%2Fj.jmrt.2023.01.195-orange.svg)](https://doi.org/10.1016/j.jmrt.2023.01.195)

## Description

This project aims to provide functions created to calculate some mechanical properties of unidirectional composites. These functions were created using artificial neural networks (__ANN__) based on data collected from the literature. For more details see the following articles:

https://doi.org/10.1016/j.jmrt.2023.01.195 (_Y<sub>t</sub>_)

https://doi.org/10.1016/j.compositesb.2019.107171 (_G<sub>12</sub>_ and _X<sub>t</sub>_)

https://doi.org/10.1016/j.compositesb.2011.04.042 (_E<sub>2</sub>_)

The highlighted properties are: longitudinal shear modulus (_G<sub>12</sub>_), ultimate longitudinal tensile strength (_X<sub>t</sub>_), transverse elastic modulus (_E<sub>2</sub>_) and the ultimate transverse tensile strength (_Y<sub>t</sub>_).

## How to use
The functions follow a common principle of usage, where the input data needs to be provided, varying according to each property. As an example, let's consider the function that calculates the value of  _G<sub>12</sub>_. This function requires three input values: volumetric fraction of fiber (_V<sub>f</sub>_), shear modulus of fiber (_G<sub>f</sub>_) and shear modulus of matrix (_G<sub>m</sub>_).

Let's consider a laminate with a volumetric fraction of fibers of 0.6, made of glass fibers (_G<sub>f</sub>_  = 35 GPa), and with an epoxy resin (_G<sub>m</sub>_ = 2 GPa). To display the results, you can use either Python or MATLAB:

In Python, you can use the following code:

```
from your_module import G12_M_ANN

Vf = 0.6
Gf = 35
Gm = 2

G12 = G12_M_ANN(0.6, 35, 2)
print(f"G12 = {G12:.2f}")
```
In MATLAB, you can use the following code:
```
Vf = 0.6
Gf = 35
Gm = 2

[G12, ~] = G12_M_ANN(0.6, 35, 2)
fprintf("G12 = %.2f\n", G12);
```
Both codes will yield the same result:
```
G12 = 7.29
```
The value obtained, 7.29 GPa, represents the G<sub>12</sub> value of the unidirectional composite, measured in gigapascals (GPa).

