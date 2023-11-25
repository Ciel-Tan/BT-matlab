function data = vectorFeatureOfall(N_FFT, frame_lem, frame_dis)

data = [];
% Thu muc chua du lieu
dataTrainDir = '..\NguyenAmHuanLuyen-16K';

% Lay danh sach thu muc con cap 1
subDirs = dir(dataTrainDir);
subDirs = subDirs([subDirs.isdir]);  % L?c ch? l?y các th? m?c
subDirs = subDirs(3:end);  % Bo qua '.' va '..'

filename = ['a';'e';'i';'o';'u'];

for j = 1:5
    result = zeros(N_FFT, 1);
    
    for i = 1:length(subDirs)
        currentDir = fullfile(dataTrainDir, subDirs(i).name);
        audioFile = fullfile(currentDir, strcat(filename(j),'.wav'));

        y = vectorFeatureOfOne(audioFile, N_FFT, frame_lem, frame_dis);
        result = result + y;

    end
    average = result / length(subDirs);
    data = [data,average];
    
end
