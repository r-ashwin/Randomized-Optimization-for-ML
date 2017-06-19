function x = crossover(x)
n = size(x,1);
m = size(x,2);
if n == 1
    x = x;
    return
end

if n < 3
    k=1;
else
    k=2;
end
for i = 1:floor(n/2)
    p = datasample(1:m-1, 1);
    for j = 1:p
        temp = x(i,j);
        x(i,j) = x(i+k,j);
        x(i+k,j) = temp;
    end
end

