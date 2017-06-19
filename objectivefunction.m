function f = objectivefunction(alpha)

beta = 0.1;
f = zeros(size(alpha));
x = [-4.2, -2.85, -2.3, -1.02, 0.70, 0.98, 2.72, 3.5];
for i = 1:length(alpha)
    f(i) = sum(log(beta.^2 + (x - alpha(i) ).^2) );
end    