%{

* Look up the name of a portfolio default rate shock

* Create a model with no macro feedback
  Switch off parameters on new_rl_full_spread_gap
  in macroLocal.model

* Simulate a future PDR shock (t+4) 0.01 twice:
  anticipated vs unanticipated

* Plot new_rl, rl

%}

close all
clear

load mat/createModel.mat m

m1 = m;
m1.c3_y_gap = 0;
m1.c1_prem = 0;
checkSteady(m1);
m1 = solve(m1);

d = databank.forModel(m1, 1:40);
d.shock_q_hh(5) = 0.01;

sa = simulate( ...
    m, d, 1:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "anticipate", true ...
);

su = simulate( ...
    m, d, 1:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "anticipate", false ...
);

tiledlayout(4, 4);

nexttile();
plot(0:40, [sa.q_hh, su.q_hh]);

nexttile();
plot(0:40, [sa.new_rl_hh, su.rl_hh]);

