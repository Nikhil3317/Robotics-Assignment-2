function [] = DobotControl()
%% Setup joystick
ID = 1; % Joystick ID number
joy = vrjoystick(ID); % Setting up joystick input
caps(joy) % Display joystick information
%% Simulation variables
duration = 120;  % Set duration of the simulation (seconds)
dt = 0.1;      % Set time step for simulation (seconds)
lambda = 0.1;   % Damping factor
%% Set up robot
dobot = Dobot; % Creating instance of Dobot class
dobot.model.base = transl(1,1,0); % Changing Dobot base location
dobot.model.delay = 0.001; % Setting animation delay time
view(2); % Change viewpoint
hold on; % Holding figure
axis equal; % Setting aspect ratio of axes
%% Start simulation
q = deg2rad([0,-42.5,-50,0,0]); % Initial pose
n = 0;  % Reset step counter 
tic;    % Begin simulation timer
while(toc < duration) % Begin simulation
    n = n + 1; % Increment step count
    [axes, buttons, ~] = read(joy); % Read joystick input
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
    if n == 1 
       J = dobot.model.jacob0(q); % Calculate Jacobian
    else
       J = dobot.model.jacob0([q,0,0]); % Calculate Jacobian
    end
    J = J(1:3,1:3); % Taking first 3 rows and columns
    Jinv_DLS = ((J'*J)+lambda^2*eye(3))\J'; % Computing DLS Jacobian
    dq = Jinv_DLS*dx; % Convert velocity from cartesian to joint space
    % 3 - Apply joint velocity to step robot joint angles
    q = q(1,1:3) + (dq * dt)'; % Convert joint velocity to joint displacement
    % -------------------------------------------------------------
    dobot.model.animate([q,0,0]); % Update robot pose
    if (toc > dt*n) % Wait until loop time has elapsed
        warning('Loop %i took too much time - consider increating dt',n); % Display warning
    end
    while (toc < dt*n) % Wait until loop time has elapsed 
    end
end
end