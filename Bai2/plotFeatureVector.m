function plotFeatureVector(vectorsCheck, N_FFT)
    figure('NumberTitle', 'off', 'Name', 'Plot feature vector Bài 2')
    hold on;
    
    colors = ['r', 'g', 'b', 'c', 'm']; % Mang chua mau sac
    
    for j = 1:5
        featureVector = vectorsCheck(:, j);
        plot(featureVector(1:end/2), 'Color', colors(j));
    end
    
    hold off;
    
    title(sprintf('Vecto dac trung cua 5 nguyen am voi so chieu la %d', N_FFT));
    
    % Tao chu thich mau sac
    legend('a', 'e', 'i', 'o', 'u');
end