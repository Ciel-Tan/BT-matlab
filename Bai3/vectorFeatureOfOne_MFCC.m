function VectorFeatureOfOne = vectorFeatureOfOne_MFCC(filename, N_MFCC, framelen, frameshift)

    [x, fs] = removeSilence(filename, framelen);
    
    % Normalize x
    x = x / max(abs(x));

    % Split into three parts and take the middle part
    part_len = floor(length(x) / 3);
part_middle = x(part_len + 1 : part_len * 2);

frame_len = framelen * 0.001 * fs;
frame_dis = frameshift * 0.001 * fs;

num_frames = floor((length(part_middle) - frame_len) / frame_dis) + 1;
frames = zeros(frame_len, num_frames);

for i = 1:num_frames
    start_index = (i - 1) * frame_dis + 1;
    end_index = start_index + frame_len - 1;
    frames(:, i) = part_middle(start_index:end_index);
end
    num_frames = size(frames, 2);

    featureVector = zeros(N_MFCC, 1);
    for i = 1:num_frames
        frame = frames(:, i);
        
        % Extract MFCC vector from one frame
        mfcc_result = melcepst(frame, fs, 'M', N_MFCC);
        
        featureVector = featureVector + transpose(mfcc_result);
    end

    % Calculate the average feature vector
    featureVector = featureVector / num_frames;
    VectorFeatureOfOne = (featureVector);
end