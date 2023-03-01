
close all
clear
load mat/createModel.mat m

m.c2_q_hh = 0.020;
m.c4_q_hh = -0.003;
m = steady(m);

ss = access(m, "steady-level");

z = linspace(-0.10, 0.10, 500);

z = reshape(z, [], 1);
q = glogc(-z, ss.ss_q_hh, ss.c2_q_hh, ss.c3_q_hh, ss.c4_q_hh, ss.c5_q_hh);

figure();
hold on

plot(100*z, 100*q);


xlabel("Macroeconomic conditions index [%]");
ylabel("Portfolio default rate [%]");

slope = glogd(0, ss.ss_q_hh, ss.c2_q_hh, ss.c3_q_hh, ss.c4_q_hh, ss.c5_q_hh);
ql = ss.q + slope * (-z);

plot(100*z, 100*ql, "lineStyle", ":");

xline(0, "color", 0.6*[1,1,1], "lineWidth", 5);

set(gca(), "yLim", [0.5, 5.5], "xLim", 100*z([1,end]), "fontSize", 14);

print -dpng ../docs/portfolio-default-rate-func.png

