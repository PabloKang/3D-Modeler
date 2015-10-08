% CREATE WORKSPACE % :-----------------------------------------------------
function [settings] = setup()
    
%LION
%     % Fill settings struct accordingly
%     srcDir = 'lion/';
%     resDir = 'results/';
%     setFormat = 'set_%02d/';
%     setStart = 2;
%     setFinish = 2;
%     imgSuffix = '%02d.jpg';
%     
%     bbox.xmin = -1500;
%     bbox.xmax = 500;
%     bbox.ymin = -600;
%     bbox.ymax = 300;
%     bbox.zmin = -4000;
%     bbox.zmax = 4000;

%MONKEY
    % Fill settings struct accordingly
    srcDir = 'monkey/';
    resDir = 'data/';
    setFormat = 'set_%02d/';
    setStart = 1;
    setFinish = 7;
    imgSuffix = '%02d.jpg';
    
    bbox.xmin = -300;
    bbox.xmax = 600;
    bbox.ymin = -750;
    bbox.ymax = 750;
    bbox.zmin = 3000;
    bbox.zmax = 3700;

    % Create the workspace struct.
    settings = struct('srcDir',srcDir,'resDir',resDir,'setFormat',setFormat,'setStart',setStart,'setFinish',setFinish,'imgSuffix',imgSuffix,'bbox',bbox);
    
    fprintf('\n- Make sure that your file organization matches the settings below, or the program will not run properly.');
    settings
    
end
