
clc;
clear;
close all;

% DIRECT FORM I vs DIRECT FORM II

% 1. System coefficients
N = 20;
x = [1 zeros(1,N-1)];
n = 0:N-1;

% 2. Direct Form I
y1 = zeros(1,N);

for k = 1:N
    y1(k) = x(k);

    if k > 1
        y1(k) = y1(k) + 2*x(k-1) + 0.5*y1(k-1);
    end

    if k > 2
        y1(k) = y1(k) - 0.25*y1(k-2);
    end
end

% 3. Direct Form II
w = zeros(1,N);
y2 = zeros(1,N);

for k = 1:N
    w(k) = x(k);

    if k > 1
        w(k) = w(k) + 0.5*w(k-1);
    end

    if k > 2
        w(k) = w(k) - 0.25*w(k-2);
    end

    y2(k) = w(k);

    if k > 1
        y2(k) = y2(k) + 2*w(k-1);
    end
end

% 4. Verify using filter()
b = [1 2];
a = [1 -0.5 0.25];
ycheck = filter(b,a,x);

fprintf('DF-I verification error: %.8f\n',max(abs(y1-ycheck)));
fprintf('DF-II verification error: %.8f\n',max(abs(y2-ycheck)));

% 5. Simplified fixed-point quantization
Q = 128;
y1q = zeros(1,N);
wq = zeros(1,N);
y2q = zeros(1,N);

for k = 1:N
    % Direct Form I
    y1q(k) = x(k);

    if k > 1
        y1q(k) = y1q(k) + 2*x(k-1) + 0.5*y1q(k-1);
    end

    if k > 2
        y1q(k) = y1q(k) - 0.25*y1q(k-2);
    end

    y1q(k) = round(y1q(k)*Q)/Q;

    % Direct Form II
    wq(k) = x(k);

    if k > 1
        wq(k) = wq(k) + 0.5*wq(k-1);
    end

    if k > 2
        wq(k) = wq(k) - 0.25*wq(k-2);
    end

    wq(k) = round(wq(k)*Q)/Q;
    y2q(k) = wq(k);

    if k > 1
        y2q(k) = y2q(k) + 2*wq(k-1);
    end

    y2q(k) = round(y2q(k)*Q)/Q;
end

% 6. Quantization errors
e1 = abs(y1-y1q);
e2 = abs(y2-y2q);

fprintf('\nMaximum quantization errors:\n');
fprintf('Direct Form I  = %.6f\n',max(e1));
fprintf('Direct Form II = %.6f\n',max(e2));

% 7. Plots
figure;

subplot(2,2,1);
stem(n,y1,'b','filled');
hold on;
stem(n,y2,'r');
hold off;
title('Direct Form I vs II');
xlabel('Sample n');
ylabel('Output');
legend('DF-I','DF-II');
grid on;

subplot(2,2,2);
stem(n,ycheck,'filled');
title('Impulse Response (filter)');
xlabel('Sample n');
ylabel('Amplitude');
grid on;

subplot(2,2,3);
stem(n,e1,'b','filled');
hold on;
stem(n,e2,'r');
hold off;
title('Quantization Error');
xlabel('Sample n');
ylabel('Absolute Error');
legend('DF-I','DF-II');
grid on;

subplot(2,2,4);
bar([4 2]);
set(gca,'XTickLabel',{'Direct Form I','Direct Form II'});
title('Number of Delay Elements');
ylabel('Delays');
grid on;

% 8. Component comparison
fprintf('\nHardware comparison:\n');
fprintf('Direct Form I: 4 delays\n');
fprintf('Direct Form II: 2 delays\n');
fprintf('Both use 3 non-unity multipliers and 3 adders.\n');
