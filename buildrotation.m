
function R = buildrotation(thx,thy,thz)

% function R = buildrotation(thx,thy,thz)
%
% build up rotation matrix from rotation around
% the three axes
%
% thx,thy,thz : rotations around the three axes
%  specified in radians
%
% R : the resulting rotation matrix
%
Rx = [ 1 0 0 ; ...
       0 cos(thx) -sin(thx) ; ...
       0 sin(thx) cos(thx) ];
Ry = [  cos(thy)   0  -sin(thy) ; ...
              0    1         0 ; ...
       sin(thy)   0  cos(thy) ];
Rz = [  cos(thz) -sin(thz) 0 ; ...
       sin(thz) cos(thz) 0 ; ...
               0        0 1 ];

% concatenate the three rotations.
R = Rx*Rz*Ry;
