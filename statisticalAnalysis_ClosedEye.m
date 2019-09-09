clc, clear all


%%%%%%%%%%%%%%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%%%%
pathName = 'C:\Users\ssadegh4\Dropbox (ASU)\BrainResearch\EMBC2017_Permanency\Data\ClosedEye\';
[dataLabels, rawData] = createDataBase(pathName);

%%%%%%%%%%%%%%%%%%%% TIME DOMAIN STATISTICAL ANALYSIS %%%%%%%%%%%%%%%%%%%%

%%% Plotting mean of raw signal with interpolated data %%%
% interpolationPlot(meanCalculator(rawData)); 

%%% Plotting min of raw signal with interpolated data %%%
% interpolationPlot(minCalculator(rawData));

%%% Plotting max of raw signal with interpolated data %%%
% interpolationPlot(maxCalculator(rawData));

%%% Plotting cosine similarity between daily samples with interpolated data %%%
% interpolationPlot(cosineDistCalculator(rawData));

%%% Plotting Euclidean distance between daily samples with interpolated data %%%
% interpolationPlot(euclideanDistCalculator(rawData));

%%% Plotting Hamming distance between daily samples with interpolated data %%%
% interpolationPlot(hammingDistCalculator(rawData));

%%% Plotting Jaccard distance between daily samples with interpolated data %%%
interpolationPlot(jaccardDistCalculator(rawData));

%%%%%%%%%%%%%%%%%%%% FREQUENCY DOMAIN STATISTICAL ANALYSIS %%%%%%%%%%%%%%%%%%%%


