clc 
clear all
%This is the final project submission for the subject ENPM-667 and group
%members are Rishikesh Jadhav(119256534) and Nishant Pandey(119247556)

M=1000;
m1=100;m2=100;
l1=20;l2=10;
g=10;

%%State Space form of the System
%%%%%%%% X = A*x +B*u%%%%%%%%%%%
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
  %% Initial Value Conditions
  % 1. Initial Value Conditions are arbitrary
  % 2. Angular Velocity and the Liner velocity and Position are Assumed to
  % Be zero
  % Pendulam initial positions are 15*pi/180 and %10*Pi/180
  
  X=[0,0,15*pi/180,0,20*pi/180,0];
  t=0:0.01:150;
  dim_t= size(t);
  F = zeros(dim_t);
 
  %Defining The Parameters of the State for Visualization
  States={'x' 'x_dot' 'theta1' 'theta1_dot' 'theta2' 'theta2_dot'};
  input={'F'};
  Outputs = {'x'; 'alpha1'; 'alpha2'};
  
  %State
  sys=ss(A,B,C,0,'statename',States,'inputname',input,'outputname',Outputs);
  [Y, t_T, X_T] = lsim(sys, F, t, X);
  
  %% Visualization

  figure,
  plot(t, Y(:,1),'r-.');
  xlabel('Time'); ylabel('Crane Position');

  figure,
  plot(t, Y(:,2),'g-');
  xlabel('Time'); ylabel('Pendulum Angle1');

  figure,
  plot(t, Y(:,3),'b-');
  xlabel('Time'); ylabel('Pendulum Angle2');

  