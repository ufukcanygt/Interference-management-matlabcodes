clc; clear; close all;

%% 🔹 1. Kanal Vektörleri Oluştur (2x1 Kompleks)
H_desired = randn(2,1) + 1i*randn(2,1);    % İstenen sinyal kanalı
H_interf  = randn(2,1) + 1i*randn(2,1);    % Parazit sinyal kanalı

%% 🔹 2. Nulling için Beamforming Vektörü Hesapla
w_null = null(H_desired');                % H_desired'a dik yön
w_null = w_null / norm(w_null);          % Normalize et

%% 🔹 3. Parazitin İstenene Etkisini Ölç
impact = H_desired' * w_null;
fprintf('Parazitin istenen sinyale etkisi: %.6f + %.6fi\n', real(impact), imag(impact));

%% 🔹 4. Gerçek Açı Hesapla (0–180° arası)
dot_prod = real(H_desired' * w_null);    % Gerçek iç çarpım
angle_rad = acos(dot_prod / (norm(H_desired) * norm(w_null)));
angle_deg = rad2deg(angle_rad);
fprintf('Gerçek açı (derece): %.2f°\n', angle_deg);

%% 🔹 5. Grafik: Kompleks Düzlemde Vektörleri Göster
vec1 = H_desired / norm(H_desired);   % normalize edilmiş H_desired
vec2 = w_null;                        % normalize edilmiş w_null

figure;
hold on; grid on; axis equal;

% H_desired vektörü (kırmızı düz + kesikli)
quiver(0, 0, real(vec1(1)), imag(vec1(1)), 0, 'r', 'LineWidth', 2, 'DisplayName','H_{desired}(1)');
quiver(0, 0, real(vec1(2)), imag(vec1(2)), 0, 'r--', 'LineWidth', 2, 'HandleVisibility','off');

% w_null vektörü (mavi düz + kesikli)
quiver(0, 0, real(vec2(1)), imag(vec2(1)), 0, 'b', 'LineWidth', 2, 'DisplayName','w_{null}(1)');
quiver(0, 0, real(vec2(2)), imag(vec2(2)), 0, 'b--', 'LineWidth', 2, 'HandleVisibility','off');

legend;
xlabel('Gerçek Eksen'); ylabel('Sanal Eksen');
title(['Interference Nulling - Açı: ', num2str(angle_deg, '%.2f'), '°']);
