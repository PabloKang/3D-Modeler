function view_mesh(setIndex)

% Load current settings and mesh data
load('settings.mat');
load([settings.resDir sprintf('meshdata_%02d.mat',setIndex)]);

% visualize results of smooth with
% mesh edges visible
h = trisurf(tri,Y(1,:),Y(2,:),Y(3,:));
set(h,'edgecolor','flat')
axis image; axis vis3d;
camorbit(120,0); camlight left;
camorbit(120,0); camlight left;
lighting flat;
set(gca,'projection','perspective')
set(gcf,'renderer','opengl')
set(h,'facevertexcdata',xColor'/255);
material dull