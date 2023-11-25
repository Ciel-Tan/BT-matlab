folders = {'33MHP', '40MHS', '43MNT', '44MTT'};
files = {'a.wav', 'e.wav', 'i.wav', 'o.wav', 'u.wav'};   
for i = 1 : 4
    figure('Name', ['Nguyen am cua  ' folders{i}]); 
    k = 1;
    for j = 1 : 5
        [s, fs] = audioread(fullfile('..\NguyenAmHuanLuyen-16K', folders{i}, files{j}));
        t = 0 : 1/fs : length(s)/fs - 1/fs;     
        subplot(5, 1, k ); 
        spectrogram(s, 5*10^(-3)*fs, 2*10^(-3)*fs, 1024, fs, 'yaxis');
        title(['Vowel: /' files{j} '/']);
        k = k + 1;
    end
end