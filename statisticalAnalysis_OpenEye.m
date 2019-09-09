clc, clear all


%%%%%%%%%%%%%%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%%%%
pathName = 'C:\Users\ssadegh4\Dropbox (ASU)\BrainResearch\EMBC2017_Permanency\Data\OpenEye\';
% pathName = 'C:\Users\ssadegh4\Dropbox (ASU)\BrainResearch\EMBC2017_Permanency\Data\ClosedEye\';
[dataLabels, rawData] = createDataBase(pathName);

%%%%%%%%%%%%%%%%%%%% PREPROCESSING %%%%%%%%%%%%%%%%%%%%
rawData = preprocessing(rawData);

%%%%%%%%%%%%%%%%%%%% TIME DOMAIN STATISTICAL ANALYSIS %%%%%%%%%%%%%%%%%%%%

%%% Plotting mean of raw signal with interpolated data %%%
% interpolationPlot(meanCalculator(rawData)); 

%%% Plotting std of raw signal with interpolated data %%%
% interpolationPlot(stdCalculator(rawData)); 

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
% interpolationPlot(jaccardDistCalculator(rawData));

%%%%%%%%%%%%%%%%%%%% FREQUENCY DOMAIN STATISTICAL ANALYSIS %%%%%%%%%%%%%%%%%%%%

%%% Plotting mean value of delta band absolute power spectrum over 2 min signal %%%
% interpolationPlot(apsCalculator(rawData, 1, 4));

%%% Plotting mean value of theta band absolute power spectrum over 2 min signal %%%
% interpolationPlot(apsCalculator(rawData, 5, 7));

%%% Plotting mean value of alpha band absolute power spectrum over 2 min signal %%%
% interpolationPlot(apsCalculator(rawData, 8, 13));

%%% Plotting mean value of beta band absolute power spectrum over 2 min signal %%%
% interpolationPlot(apsCalculator(rawData, 14, 30));

%%% Plotting mean value of gamma band absolute power spectrum over 2 min signal %%%
% interpolationPlot(apsCalculator(rawData, 31, 100));

%%%%%%%%%%%%%%%%%%%% SIMILARITY BETWEEN FEATURES (APS, AR, DWT) %%%%%%%%%%%%%%%%%%%%

%%% Plotting cosine similarity between daily aps features %%%
% interpolationPlot(cosineDistCalculator(apsExtractor(rawData, 8, 13)));

%%% Plotting Euclidean distance between daily aps features %%%
% interpolationPlot(euclideanDistCalculator(apsExtractor(rawData, 8, 13)));

%%% Plotting cosine similarity between daily ar features %%%
% interpolationPlot(cosineDistCalculator(arExtractor(rawData, 6)));

%%% Plotting Euclidean distance between daily ar features %%%
% interpolationPlot(euclideanDistCalculator(arExtractor(rawData, 6)));

%%% Plotting cosine similarity between daily dwt features %%%
% interpolationPlot(cosineDistCalculator(dwtExtractor(rawData, 10)));

%%% Plotting Euclidean distance between daily dwt features %%%
% interpolationPlot(euclideanDistCalculator(dwtExtractor(rawData, 10)));

%%%%%%%%%%%%%%%%%%%% Learning Performance %%%%%%%%%%%%%%%%%%%%

%%%%% Near Centroid Classifier NCC %%%%%

%%% Plotting classification performance of alpha band aps within two std %%%
% interpolationPlot(ncc_aps_2std(rawData, 8, 13));

%%% Plotting WEEKLY classification performance of alpha band aps within two std %%%
% interpolationPlot(weekly_ncc_aps_2std(rawData, 8, 13));

%%% Plotting classification performance of AR coefficients within two std %%%
% interpolationPlot(ncc_ar_2std(rawData, 6));

%%% Plotting WEEKLY classification performance of AR coefficients within two std %%%
% interpolationPlot(weekly_ncc_ar_2std(rawData, 6));

%%% Plotting classification performance of dwt within two std %%%
% interpolationPlot(ncc_dwt_2std(rawData, 10));

%%% Plotting WEEKLY classification performance of dwt within two std %%%
% interpolationPlot(weekly_ncc_dwt_2std(rawData, 10));








% figure
% subplot(2,1,1)
% weeklyGraphTrend(interpolationPlot(ncc_aps_2std(rawData, 31, 40)))
% subplot(2,1,2)
% weeklyGraphTrend(interpolationPlot(weekly_ncc_aps_2std(rawData, 31, 40)))



% alpha = apsCalculator2(rawData, 8, 13)
% labels = 'y';
% labels = repelem(labels,11040,1)
% clc
% csvwrite('alphaOE.csv',alpha)





