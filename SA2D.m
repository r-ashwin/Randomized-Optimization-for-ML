% Simulated Annealing for Randomized Optimization
clear all
close all
clc

f = @objectivefunction3; % objective function we want to minimize
a0 = 100;  % starting point
T  = 1000; % starting Temperature
rho= .95;   % cooling rate

[d_s1, d_s2] = meshgrid(-512:6:512, -512:6:512); % design space
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

h = gca;

xlab = 'Design Space';
ylab = 'ObjFn Value';
    txt  = sprintf('Temperature = % 2.2f', T);

        mins = [];
        minserror = 10;
        fncalls = 0;    
while T >= 1 && minserror > 1e-2

while iter <= 20 && minserror > 1e-2
%         delete(t);
    a = datasample(1:numel(d_s1),1); % datasample(des_space,1);
    C = f(d_s1(a),d_s2(a));

    if (C < C0) || (exp((C0-C)/T) > rand)
        a0 = a;
        C0 = C;
    end
    
        mins = [mins C0];
    
    if length(mins) > 10
        minserror = norm(mins - mean(mins));
        mins = [];
    end
    
    iter = iter + 1; 
    delete(fig2);
    fig2 = line(d_s1(a0),d_s2(a0),C0);
    fig2.Marker = 'o';
    fig2.MarkerSize = 30;
    fig2.MarkerFaceColor = 'green';
    fig2.MarkerEdgeColor = 'black';
    titl = sprintf('Design point = [%1.2f,%1.2f], Objfn value = %2.2f', d_s1(a0),d_s2(a0), C0);
        txt  = sprintf('Temperature = % 2.2f', T);
    h.Title = title(titl);
    h.TitleFontWeight = 'normal';
    h.XLabel = xlabel(xlab);
    h.YLabel = ylabel(ylab);
    drawnow;
    pause(0.01);

end
fncalls = fncalls + iter;
iter = 1;

T = rho*T
end

disp('function calls');
disp(fncalls);
disp('minimum location');
disp([d_s1(a0),d_s2(a0)]);
disp('minimum');
disp(C0);