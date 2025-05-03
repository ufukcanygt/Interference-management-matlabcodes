clc; clear; close all;

%% 1. Kanal tanımları (2 antenli sistem)
H_desired = randn(2,1) + 1i*randn(2,1);   % İstenen sinyal kanalı
H_interf  = randn(2,1) + 1i*randn(2,1);   % Parazit sinyal kanalı

%% 2. MMSE temelli beamforming vektörü (interference mitigation)
R_interf = H_interf * H_interf';        % Parazit kovaryans matrisi
I = eye(2);                             % Gürültü kovaryansı (beyaz gürültü)
w_rx = (R_interf + I) \ H_desired;      % MMSE çözüm
w_rx = w_rx / norm(w_rx);              % Normalize et

%% 3. SINR hesapla
signal_power = abs(w_rx' * H_desired)^2;
interf_power = abs(w_rx' * H_interf)^2;
SINR = signal_power / interf_power;
SINR_dB = 10 * log10(SINR);
fprintf("SINR: %.2f dB\n", SINR_dB);

%% 4. Grafik için vektörleri çizime uygun hale getir
vec_d = sum(H_desired);   % Tüm yönü temsil etsin
vec_i = sum(H_interf);
vec_w = sum(w_rx);

figure;
hold on; grid on; axis equal;

% Vektörlerin çizimi
quiver(0, 0, real(vec_d), imag(vec_d), 0, 'r', 'LineWidth', 2, 'DisplayName','H_{desired}');
quiver(0, 0, real(vec_i), imag(vec_i), 0, 'b', 'LineWidth', 2, 'DisplayName','H_{interf}');
quiver(0, 0, real(vec_w), imag(vec_w), 0, 'k--', 'LineWidth', 2, 'DisplayName','w_{rx}');

xlabel('Gerçek Eksen'); ylabel('Sanal Eksen');
title(['Interference Mitigation via Beamforming — SINR: ', num2str(SINR_dB, '%.2f'), ' dB']);
legend;
xlim([-1 1]); ylim([-1 1]);
