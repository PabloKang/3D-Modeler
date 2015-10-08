
function Xround = mapnearest(X,Xdest);
%
% Xround = mapnearest(X,Xdest)
%  
%  This function maps each of N points stored in X to the nearest point 
%  contained in the array Xdest.  The resulting list of points is returned 
%  in Xround
%
%  X :  NxD vector of points
%  Xdest : MxD vector of possible locations to round to
%
%  Xround : NxD vector of resulting rounded points.
%

[nx, dimx] = size(X);
[nxd, dimxd] = size(Xdest);
if dimx ~= dimxd
	error('Data dimensions dont match!');
end

% compute squared distance between all point pairs in X and Xdest
dist2 = (ones(nxd, 1) * sum((X.^2)', 1))' + ones(nx, 1) * sum((Xdest.^2)',1) - 2.*(X*(Xdest'));

% find the minimum distance for each point in X
[val,ind] = min(dist2,[],2);

% return the list of closest points.
Xround = Xdest(ind,:);

