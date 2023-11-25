function [outputSignal, Fs] =  removeSilence(file, frame_len)
    % ??c file âm thanh ??u vào
    outputSignal = [];
    [inputSignal, Fs] = audioread(file);
    frameSize = floor(Fs*(frame_len*0.001)); 
    frames = buffer(inputSignal, frameSize); 
    averageEnergy = mean(sum(frames.^2, 1));
    threshold = 0.2 * averageEnergy;
    
    
    for i=1:size(frames,2)
        if sum(frames(:,i).^2) > threshold
            outputSignal = [outputSignal; frames(:,i)];
        end
    end  
end