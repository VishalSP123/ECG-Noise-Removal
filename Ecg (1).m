clc; clear; close all;

%% Step 1: Generate Synthetic ECG Signal
fs = 500;               % Sampling frequency (Hz)
t = 0:1/fs:2;           % 2-second time vector

% Synthetic ECG signal (simple sine wave as demo)
ecg_signal = 1.5*sin(2*pi*1*t);  % 1 Hz component to simulate ECG

%% Step 2: Add Noise
noisy_ecg = ecg_signal + 0.5*randn(size(ecg_signal)); % Add random Gaussian noise

%% Step 3: Design Butterworth Bandpass Filter
low_cutoff = 0.5;   % Low cutoff frequency (Hz)
high_cutoff = 40;   % High cutoff frequency (Hz)
order = 4;          % Filter order

[b,a] = butter(order, [low_cutoff high_cutoff]/(fs/2)); % Normalize frequency
filtered_ecg = filter(b, a, noisy_ecg);                 % Apply filter

%% Step 4: Plot and Save Original ECG
figure;
plot(t, ecg_signal, 'g', 'LineWidth', 1.5);
title('Original ECG Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
saveas(gcf, 'Original_ECG.png');  % Save plot as PNG

%% Step 5: Plot and Save Noisy ECG
figure;
plot(t, noisy_ecg, 'r', 'LineWidth', 1.5);
title('Noisy ECG Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
saveas(gcf, 'Noisy_ECG.png');  % Save plot as PNG

%% Step 6: Plot and Save Filtered ECG
figure;
plot(t, ecg_signal, 'g', 'LineWidth', 1.5); hold on;
plot(t, noisy_ecg, 'r');
plot(t, filtered_ecg, 'b', 'LineWidth', 1.5);
legend('Original ECG', 'Noisy ECG', 'Filtered ECG');
title('ECG Signal Noise Removal Using Digital Filter');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
saveas(gcf, 'Filtered_ECG.png');  % Save plot as PNG

%% Step 7: Save Filtered ECG Data as CSV
csvwrite('Filtered_ECG_Data.csv', filtered_ecg');
disp('Filtered ECG data saved as Filtered_ECG_Data.csv');

%% Step 8: Calculate and Display SNR
snr_before = snr(ecg_signal, noisy_ecg - ecg_signal);
snr_after  = snr(ecg_signal, filtered_ecg - ecg_signal);

fprintf('SNR before filtering: %.2f dB\n', snr_before);
fprintf('SNR after filtering: %.2f dB\n', snr_after);

disp('All plots and data saved successfully!');
