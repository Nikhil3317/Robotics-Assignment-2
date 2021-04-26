clc                                          % Clearing command window,figures
clear all
clf

set(0,'DefaultFigureWindowStyle','docked')   % Docking simulation beside code

%% Token Location Input

P1 = transl(0.6,1,0.35);



%% Plot Robots
workspace = [0 2.5 0 2.5 0 1];             % Creating scale of environment                                                      % Setting workspace of environment
scale = 1;                                   % Scaling/ size of UR3 robot                                           % Scale setting of robot
base = transl(0.6,1.4,0.6);


L1 = Link('d',0.1519,'a',0,'alpha',pi/2,'qlim',deg2rad([-360,360]), 'offset', 0);     % DH parameters of UR3 robot
L2 = Link('d',0,'a',-0.24365,'alpha',0,'qlim', deg2rad([-360,360]), 'offset',0); 
L3 = Link('d',0,'a',-0.21325,'alpha',0,'qlim', deg2rad([-360,360]), 'offset', 0);
L4 = Link('d',0.11235,'a',0,'alpha',pi/2,'qlim',deg2rad([-360,360]),'offset', 0); 
L5 = Link('d',0.08535,'a',0,'alpha',-pi/2,'qlim',deg2rad([-360,360]), 'offset',0);
L6 = Link('d',0.0819,'a',0,'alpha',0,'qlim',deg2rad([-360,360]), 'offset', 0);

UR3 = SerialLink([L1 L2 L3 L4 L5 L6],'name','DoBot','base',base);                     % 6 links for robot, assigning position using serial link class
q = zeros(1,6);                              % Initial joint angles of UR3                                       % Initial joint angles
                                             % stored in a zeroes matrix
                                             
UR3.plot(q,'workspace',workspace,'scale',scale);  % Plotting UR3 in workspace                                    

hold on;


base1 = transl(1.9,1.4,0.6);
L1 = Link('d',0.1519,'a',0,'alpha',pi/2,'qlim',deg2rad([-360,360]), 'offset', 0);     % DH parameters of UR3 robot
L2 = Link('d',0,'a',-0.24365,'alpha',0,'qlim', deg2rad([-360,360]), 'offset',0); 
L3 = Link('d',0,'a',-0.21325,'alpha',0,'qlim', deg2rad([-360,360]), 'offset', 0);
L4 = Link('d',0.11235,'a',0,'alpha',pi/2,'qlim',deg2rad([-360,360]),'offset', 0); 
L5 = Link('d',0.08535,'a',0,'alpha',-pi/2,'qlim',deg2rad([-360,360]), 'offset',0);
L6 = Link('d',0.0819,'a',0,'alpha',0,'qlim',deg2rad([-360,360]), 'offset', 0);

Dobot2 = SerialLink([L1 L2 L3 L4 L5 L6],'name','DoBot2','base',base1);                     % 6 links for robot, assigning position using serial link class
q = zeros(1,6);                              % Initial joint angles of UR3                                       % Initial joint angles
                                             % stored in a zeroes matrix
                                             
Dobot2.plot(q,'workspace',workspace,'scale',scale);  % Plotting UR3 in workspace                                    

hold on;


%% Create Environment

%workspace = [-5 5 -5 5 0 2];             % Creating scale of environment

[f,v,data] = plyread('Table.ply','tri');      % Inputting environment ply
                                                    % file from Blender

vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255; %rgb colour

hold on;                                            % Ensures environment stays

