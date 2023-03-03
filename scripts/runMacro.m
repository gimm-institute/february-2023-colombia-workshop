
close all
clear

load mat/createMacro.mat n

endHist = qq(2022,3);
startScen = endHist + 1;
endScen = endHist + 5*4;

h = databank.fromSheet("data/model-data.csv");

s = simulate( ...
    n, h, startScen:endScen ...
    , "prependInput", true ...
    ... , "method", "stacked" ...
);

