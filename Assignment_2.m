%% DUAL DOBOT GAMEPLAY - Assignment 2 Program
% Divjot Babra, Nikhil Senthilvel, Vivien Thai
clc % Clear command window
clearvars % Clear workspace variables
clf % Close all figures
set(0,'DefaultFigureWindowStyle','docked') % Docking figure window
%% Setting Token Initial Positions
tokenO1 = transl(1.3,0.8,0.37);
tokenO2 = transl(1.5,0.9,0.37);                   
tokenO3 = transl(1.5,1.1,0.37);
tokenO4 = transl(1.3,1.2,0.37);
tokenX5 = transl(0.75,1.2,0.37);
tokenX6 = transl(0.55,1.2,0.35);
tokenX7 = transl(0.55,1,0.35);
tokenX8 = transl(0.55,0.8,0.35);
tokenX9 = transl(0.75,0.8,0.35);
tokens = {tokenO1 tokenO2 tokenO3 tokenO4 tokenX5 tokenX6 tokenX7 tokenX8 tokenX9}; % Storing token locations
%% Creating Environment
Environment(); % Call environment function
%% Plotting Dobots
q0 = [0,0,0,0,0]; % Default pose
workspace = [0 2 0 2 0 1]; % Workspace dimensions
dobot1 = Dobot1;
hold on;
dobot2 = Dobot2;
view(3); % Setting viewpoint
axis equal; % Setting axis to be equal
%% Plotting Tokens
tokens_h = {0 0 0 0 0 0 0 0 0}; % Cell array for storing Token handles
tokenVertices = {0 0 0 0 0 0 0 0 0}; % Cell array for storing Token vertices
for i = 1:1:9 % Plotting 9 Tokens
    if i <= 4
        tokens_h{i} = PlaceObject('Token O.ply'); % Importing Token-O
    else
        tokens_h{i} = PlaceObject('Token X.ply'); % Importing Token-X
    end
    tokenVertices{i} = get(tokens_h{i},'Vertices'); % Extracting vertices data
    transformedVertices = [tokenVertices{i},ones(size(tokenVertices{i},1),1)] * tokens{i}'; % Transforming vertices
    set(tokens_h{i},'Vertices',transformedVertices(:,1:3)); % Updating object location
    drawnow; % Update simulation
    pause(0.001); % Wait before execution
end
%% Dobot Operation
disp('Press <Enter> to begin Dobot gameplay'); % Wait for user input

%Moving Dobot to Token
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







