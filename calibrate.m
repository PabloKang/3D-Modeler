function [camL,camR] = calibrate(caldir)

% function [cam,Pcam,Pworld] = calibrate(imfile);
%
%  This function 
%
%  Output: 
%

% Load calibration data
load(caldir);

% Fill cam structs
camL.f = fc_left;
camR.f = fc_right;

camL.c = cc_left;
camR.c = cc_right;

camL.R = R;
camR.R = [1 0 0; 0 1 0; 0 0 1];

camL.t = T;
camR.t = [0; 0; 0];


end


