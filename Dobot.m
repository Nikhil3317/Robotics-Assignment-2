% The PLY files for the Dobot were created from a 3D model found online
% Link to the model: https://www.dropbox.com/s/9a3byv5vsm3446d/3D-Model%20DOBOT%20Magician%20incl.%20Tools.zip?dl=0 

classdef Dobot < handle % Creating Dobot class
    
    properties
        model; % Robot model = dobot
        workspace = [0 2 0 2 0 1]; % Defining workspace boundaries
        eStop = 0; % Used to check E-stop
    end
    
    methods % Class for Dobot robot simulation
        
        function self = Dobot() % Defining Dobot
            self.GetDobotRobot(); % Get the Dobot robot  
            self.PlotAndColourRobot(); % Plot and colour the Dobot robot (comment out this line to view the stick model)
        end
        
        function GetDobotRobot(self) % Creating and returning Dobot robot model
        pause(0.001); % Wait before execution
        name = ['Dobot',datestr(now,'yyyymmddTHHMMSSFFF')]; % Creating unique Dobot name

        % Setting DH parameters for Dobot model
        L(1) = Link('d',0.087,  'a',0,          'alpha',pi/2,   'offset',deg2rad(180));
        L(2) = Link('d',0,      'a',-0.135,     'alpha',0,      'offset',deg2rad(-42.5));
        L(3) = Link('d',0,      'a',-0.147,     'alpha',0,      'offset',deg2rad(80));
        L(4) = Link('d',0,      'a',0.061,      'alpha',pi/2,   'offset',deg2rad(142.5));  
        L(5) = Link('d',-0.023, 'a',0,          'alpha',0,      'offset',0);
    
        % Setting joint limits for Dobot model
        L(1).qlim = deg2rad([-90,90]);
        L(2).qlim = deg2rad([-42.5,42.5]);
        L(3).qlim = deg2rad([-50,50]);
        L(4).qlim = deg2rad([0,0]);  
        L(5).qlim = deg2rad([-90,90]);
    
        self.model = SerialLink(L,'name',name); % Create Dobot stick model
        self.model.base = self.model.base * transl(0,0,0); % Setting Dobot base location
        end
        
        function PlotAndColourRobot(self) % Adding PLY files to stick model
            for linkIndex = 0:self.model.n % Index through each link
                [faceData,vertexData,plyData{linkIndex+1}] = plyread(['DobotLink',num2str(linkIndex),'.ply'],'tri'); % Input PLY files 
                self.model.faces{linkIndex+1} = faceData; % Storing face data 
                self.model.points{linkIndex+1} = vertexData; % Storing vertex data
            end
            self.model.plot3d(zeros(1,self.model.n),'noarrow','workspace',self.workspace); % Plot Dobot model
            if isempty(findobj(get(gca,'Children'),'Type','Light')) % Checking lighting options
               camlight % Activate camera lighting
            end
            self.model.delay = 0; % Setting animation delay
            for linkIndex = 0:self.model.n % Index through each link
                handles = findobj('Tag', self.model.name); % Checking model Tag 
                h = get(handles,'UserData'); % Getting data from handles variables
                try 
                    h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red, ...
                                                                    plyData{linkIndex+1}.vertex.green, ...
                                                                    plyData{linkIndex+1}.vertex.blue]/255; % Scaling PLY file colours
                    h.link(linkIndex+1).Children.FaceColor = 'interp'; % Setting face data
                catch ME_1 % For error handling
                    disp(ME_1); % For error handling
                    continue;
                end
            end
        end
        
        function ReadyPosition(self) % For plotting Dobot in correct pose
            qr = deg2rad([0,-42.5,-50,92.5,0]); % Ready pose
            self.model.animate(qr); % Update Dobot pose
        end
        
    end
    
end