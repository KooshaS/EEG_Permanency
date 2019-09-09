clc, clear all


srcPathName = 'C:\Users\ssadegh4\Dropbox (ASU)\BrainResearch\ACCEPTED PAPERS\ARCHIVE\EMBC2017_Permanency\Data\OpenEye';
destPathName = 'C:\Users\ssadegh4\Dropbox (ASU)\BrainResearch\ACCEPTED PAPERS\ARCHIVE\EMBC2017_Permanency\Data\OpenEye_newformat';

srcFolder = fullfile(srcPathName);
destFolder = fullfile(destPathName);

Files = dir(srcFolder);
for k = 3:length(Files)
    
    firstPart = Files(k).name(1:2);
    secondPart = Files(k).name(4:5);
    thirdPart = Files(k).name(7:10);
            
    copyfile(fullfile(srcFolder,Files(k).name),...
    fullfile(destFolder,[firstPart, '-', secondPart, '-', thirdPart,'.csv']));

end