for zOffset = [0]                                   % Positioned environment at the origin
    for yOffset = [0]
        for xOffset = [0]
        modelcoordinate = trisurf(f,v(:,1) + xOffset,v(:,2) + yOffset, v(:,3) + zOffset ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
        end
    end
end

axis equal;                                         
hold on;




[f,v,data] = plyread('Fire Extinguisher.ply','tri');      % Inputting environment ply
                                                    % file from Blender

vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255; %rgb colour

hold on;                                            % Ensures environment stays

for zOffset = [0]                                   % Positioned environment at the origin
    for yOffset = [0]
        for xOffset = [0]
        modelcoordinate = trisurf(f,v(:,1) + xOffset,v(:,2) + yOffset, v(:,3) + zOffset ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
        end
    end
end

axis equal;                                         
hold on;




[f,v,data] = plyread('E-Stop.ply','tri');      % Inputting environment ply
                                                    % file from Blender

vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255; %rgb colour

hold on;                                            % Ensures environment stays

for zOffset = [0]                                   % Positioned environment at the origin
    for yOffset = [0]
        for xOffset = [0]
        modelcoordinate = trisurf(f,v(:,1) + xOffset,v(:,2) + yOffset, v(:,3) + zOffset ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
        end
    end
end

axis equal;                                         
hold on;





[f,v,data] = plyread('Board.ply','tri');      % Inputting environment ply
                                                    % file from Blender

vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255; %rgb colour

hold on;                                            % Ensures environment stays

for zOffset = [0]                                   % Positioned environment at the origin
    for yOffset = [0]
        for xOffset = [0]
        modelcoordinate = trisurf(f,v(:,1) + xOffset,v(:,2) + yOffset, v(:,3) + zOffset ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
        end
    end
end

axis equal;                                         
hold on;
%% Create Floor and Walls

surf([0,0;2.5,2.5],[0,2.5;0,2.5],[0.1,0.1;0.1,0.1],'CData',imread('WoodFloor.jpg'),'FaceColor','texturemap')
% surf([-1.2,-1.2;3.2,3.2],[-1.2,1.2;-1.2,1.2],[0.01,0.01;0.01,0.01],'CData',imread('tape.jpg'),'FaceColor','texturemap')
% surf([-0.8,-0.8;2.8,2.8],[-0.8,0.8;-0.8,0.8],[0.01,0.01;0.01,0.01],'CData',imread('concrete.jpg'),'FaceColor','texturemap')

% surf([-4,-4;4,4],[-2,-2;-2,-2],[2,0.01;2.0,0.01],'CData',imread('Window.jpg'),'FaceColor','texturemap')
surf([2.5,2.5;2.5,2.5],[2.5,2.5;0,0],[1,0;1,0],'CData',imread('RightWall.jpg'),'FaceColor','texturemap')
surf([2.5,2.5;0,0],[2.5,2.5;2.5,2.5],[1,0;1,0],'CData',imread('Window.jpg'),'FaceColor','texturemap')
% surf([-4,-4;-4,-4],[4,4;-2,-2],[2,0.01;2,0.01],'CData',imread('TicTacToeBackground.jpg'),'FaceColor','texturemap')

%% Plotting Token
%workspace = [0 2.5 0 2.5 0 0.8];     
scale = 0.5;

[faceData,vertexData] = plyread('Token O.ply','tri');
Token = SerialLink([L1],'name','Token','base',P1);     % Inputting 9 bricks     
Token.faces = {faceData,[]};                           % Referring to robotcows.m file
Token.points = {vertexData,[]};                        % Inputting brick faces and vertices
qa = zeros(1,1);                                       % Creating initial joint angles as zero for all bricks
Token.plot3d(qa,'workspace',workspace,'scale',scale);

%% Moving Dobot to Token

steps = 80;                             % Number of steps used in each motion

q2 = UR3.ikine(P1,q,[1,1,1,0,0,0]);     % Computing joint angles required for end effector to reach
qMatrix = jtraj(q,q2,steps);           % desired position using inverse kinematics
x = UR3.fkine(q2);                     % Calculating trajectory required
disp(x);                                % using quintic polynomial method
                                        % from Lab4 and storing in qMatrix                                                                         
for i = 1:6:steps                       % Plotting trajectory for UR3 robot
   UR3.plot(qMatrix(i,:));
end

%% 

q3 = UR3.ikine(transl(1,1.1,0.5),q,[1,1,1,0,0,0]);    
qMatrix = jtraj(q2,q3,steps);           % Calculating joint angles needed to get to wall, masking off R,P,Y
                                        % Working out trajectory from brick
                                        % to wall using quintic polynomial
                                        % method
for i = 1:6:steps
   UR3.plot(qMatrix(i,:));              % Plotting movement of UR3 
   T2 = UR3.fkine(qMatrix(i,:));        % Using forward kinematics to find and store position of pose of wall
   Token.base = T2;                     % Updating brick location to that wall position
   Token.plot(0);                       % Plotting movement of brick to move with UR3 end effector
end

%% Moving Dobot to Token

steps = 80;                             % Number of steps used in each motion

q2 = UR3.ikine(P1,q,[1,1,1,0,0,0]);     % Computing joint angles required for end effector to reach
qMatrix = jtraj(q,q2,steps);           % desired position using inverse kinematics
x = UR3.fkine(q2);                     % Calculating trajectory required
disp(x);                                % using quintic polynomial method
                                        % from Lab4 and storing in qMatrix                                                                         
for i = 1:6:steps                       % Plotting trajectory for UR3 robot
   UR3.plot(qMatrix(i,:));
end