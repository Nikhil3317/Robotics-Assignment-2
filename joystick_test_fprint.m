%% Test for Joystick functionality
% run this script to test your joystick button/axis function
%
% To quit, press ctrl-C
%
%% setup joystick
id = 1; % NOTE: may need to change if multiple joysticks present
joy = vrjoystick(id);
joy_info = caps(joy); % print joystick information

fprintf('Your joystick has:\n');
fprintf(' - %i buttons\n',joy_info.Buttons);
fprintf(' - %i axes\n', joy_info.Axes);
pause(2);
%% Set up robot

%mdl_puma560;
robot = Dobot;
%robot.tool = transl(0.1,0,0);

%% Start "real-time" simulation
qr = deg2rad([0,-42.5,-50,0,0]); 

q = qr;

HF = figure(1);
robot.model.plot(q);
robot.model.delay = 0.001;
set(HF, 'Position',[0.1 0.1 0.8 0.8]);

duration = 120;
dt = 0.05;

n = 0;
tic;

while (toc < duration)
    
    n=n+1;
    
    [axes, buttons, pov] = read(joy);
    
    Kv = 0.2;
    Kw = 0.05;
    
    vx = Kv*axes(1);
    vy = Kv*axes(2);
    vz = Kv*(buttons(5)-buttons(7));
    
    wx = Kw*axes(4);
    wy = Kw*axes(3);
    wz = Kw*(buttons(6)-buttons(8));
    
    dx = [vx;vy;vz;wx;wy;wz];
    
    dx((dx.^2)<0.01) = 0;
    
    J = robot.model.jacob0(q);
    
    J = J(1:2,1:3);
    
    dq = inv(J)*dx;
 
    q = q + (dq*dt)';
    
    robot.model.animate(q);

    if (toc > dt*n)
        warning('Loop %i took too much time - consider increating dt', n);
    end
    
    while (toc < dt*n);
    end
end
%%
% while(1)
%     
%     % Read joystick buttons
%     [axes, buttons, povs] = read(joy);
% 
%     % Print buttons/axes info to command window
%     str = sprintf('--------------\n');
%     for i = 1:joy_info.Buttons
%         str = [str sprintf('Button[%i]:%i\n',i,buttons(i))];
%     end
%     for i = 1:joy_info.Axes 
%         str = [str sprintf('Axes[%i]:%1.3f\n',i,axes(i))]; 
%     end
%     str = [str sprintf('--------------\n')];
%     fprintf('%s',str);
%     pause(0.05);  
%     
% end
%     