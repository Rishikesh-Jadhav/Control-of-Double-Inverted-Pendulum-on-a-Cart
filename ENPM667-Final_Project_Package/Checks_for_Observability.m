clc
clear all

syms x1 x1_dot t1 t1_dot t2 t2_dot

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

Order_of_A=6;

%% Checks for Different Cases

%Case 1 for x(t)

disp('Observability check for Case1-x(t)')

C1=[1 0 0 0 0 0];
% Check1=rank([C1;C1*A;C1*(A^2);C1*(A^3);C1*(A^4);C1*(A^5)])
Check1=Observability(C1,A)

disp('Observability check for Case1-x(t)')

if Check1==Order_of_A
    disp('System is Observable for x(t)')
else
    disp('System is not Observable for the expected Output')
end

%Case 2 for (t1,t2)

C2=[0 0 1 0 0 0
    0 0 0 0 1 0];

Check2=Observability(C2,A)

disp('Observability check for Case2-(t1,t2)')

if Check2==Order_of_A
    disp('System is Observable for (t1,t2)')
else
    disp('System is not Observable for the expected Output')
end

%Case 3 for (x,t2)
 
C3=[1 0 0 0 0 0
    0 0 0 0 1 0];

Check3=Observability(C3,A)

disp('Observability check for Case3-(x,t2)')

if Check3==Order_of_A
    disp('System is Observable for (x,t2)')
else
    disp('System is not Observable for the expected Output')
end


%Case 4 for (x,t1,t2)
 
C4=[1 0 0 0 0 0
    0 0 1 0 0 0
    0 0 0 0 1 0];

Check4=Observability(C4,A)

disp('Observability check for Case4-(x,t1,t2)')

if Check4==Order_of_A
    disp('System is Observable for (x,t1,t2)')
else
    disp('System is not Observable for the expected Output')
end





