function [tri,err] = nbr_error(x,X)

% function [tri,err] = nbr_error(x,X)
%
% triangulate the set of points based on their 2D locations x
% and then for each point, compute an error based on the 
% distance between the point in 3D and the median location 
% of its neighbors 
%
% x : 2D point locations (e.g. xL or xR)
% X : 3D point locations
%
% tri : triangulation of x
% err : error for each point X based on distance to neighbors
%

% fprintf('   Triangulating\n');
tri = delaunay(x(1,:),x(2,:));
ntri = size(tri,1);
npts = size(x,2);

nbrct = zeros(npts,1);
nbr = zeros(npts,100);
for i = 1:ntri
%   fprintf('\rtraversing triangles %d/%d',i,ntri);
  k = tri(i,1);
  nbr(k,nbrct(k)+1) = tri(i,2);
  nbr(k,nbrct(k)+2) = tri(i,3);
  nbrct(k) = nbrct(k) + 2;
  k = tri(i,2);
  nbr(k,nbrct(k)+1) = tri(i,1);
  nbr(k,nbrct(k)+2) = tri(i,3);
  nbrct(k) = nbrct(k) + 2;
  k = tri(i,3);
  nbr(k,nbrct(k)+1) = tri(i,1);
  nbr(k,nbrct(k)+2) = tri(i,2);
  nbrct(k) = nbrct(k) + 2;
end
% fprintf('\n');
nbr = nbr(:,1:max(nbrct));
err = zeros(npts,1);
for i = 1:npts
%   fprintf('\rcomputing errors %d/%d',i,npts);
  nlist = nbr(i,1:nbrct(i));
  nlist = setdiff(unique(nlist(:)),i);
  nX = median(X(:,nlist),2) - X(:,i);
  err(i) = sum(nX.^2);
end
% fprintf('\n');
