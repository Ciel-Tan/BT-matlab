function [outputSignal, Fs] =  removeSilence(file, frame_len)
    % file : file âm thanh dau vao
    % frame_len : kich thuoc cua 1 khung (ms)
    outputSignal = [];
    [inputSignal, Fs] = audioread(file);

    frameSize = floor(Fs*(frame_len*0.001)); % so mau cua 1 khung
    frames = buffer(inputSignal, frameSize);

    averageEnergy = mean(sum(frames.^2, 1));
    threshold = 0.1 * averageEnergy;
   
    for i=1:size(frames,2)
        if sum(frames(:,i).^2) > threshold
            outputSignal = [outputSignal; frames(:,i)];
        end
    end  
end