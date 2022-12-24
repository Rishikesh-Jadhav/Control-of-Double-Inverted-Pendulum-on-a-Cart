clc
clear all

%This is the final project submission for the subject ENPM-667 and group
%members are Rishikesh Jadhav(119256534) and Nishant Pandey(119247556)

% M=1000;
% m1=100;m2=100;
% l1=20;l2=10;
% g=10;

syms g m1 m2 l1 l2 M

%% State Space form of the System X = A*x +B*u

A=[0 1 0 0 0 0
    0 0 (-g*m1)/M 0 (-g*m2)/M 0
    0 0 0 1 0 0
    0 0 (-g*(m1+M))/(M*l1) 0 (-g*m2)/(M*l1) 0
    0 0 0 0 0 1
    0 0 (-g*m1)/(M*l2) 0 (-g*(m2+M))/(M*l2) 0 ];
    
%size(A)
B=[ 0
    1/M
    0
    1/(M*l1)
    0
    1/(M*l2)];

C= [ 1 0 0 0 0 0 
      0 0 1 0 0 0
      0 0 0 0 1 0];
  
 % Check for Controllability
disp('Checking Controllabilitiy') 

% Using the generalized form rank([B B*A B*A^2 B*A^3 B*A^4 B*A^5])=size(A)

rank_check=([B A*B (A^2)*B (A^3)*B (A^4)*B (A^5)*B])
det(rank_check)
