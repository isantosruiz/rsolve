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
%

    % Extract the discrete-domain variable 'n'
    n = symvar(fun, 1);
    z = sym('z');

    % Assume 'n' is a non-negative integer
    assume(n >= 0 & in(n, 'integer'));

    % Apply Z-transform to the difference equation
    eqnZT = ztrans(eq, n, z);

    % Substitute Z-transform of y(n) with Y(z)
    Y = sym('Y');
    eqnZT = subs(eqnZT, ztrans(fun, n, z), Y);

    % Solve the algebraic equation for Y(z)
    Ysol = solve(eqnZT, Y, 'ReturnConditions', true);
    Ysol = Ysol.Y;

    % Compute inverse Z-transform to obtain discrete-domain solution
    sol = iztrans(Ysol, z, n);

    % Apply initial conditions if provided
    if nargin >= 3 && ~isempty(ic)
        % Validate initial conditions format
        if isvector(ic) && isa(ic, 'sym') && ...
           all(arrayfun(@(x) isa(x, 'sym') && hasSymType(x, 'equation'), ic))
            % Expected format: [y(0) == 1, y(1) == 0]
            for i = 1:length(ic)
                side = children(ic(i));  % Extract both sides of the equation
                sol = subs(sol, side(1), side(2));
            end
        else
            error('rsolve:InvalidInitialCondition', ...
                'Initial conditions must be a vector of symbolic equations, e.g., [y(0)==1, y(1)==2].');
        end
    end

    % Rewrite solution in exponential form and simplify
    sol = rewrite(sol, "exp");
    sol = simplify(sol, "Steps", 80);
end
