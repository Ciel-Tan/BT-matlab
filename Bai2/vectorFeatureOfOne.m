function VectorFeatureOfOne = vectorFeatureOfOne(filename, N_FFT, framelen, framedis)

    [x,fs] = removeSilence(filename, framelen);
    %Chuan hoa x
    x = x / max(abs(x));

    %2.a Chia thanh 3 doan lay doan giua
    part_len = floor(length(x) / 3);
part_middle = x(part_len + 1 : part_len * 2);

frame_len = framelen * 0.001 * fs;
frame_dis = framedis * 0.001 * fs;

num_frames = floor((length(part_middle) - frame_len) / frame_dis) + 1;
frames = zeros(frame_len, num_frames);

for i = 1:num_frames
    start_index = (i - 1) * frame_dis + 1;
    end_index = start_index + frame_len - 1;
    frames(:, i) = part_middle(start_index:end_index);
end
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