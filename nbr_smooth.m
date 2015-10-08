function [Y] = nbr_smooth(tri,X,nrounds)

% function [Y] = nbr_smooth(tri,X,nrounds)
%
% smooth the 3D locations of points in a given mesh by moving
% each point to the mean location of its neighbors
%
% X : 3D point locations
% tri : triangulation of the points X to make a surface
% nrounds : number of iterations of averaging with neighbors
%
% Y: smoothed point locations
%

npts = size(X,2);
ntri = size(tri,1);
nbrct = zeros(npts,1);
nbr = zeros(npts,100);
%
% get the list of neighbors for each point in the mesh
%
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

%
% now go thru nrounds of smoothing where the point
% in round 2 is placed at the average of its neighbor
% locations in round 1.
%
Y = X;
Ynew = X;
for j = 1:nrounds
  fprintf('   nbr_smooth: Round %d of %d\n',j,nrounds);
  for i = 1:npts
%     fprintf('\rsmoothing points %d/%d',i,npts);
    nlist = nbr(i,1:nbrct(i));
    nlist = setdiff(unique(nlist(:)),i);
    if (length(nlist)>0)
      Ynew(:,i) = mean(Y(:,nlist),2);
    end
  end
  Y = Ynew;
%   fprintf('\n');
end

