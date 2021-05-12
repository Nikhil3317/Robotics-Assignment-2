function [ ] = Environment() % Function for creating simulation environment
%% Inserting Objects
[f,v,data] = plyread('Table.ply','tri'); % Inserting PLY object
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255; % Scaling colours
hold on; % Hold figure
for zOffset = (0) % Position object in environment
    for yOffset = (0)
        for xOffset = (0)
        trisurf(f,v(:,1) + xOffset,v(:,2) + yOffset, v(:,3) + zOffset, ...
        'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
        end
    end
end
axis equal; % Set axis to be equal        
hold on; % Hold figure

[f,v,data] = plyread('Fire Extinguisher.ply','tri'); % Inserting PLY object
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255; % Scaling colours
hold on; % Hold figure
for zOffset = (0) % Position object in environment
    for yOffset = (0)
        for xOffset = (0)
        trisurf(f,v(:,1) + xOffset,v(:,2) + yOffset, v(:,3) + zOffset, ...
        'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
        end
    end
end
axis equal; % Set axis to be equal        
hold on; % Hold figure

[f,v,data] = plyread('E-Stop.ply','tri'); % Inserting PLY object
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255; % Scaling colours
hold on; % Hold figure
for zOffset = (0) % Position object in environment
    for yOffset = (0)
        for xOffset = (0)
        trisurf(f,v(:,1) + xOffset,v(:,2) + yOffset, v(:,3) + zOffset, ...
        'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
        end
    end
end
axis equal; % Set axis to be equal        
hold on; % Hold figure

[f,v,data] = plyread('Board.ply','tri'); % Inserting PLY object
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255; % Scaling colours
hold on; % Hold figure
for zOffset = (0) % Position object in environment
    for yOffset = (0)
        for xOffset = (0)
        trisurf(f,v(:,1) + xOffset,v(:,2) + yOffset, v(:,3) + zOffset, ...
        'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
        end
    end
end
axis equal; % Set axis to be equal        
hold on; % Hold figure
%% Inserting Floor and Walls
surf([0,0;2,2],[0,2;0,2],[0.05,0.05;0.05,0.05],'CData',imread('WoodFloor.jpg'),'FaceColor','texturemap')
% surf([-1.2,-1.2;3.2,3.2],[-1.2,1.2;-1.2,1.2],[0.01,0.01;0.01,0.01],'CData',imread('tape.jpg'),'FaceColor','texturemap')
% surf([-0.8,-0.8;2.8,2.8],[-0.8,0.8;-0.8,0.8],[0.01,0.01;0.01,0.01],'CData',imread('concrete.jpg'),'FaceColor','texturemap')

% surf([-4,-4;4,4],[-2,-2;-2,-2],[2,0.01;2.0,0.01],'CData',imread('Window.jpg'),'FaceColor','texturemap')
surf([2,2;2,2],[2,2;0,0],[1,0;1,0],'CData',imread('RightWall.jpg'),'FaceColor','texturemap')
surf([2,2;0,0],[2,2;2,2],[1,0;1,0],'CData',imread('Window.jpg'),'FaceColor','texturemap')
% surf([-4,-4;-4,-4],[4,4;-2,-2],[2,0.01;2,0.01],'CData',imread('TicTacToeBackground.jpg'),'FaceColor','texturemap')
end