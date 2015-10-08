function reconstruct(setIndex)

% Load current settings
load('settings.mat');

% directory where the scan data is stored
setDir = [settings.srcDir sprintf(settings.setFormat,setIndex)];
calDir = [settings.resDir 'Calib_Results_stereo.mat'];


% Acquire camera calibration data
[camL, camR] = calibrate(calDir);


% Define pixel difference threshold
thresh = 0.005;


[R_h,R_h_good] = decode([setDir 'r_'],1,10,thresh);
[R_v,R_v_good] = decode([setDir 'r_'],11,20,thresh);
[L_h,L_h_good] = decode([setDir 'l_'],1,10,thresh);
[L_v,L_v_good] = decode([setDir 'l_'],11,20,thresh);


% visualize the masked out horizontal and vertical
% codes for left and right camera
figure(1); clf;
subplot(2,2,1); imagesc(R_h.*R_h_good); axis image; axis off;title('right camera, h coord');
subplot(2,2,2); imagesc(R_v.*R_v_good); axis image; axis off;title('right camera,v coord');
subplot(2,2,3); imagesc(L_h.*L_h_good); axis image; axis off;title('left camera,h coord');  
subplot(2,2,4); imagesc(L_v.*L_v_good); axis image; axis off;title('left camera,v coord');  
colormap jet


% combine horizontal and vertical codes
% into a single code and mask.
%
Rmask = R_h_good & R_v_good;
R_code = R_h + 1024*R_v;
Lmask = L_h_good & L_v_good;
L_code = L_h + 1024*L_v;


% now find those pixels which had matching codes
% and were visible in both the left and right images
%
% only consider good pixels
Rsub = find(Rmask(:));
Lsub = find(Lmask(:));
% find matching pixels 
[matched,iR,iL] = intersect(R_code(Rsub),L_code(Lsub));
indR = Rsub(iR);
indL = Lsub(iL);
% indR,indL now contain the indices of the pixels whose 
% code value matched

% pull out the pixel coordinates of the matched pixels
[h,w] = size(Rmask);
[xx,yy] = meshgrid(1:w,1:h);
xL = []; xR = [];
xR(1,:) = xx(indR);
xR(2,:) = yy(indR);
xL(1,:) = xx(indL);
xL(2,:) = yy(indL);


% while we are at it, we can use the same indices (indR,indL) to
% pull out the colors of the matched pixels


% array to store the (R,G,B) color values of the matched pixels
xColor = zeros(3,size(xR,2));

% load in the images and seperate out the red, green, blue
% color channels into separate matrices
rgbL = imread([setDir 'l_rgb.jpg']);
rgbL_R = rgbL(:,:,1); 
rgbL_G = rgbL(:,:,2);
rgbL_B = rgbL(:,:,3);

rgbR = imread([setDir 'r_rgb.jpg']);
rgbR_R = rgbR(:,:,1);
rgbR_G = rgbR(:,:,2);
rgbR_B = rgbR(:,:,3);

% use the average of the color in the left and 
% right image.  depending on the scan, it may
% be better to just use one or the other.
xColor(1,:) = 0.5*(rgbR_R(indR) + rgbL_R(indL));
xColor(2,:) = 0.5*(rgbR_G(indR) + rgbL_G(indL));
xColor(3,:) = 0.5*(rgbR_B(indR) + rgbL_B(indL));


% now triangulate the matching pixels using the calibrated cameras
X = triangulate(xL,xR,camL,camR);

% save the results of all our hard work
%save([settings.resDir sprintf('scandata_%02d.mat',setIndex)],'X','xColor','xL','xR','R_h','R_v','L_h','L_v','camL','camR','setDir');

end
