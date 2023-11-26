function Bai2(N_FFT, frame_len, frame_dis)
    %TrainDir = '..\NguyenAmKiemThu-16K';
    TrainDir = fullfile('..', 'NguyenAmKiemThu-16K');

    % Lay danh sach thu muc con cap 1
    ListDir = dir(TrainDir);
    ListDir = ListDir(3:end);  % Bo qua '.' va '..'

    filename = ['a';'e';'i';'o';'u'];

    vectorsCheck = vectorFeatureOfall(N_FFT, frame_len, frame_dis);

    plotFeatureVector(vectorsCheck, N_FFT);
    
    confusion_matrix = zeros(5, 5);
    for i = 1:length(ListDir)
        CurtDir = fullfile(TrainDir, ListDir(i).name);

        for j = 1:5
            audioFile = fullfile(CurtDir, strcat(filename(j),'.wav'));
            vector = vectorFeatureOfOne(audioFile, N_FFT, frame_len, frame_dis);

            minDistance = euclideanDistance(vector, vectorsCheck(:,1));
            position = 1;
            for k = 2: 5
                tmpDistance = euclideanDistance(vector,vectorsCheck(:,k));
                if(minDistance >= tmpDistance)
                   minDistance = tmpDistance;
                   position = k;
                end
            end
                confusion_matrix(j, position) = confusion_matrix(j, position) + 1;
        end

    end
    count = 0;
    for i = 1 : 5
        count = count + confusion_matrix(i, i);
    end
    
    fprintf('Ty le: %f\n', count/105);
    disp(confusion_matrix);

    fig = figure('NumberTitle', 'off', 'Name', 'Bai 2');

    % Tao mot bang
    % tableData = num2cell(transpose(confusion_matrix));
    columnNames = cellstr(filename);
    rowNames = cellstr(filename);
    tableHandle = uitable('Data', confusion_matrix, 'ColumnName', columnNames, 'RowName', rowNames);

    % Thiet lap kich thuoc vi tri cua bang
    tablePosition = getpixelposition(fig);  % Lay kich thuoc cua figure
    tablePosition(1) = 0;  % vi tri x
    tablePosition(2) = 0;  % vi tri y
    tablePosition(3) = tablePosition(3);  % Chieu dai
    tablePosition(4) = tablePosition(4) * 0.9;  % Chieu cao
    set(tableHandle, 'Units', 'pixels', 'Position', tablePosition);

    fontSize = 20;
    set(tableHandle, 'FontSize', fontSize);

    set(tableHandle, 'ColumnWidth', {105});
    set(tableHandle, 'FontSize', 40);

    annotation('textbox', [0.35, 0.9, 0.1, 0.1], 'String', sprintf('Ty le: %.4f', count/105), 'FontSize', 20);
end