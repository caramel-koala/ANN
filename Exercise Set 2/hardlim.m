## Copyright (C) 2015 CarnĂŤ Draug
##
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License as
## published by the Free Software Foundation; either version 3 of the
## License, or (at your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, see
## <http:##www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {} hardlims (@var{n})
## Hard-limit transfer function.
##
## Return an array of size equal to @var{n}, with values of 1
## when @var{n} is larger than or equal to 0.
##
## @example
##    / 0, @var{n} < 0
##    |
##    \ 1, @var{n} >= 0
## @end example
##
## It is equivalent to:
##
## @example
## double (@var{n} >= 0)
## @end example
##
## @seealso{hardlims, purelin, satlin, satlins, tansig}
## @end deftypefn

## Author: CarnĂŤ Draug <carandraug@octave.org>

function a = hardlim (n)

  if (nargin != 1)
    print_usage ();
  endif

  if (isnumeric (n))
    a = double (n >= 0);
  elseif (isbool (n))
    a = ones (size (n));
  elseif (ischar (n))
    switch (tolower (n))
      case "name",      a = "Hard Limit Positive";
      case "output",    a = [0 1];
      case "fullderiv", a = 0;
      otherwise
        error ("hardlim: unknown command '%s'", n);
    endswitch
  else
    print_usage ();
  endif
endfunction

%!assert (hardlim (-2), 0)
%!assert (hardlim (2), 1)
%!assert (hardlim (0), 1)
%!assert (hardlim (true), 1)
%!assert (hardlim (false), 1)

%!assert (hardlim ([false true]), [1 1])
%!assert (hardlim ([-3 -2.5 0; 0 .5 -3]), [0 0 1; 1 1 0])

%!assert (hardlim (single (4)), 1)

%!assert (hardlim ("name"), "Hard Limit Positive")
%!assert (hardlim ("output"), [0 1])
%!assert (hardlim ("fullderiv"), 0)