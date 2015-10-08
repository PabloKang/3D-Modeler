
function xdetect = mapgrid(I)

% function xdetect = mapgrid(I)
% 
% this function takes an image containing a grid of corners
% and with some user help, locates all the corners in the 
% grid and returns the grid corner image coordinates in a 
% canonical order.
%
% WARNING: This code assumes the grid of points is 10x8 and
%  that the corner points are clicked starting with the long
%  edge followed by the short edge.  There is lots of room 
%  for making this more robust to deal with other calibration 
%  grids.
%

figure(1);  clf;
imagesc(I); axis image; colormap gray

fprintf('finding corners in image\n');
% use harris corner detector.  
% TODO: experiment with scale parameters to get more accurate
% corner detection.
[cim,y,x] = harris(I,2,0.02,5);
hold on;
plot(x,y,'ro','MarkerSize',10,'LineWidth',3);

% get 4 clicked points
fprintf('click on 4 corner points (in standard order)\n');
[xp,yp] = ginput(4);

% map them to the nearest 4 corners detected
Xp = mapnearest([xp yp],[x y]);

% now find a homography from the unit square
% to the 4 corners
xd = [0 0 1 1];
yd = [0 1 1 0];
H = homography(xd,yd,Xp(:,1),Xp(:,2));
% use this homography to map a grid onto the image
[yd,xd] = meshgrid(linspace(0,1,10),linspace(0,1,8));
X = H*[xd(:) yd(:) ones(size(xd(:)))]';
X(1,:) = X(1,:) ./ X(3,:);
X(2,:) = X(2,:) ./ X(3,:);

% now map the interpolated grid point locations to 
% the nearest actual detected corner
xdetect = mapnearest(X(1:2,:)',[x y]);
xdetect = xdetect';

% display the final result
figure(1); hold on;
plot(xdetect(1,:),xdetect(2,:),'c.','MarkerSize',18);
for i = 1:size(xdetect,2)
  h = text(xdetect(1,i)+5,xdetect(2,i)+5,num2str(i));
  set(h,'Color','r')
  set(h,'FontSize',15);
end
drawnow;

