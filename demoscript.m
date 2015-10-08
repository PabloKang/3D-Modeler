% demoscript - Creates a 3D model of a scanned object.
%  
% Description:
%   This script calls other functions that take in scans (using structured
%   light). After calibrating the cameras used to take the scans, the 
%   functions then operate on these scans to create a 3D model of the
%   original physical figure.
%
% Author:   Pablo Kang (58842064)
% Email:    pkang@uci.edu
% Updated:  5/21/2015
%
%------------------------------ BEGIN CODE --------------------------------

% Clean-up and create new workspace
close all; clc;

% Create new workspace
settings = setup();
save('settings.mat','settings');

fprintf(sprintf('Only perform reconstruction if you have no scandata_0n.mat files in data folder.\nAlso, ensure that monkey scan sets 1-7 are in the monkey folder.\n', i));

% Ask if reconstruction needs to be performed (build scandata.mat's)
doRecon = input('- Perform reconstruction?  [Y/N]: ','s');
if doRecon == 'y' || doRecon == 'Y'
    for i = settings.setStart:settings.setFinish
        fprintf(sprintf('Reconstructing set_%02d\n', i));
        reconstruct(i);
    end
end

fprintf(sprintf('\nPlease ensure that scandata_0n.mat files are present in data folder.\n', i));

% Ask if mesh generation needs to be performed (build mesh.ply's)
doMesh = input('- Perform mesh generation? [Y/N]: ','s');
if doMesh == 'y' || doMesh == 'Y'
    for i = settings.setStart:settings.setFinish
        fprintf(sprintf('   Making mesh for set_%02d\n', i));
        make_mesh(i);
    end
end

% Ask if mesh generation needs to be performed (build mesh.ply's)
doPly = input('- Perform Ply conversion?  [Y/N]: ','s');
if doPly == 'y' || doPly == 'Y'
    for i = settings.setStart:settings.setFinish
        % load in results of reconstruct 
        clear meshData;
        clear ply_data;
        meshData = load([settings.resDir sprintf('meshdata_%02d.mat',i)]);
        meshPath = [settings.resDir sprintf('mesh_%02d.ply',i)];
        ply_data = tri_mesh_to_ply(meshData.Y, meshData.xColor, meshData.tri');
        ply_write(ply_data,meshPath,'ascii');
    end
end


for i = settings.setStart:settings.setFinish
    figure(1); clf;
    view_mesh(i);
    input('- Press any key to view next mesh: ','s');
end








