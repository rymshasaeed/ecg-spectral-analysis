function ecg_analysis(x, fs, gain, d)
% ARGUMENTS:
%           x: ecg signal
%           fs: sampling frequency
%           gain: signal gain (input 1 if gain is none)
%           d: scalar integer (either 1 or 2) to display graphic windows

% Time duration (s)
time = (0 : numel(x)-1)/fs;

% Adjust scale
x = x/gain;

% Detrend the signal
x = detrend(x);

% Extract ecg signal for a duration of 1 minute
if max(time) > 300
    x = x(1: find(time == 300)-1);
end

% Number of samples
N = numel(x);

% Get time and frequncy vectors
t = (0 : N-1)/fs;
f = (0 : N/2-1)*fs/N;
fn = f/fs;

% Compute DFT and retain samples upto Nyquist frequency i.e. Fs/2
X = fft(x, N); 
X = X(1:N/2);

% Power spectral density
psd = (2*abs(X.^2))/(fs*N);

% Find local Maxima
[~, locs] = findpeaks(x, 'MinPeakProminence', 0.5);

% R-R peaks interval
RR_interval = mean(diff(locs/fs));

% Heartrate
heartrate = 60/RR_interval;

% Percentage of power in each frequency band
vlf = 0.04;
lf = 0.15;
hf = 0.4;    
P_total = bandpower(x, fs, [0 fs/2]);
P_VLF = 100*bandpower(x, fs, [0.003*fs vlf*fs]) / P_total;
P_LF = 100*bandpower(x, fs, [vlf*fs lf*fs]) / P_total;
P_HF = 100*bandpower(x, fs, [lf*fs hf*fs]) / P_total;

% Display graphic windows as per the integer argument 'd'
if d == 2
    % Plot ecg over an interval of 60 seconds
    figure;
    plot(t(1:find(t == 60)), x(1:find(t == 60)))
    grid on
    xlabel('Time (s)')
    ylabel('Voltage (mV)')
    title('ECG sample')
end
if d >= 1
    % Plot PSD estimates to represent power in each freq-band
    figure;
    plot(fn(1:find(fn == vlf)), psd(1:find(fn == vlf)), 'r')
    hold on
    grid on
    plot(fn(find(fn == vlf):find(fn == lf)), psd(find(fn == vlf):find(fn == lf)), 'g')
    plot(fn(find(fn == lf):find(fn == hf)), psd(find(fn == lf):find(fn == hf)), 'b')
    legend(['Very low freq components [P = ' num2str(P_VLF, '%.2f'), '%]'],...
           ['Low freq components [P =' num2str(P_LF, '%.2f'), '%]'],...
           ['High freq components [P =' num2str(P_HF, '%.2f'), '%]'])
    xlabel('Normalized Frequency (cycles/sample)')
    ylabel('PSD (mV^2/Hz)')
    title(['Heartrate: ', num2str(heartrate, '%.1f') ' beats per minute'])
end
end