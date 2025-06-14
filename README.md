# rsolve - Difference Equation Solver

A MATLAB function for automatically solving linear difference equations using the Z-transform method.

## Overview
This submission provides a custom MATLAB function called `rsolve`, designed to automatically solve linear difference equations with constant coefficients using the Z-transform method. It is particularly useful for modeling and analyzing discrete-time systems in fields such as digital signal processing, control systems, economics, and other related areas.

The function takes as input a symbolic difference equation along with initial conditions and returns the closed-form analytical solution in the discrete domain. Internally, it applies the Z-transform to convert the recurrence into an algebraic equation, solves it symbolically, and then computes the inverse Z-transform to recover the solution. This workflow leverages MATLAB's built-in symbolic math capabilities (`ztrans`, `iztrans`, and the *Symbolic Math Toolbox*), offering both accuracy and flexibility.

#### Abrir en MATLAB Online
https://matlab.mathworks.com/open/fileexchange/v1?id=181285

[![View rsolve - Difference Equation Solver on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://la.mathworks.com/matlabcentral/fileexchange/181285-rsolve-difference-equation-solver)
