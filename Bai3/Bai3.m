function Bai3(N_MFCC, frame_len, frame_shift)
TrainDir = '..\NguyenAmKiemThu-16K';

% Lay danh sach thu muc con cap 1
ListDir = dir(TrainDir);  % L?c ch? l?y c?c th? m?c
ListDir = ListDir(3:end);  % Bo qua '.' va '..'

filename = ['a';'e';'i';'o';'u'];

vectorsCheck = vectorFeatureOfAll_MFCC(N_MFCC, frame_len, frame_shift);

plotFeatureVector(vectorsCheck);

confusion_matrix = zeros(5, 5);
for i = 1:length(ListDir)
    currentDir = fullfile(TrainDir, ListDir(i).name);
    
    for j = 1:5
        audioFile = fullfile(currentDir, strcat(filename(j),'.wav'));
        vector = vectorFeatureOfOne_MFCC(audioFile, N_MFCC, frame_len, frame_shift);
           
        minDistance = euclideanDistance(vector,vectorsCheck(:,1));
        position = 1;
        for k = 2: 5
            tmpDistance = euclideanDistance(vector,vectorsCheck(:,k));
            if(minDistance>=tmpDistance)
                 minDistance = tmpDistance;
                 position = k;
            end
                
        end
            confusion_matrix(position, j) = confusion_matrix(position, j) + 1;
        
    end
    
end
    count = 0;
    for i = 1 : 5
        count = count + confusion_matrix(i, i);
    end

fprintf('Ty le: %f\n', count/105);
disp(confusion_matrix);

fig = figure('NumberTitle', 'off', 'Name', 'Bài 3');

% ao bang
tableData = num2cell(transpose(confusion_matrix));
columnNames = cellstr(filename);
rowNames = cellstr(filename);
tableHandle = uitable('Data', tableData, 'ColumnName', columnNames, 'RowName', rowNames);

% Thiet lap kich thuoc va vi tri cua bang
tablePosition = getpixelposition(fig);  % Lay kich thuoc cua figure
tablePosition(1) = 0;  % ??t v? trí x c?a b?ng là 0
tablePosition(2) = 0;  % ??t v? trí y c?a b?ng là 0
tablePosition(3) = tablePosition(3);  % ??t chi?u dài c?a b?ng b?ng chi?u dài c?a figure
tablePosition(4) = tablePosition(4) * 0.9;  % ??t chi?u cao c?a b?ng b?ng chi?u cao c?a figure
set(tableHandle, 'Units', 'pixels', 'Position', tablePosition);

fontSize = 20;  % Kích th??c ch? mong mu?n
set(tableHandle, 'FontSize', fontSize);

set(tableHandle, 'ColumnWidth', {105});
set(tableHandle, 'FontSize', 40);

annotation('textbox', [0.35, 0.9, 0.1, 0.1], 'String', sprintf('Ty le: %.4f', count/105), 'FontSize', 20);

% [max_c, max_index] = max(str2double(confusion(1:5)));
% 
% addStyle(tableHandle, uistyle('BackgroundColor','green'), 'row', max_index);