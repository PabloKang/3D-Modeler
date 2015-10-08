
function err = project_error(params,X,xL,cx,cy)

%
% wrap our project function for the purposes of optimization
%  params contains the parameters of the camera we want to 
%  estimate.  X,cx,cy are given.
%

% unpack parameters.
fmx = params(1);
fmy = params(2);
thx = params(3);
thy = params(4);
thz = params(5);
tx = params(6);
ty = params(7);
tz = params(8);

%focal length
cam.f = [fmx;fmy];

%location of camera center
cam.c = [cx;cy];

%extrinsic params for right camera
cam.t= [tx;ty;tz];

% concatenate the three rotations.
cam.R = buildrotation(thx,thy,thz);

x = project(X,cam);
err = x-xL;
