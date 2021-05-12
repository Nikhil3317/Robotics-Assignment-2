%% DUAL DOBOT GAMEPLAY - Assignment 2 Program
% Divjot Babra, Nikhil Senthilvel, Vivien Thai
clc % Clear command window
clearvars % Clear workspace variables
clf % Close all figures
set(0,'DefaultFigureWindowStyle','docked') % Docking figure window
%% Token Starting Positions
T1 = transl(0.8,0.7,0.35);
% T2 = transl(1.75,0.5,0.2);                   
% T3 = transl(2,0.5,0.2);
% T4 = transl(1.5,0.25,0.22);
% T5 = transl(1.75,0.25,0.2);
% T6 = transl(2,0.25,0.2);
% T7 = transl(1.5,0.75,0.2);
% T8 = transl(1.75,0.75,0.2);
% T9 = transl(2.25,0.85,0.2);
%% Plot Both Dobots
q0 = [0,0,0,0,0];
dobot1 = Dobot1;
hold on;
dobot2 = Dobot2;
%% Create Environment
Environment(); % Call environment function
%% Plotting Token
workspace = [0 2 0 2 0 0.8];     
scale = 0.5;

L1 = Link('d',0,'a',0,'alpha',pi/2,'qlim',deg2rad([-360,360]), 'offset', 0);     % DH parameters of UR3 robot

[faceData,vertexData] = plyread('Token O.ply','tri');
Token = SerialLink([L1],'name','Token','base',T1);     % Inputting 9 bricks     
Token.faces = {faceData,[]};                           % Referring to robotcows.m file
Token.points = {vertexData,[]};                        % Inputting brick faces and vertices
qa = zeros(1,1);                                       % Creating initial joint angles as zero for all bricks
Token.plot3d(qa,'workspace',workspace,'scale',scale);

%% Moving Dobot to Token
% 
% steps = 80;                             % Number of steps used in each motion
% 
% q2 = UR3.ikine(P1,q,[1,1,1,0,0,0]);     % Computing joint angles required for end effector to reach
% qMatrix = jtraj(q,q2,steps);           % desired position using inverse kinematics
% x = UR3.fkine(q2);                     % Calculating trajectory required
% disp(x);                                % using quintic polynomial method
%                                         % from Lab4 and storing in qMatrix                                                                         
% for i = 1:6:steps                       % Plotting trajectory for UR3 robot
%    UR3.plot(qMatrix(i,:));
% end
% 
% %% Moving Dobot to Token 2
% 
% q3 = UR3.ikine(transl(1,1.1,0.5),q,[1,1,1,0,0,0]);    
% qMatrix = jtraj(q2,q3,steps);           % Calculating joint angles needed to get to wall, masking off R,P,Y
%                                         % Working out trajectory from brick
%                                         % to wall using quintic polynomial
%                                         % method
% for i = 1:6:steps
%    UR3.plot(qMatrix(i,:));              % Plotting movement of UR3 
%    T2 = UR3.fkine(qMatrix(i,:));        % Using forward kinematics to find and store position of pose of wall
%    Token.base = T2;                     % Updating brick location to that wall position
%    Token.plot(0);                       % Plotting movement of brick to move with UR3 end effector
% end
% 
% %% Moving Dobot to Token 1
% 
% steps = 80;                             % Number of steps used in each motion
% 
% q2 = UR3.ikine(P1,q,[1,1,1,0,0,0]);     % Computing joint angles required for end effector to reach
% qMatrix = jtraj(q,q2,steps);           % desired position using inverse kinematics
% x = UR3.fkine(q2);                     % Calculating trajectory required
% disp(x);                                % using quintic polynomial method
%                                         % from Lab4 and storing in qMatrix                                                                         
% for i = 1:6:steps                       % Plotting trajectory for UR3 robot
%    UR3.plot(qMatrix(i,:));
% end

%% Moving Dobot to Token 2







