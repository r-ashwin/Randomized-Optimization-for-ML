function f = objectivefunction3(x,y)
a = 50;
b = 50;
f = -(y + a).*sin(sqrt(abs(y + x./2 + a))) - x.*sin(sqrt(abs(x - y - b)));