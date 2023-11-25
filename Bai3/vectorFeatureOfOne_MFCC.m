function VectorFeatureOfOne = vectorFeatureOfOne_MFCC(filename, N_MFCC, framelen, frameshift)

    [x, fs] = removeSilence(filename, framelen);
    
    % Normalize x
    x = x / max(abs(x));

    % Split into three parts and take the middle part
    part_len = floor(length(x) / 3);
    part_middle = x(part_len + 1 : part_len * 2);

    % Split the middle part into frames with a length of 20ms and a frame distance of 10ms
    frame_len = framelen * 0.001 * fs;
    frame_dis = frameshift * 0.001 * fs;

    frames = buffer(part_middle, frame_len, frame_dis, 'nodelay');
    num_frames = size(frames, 2);

    featureVector = zeros(N_MFCC, 1);
    for i = 1:num_frames
        tmp = frames(:, i);
        
        % Extract MFCC vector from one frame
        mfcc_result = melcepst(tmp, fs, 'M', N_MFCC);
        
        featureVector = featureVector + transpose(mfcc_result);
    end

    % Calculate the average feature vector
    featureVector = featureVector / num_frames;
    VectorFeatureOfOne = (featureVector);
end