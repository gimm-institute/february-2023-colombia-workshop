

close all
clear

h = struct();


%% CO macro

co = databank.fromSheet("imf-macro-quarterly.csv");

scale = 1e-14;
h.y = co.NGDP_R_SA_XDC * scale;
h.ny = co.NGDP_SA_XDC * scale;
h.cpi = x13.season(co.PCPI_IX / 100, autoMdl=true);
h.r = co.FIMM_PA / 400;
h.e = co.ENDA_XDC_USD_RATE / 1000;


%% US macro

us = databank.fromSheet( ...
    ["CPIAUCSL.csv", "GDPC1.csv", "TB3MS.csv"]  ...
    , isDateColumn=@(n) n=="DATE" ...
    , frequencyFromHeader=@(varargin) Frequency.MONTHLY ...
    , includeComments=false ...
);


h.yw = convert(us.GDPC1, Frequency.QUARTERLY, select=1) * 1e-4;
h.rw = convert(us.TB3MS, Frequency.QUARTERLY) / 400;
h.cpiw = convert(us.CPIAUCSL, Frequency.QUARTERLY) / 100;

h = databank.clip(h, qq(2000,1), Inf);


%% Banking

d = databank.fromSheet( ...
    "Data workshop - Colombia.xlsx" ...
    , isDateColumn=@(n) n=="Date" ...
    , frequencyFromHeader=@(varargin) Frequency.QUARTERLY ...
    , includeComments=false ...
    , targetNames=@(n) regexprep(n, "\W", "_") ...
);

scale = 1e-11;

h.tna = d.Assets * scale;
h.l = d.Total_gross_loans * scale;
h.le = d.Total_net_loans * scale;

% h.lp = d.Total_performing_loans * scale;
h.ln = d.Total_non_performing_loans * scale;
h.bk = d.Balance_sheet_capital * scale;
h.rwa = d.Risk_weighted_assets * scale;
% h.woff = replaceData(d.Write_offs, [0, NaN]) * scale;

h.car = d.Capital_adequacy_ratio;
h.bg = h.car * h.rwa;
h.rbk = d.Pre_tax_return_on_equity / 4;
h.new_rl = d.New_lending_rates / 4;
h.rd = d.Average_funding_rates / 4;

h.car_min = d.CAR_limit + fillMissing(d.Buffer, getRange(d.CAR_limit), 0);

databank.toSheet(h, "../data/model-data.csv");


