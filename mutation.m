function x = mutation(x)
n = size(x,1)
m = size(x,2)
for i = 1:floor(n)
    p = .1; %mutation probability
    for j = 2:m
        if (rand < .1)
            x(i,j) = num2str(1 - str2num(x(i,j)));
        end
    end
end