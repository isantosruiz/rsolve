# rsolve

A MATLAB function for automatically solving linear difference equations using the Z-transform method.

## Overview
This submission provides a custom MATLAB function called rsolve, designed to automatically solve linear difference equations with constant coefficients using the Z-transform method . It is particularly useful for modeling and analyzing discrete-time systems in fields such as digital signal processing, control systems, economics, and more.

The function takes as input a symbolic difference equation along with initial conditions and returns the closed-form analytical solution in the discrete domain. Internally, it applies the Z-transform to convert the recurrence into an algebraic equation, solves it symbolically, and then computes the inverse Z-transform to recover the solution. This workflow leverages MATLAB's built-in symbolic math capabilities (`ztrans`, `iztrans`, and the Symbolic Math Toolbox), offering both accuracy and flexibility.

```matlab
function sol = rsolve(eq, fun, ic)
% rsolve - Solve linear difference equations using the Z-transform method.
%
% Syntax:
%   sol = rsolve(eq, fun)                % without initial conditions
%   sol = rsolve(eq, fun, ic)            % with initial conditions
%
% Description:
%   Solves a linear constant-coefficient difference equation using the
%   Z-transform technique. The function supports optional initial conditions
%   and returns the closed-form symbolic solution in terms of the 
%   discrete-domain variable.
%
% Input Arguments:
%   eq  - Difference equation expressed as a symbolic equation or relation.
%         Example: y(n+2) - y(n+1) - y(n) == 0
%   fun - Symbolic function representing the unknown sequence.
%         Example: y(n)
%   ic  - (Optional) Initial conditions as a vector of symbolic equations.
%         Example: [y(0) == 1, y(1) == 1]
%
% Output Argument:
%   sol - Symbolic expression representing the solution to the difference
%         equation in terms of the discrete-domain variable n.
%
% Example 1: Sum of the first n positive integers
%   syms n s(n)
%   eq = s(n+1) == s(n) + n + 1;
%   ic = s(0) == 0;
%   sol = rsolve(eq, s(n), ic)
%
% Example 2: Fibonacci sequence
%   syms n f(n)
%   eq = f(n+2) == f(n+1) + f(n);
%   ic = [f(0) == 1, f(1) == 1];
%   sol = rsolve(eq, f(n), ic)
%
% AUTHOR: Ildeberto de los Santos Ruiz
% REQUIRES: Symbolic Math Toolbox

