function plotFeatureVector(vectorsCheck)
    figure('NumberTitle', 'off', 'Name', 'Plot feature vector Bài 3')
    hold on;
    
    colors = ['r', 'g', 'b', 'c', 'm']; % M?ng ch?a các màu s?c
    
    for j = 1:5
        featureVector = vectorsCheck(:, j);
        plot(featureVector, 'Color', colors(j));
    end
    
    hold off;
    
    title('Vecto dac trung cua 5 nguyen am voi so chieu la 13');
    
    % T?o chú thích cho màu s?c
    legend('a', 'e', 'i', 'o', 'u');
end