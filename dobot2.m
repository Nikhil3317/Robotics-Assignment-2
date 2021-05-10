classdef dobot2 < handle
    properties
        %> Robot model = dobot
        model;
        
        %> Define the boundaries of the workspace
        workspace = [0 2 0 2 0 1];     
            
    end
    
    methods%% Class for Dobot robot simulation
 function self = dobot2()

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
     self.model.base = self.model.base * transl(1.3,1,0.4) * trotz(pi);

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

%% 
% function CalculateUR3WorkArea(self)
% 
% stepRads = deg2rad(30);
% qlim = self.model.qlim;
% pointCloudSize = prod(floor((qlim(1:5,2)-qlim(1:5,1))/stepRads + 1));
% pointCloud = zeros(pointCloudSize,3);
% counter = 1;
% tic
% 
% for q1 = qlim(1,1):stepRads:qlim(1,2)
%     for q2 = qlim(2,1):stepRads:qlim(2,2)
%         for q3 = qlim(3,1):stepRads:qlim(3,2)
%             for q4 = qlim(4,1):stepRads:qlim(4,2)
%                 for q5 = qlim(5,1):stepRads:qlim(5,2)
%                     q6 = 0;
%                         q = [q1,q2,q3,q4,q5,q6];
%                         tr3 = self.model.fkine(q);   
%                         pointCloud(counter,:) = tr3(1:3,4)';
%                         counter = counter + 1; 
%                         if mod(counter/pointCloudSize * 100,1) == 0
%                             display(['After ',num2str(toc),' seconds, ',num2str(counter/pointCloudSize * 100),'% of poses have been completed.']);
%                         end
%                 end
%             end
%         end
%     end
% end
% 
% plot3(pointCloud(:,1),pointCloud(:,2),pointCloud(:,3),'r.');
% 
% xMax = max(pointCloud(:,1));
% xMin = min(pointCloud(:,1));
% yMax = max(pointCloud(:,2));
% yMin = min(pointCloud(:,2));
% zMax = max(pointCloud(:,3));
% zMin = abs(min(pointCloud(:,3)));
% radius = (xMax+abs(xMin))/2;
% volume = ((radius^3)*(4/3)*pi)/2;
% display(['The volume of the UR3 work area is ~',num2str(volume), ' m^3 with radius of ',num2str(radius), ' m.']);
% end

    end
end