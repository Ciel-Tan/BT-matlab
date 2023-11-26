function Bai3_Kmean(N_MFCC, frame_len, frame_shift, k)
    TrainDir = fullfile('..', 'NguyenAmKiemThu-16K');
    
    % Lay danh sach thu muc con cap 1
    ListDir = dir(TrainDir);  % L?c ch? l?y c?c th? m?c
    ListDir = ListDir(3:end);  % Bo qua '.' va '..'
    
    filename = ['a';'e';'i';'o';'u'];
    
    vectorsCheck = vectorFeatureOfAllKmean(N_MFCC, frame_len, frame_shift, k);
    
    if (k == 1) 
        plotFeatureVector(vectorsCheck);
    end
    
    confusion_matrix = zeros(5, 5);

    for i = 1:length(ListDir)
        currentDir = fullfile(TrainDir, ListDir(i).name);
        
        for j = 1:5
            audioFile = fullfile(currentDir, strcat(filename(j),'.wav'));
            vector = vectorFeatureOfOne_MFCC(audioFile, N_MFCC, frame_len, frame_shift);
               
            minDistance = euclideanDistance(vector,vectorsCheck(:,1));
            indentifiedVowel = 1;
            for l = 2 : 5 * k
                tmpDistance = euclideanDistance(vector,vectorsCheck(:,l));
                if(minDistance>=tmpDistance)
                     minDistance = tmpDistance;
                     indentifiedVowel = floor((l - 1) / k) + 1;
                end
                    
            end
    
            confusion_matrix(j, indentifiedVowel) = confusion_matrix(j, indentifiedVowel) + 1; 
        end
    end
    
    % Tính tỉ lệ nhận dạnh chính xác
    count = 0;
    for i = 1 : 5
        count = count + confusion_matrix(i, i);
    end
    
    fprintf('Ty le: %f\n', count/105);
    disp(confusion_matrix);
    
    fig = figure('NumberTitle', 'off', 'Name', sprintf('Bài 3 với k = %d', k));
    
    % Tạo bảng hiển thị confusion_matrix
    columnNames = cellstr(filename);
    rowNames = cellstr(filename);
    tableHandle = uitable('Data', confusion_matrix, 'ColumnName', columnNames, 'RowName', rowNames);
    
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
end
