function [x, y] = CreateDataBase(pathName)

    %%% Initialization %%%
    filesList = dir(pathName);
    [dx,dx] = sort([filesList.datenum]);

    startFileName = filesList(dx(1)).name;
    endFileName = filesList(dx(end - 2)).name;

    startDate = datetime(str2double(startFileName(7:10)),str2double(startFileName(1:2)),str2double(startFileName(4:5)));
    endDate = datetime(str2double(endFileName(7:10)),str2double(endFileName(1:2)),str2double(endFileName(4:5)));
    dataLabels = startDate:endDate;
    dataLabels = dataLabels';

    filesNumber = size(filesList, 1);
    dataBase = zeros(size(dataLabels, 1), 2*60*512); 

    %%% Preparing signals for each day in database %%%
    for i = 1:filesNumber - 2
        fileName = filesList(i + 2).name;
        currentDate = datetime(str2double(fileName(7:10)),str2double(fileName(1:2)),str2double(fileName(4:5)));
        index = find (dataLabels == currentDate);    
        X = csvread(strcat(pathName, fileName), 1, 0);   
        dataBase(index,:) = X(10*512 + 1:130*512, 2)';
    end
    
    %%% Putting Nan for missing data %%%
    for i = 1:size(dataBase, 1)
        if mean(dataBase(i,:)) == 0
            for j = 1:size(dataBase, 2)
                dataBase(i,j) = NaN;
            end
        end
    end
    
    x = dataLabels;
    y = dataBase;

end




