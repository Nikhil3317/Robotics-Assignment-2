function [ ] = PlotToken()


tokens_h = {0 0 0 0 0 0 0 0 0}; % Cell array for storing token handles
tokenVertices = {0 0 0 0 0 0 0 0 0}; % Cell array for storing token vertices
for i = 1:1:9 % Plotting all tokens
    if i == 2 || i == 4 || i == 6 || i == 8 
        tokens_h{i} = PlaceObject('Token O.ply'); % Importing Token-O
    else
        tokens_h{i} = PlaceObject('Token X.ply'); % Importing Token-X
    end
    tokenVertices{i} = get(tokens_h{i},'Vertices'); % Extracting vertices data
    transformedVertices = [tokenVertices{i},ones(size(tokenVertices{i},1),1)] * tokens{i}'; % Transforming vertices
    set(tokens_h{i},'Vertices',transformedVertices(:,1:3)); % Updating token location
    drawnow; % Update simulation
    pause(0.001); % Wait before execution
end


end