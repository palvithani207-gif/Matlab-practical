% 1.Write a matlab code to verify the discrete time signal is linear or % non-linear.

clc;
close all;
clear all;
n=1:50;
x1=[1,0,-1,2];
x2=[1,-1,1,-1];
a=input('enter the value of multiplier of a:- ');
b=input('enter the value of multiplier of b:- ');
x=a*x1+b*x2;
y=2.^x ; %y=2^x
y1=2.^x1; %y1=2^x1
y2=2.^x2; %y2=2^x2
y_n=a*y1+b*y2 ;
figure();
stem(y);
xlabel("sample");
ylabel("amplitude");
title("case 1");
figure();
stem(y_n);
xlabel("sample");
ylabel("amplitude");
title("case 2");
tolerance=0.0001;
if(abs(y-y_n)<=tolerance)
    then
    disp('the system is linear');
else
    disp('the system is non linear');
end;
% time delay
x=[1,0,-1,2];
k=input('enter the value of delay:- ');
x3=[zeros(1,k) x];
y3=2.^x3; %y(n,k)(output with delayed input)
yt=2.^x;
figure();
stem(y3);
xlabel("sample");
ylabel("amplitude");
title("output with delayed input");
y4=[zeros(1,k) yt]; %y(n-k)(delayed output);
figure();
stem(y4);
xlabel("sample");
ylabel("amplitude");
title("delayed output");
tolerance=0.0001;
if(abs(y3-y4)<=tolerance)
    then
    disp('the system is time invariant');
else
    disp('the system is time variant');
end;
% 2.Write a matlab code to verify the discrete time signal is energy or not.

x1=[1,-1,2,-2,3];
E=sum(abs(x1).^2);
disp(E);

% stability

if(E<inf)
    disp('the system is stable');
else
    disp('the system is unstable');
end;

% 3.Write a matlab code to detect the even and odd component of the
% discrete time signal

figure()
x2=[2,-2,3,4];
xe=(x+x(end:-1:1))/2;
xo=(x-x(end:-1:1))/2;
subplot(1,3,1);
stem(x2);
subplot(1,3,2);
stem(xe);
subplot(1,3,3);
stem(xo);
