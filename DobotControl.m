function [] = DobotControl()
%% Setting Token Positions
tokenX1 = transl(0.78,1.30,0.37);
tokenO2 = transl(1.27,0.70,0.37);
tokenX3 = transl(0.78,1.15,0.35);
tokenO4 = transl(1.27,0.85,0.37);
tokenX5 = transl(0.78,0.85,0.35);
tokenO6 = transl(1.27,1.15,0.37);
tokenX7 = transl(0.78,0.70,0.35);
tokenO8 = transl(1.27,1.30,0.37);
tokenX9 = transl(0.92,1.25,0.35);
tokens = {tokenX1 tokenO2 tokenX3 tokenO4 tokenX5 tokenO6 tokenX7 tokenO8 tokenX9}; % Storing token locations
%% Creating Environment
Environment(); % Call environment function
%% Plotting Dobots
qr = deg2rad([0,-42.5,-50,0,0]); % Ready pose
dobot1 = Dobot; % Creating robot object
dobot1.model.base = transl(1.27,1,0.4) * trotz(pi); % Repositioning Dobot1
hold on; % Holding figure
dobot2 = Dobot; % Creating robot object
dobot2.model.base = transl(0.78,1,0.4); % Repositioning Dobot2
axis equal; % Setting axis aspect ratio
view(3); % Setting viewpoint
%% Ready Position
qr(1,4) = 0 - qr(1,2) - qr(1,3); % Ensure end effector points down
dobot1.model.animate(jtraj(dobot1.model.getpos,qr,5));
dobot2.model.animate(jtraj(dobot2.model.getpos,qr,5));
%% Plotting Tokens
tokens_h = {0 0 0 0 0 0 0 0 0}; % Cell array for storing Token handles
tokenVertices = {0 0 0 0 0 0 0 0 0}; % Cell array for storing Token vertices
for i = 1:1:9 % Plotting 9 Tokens
    if i == 2 || i == 4 || i == 6 || i == 8 
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
%% Setup joystick
joy = vrjoystick(1); % Setting up joystick input
disp('Input commands via joystick.'); % Display message
%% Simulation variables
duration = 120; % Set duration of the simulation (seconds)
dt = 0.3;       % Set time step for simulation (seconds)
lambda = 0.1;   % Damping factor
%% Start simulation
dobotSwitch = 1; % Variable for switching robots
q = qr(1,1:3); % Initial pose
counter = 0;  % Reset step counter 
tic;    % Begin simulation timer
while(toc < duration) % Begin simulation
    counter = counter + 1; % Increment step count
    [axes, buttons, ~] = read(joy); % Read joystick input
    if buttons(9) == 1 % For switching between robots
       if dobotSwitch == 1 % For switching between robots
          dobotSwitch = 2; % For switching between robots
       else
           dobotSwitch = 1; % For switching between robots
       end
    end
    % -------------------------------------------------------------
    % 1 - Turn joystick input into end-effector velocity command
    Kv = 0.3; % Linear velocity gain (use to set max speed)
%     Kw = 0.8; % Angular velocity gain (use to set max speed)
    vx = Kv*axes(1); % Mapping input to control linear velocity
    vy = Kv*axes(2); % Mapping input to control linear velocity
    vz = Kv*(buttons(5)-buttons(7)); % Mapping input to control linear velocity
%     wx = Kw*axes(3); % Mapping input to control angular velocity
%     wy = Kw*axes(4); % Mapping input to control angular velocity
%     wz = Kw*(buttons(6)-buttons(8)); % Mapping input to control angular velocity
    dx = [vx vy vz]'; % Combined velocity vector
    dx((dx.^2)<0.01) = 0; % Reducing joystick error
    % 2 - Use J inverse to calculate joint velocity
    if dobotSwitch == 1
       J = dobot1.model.jacob0([q,0,0]); % Calculate Jacobian
    elseif dobotSwitch == 2
       J = dobot2.model.jacob0([q,0,0]); % Calculate Jacobian
    end
    J = J(1:3,1:3); % Taking first 3 rows and first 3 columns
    Jinv_DLS = ((J'*J)+lambda^2*eye(3))\J'; % Computing DLS Jacobian
    dq = Jinv_DLS*dx; % Convert velocity from cartesian to joint space
    % 3 - Apply joint velocity to step robot joint angles
    if dobotSwitch == 1
       q = q(1,1:3) + (dq * dt)'; % Convert joint velocity to joint displacement
    elseif dobotSwitch == 2
       q = q(1,1:3) + (dq * dt)'; % Convert joint velocity to joint displacement
    end
    % -------------------------------------------------------------
    % Joint limits
    if q(1,1) < -1.5708 
       q(1,1) = -1.5708;
    end
    if q(1,1) > 1.5708
       q(1,1) = 1.5708;
    end
    if q(1,2) < -0.7418 
       q(1,2) = -0.7418;
    end
    if q(1,2) > 0.7418 
       q(1,2) = 0.7418;
    end
    if q(1,3) < -0.8727
       q(1,3) = -0.8727;
    end
    if q(1,3) > 0.8727 
       q(1,3) = 0.8727;
    end
    if dobotSwitch == 1
       dobot1.model.animate([q,(0-q(1,2)-q(1,3)),0]); % Update robot pose
    elseif dobotSwitch == 2
       dobot2.model.animate([q,(0-q(1,2)-q(1,3)),0]); % Update robot pose
    end
    drawnow; % Update simulation
    if (toc > dt*counter) % Wait until loop time has elapsed
        warning('Loop %i took too much time. Increase ''dt'' value.',counter); % Display warning
    end
    while (toc < dt*counter) % Wait until loop time has elapsed 
    end
end
if toc > duration % Finish simulation
   disp('Simulation timeout.'); % Display message 
end
end