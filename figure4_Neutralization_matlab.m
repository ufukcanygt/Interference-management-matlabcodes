clc; clear; close all;

%% 1. Kanal matrislerini tanımla (2x2)
H1 = randn(2,2) + 1i*randn(2,2);   % Tx1 → Rx
H2 = randn(2,2) + 1i*randn(2,2);   % Tx2 → Rx

%% 2. Parazit sinyali (örnek QPSK gibi)
x = 1 + 1i;

%% 3. W1 beamforming vektörü (rastgele ama normalize)
W1 = randn(2,1) + 1i*randn(2,1);
W1 = W1 / norm(W1);

%% 4. W2 beamforming vektörü (W1’e göre nötrleme)
W2 = -pinv(H2) * H1 * W1;

%% 5. Her bir parazit vektörünü hesapla
v1 = H1 * W1 * x;   % Tx1 paraziti
v2 = H2 * W2 * x;   % Tx2 paraziti

%% 6. Toplam parazit
v_total = v1 + v2;
interference_power = norm(v_total)^2;

fprintf("Toplam parazit gücü: %.6f\n", interference_power);

%% 7. Grafik: Vektörlerin yönünü ve nötrlemeyi göster
vec1 = sum(v1);       % Kırmızı
vec2 = sum(v2);       % Mavi
vec_total = vec1 + vec2;  % Toplam (siyah kesik)

figure;
hold on; grid on; axis equal;

% Her vektörü (0,0)'dan başlat
quiver(0, 0, real(vec1), imag(vec1), 0, 'r', 'LineWidth', 2, 'DisplayName','H_1 W_1');
quiver(0, 0, real(vec2), imag(vec2), 0, 'b', 'LineWidth', 2, 'DisplayName','H_2 W_2');
quiver(0, 0, real(vec_total), imag(vec_total), 0, 'k--', 'LineWidth', 1.5, 'DisplayName','Toplam Vektör');

xlabel('Gerçek Eksen'); ylabel('Sanal Eksen');
title(['Interference Neutralization: Toplam Parazit Gücü = ', num2str(interference_power, '%.2e')]);
legend;
xlim([-2 2]); ylim([-2 2]);
