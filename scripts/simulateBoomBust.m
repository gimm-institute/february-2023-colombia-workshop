%% Simulate boom-bust in asset prices and credit 


%% Clear the workspace

close all
clear
load mat/createModel.mat m


%% Design the simulation

m.c1_y_gap = 0.02;
m.c3_y_gap = 0.16;
m.c1_roc_y_tnd = 0.001;
m.c1_fwy = 0.01;
m.c1_bk = 0.5;

m.c2_q_hh = 0.019;
m.c5_q_hh = 4/100;

m.c1_z_hh = 0.50;
m.c2_q_hh = 0.019;

m = steady(m);
checkSteady(m);
m = solve(m);

d0 = databank.forModel(m, -10:40);

%% Boom (asset prices, credit demand)

T = 12;
d1 = d0;
d1.shock_fwy_bubble(1:T) = log(1.03);
d1.shock_ivy_tnd_hh(1:T) = log(1.03);


s1 = simulate( ...
    m, d1, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
);


%% Boom with CCY buffers

p2 = Plan.forModel(m, 1:40);
p2 = swap(p2, 1:T, ["car_min", "shock_car_min"]);

d2 = d1;
d2.car_min(0:T) = linspace(m.car_min, m.car_min+2.5/100, T+1);

s2 = simulate( ...
    m, d2, 1:40 ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p2 ...
);


%% Bust

p3 = Plan.forModel(m, T+1:40);
p3 = swap(p3, T+1, ["fwy_bubble", "shock_fwy_bubble"]);
p3 = swap(p3, T+1, ["ivy_tnd_hh", "shock_ivy_tnd_hh"]);

d3 = s1;
d3.fwy_bubble(T+1) = 1;
d3.ivy_tnd_hh(T+1) = real(m.ivy_hh);

s3 = simulate( ...
    m, d3, T+1:40 ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p3 ...
);


%% Bust with CCY buffers

p4 = p3;
p4 = swap(p4, T+1, ["car_min", "shock_car_min"]);

d4 = s2;
d4.fwy_bubble(T+1) = 1;
d4.ivy_tnd_hh(T+1) = real(m.ivy_hh);
d4.car_min(T+1) = m.ss_car_min;

s4 = simulate( ...
    m, d4, T+1:40 ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p4 ...
);

%% Bust with CCY buffers, late response

p5 = Plan.forModel(m, T+1:40, "anticipate", false);
p5 = swap(p5, T+1, ["fwy_bubble", "shock_fwy_bubble"]);
p5 = swap(p5, T+1, ["ivy_tnd_hh", "shock_ivy_tnd_hh"]);
p5 = swap(p5, T+4, ["car_min", "shock_car_min"]);

d5 = s2;
d5.fwy_bubble(T+1) = 1;
d5.ivy_tnd_hh(T+1) = real(m.ivy_hh);
d5.car_min(T+4) = m.ss_car_min;

s5 = simulate( ...
    m, d5, T+1:40 ...
    , prependInput=true ...
    , method="stacked" ...
    , plan=p5 ...
);


%% Simulation minus control databanks

smc1 = databank.minusControl(m, s1, d0);
smc2 = databank.minusControl(m, s2, d0);
smc3 = databank.minusControl(m, s3, d0);
smc4 = databank.minusControl(m, s4, d0);
smc5 = databank.minusControl(m, s5, d0);



%% Chartpack

ch = defineChartpack();

ch.FigureTitle = "Asset price and credit boom-bust: " + ch.FigureTitle;
ch.Range = 0:40;
ch.Highlight = 0:T;

draw(ch, databank.merge("horzcat", smc3, smc4, smc5));





%% Save results to MAT file for further use

save mat/simulateBoomBust.mat m T s1 s2 s3 s4 smc1 smc2 smc3 smc4


