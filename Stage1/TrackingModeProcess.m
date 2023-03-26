function [Data, THD, Distortion] = TrackingModeProcess(Pathname, L, Fi, Fs)
% 根据xlsx文件批量处理采样数据计算THD
%   Input：
%       Pathname: the file(.xlsx) stored the data;
%       L: the length of sample points;
%       Fi: input frequency;
%       Fs: sample rate;
%   Output:
%       Data: data table in phase-order;
%       THD: Total distortion;
%       Distortion: distortion table;
%   Plot:
%       Wave: data wave in time sequency;
%       Spectrum: distortion information in frequency domain;
% reading data from .xlsx file and resort
    wave_data = readmatrix(Pathname);
    vout = wave_data(1:L,1) - wave_data(1:L,2);
    Data = PhaseOrder(vout, Fi, Fs);
   
% calculate the distortion
    [THD,harmpow,harmfreq] = thd(vout, Fs, 9, 'aliased');
    [pxx, f] = periodogram(vout, kaiser(L, 38), L, Fs, 'onesided', 'power');
    Distortion = table(harmfreq, harmpow, ...
        'VariableNames',{'Frequency', 'Power'});

%% Generate plot figure
    % Wave
    figure("Name",'Wave');
    plot(vout, ":");
    hold on
    plot(Data.Value);
    hold off
    xlabel("Sampled Point");
    ylabel("Value");
    legend(["Original Data", "Sorted Data"], "Location","northeast");
    title(Pathname)

    % Spectrum
    figure("Name",'Spectrum');
    semilogx(f, pow2db(pxx));
    grid on;
    xlabel("Frequency (Hz)");
    ylabel("Power (dB)");
    title(Pathname)
end