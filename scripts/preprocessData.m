
%% Preprocess macro and banking data for model

close all
clear


%% Load raw data file

h = databank.fromSheet("data/model-data.csv");


%% Macro data transformations and filtering

% Foreign real short rate, backward looking inflation
h.rrw_bkw = (1 + h.rw) / roc(h.cpiw) - 1;

% Foreign output trend and gap
[h.yw_tnd, h.yw_gap] = hpf(h.yw, "log", true);

% Foreign real short rate trend and gap
h.rrw_bkw_tnd = hpf(h.rrw_bkw, "lambda", 3000, "change", Series(getEnd(h.rrw_bkw), 0));


% GDP deflator
h.py = h.ny / h.y;

% CPI based real exchange rate
h.re = h.e * h.cpiw / h.cpi;

% Real short rate, backward looking inflation
h.rr_bkw = (1 + h.r) / roc(h.cpi) - 1;

% Real output trend and gap
[h.y_tnd, h.y_gap] = hpf(h.y, "log", true);

% Real short rate trend and gap
h.rr_bkw_tnd = hpf(h.rr_bkw, "lambda", 3000, "change", Series(getEnd(h.rr_bkw), 0));

% Real exchange rate trend and gap
[h.re_tnd, h.re_gap] = hpf(h.re, "log", true);


%% Banking data transformations and filtering

% Effective risk weights
h.riskw = h.rwa / h.tna;

% Allowances
h.a = h.l - h.le;

% Other net assets
h.ona = h.tna - h.le;

% Performing loans
h.lp = h.l - h.ln;

% Gross loans to GDP ratio
h.l_to_4ny = h.l / (4 * h.ny);

% Gross loans to GDP ratio trend and gap
h.l_to_4ny_tnd = hpf(h.l_to_4ny, "lambda", 3000, "change", Series(getEnd(h.l_to_4ny), 0));


%% Rates of change

names = ["y", "y_tnd", "ny", "l", "cpi", "py", "re", "re_tnd", "cpiw"];

h = databank.apply(h, @roc, "sourceNames", names, "targetNames", "roc_"+names);
h = databank.apply(h, @apct, "sourceNames", names, "targetNames", "apct_"+names);


