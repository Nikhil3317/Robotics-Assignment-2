% The .PLY files for the Dobot were created from a 3D Model of the Dobot
% found online. Link to the model: 
% https://www.dropbox.com/s/9a3byv5vsm3446d/3D-Model%20DOBOT%20Magician%20incl.%20Tools.zip?dl=0 

classdef Dobot2 < handle
    properties
        %> Robot model = dobot
        model;
        
        %> Define the boundaries of the workspace
        workspace = [0 2 0 2 0 1];     
        
    end
    
    methods%% Class for Dobot robot simulation
 function self = Dobot2()

% get the Dobot robot = 
self.GetDobotRobot();
% plot and colour the Dobot Magician robot = 
self.PlotAndColourRobot();%robot,workspace);

 end
%% GetDobotRobot
% Given a name (optional), create and return a Dobot robot model
function GetDobotRobot(self)
%     if nargin < 1
        % Create a unique name (ms timestamp after 1ms pause)
        pause(0.001);
        name = ['Dobot',datestr(now,'yyyymmddTHHMMSSFFF')];
%     end

    % Create the dobot model 
    
    L(1) = Link('d',0.087,  'a',0,          'alpha',pi/2,       'qlim',deg2rad([-90,90]),       'offset',pi);
    L(2) = Link('d',0,      'a',-0.135,     'alpha',0,          'qlim',deg2rad([-42.5,42.5]),   'offset',deg2rad(-42.5));
    L(3) = Link('d',0,      'a',-0.147,     'alpha',0,          'qlim',deg2rad([-50,50]),       'offset',deg2rad(80));
    L(4) = Link('d',0,      'a',0.061,      'alpha',pi/2,       'qlim',deg2rad([0,0]),       'offset',deg2rad(142.5));  
    L(5) = Link('d',-0.023,      'a',0,     'alpha',0,          'qlim',deg2rad([-90,90]),         'offset',0);
    
    %     L(4) = Link('d',0,      'a',0.061,      'alpha',pi/2,       'qlim',deg2rad([0,0]),       'offset',deg2rad(142.5)); 
    %     L(4) = Link('d',0.11235,'a',0,          'alpha',pi/2,       'qlim',deg2rad([-90,90]),       'offset',pi/2);

    self.model = SerialLink(L,'name',name);
    
    % Rotate robot to the correct orientation
     self.model.base = self.model.base * transl(0.75,1,0.4);

end

%% PlotAndColourRobot
% Given a robot index, add the glyphs (vertices and faces) and
% colour them in if data is available 
function PlotAndColourRobot(self)%robot,workspace)
    for linkIndex = 0:self.model.n
        [ faceData, vertexData, plyData{linkIndex+1} ] = plyread(['DobotLink',num2str(linkIndex),'.ply'],'tri'); %#ok<AGROW>
        self.model.faces{linkIndex+1} = faceData;
        self.model.points{linkIndex+1} = vertexData;
    end

    % Display robot
    self.model.plot3d(zeros(1,self.model.n),'noarrow','workspace',self.workspace);
    if isempty(findobj(get(gca,'Children'),'Type','Light'))
        camlight
    end  
    self.model.delay = 0;

    % Try to correctly colour the arm (if colours are in ply file data)
    for linkIndex = 0:self.model.n
        handles = findobj('Tag', self.model.name);
        h = get(handles,'UserData');
        try 
            h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
                                                          , plyData{linkIndex+1}.vertex.green ...
                                                          , plyData{linkIndex+1}.vertex.blue]/255;
            h.link(linkIndex+1).Children.FaceColor = 'interp';
        catch ME_1
            disp(ME_1);
            continue;
        end
    end
end

    end
end