function [tri,err] = trierr(x,X)

% function [tri,err] = trierr(x,X)
%
% triangulate the 2D pointset x and compute an "error" 
% for each triangle which is the maximum of the 3 edge
% lengths for that triangle based on the 3D point locations
% X.
%
% x : 2d point locations (e.g. coordinates in one image)
% X : 3D point locations
%
% tri : list of triangles
% err : list of triangle edge lengths
%

% fprintf('   Triangulating\n');
tri = delaunay(x(1,:),x(2,:));
ntri = size(tri,1);
npts = size(x,2);
err = zeros(ntri,1);
for i = 1:ntri
%   fprintf('\rtraversing triangles %d/%d',i,ntri);
  d1 = sum((X(:,tri(i,1)) - X(:,tri(i,2))).^2);
  d2 = sum((X(:,tri(i,1)) - X(:,tri(i,3))).^2);
  d3 = sum((X(:,tri(i,2)) - X(:,tri(i,3))).^2);
  err(i) = max([d1 d2 d3]).^0.5;
end
% fprintf('\n');

