function make_mesh(setIndex)

% X, xL, xR

% Load current settings
load('settings.mat');

% load in results of reconstruct 
scandata = load([settings.resDir sprintf('scandata_%02d.mat',setIndex)]);

X = scandata.X;
xL = scandata.xL;
xR = scandata.xR;
xColor = scandata.xColor;
bbox = settings.bbox;

% threshold for pruning neighbors
nbrthresh = 0.25;
trithresh = 50;


%
% cleaning step 1: remove points outside known bounding box
%
goodpoints = find( (X(1,:)>bbox.xmin) & (X(1,:)<bbox.xmax) & (X(2,:)>bbox.ymin) & (X(2,:)<bbox.ymax) & (X(3,:)>bbox.zmin) & (X(3,:)<bbox.zmax) );
fprintf('   Dropping %2.2f %% of points from scan',100*(1 - (length(goodpoints)/size(X,2))));
X = X(:,goodpoints);
xR = xR(:,goodpoints);
xL = xL(:,goodpoints);
xColor = xColor(:,goodpoints);

%%
%% cleaning step 2: remove points whose neighbors are far away
%%
fprintf('   Filtering right image neighbors\n');
[tri,pterrR] = nbr_error(xR,X);

fprintf('   Filtering left image neighbors\n');
[tri,pterrL] = nbr_error(xL,X);

goodpoints = find((pterrR<nbrthresh) & (pterrL<nbrthresh));
fprintf('   Dropping %2.2f %% of points from scan\n',100*(1-(length(goodpoints)/size(X,2))));
X = X(:,goodpoints);
xR = xR(:,goodpoints);
xL = xL(:,goodpoints);
xColor = xColor(:,goodpoints);

%
% cleaning step 3: remove triangles which have long edges
%
[tri,terr] = tri_error(xL,X);
subt = find(terr<trithresh);
tri = tri(subt,:);

%
% cleaning step 4: simple smoothing
%
Y = nbr_smooth(tri,X,3);

% save the results of all our hard work
save([settings.resDir sprintf('meshdata_%02d.mat',setIndex)],'Y','tri','xColor');

end

