function [H] = homography(x,y,xd,yd)

% function [H] = homography(x,y,xd,yd)
%
% estimate a homography which maps points (x,y) to (xd,yd)
% using linear least squares.  this is a homogenous system 
% so we use svd rather than pseudoinverse.
%

npoints = size(x,2);

A = zeros(2*npoints,9); 
for i=1:npoints,
  A(2*i-1,:)= [x(i),y(i),1,0,0,0, -x(i)*xd(i),-xd(i)*y(i),-xd(i)];
  A(2*i, :)= [0,0,0,x(i),y(i),1, -x(i)*yd(i),-yd(i)*y(i),-yd(i)];
end; 

if npoints==4 
  h = null(A); 
else 
  [U,S,V] = svd(A);
  h=V(:,9); 
end;

H=[h(1),h(2),h(3);h(4),h(5),h(6);h(7),h(8),h(9);];


