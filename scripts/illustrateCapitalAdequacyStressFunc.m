

%close all
clear

load mat/createModel.mat m

figure();
drawCapitalAdequacyRiskFunc(gca(), m);

x = access(m, "steady-level");

hold on;
xline(gca(), 100*x.car, "-", "", "lineWidth", 6, "color", 0.6*[1,1,1]);

print -dpng ../docs/capital-adequacy-stress-func.png

