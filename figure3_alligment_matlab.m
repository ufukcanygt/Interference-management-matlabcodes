clc; clear; close all;

%% 1. Kanal matrislerini oluştur (2x2)
H12 = randn(2,2) + 1i*randn(2,2);
H13 = randn(2,2) + 1i*randn(2,2);

%% 2. Manuel olarak kırmızı vektör belirle (görünür olsun)
aligned_direction = [0.3 + 0.4i; -0.5 + 0.1i];  % elle belirlenmiş kırmızı yön

%% 3. W2 ve W3 beamforming vektörlerini bu yöne göre hesapla
W2 = pinv(H12) * aligned_direction;
W2 = W2 / norm(W2);  % normalize (isteğe bağlı)

W3 = pinv(H13) * aligned_direction;
W3 = W3 / norm(W3);

%% 4. Gerçek yönleri yeniden hesapla (kontrol için)
v1 = H12 * W2;
v2 = H13 * W3;

% normalize for angle check
v1n = v1 / norm(v1);
v2n = v2 / norm(v2);

%% 5. Açı hesapla
dot_prod = real(v1n' * v2n);
angle_rad = acos(dot_prod / (norm(v1n)*norm(v2n)));
angle_deg = rad2deg(angle_rad);

fprintf("Parazit hizalama açısı: %.2f° (≈0° ise hizalama başarılı)\n", angle_deg);

%% 6. Grafik (kırmızı garanti görünecek!)
vec1 = sum(v1);
vec2 = sum(v2);

figure;
hold on; grid on; axis equal;

quiver(0, 0, real(vec1), imag(vec1), 0, 'r', 'LineWidth', 2, 'DisplayName','H_{12}W_{2}');
quiver(0, 0, real(vec2), imag(vec2), 0, 'b', 'LineWidth', 2, 'DisplayName','H_{13}W_{3}');

xlim([-1 1]); ylim([-1 1]);
xlabel('Gerçek Eksen'); ylabel('Sanal Eksen');
legend;
title(['Interference Alignment - Açı: ', num2str(angle_deg, '%.2f'), '°']);

