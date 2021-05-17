%% Function for creating simulation environment
% PLY files were sourced from: GrabCad
% Tic-Tac-Toe board and pieces: https://grabcad.com/library/tic-tac-toe--4
% Table: https://grabcad.com/library/zamani-premium-xl-dining-table-1
% Fire Extinguisher: https://grabcad.com/library/fire-extinguisher-support-1
% E-stop Button: https://grabcad.com/library/emergency-stop-button
% Cat model was sourced from Free3D: https://free3d.com/3d-model/low-poly-cat-46138.html

function [] = Environment()
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
for zOffset = (0.11) % Position object in environment
    for yOffset = (0.27)
        for xOffset = (0.28)
        trisurf(f,v(:,1) + xOffset,v(:,2) + yOffset, v(:,3) + zOffset, ...
        'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
        end
    end
end
axis equal; % Set axis to be equal        
hold on; % Hold figure
%% Inserting Floor and Walls
surf([0,0;2,2],[0,2;0,2],[0.002,0.002;0.002,0.002],'CData',imread('WoodFloor.jpg'),'FaceColor','texturemap') % Insert image
surf([2,2;2,2],[2,2;0,0],[1,0;1,0],'CData',imread('RightWall.jpg'),'FaceColor','texturemap') % Insert image
surf([2,2;0,0],[2,2;2,2],[1,0;1,0],'CData',imread('Window.jpg'),'FaceColor','texturemap') % Insert image
end