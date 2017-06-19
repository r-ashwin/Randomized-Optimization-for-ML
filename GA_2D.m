% Genetic Algorithm

clear all
close all
clc

% Choose objective function
f = @objectivefunction3; % objective function we want to minimize
a0 = 100;  % starting point
[d_s1, d_s2] = meshgrid(-512:1024/90:512, -512:1024/90:512); % design space
iter = 0;

%plot objfunc for visualization purposes
% fig = surf(d_s1,d_s2,f(d_s1,d_s2));

ff = f(d_s1,d_s2);
[min, idx] = min(ff(:));
fig = contour(d_s1,d_s2,ff);
set(gcf,'units','normalized','outerposition',[0 0 1 1])

C0   = f(d_s1(a0),d_s2(a0));fig1 = line(d_s1(idx),d_s2(idx),min); fig1.Marker = 'o'; fig1.MarkerSize = 30;    fig1.MarkerFaceColor = 'red';
    fig1.MarkerEdgeColor = 'black';
C0   = f(d_s1(a0),d_s2(a0));fig2 = line(d_s1(a0),d_s2(a0),C0);fig2.Marker = 'o';
xlab = 'x';
ylab = 'y';
        mins = [];
        minserror = 10;
        fncalls = 0;    
        iter = 0;

%%%%%%%%%%% Start old
xbits = dec2bin((1:numel(d_s1))');
% xbits = dec2bin((1:8191)');

% Starting Population
[a0,idx]  = datasample(1:numel(d_s1), 400);  % starting point
x0        = xbits(a0',:);
C0        = f(d_s1(a0),d_s2(a0));
 
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
a = [d_s1(xind), d_s2(xind)];

% plot
f2 = line(a(:,1),a(:,2),C');
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
frac = 0.9; % used for crossover. remaining for mutation
[idx1,~] = datasample(1:length(x),ceil(frac*length(x)),    'Replace', false);
[idx2,~] = datasample(1:length(x),ceil((1-frac)*length(x)),'Replace', false);
x1 = x(idx1',:);
x2 = x(idx2',:);
% [x2,idx2] = datasample(x(1:half_len,:),ceil((1-frac)*half_len), 'Replace', false);
% x1 = x(idx1',:);
% x2 = x(idx2',:);

if size(x1,1)>1
% Crossover
x1 = crossover(x1);
xind = bin2dec(x1);
a = [d_s1(xind), d_s2(xind)];
l1 = length(a);
fc = f(d_s1(xind),d_s2(xind));
else
    x1 = [];
    fc = [];
end
% Mutation
x2 = mutation(x2);
xind = bin2dec(x2);
a = [d_s1(xind(xind(xind~=0) < numel(d_s1(:)))), d_s2(xind(xind(xind~=0) < numel(d_s1(:))))];

l2 = length(a);
fm = f(d_s1(xind),d_s2(xind));

C0 = [fc; fm];
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