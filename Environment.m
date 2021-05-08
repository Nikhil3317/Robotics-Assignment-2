function [input] = Environment(output)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

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




























end

