function plotFeatureVector(vectorsCheck)
    figure('NumberTitle', 'off', 'Name', 'Plot feature vector Bài 2')
    hold on;
    
    colors = ['r', 'g', 'b', 'c', 'm']; % M?ng ch?a các màu s?c
    
    for j = 1:5
        featureVector = vectorsCheck(:, j);
        plot(featureVector(1:end/2), 'Color', colors(j));
    end
    
    hold off;
    
    title('Vecto dac trung cua 5 nguyen am voi so chieu la 1024');
    
    % T?o chú thích cho màu s?c
    legend('a', 'e', 'i', 'o', 'u');
end