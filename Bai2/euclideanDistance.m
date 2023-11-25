function[distance] = euclideanDistance(v1, v2)
%     distance = sqrt(sum((v1 - v2) .^ 2));
    distance = norm(v1 - v2);
    %disp(distance);
end