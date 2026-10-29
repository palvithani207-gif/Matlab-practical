clc;
close all;
clear all;
T = 2*pi;
omega = 2*pi/T;
t = linspace(0,4*pi,1000); 
N = 1000; % Harmonics 
sq_wave = zeros(size(t)); 
for n = 1:2:N sq_wave = sq_wave + 4/(n*pi)*sin(n*omega*t);
    plot(t,sq_wave); 
    hold on; 
    pause(2); 
end 
figure(); 
plot(t,sq_wave); 
title("fourier series rectangular wave");