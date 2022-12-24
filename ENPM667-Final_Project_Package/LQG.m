clc 
clear all

%This is the final project submission for the subject ENPM-667 and group
%members are Rishikesh Jadhav(119256534) and Nishant Pandey(119247556)

M=1000;
m1=100;m2=100;
l1=20;l2=10;
g=10;

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
  
%% Considering FeedBack Control for the State x(t)
C1=[1 0 0 0 0 0];
Q=diag([50 1500 50000 1200 50000 80000]);
R=0.01;
disp(' State FeedBack')
%State FeedBack 'K'
K=lqr(A,B,Q,R);
%size(K)
disp(K)


Poles=[-1 -2 -3 -4 -5 -6];
L1=place(A',C1',Poles)';

%Kalman Estimator
stat_space= ss(A,[B B],C,0);
R1=0.01; Q1=0.05;
sensors=[1];
W=[1];
[~,L,~]=kalman(stat_space,Q1,R1,[],sensors,W);

 %Defining The Parameters of the State for Visualization
States={'x' 'x_dot' 'theta1' 'theta1_dot' 'theta2' 'theta2_dot','e_1','e_2','e_3','e_4','e_5','e_6'};
input={'F'};
Outputs = {'x'};
 
A_L1=[(A-B*K) (B*K)
    zeros(6,6) (A-L1*C1)];
B_L1=[B
    zeros(size(B))];
C_L1=[C1 zeros(size(C1))];
stat_space2=ss(A_L1,B_L1,C_L1,0,'statename',States,'inputname',input,'outputname',Outputs);


X=[0;0;45*pi/180;0;35*pi/180;0;0;0;0;0;0;0];
t = 0:0.01:150;
dim_t= size(t);
F = zeros(dim_t);
[Y, t_T, X_T] = lsim(stat_space2, F, t, X);

figure(1) 
plot(t,Y(:,1),'r-.')
ylabel('Cart Position')
xlabel('Time(sec)')

