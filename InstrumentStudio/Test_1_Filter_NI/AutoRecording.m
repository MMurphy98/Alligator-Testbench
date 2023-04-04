%% Initial
clear;
clc

%% Parameters Setup and reading data
M = 70000;                      % record length
Fs = 10E6;                      % sample rate
pathname = 'Instrument_Capture_2023_861k_2.csv';   % data file
outputfile = 'Recording.xlsx';  % output file

wave_data = readmatrix(pathname);
vout = wave_data(1:M,1) - wave_data(1:M,2);
clear wave_data

%% Calculate THD and Generate output 

 % use kaisr-38 to calculate thd and plot spectrum
[r,harmpow,harmfreq] = thd(vout, Fs, 9, 'aliased');
figure
thd(vout, Fs, 9, 'aliased');

%% Display results
Time = datetime('now', 'InputFormat','dd-MMM-uuuu HH:mm:ss');
Frequency = harmfreq(1);
Amplitude = (max(vout) - min(vout))/2;
THD = r;
HD = harmpow(1:3);

data_table = table(Time,string(pathname),Frequency,Amplitude,...
    THD,HD(1),HD(2),HD(3),...
    'VariableNames',{'Time', 'File', 'Frequency', 'Amplitude', ...
    'THD','HD1', 'HD2', 'HD3'});

writetable(data_table, 'Recording.xlsx', ...
    'Sheet', 'Sheet1', 'WriteMode', 'append')

display(data_table)





