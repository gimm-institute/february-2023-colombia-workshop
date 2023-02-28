
%{

# Simulate the creation of conservation buffers

%}


%% Clear the workspace

close all
clear
load mat/createModel.mat m


%% Design the simulation

m = steady(m);
m = solve(m);

m1 = m;
m1.ss_car_min = m1.ss_car_min + 2.5/100;
m1.c0_car_min = 0;

m2 = m;
m2.ss_car_min = m2.ss_car_min + 2.5/100;
m2.c0_car_min = 0.8;

m1 = steady(m1);
checkSteady(m1);
m1 = solve(m1);

m2 = steady(m2);
checkSteady(m2);
m2 = solve(m2);


%% Run simulations

d0 = databank.forModel(m, -10:40);


% Immediate unanticipated increase
d1 = d0;
s1 = simulate( ...
    m1(1), d1, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
);


% Immediate unanticipated increase with flat policy rate
p = Plan.forModel(m, 1:40);
p = swap(p, 1:8, ["r", "shock_r"]);
d2 = d0;
s2 = simulate( ...
    m1, d2, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p ...
);


% Gradual increase
d3 = d0;
s3 = simulate( ...
    m2, d3, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
);


% Gradual announced/anticipated increase starting at beginning of year 3
p = Plan.forModel(m, 1:40);
p = swap(p, 1:8, ["car_min", "shock_car_min"]);
d4 = d0;
s4 = simulate( ...
    m2, d4, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p ...
);


%% Simulation minus control databanks

% s = databank.merge("horzcat", s1, s2, s3, s4);
s = databank.merge("horzcat", s1, s3, s4);
smc = databank.minusControl(m, s, d0);


%% Chartpack

ch = defineChartpack();
ch.Range = 0:40;
ch.FigureTitle = "Asset price and credit boom-bust: " + ch.FigureTitle;
ch.FigureExtras = { @(h) visual.hlegend( ...
    "bottom" ...
    , "Immediate unanticipated" ...
    ... , "Immediate unanticipated with flat policy rate" ...
    , "Gradual unanticipated" ...
    , "Gradual anticipated 2Y ahead" ...
) };

draw(ch, smc);


