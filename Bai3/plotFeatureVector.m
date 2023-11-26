function plotFeatureVector(vectorsCheck, N_MFCC)
    figure('NumberTitle', 'off', 'Name', 'Plot feature vector Bài 3')
    hold on;
    
    colors = ['r', 'g', 'b', 'c', 'm']; % Mang chua mau sac
    
    for j = 1:5
        featureVector = vectorsCheck(:, j);
        plot(featureVector, 'Color', colors(j));
    end
    
    hold off;
    
    title(sprintf('Vecto dac trung cua 5 nguyen am voi so chieu la %d', N_MFCC));
    
    % Tao chu thich cho mau sac
    legend('a', 'e', 'i', 'o', 'u');
end