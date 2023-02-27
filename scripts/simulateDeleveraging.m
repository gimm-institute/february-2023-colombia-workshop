%% Simulate deleveraging


%% Clear the workspace

% close all
clear
load mat/createModel.mat m

m.sw = 0;
checkSteady(m);
m = solve(m);


%% Design the simulation

%
% Create three variants of the model with lower steady-state credit to GDP
% ratios
%

down = [0.05, 0.10, 0.15];

m1 = alter(m, numel(down));

m1.ss_l_to_4ny_hh  = m1.ss_l_to_4ny_hh - down;

m1 = steady(m1);
checkSteady(m1);
m1 = solve(m1);


%% Run simulation

d1 = steadydb(m, -10:40);

s1 = simulate( ...
    m1, d1, 1:40 ...
    , 'prependInput',true ...
    , 'method',"stacked" ...
);

smc1 = databank.minusControl(m1, s1, d1);



%% Chartpack

ch = defineChartpack();
ch.FigureTitle = "Deleveraging: " + ch.FigureTitle;
ch.Range = 0:40;
ch.FigureExtras = { @(h) visual.hlegend("bottom", "Harmless", "Severe", "Devastating") };
draw(ch, smc1);


return



%% Visualize credit risk

figure();
titles = ["Harmless", "Severe", "Devastating"];

x = access(m, "steady-level");
z = linspace(-0.10, 0.10, 500);
q = glogc(-z, x.ss_q_hh, x.c2_q_hh, x.c3_q_hh, x.c4_q_hh, x.c5_q_hh);

for i = 1 : countVariants(m1) 
    subplot(2, 2, i);
    hold on
    add = nan(40, i-1);
    plot([add, 100*s1.z_hh(1:40,i)], [add,100*s1.q_hh(1:40,i)], 'lineStyle',"none", 'marker',"s", 'markerSize', 15, 'lineWidth',5);
    plot(100*z, 100*q, 'color',0.5*[1,1,1], 'lineWidth',3);
    xline(0, 'lineWidth',2, 'lineStyle',":");
    set(gca(), 'yLim',[0, round(100*max(q+0.01),1)], 'xLim',100*z([1,end]));
    xlabel("Macro conditions index [%]");
    ylabel("Portfolio default rates [%]");
    title(titles(i));
end

visual.heading("Credit portofolio default function", 'fontSize',25, 'fontWeight',"bold");



%% Visualize bank capital risk

figure();
titles = ["Harmless", "Medium", "Severe"];

x = access(m, "steady-level");
q = glogc(-z, x.ss_q_hh, x.c2_q_hh, x.c3_q_hh, x.c4_q_hh, x.c5_q_hh);

car = linspace(x.car_min-0.02, x.car_min+0.05, 500);
car = reshape(car, [], 1);
rx = glogc(-(car - x.car_min), x.c1_rx, x.c2_rx, x.c3_rx, x.c4_rx, x.c5_rx);


for i = 1 : countVariants(m1) 
    subplot(2, 2, i);
    hold on
    add = nan(40, i-1);
    plot([add, 100*s1.car(1:40,i)], [add,400*s1.rx(1:40,i)], 'lineStyle',"none", 'marker',"s", 'markerSize',15, 'lineWidth',5);
    plot(100*car, 400*rx, 'color',0.5*[1,1,1], 'lineWidth',3);
    xline(100*x.car, 'lineWidth',2, 'lineStyle',":");
    xline(100*x.car_min, 'lineWidth',2, 'lineStyle',":");
    set(gca(), 'xLim',100*[min(car), max(car)], 'yLim',400*[0, max(rx)], 'fontSize',20);    
    xlabel("Standard capital adequacy ratio [%]");
    ylabel("Impact on credit conditions [% PA]");  
    title(titles(i));
end

visual.heading("Capital adequacy stress function", 'fontSize',25, 'fontWeight',"bold");
