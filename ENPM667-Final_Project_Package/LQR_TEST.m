
clc 
clear all

%This is the final project submission for the subject ENPM-667 and group
%members are Rishikesh Jadhav(119256534) and Nishant Pandey(119247556)

% Defining the Variables
m1 = 100; m2 = 100; M = 1000;
l1 = 20; l2 = 10;
g = 9.81;

%% Substituting the Values of Different Parameters in Matrices

A = [0 1 0 0 0 0;
     0 0 (-(m1*g)/M) 0 (-(m2*g)/M) 0;
     0 0 0 1 0 0;
     0 0 (-(M+m1)*g/(M*l1)) 0 (-(m2*g)/(M*l1)) 0;
     0 0 0 0 0 1;
     0 0 (-(m1*g)/(M*l2)) 0 (-(M+m2)*g/(M*l2)) 0];

B = [0;
     1/M;
     0;
     1/(M*l1);
     0;
     1/(M*l2)];

C = [1 0 0 0 0 0;
     0 0 1 0 0 0;
     0 0 0 0 1 0];
 
D = 0;

%% Choosing the Values of Q & R

Q = (C')*(C);

% Assigning the Values in Q using Trial & Error Method

Q(1,1) = 70000000;
Q(3,3) = 8000000000;
Q(5,5) = 9000000000;

% Selecting the Ideal Value of R 

R = 1;

%% Designing the LQR 

% Calculating the Optimal Gain Matrix K

K = lqr(A, B, Q, R);

% Calculating the New Value of A using K

ANew = (A - (B*K));

% Creating the Observability Matrix

States = {'x' 'x_dot' 'theta1' 'theta1_dot' 'theta2' 'theta2_dot'};
Inputs = {'r'};
Outputs = {'x'; 'phi1'; 'phi2'};

% Creating the State Space Model

ClosSS = ss(ANew, B, C, D,'statename', States, 'inputname', Inputs, 'outputname', Outputs);

%% Initializing Conditions

X0 = [0;
      0;
      10*pi/180;
      0;
      15*pi/180;
      0];
   
t = 0:0.01:150;

Temp = size(t)
F = zeros(Temp);

% Simulating the Time Response of Dynamic System to Arbitrary Inputs

[Y, tTemp, XTemp] = lsim(ClosSS, F, t, X0);


%% Plotting the Output

figure,
plot(t, Y(:,1),'r-.');
xlabel('Time'); ylabel('Crane Position');

figure,
plot(t, Y(:,2),'g-');
xlabel('Time'); ylabel('Pendulum Angle-1');

figure,
plot(t, Y(:,3),'b-');
xlabel('Time'); ylabel('Pendulum Angle-2');