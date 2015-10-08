function [x] = project(X,cam);

% function [x] = project(X,cam)
%
% Carry out projection of 3D points into 2D given the camera parameters
% We assume that the camera with the given intrinsic parameters produces
% images by projecting onto a focal plane at distance cam.f along the 
% z-axis of the camera coordinate system.
%
% Our convention is that the camera starts out the origin (in world
% coordinates), pointing along the z-axis.  It is first rotated by 
% some matrix cam.R and then translated by the vector cam.t.
%
%
% Input:
%
%  X : a 3xN matrix containing the point coordinates in 3D world coordinates (meters)
%
%  intrinsic parameters:
%
%  cam.f : focal length (scalar)
%  cam.c : camera principal point [in pixels]  (2x1 vector)
%
%  extrinsic parameters:
%
%  cam.R : camera rotation matrix (3x3 matrix)
%  cam.t : camera translation matrix (3x1 vector)
%
%
% Output:
%
%  x : a 2xN matrix containing the point coordinates in the 2D image (pixels)
%

npts = size(X,2);

% First transform the points in the world to the
% camera coordinate frame
Rinv = inv(cam.R); %inverse rotation
Xcam = Rinv*(X - repmat(cam.t,1,npts));

% now project the points down
x(1,:) = Xcam(1,:) ./ Xcam(3,:);
x(2,:) = Xcam(2,:) ./ Xcam(3,:);

% scale by focal length, pixel magnification and
% add in camera principal point offset.
x(1,:) = x(1,:)*cam.f + cam.c(1);
x(2,:) = x(2,:)*cam.f + cam.c(2);

