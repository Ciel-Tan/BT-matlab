function VectorFeatureOfOne = vectorFeatureOfOne(filename, N_FFT, framelen, framedis)

    [x,fs] = removeSilence(filename, framelen);
    %Chuan hoa x
    x = x / max(abs(x));

    %2.a Chia thanh 3 doan lay doan giua
    part_len = floor(length(x)/3);

    part_middle = x(part_len + 1 : part_len * 2);

    %Chia doan thanh M khung voi do dai 20ms, do dich khung 10ms
    frame_len = framelen * 0.001 * fs;
    frame_dis = framedis * 0.001 * fs; 

    frames = buffer(part_middle, frame_len, frame_dis, 'nodelay');
    %w = hamming(length(frames(1, :)));
    num_frames = size(frames, 2);

    featureVector = zeros(N_FFT,1);
    for i = 1:num_frames

        %2.b Trich xuat vecto FFT tu 1 frame  
        fft_result = abs(fft(frames(:, i), N_FFT));

        featureVector = featureVector + fft_result;
    end
    %2.c Vecto dac trung cua 1 nguyen am cua 1 nguoi noi
    featureVector = featureVector / num_frames;
    
    VectorFeatureOfOne = featureVector;
end
