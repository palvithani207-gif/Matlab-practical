clc;

close all;

clear all;

function y = Conv_user(x,h)
l1 = length(x);
l2 = length(h);
l3 = l1+l2-1;
x1 = [x, zeros(1,l2)];
h1 = [h, zeros(1,l1)];
y = [zeros(1,l3)];
for n = 1:l3 
    sum = 0;
    for k = 1:n
        sum = sum + x1(k)*h1(n - k + 1);
    end;
    y(n) = sum;
end;
end;

s1 = input("Enter first signal: ");
s2 = input("Enter second signal: ");

y = Conv_user(s1,s2);

figure;

subplot(3,1,1);

stem(s1);

xlabel("sample");

ylabel("amplitude");

title("rectangular signal");

subplot(3,1,2);

stem(s2);

xlabel("sample");

ylabel("amplitude");

title("triangular signal");

subplot(3,1,3);

stem(y);

xlabel("sample");

ylabel("amplitude");

title('RESULT OF CONVOLUTION');