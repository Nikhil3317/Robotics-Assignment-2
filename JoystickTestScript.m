%% Script for testing joystick functionality
% Run this script to test joystick buttons and axes
% Press ctrl-C to quit
%% Setup joystick
ID = 1; % Joystick ID number
joy = vrjoystick(ID); % Creating joystick object
joy_info = caps(joy); % Print joystick information
fprintf('Your joystick has:\n'); % Print message
fprintf(' - %i buttons\n',joy_info.Buttons); % Print message
fprintf(' - %i axes\n', joy_info.Axes); % Print message
pause(3); % Wait before executing
%% Begin testing
while(1)
    [axes, buttons, povs] = read(joy); % Read input data
    str = sprintf('--------------\n'); % Print to command window
    for i = 1:joy_info.Buttons
        str = [str sprintf('Button[%i]:%i\n',i,buttons(i))]; % Print input data to command window
    end
    for i = 1:joy_info.Axes 
        str = [str sprintf('Axes[%i]:%1.3f\n',i,axes(i))]; % Print input data to command window
    end
    str = [str sprintf('--------------\n')]; % Print to command window
    fprintf('%s',str); % Print data to command window
    pause(0.05); % Wait before execution
end