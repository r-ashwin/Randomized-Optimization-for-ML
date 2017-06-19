% Genetic Algorithm

clear all
close all
clc

% Choose objective function
% f = @objectivefunction; % objective function we want to minimize
f = @objectivefunction2; % objective function we want to minimize

% define design space
des_space = linspace(-6,6,511); % design space

% Initial Plot
f1    = line(des_space, f(des_space));
xbits = dec2bin(1:length(des_space));

% Starting Population
[a0,idx]  = datasample(des_space, 400);  % starting point
x0        = xbits(idx',:);
C0        = f(a0);
 
% loop parameters
Ngen = 100; %number of generations
gen = 1;
f2 = line(0, 0); %dummy
fncalls = 0;

while gen < Ngen && size(x0,1)>=2
    
    delete(f2);

% Selection
[C0, i] = sort(C0); % sort fitness
x0      = x0(i',:);    % sorted indices
half_len = floor(length(C0)/2); %half length of sorted array

C        = C0(1:half_len);   % pick best half
x        = x0(1:half_len,:); % best half indices

xind = bin2dec(x);
a = des_space(xind);

% plot
f2 = line(a,C);
a
C
f2.LineStyle  = 'none';
f2.Marker     = 'o';
f2.MarkerSize = 10;
f2.MarkerFaceColor = 'green';
f2.MarkerEdgeColor = 'black';
drawnow;
pause(.5);

if length(a) < 2
    length(a)
    break;
end
% split the selected ones into two
frac = 0.5; % used for crossover. remaining for mutation
[x1,idx1] = datasample(x(1:half_len,:),ceil(frac*half_len    ), 'Replace', false);
[x2,idx2] = datasample(x(1:half_len,:),ceil((1-frac)*half_len), 'Replace', false);
% x1 = x(idx1',:);
% x2 = x(idx2',:);

if size(x1,1)>1
% Crossover
x1 = crossover(x1);
xind = bin2dec(x1);
a = des_space(xind);
l1 = length(a);
fc = f(a);
else
    x1 = [];
    fc = [];
end
% Mutation
x2 = mutation(x2);
xind = bin2dec(x2);
a = des_space(xind);
l2 = length(a);
fm = f(a);

C0 = [fc, fm];
x0 = [x1; x2];

gen = gen + 1;
% clear x, xind
fncalls = fncalls + l1 + l2;
end

disp('generations');
disp(gen-1);
disp('function calls');
disp(fncalls);
disp('Minimum');
disp(min(C));
disp('Min location');
disp(a);