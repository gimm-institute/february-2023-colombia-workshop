%% Simulate creation of conservation buffers


%% Clear the workspace

close all
clear
load mat/createModel.mat m


%% Design the simulation

m.c1_prem = 0.005;
m = steady(m);
m = solve(m);

m1 = alter(m, 2);
m1.ss_car_min = m1.ss_car_min + 2.5/100;
m1.c0_car_min = [0, 0.8];
m1.c1_bk = [0.5, 1];

m1 = steady(m1);
checkSteady(m1);
m1 = solve(m1);


%% Run simulations

d1 = steadydb(m, -10:40);

% Immediate unanticipated increase
s1 = simulate( ...
    m1(1), d1, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
);


% Immediate unanticipated increase with flat policy rate
p = Plan.forModel(m, 1:40);
p = swap(p, 1:8, ["r", "shock_r"]);

s2 = simulate( ...
    m1(1), d1, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p ...
);


% Gradual increase
s3 = simulate( ...
    m1(2), d1, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
);


% Gradual announced/anticipated increase starting at beginning of year 3
p = Plan.forModel(m, 1:40);
p = swap(p, 1:8, ["car_min", "shock_car_min"]);

s4 = simulate( ...
    m1(2), d1, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p ...
);


%% Simulation minus control databanks

s = databank.merge("horzcat", s1, s2, s3, s4);
smc = databank.minusControl(m1, s, d1);


%% Chartpack

ch = defineChartpack();
ch.Range = 0:40;
ch.FigureTitle = "Asset price and credit boom-bust: " + ch.FigureTitle;
ch.FigureExtras = { @(h) visual.hlegend( ...
    "bottom" ...
    , "Immediate unanticipated" ...
    , "Immediate unanticipated with flat policy rate" ...
    , "Gradual unanticipated" ...
    , "Gradual anticipated 2Y ahead" ...
) };

draw(ch, smc);


