function data = vectorFeatureOfAll_MFCC(N_MFCC, frame_len, frame_shift)

data = [];
% Th? m?c ch?a d? li?u
TrainDir = '..\NguyenAmHuanLuyen-16K';

% L?y danh sách các th? m?c con c?p 1
ListDir = dir(TrainDir);
ListDir = ListDir(3:end);  % B? qua '.' và '..'

% Duy?t qua t?ng th? m?c và ??c file 'a.wav'
filename = ['a';'e';'i';'o';'u'];

for j = 1:5
    result = zeros(N_MFCC, 1);
    
    for i = 1:length(ListDir)
      
        CurrentDir = fullfile(TrainDir, ListDir(i).name);
        audioFile = fullfile(CurrentDir, strcat(filename(j),'.wav'));

        vector = vectorFeatureOfOne_MFCC(audioFile, N_MFCC, frame_len, frame_shift);
        result = result + vector;
        
    end
    
    average = result / length(ListDir);
    data = [data,average];
    
end
