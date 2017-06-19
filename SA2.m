% Simulated Annealing for Randomized Optimization
clear all
close all
clc

f   = @objectivefunction; % objective function we want to minimize
% f   = @objectivefunction2; % objective function we want to minimize
a0  = 0;  % starting point
T   = 5; % starting Temperature
rho = .95;% temperature change ratio

des_space = linspace(-6,6,400); % design space
iter = 0;

%plot objfunc for visualization purposes
fig = line(des_space,f(des_space));
fig.LineWidth = 2;
xlab = 'Design Space';
ylab = 'ObjFn Value';
h = gca;
h.XLabel = xlabel(xlab);
h.YLabel = ylabel(ylab);

C0   = f(a0);fig2 = line(a0,C0);fig2.Marker = 'o';
h = gca;

    txt  = sprintf('Temperature = % 2.2f', T);
    
        xl = mean(des_space);
        yl = f(xl);
        t = text(xl, yl,txt);
        
        mins = [];
        minserror = 10;
        fncalls = 0;
while T >= .01 && minserror > 1e-2

while iter <= 20 && minserror > 1e-2
        delete(t);
    a = datasample(des_space,1);
    C = f(a);

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
    fig2 = line(a0,C0);
    fig2.Marker = 'o';
    fig2.MarkerSize = 10;
    fig2.MarkerFaceColor = 'green';
    fig2.MarkerEdgeColor = 'black';
    titl = sprintf('Design point = %1.2f, Objfn value = %2.2f', a0, C0);
        txt  = sprintf('Temperature = % 2.2f', T);
    t = text(xl,yl,txt);
    set(t, 'String',txt);    
%     fig2.Annotation = txt;
    h.Title = title(titl);
    h.TitleFontWeight = 'normal';
    h.XLabel = xlabel(xlab);
    h.YLabel = ylabel(ylab);
    drawnow;
    pause(0.001);

end

fncalls = fncalls + iter;
iter = 1;

T = rho*T;
end

disp('function calls');
disp(fncalls);
disp('minimum location');
disp(a0);
disp('minimum');
disp(C0);