% Description: Class for unit tests
%   Essentially a wrapper around the standalone class
%   Adds some default configurations

\ProvidesClass{unittest}[2024-12-13 Unit test class]
\tracinglostchars=3% error if a glyph is missing
\errorcontextlines=5% <-- useful for debugging

\LoadClass{standalone}
\RequirePackage{booktabs,multicol,arydshln}

% TODO: Add reproducible build settings
% SEE: https://tex.stackexchange.com/questions/229605
