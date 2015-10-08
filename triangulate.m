
function X = triangulate(xL,xR,camL,camR)

%
%  function X = triangulate(xL,xR,camL,camR)
%
%  INPUT:
%   
%   xL,xR : points in left and right images  (2xN arrays)
%   camL,camR : left and right camera parameters
%
%
%  OUTPUT:
%
%    X : 3D coordinate of points in world coordinates (3xN array)
%
%

if (size(xL,2) ~= size(xR,2))
  error('must have same number of points in left and right images');
end

npts = size(xL,2);

% first convert from pixel coordinates back into 
% meters with unit focal length
qL(1,:) = (xL(1,:) - camL.c(1)) / camL.f(1);
qL(2,:) = (xL(2,:) - camL.c(2)) / camL.f(1);
qL(3,:) = 1;

qR(1,:) = (xR(1,:) - camR.c(1)) / camR.f(1);
qR(2,:) = (xR(2,:) - camR.c(2)) / camR.f(1);
qR(3,:) = 1;

%
% make the left camera the origin of the coordinate system
% and compute what the R and t for the right camera would be.
%
R = inv(camL.R)*camR.R;              
t = inv(camL.R)*(camR.t - camL.t);  

% now solve the equation:
% 
%   Z_l * qL = Z_r * R*qR + t
%
% for the Zs
%
XL = zeros(3,npts);
XR = zeros(3,npts);
for i = 1:npts
  A = [qL(:,i) -R*qR(:,i)];
  Z = A\t; 
  XL(:,i) = Z(1)*qL(:,i);
  XR(:,i) = Z(2)*qR(:,i);
end

%finally, map both back to world coordinates
Xa = camL.R*XL + repmat(camL.t,1,npts);
Xb = camR.R*XR + repmat(camR.t,1,npts);

%return the midpoint of the left and right camera estimates as our best guess
X = 0.5*(Xa+Xb);


