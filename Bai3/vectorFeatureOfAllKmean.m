function data = vectorFeatureOfAllKmean(N_MFCC, frame_len, frame_shift, k)

    data = [];
    % Th? m?c ch?a d? li?u
    TrainDir = fullfile('..', 'NguyenAmHuanLuyen-16K');

    % L?y danh sách các th? m?c con c?p 1
    ListDir = dir(TrainDir);
    ListDir = ListDir(3:end);  % B? qua '.' và '..'

    % Duy?t qua t?ng th? m?c và ??c file 'a.wav'
    filename = ['a';'e';'i';'o';'u'];

    for j = 1:5
        result = [];
        
        for i = 1:length(ListDir)
        
            CurrentDir = fullfile(TrainDir, ListDir(i).name);
            audioFile = fullfile(CurrentDir, strcat(filename(j),'.wav'));

            vector = vectorFeatureOfOne_MFCC(audioFile, N_MFCC, frame_len, frame_shift);
            result = [result, vector];
            
        end

        % Phân cụm 21 vector đặc trưng thành k cụm
        %  và tính vector trung bình của từng cụm
        % -> Thu được k vector trung bình, lấy làm vector đặc trưng cho một nguyên âm
        [idx, centroids] = kmeans(transpose(result), k);
    
        data = [data, transpose(centroids)]; 
    end
end