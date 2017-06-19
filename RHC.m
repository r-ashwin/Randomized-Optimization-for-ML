% Randomized Hill Climbing

clear all
close all
clc

% f = @objectivefunction; % objective function we want to minimize
f = @objectivefunction2; % objective function we want to minimize
a0 = 6;  % starting point

% design space
des_space = linspace(-6,6,100); % Test-Function 1
% des_space = [-2*pi:pi/256:2*pi]; % Test-Function 2

iter = 0;
eps = 10;
%plot objfunc for visualization purposes
fig = line(des_space,f(des_space));

C0   = f(a0);fig2 = line(a0,C0);fig2.Marker = 'o';
h = gca;
xlab = 'Design Space';
ylab = 'ObjFn Value';
mins = [];
minserror = 1;

while iter <= 500 && minserror > 1e-2

    a = datasample(des_space,1);
    C = f(a);
     
    if (C < C0)
        eps = abs(C - C0);
        a0 = a;
        C0 = C;                
    end
    
    mins = [mins C0];
    
    if length(mins) > 10
        minserror = norm(mins - mean(mins))
        mins = [];
    end
    iter = iter + 1;
    delete(fig2);
    fig2 = line(a0,C0);
    fig2.Marker = 'o';
    fig2.MarkerSize = 5;
    fig2.MarkerFaceColor = 'green';
    fig2.MarkerEdgeColor = 'black';
    titl = sprintf('Design point = %1.2f, Objfn value = %2.2f', a0, C0);

    h.Title = title(titl);
    h.TitleFontWeight = 'normal';
    h.XLabel = xlabel(xlab);
    h.YLabel = ylabel(ylab);
    drawnow;
    pause(0.001);
    

end

disp('function calls');
disp(iter-1);
disp('minimum location');
disp(a0);
disp('minimum');
disp(C0);
