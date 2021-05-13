%% DUAL DOBOT GAMEPLAY - Assignment 2 Program
% Divjot Babra, Nikhil Senthilvel, Vivien Thai
clc % Clear command window
clearvars % Clear workspace variables
clf % Close all figures
set(0,'DefaultFigureWindowStyle','docked') % Docking figure window
%% Setting Token Positions
tokenO1 = transl(1.3,0.7,0.37);
tokenO2 = transl(1.3,0.85,0.37);
tokenO3 = transl(1.3,1.15,0.37);
tokenO4 = transl(1.3,1.3,0.37);
tokenX5 = transl(0.75,1.3,0.37);
tokenX6 = transl(0.75,1.15,0.35);
tokenX7 = transl(0.75,0.85,0.35);
tokenX8 = transl(0.75,0.7,0.35);
tokenX9 = transl(0.55,1,0.35);
tokens = {tokenO1 tokenO2 tokenO3 tokenO4 tokenX5 tokenX6 tokenX7 tokenX8 tokenX9}; % Storing token locations
board1 = transl(1.13,0.9,0.4);
board2 = transl(1.13,1.01,0.4);
board3 = transl(1.13,1.11,0.4);
board4 = transl(1.02,1.11,0.4);
board5 = transl(1.02,1.01,0.38);
board6 = transl(1.02,0.9,0.38);
board7 = transl(0.92,0.9,0.38);
board8 = transl(0.92,1.01,0.38);
board9 = transl(0.92,1.11,0.38);
boardSpots = {board1 board2 board3 board4 board5 board6 board7 board8 board9}; % Storing board locations
%% Creating Environment
Environment(); % Call environment function
%% Plotting Dobots
qr = deg2rad([0,-42.5,-50,0,0]); % Ready pose
workSpace = [0 2 0 2 0 1]; % Workspace dimensions
dobot1 = Dobot; % Creating robot object
dobot1.model.base = transl(1.3,1,0.4) * trotz(pi); % Repositioning Dobot1
hold on; % Holding figure
dobot2 = Dobot; % Creating robot object
dobot2.model.base = transl(0.75,1,0.4); % Repositioning Dobot2
axis equal; % Setting axis aspect ratio
view(3); % Setting viewpoint
%% Ready Position
qr(1,4) = 0 - qr(1,2) - qr(1,3); % Ensures that the end effector always points down
dobot1.model.animate(jtraj(dobot1.model.getpos,qr,5));
dobot2.model.animate(jtraj(dobot2.model.getpos,qr,5));
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
%% Dual Dobot Operation
input('Press <Enter> to begin Dobot Gameplay'); % Wait for user input

steps = 30; % Setting robot speed
gripOffset = 0.1; % Setting offset for gripper
oldQ = qr;   % Setting initial pose
for i = 1:1:4   % Collecting and placing tokens
    pickTr = tokens{i}*transl(0,0,gripOffset);   % Calculating pickup point
    dropTr = boardSpots{i}*transl(0,0,gripOffset);   % Calculating drop off point
    newQ = dobot1.model.ikcon(pickTr,oldQ); % Calculating required pose
    newTr = dobot1.model.fkine(newQ);   % Calculating forward transform
    if abs(pickTr(1,4) - newTr(1,4)) <= 0.1 && abs(pickTr(2,4) - newTr(2,4)) <= 0.1 && abs(pickTr(3,4) - newTr(3,4)) <= 0.1 % Checking reachability
       disp(['Token ',num2str(i),' is within reach.']); % Display message
       if newTr(3,4) >= 0.4   % Check to see if the transform is above table
          qMatrix = jtraj(oldQ,newQ,steps); % Calculating trajectory
          for j = 1:1:steps % Moving robot to token
              dobot1.model.animate(qMatrix(j,:)); % Update robot pose
              drawnow; % Update simulation
          end
          oldQ = newQ; % Update robot pose
          newQ = dobot1.model.ikcon(dropTr,oldQ); % Calculating required pose
          qMatrix = jtraj(oldQ,newQ,steps); % Calculating trajectory
          for j = 1:1:steps % Moving robot with token to board spot
              dobot1.model.animate(qMatrix(j,:)) % Update robot pose                                                               % Move token 
              transformedVertices=[tokenVertices{i},ones(size(tokenVertices{i},1),1)]*(dobot1.model.fkine(qMatrix(j,:))*transl(0,0,-gripOffset))'; 
              set(tokens_h{i},'Vertices',transformedVertices(:,1:3)); % Updating token location
              drawnow;  % Update simulation
          end
          oldQ = newQ; % Update robot pose
       else
           warning(['A pose for brick',num2str(i),' is not possible.']); % Display message
       end
    else
       warning(['Token',num2str(i),' is out of reach.']); % Display message
    end
end
qMatrix = jtraj(dobot1.model.getpos,qr,steps); % Calculating trajectory
for i = 1:1:steps % Moving robot to ready pose
  dobot1.model.animate(qMatrix(i,:)); % Update robot pose
  drawnow; % Update simulation
end








