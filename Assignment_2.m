%% DUAL DOBOT GAMEPLAY - Assignment 2 Program
% Divjot Babra, Nikhil Senthilvel, Vivien Thai
clc % Clear command window
clearvars % Clear workspace variables
clf % Close all figures
set(0,'DefaultFigureWindowStyle','docked') % Docking figure window
%% Setting Token Initial Positions
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
%% Creating Environment
Environment(); % Call environment function
%% Plotting Dobots
qr = deg2rad([0,-42.5,-50,0,0]); % Ready pose
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
%% Dual Dobot Operation
input('Press <Enter> to begin Dobot gameplay'); % Wait for user input

% steps = 70; % Setting speed of both robots
% gripOffset = 0.2; % Setting offset for gripper
% oldQ = [-0.4 0 0 0 pi 0 0];   % Setting initial pose
% for i = 1:1:6   % Collecting and stacking bricks
%     brickTr = bricks{i}*transl(0,0,-gripOffset);   % Calculating pickup point
%     wallTr = wall{i}*transl(0,0,-gripOffset);   % Calculating drop off point
%     newQ = ur5.model.ikcon(brickTr,oldQ); % Calculating required pose
%     newTr = ur5.model.fkine(newQ);   % Calculating forward transform
%     if abs(brickTr(1,4) - newTr(1,4)) <= 0.1 && abs(brickTr(2,4) - newTr(2,4)) <= 0.1 && abs(brickTr(3,4) - newTr(3,4)) <= 0.1 % Checking brick reachability
%        disp(['brick',num2str(i),' is within UR5 reach. Calculated transform is:']);  % Display message
%        disp(newTr); % Display message
%        if newTr(3,4) >= 0   % Check to see if the transform is above floor
%           ur5.model.plot(jtraj(oldQ,newQ,steps),'workspace',workSpace); % Move robot to brick
%           oldQ = newQ; % Update robot pose
%           newQ = ur5.model.ikcon(wallTr,oldQ); % Calculating required pose
%           trajectory = jtraj(oldQ,newQ,steps);  % Calculating trajectory
%           for j = 1:1:steps % Moving robot with brick to wall
%               ur5.model.animate(trajectory(j,:))    % Update robot pose
%               transformedVertices=[brickVertices{i},ones(size(brickVertices{i},1),1)]*(ur5.model.fkine(trajectory(j,:))*transl(0,0,gripOffset))'; % Moving brick 
%               set(bricks_h{i},'Vertices',transformedVertices(:,1:3)); % Updating brick location
%               drawnow;  % Update simulation
%           end
%           oldQ = newQ; % Update robot pose
%        else
%            warning(['A pose for brick',num2str(i),' is not possible.']);   % Display message
%        end
%     else
%        warning(['brick',num2str(i),' is out of UR5 reach.']);   % Display message
%     end
% end
% ur5.model.plot(jtraj(ur5.model.getpos,[-0.4 0 0 0 0 0 0],steps),'workspace',workSpace); % Returning to ready pose








