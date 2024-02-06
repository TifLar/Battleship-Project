function varargout = Battleship(varargin)
% BATTLESHIP MATLAB code for Battleship.fig
%      BATTLESHIP, by itself, creates a new BATTLESHIP or raises the existing
%      singleton*.
%
%      H = BATTLESHIP returns the handle to a new BATTLESHIP or the handle to
%      the existing singleton*.
%
%      BATTLESHIP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATTLESHIP.M with the given input arguments.
%
%      BATTLESHIP('Property','Value',...) creates a new BATTLESHIP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Battleship_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Battleship_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Battleship

% Last Modified by GUIDE v2.5 15-Jan-2022 22:18:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Battleship_OpeningFcn, ...
                   'gui_OutputFcn',  @Battleship_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Battleship is made visible.
function Battleship_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Battleship (see VARARGIN)

% Choose default command line output for Battleship
handles.output = hObject;
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('background.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1); title('Map 1','FontSize',16);
axis equal off
hold on
%board
global n shipname sizes running iteration1 iteration board2 board1 p1 p2;
running= 1; % true if game is running, false otherwise
n = 15;
for i=0:n-1
    for j=0:n-1
        % Draw board
        fill([i i+1 i+1 i i],[j j j+1 j+1 j],[0.2 0.4 1])
    end
end
axes(handles.axes2); title('Map 2','FontSize',16);
axis equal off %
hold on 
for i=-n+1:0
    for j=-n+1:0
        fill([i i-1 i-1 i i],[j j j-1 j-1 j],[0.2 0.4 1])
    end
end
shipname = {' 1 cell ship',' 1 cell ship',' 1 cell ship',' 1 cell ship ',' 2 cells ship',' 2 cells ship',' 2 cells ship',' 3 cells ship',' 3 cells ship',' 4 cells ship'};
sizes = [1, 1, 1, 1, 2, 2, 2, 3, 3, 4];
iteration = 1; iteration1 =1;
board2 = zeros(15); board1 = zeros(15);
set(handles.m1,'visible','off');
set(handles.m2,'visible','off');
p1=0; p2=0;

figure('Name','Rule','Numbertitle','off'),imshow('rule.png'); title('Rule');
% UIWAIT makes Battleship wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Battleship_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global n p2 p1 battlemode turn mapstatus1 mapstatus2 numhit1 numhit2;
if p1==1 && p2==1
    battlemode=1; %inable guess buttons 
    axes(handles.axes1)
    axis equal off
    hold on 
    for i=0:n-1
        for j=0:n-1
            fill([i i+1 i+1 i i],[j j j+1 j+1 j],[0.2 0.4 1])
        end
    end
    axes(handles.axes2)
    axis equal off
    hold on 
    for i=1-n:0
        for j=1-n:0
            fill([i i-1 i-1 i i],[j j j-1 j-1 j],[0.2 0.4 1])
        end
    end
    set(handles.m1,'visible','on');
    set(handles.m1,'enable','on');
    set(handles.set_up_button,'visible','off');
    set(handles.set_up_button2,'visible','off');
    set(handles.Save_button,'visible','off');
    set(handles.pushbutton5,'visible','off');
    turn=1; %first turn for player 2 (map 1)
    mapstatus1=zeros(n); %check the status of chosen cell map p1 (chosen in the past or not)
    numhit1=0; %cells of p1 ships will be sink by player 2 
    mapstatus2=zeros(n); %check the status of chosen cell  map p2 (chosen in the past or not)
    numhit2=0; %cells of p2 ships will be sink by player 1 
    set(handles.game_text,'String','Battle!!!');
else 
    set(handles.game_text,'String','Players have not finished set up');
end

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in set_up_button.
function set_up_button_Callback(hObject, eventdata, handles)
% hObject    handle to set_up_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.game_text,'String','Player 1 ships set up'); 
axes(handles.axes1); global board1 shipname sizes iteration it;
it = iteration;
for i = it:1:numel(sizes)
    shipsize = sizes(i);
    shiptype = cell2mat(shipname(i));
    k = 0;
    while k ~= 1
        if shipsize == 1
            x = inputdlg({'Column:','Row:'},shiptype,[1 50;1 50]);
            col = str2num(cell2mat(x(1))); 
            row = str2num(cell2mat(x(2))); 
            if (row>15) || (col>15)
                set(handles.game_text,'String','Ship exceeded the map');
            else            
                if board1(row,col) == 1
                   set(handles.game_text,'String','There already a ship here!');
                else
                    fill([col-1 col col col-1 col-1],15-[row row row-1 row-1 row],'k');    
                    board1(row,col) = 1; 
                    k = 1; iteration = i+1;
                    set(handles.game_text,'String','Player 1 ships set up'); 
                end
            end
        else
        x = inputdlg({'Start column:','Start row:','Orientation (odd-vertical, even-horizontal):'},shiptype,[1 50;1 50;1 50]);
        col = str2num(cell2mat(x(1))); %pick a start column 
        row = str2num(cell2mat(x(2))); %pick a start row
        orient = str2num(cell2mat(x(3)));   
        if mod(orient,2) == 0
                if (col>15) || (row>15) || (col+shipsize-1 > 15)
                    set(handles.game_text,'String','Ship exceeded the map');                   
                else er = 0;
                    for w = 0:shipsize-1
                        if board1(row,col+w) == 1
                        er = 1;
                        end
                     end
                     if er == 0
                        for c = (col):(col+shipsize-1)
                            k = 1; set(handles.game_text,'String','Player 1 ships set up'); 
                            board1(row,c) = 1; iteration = i+1;
                            fill([col col+shipsize col+shipsize col col]-1,16-[row+1 row+1 row row row+1],'k');
                        end
                     else 
                            set(handles.game_text,'String','There already a ship here!'); 
                     end
                end                
        else if mod(orient,2) == 1 
            if (row>15) || (col>15) || (row+shipsize-1 > 15)
                   set(handles.game_text,'String','Ship exceeded the map');                  
            else er =0;
                for w = 0:shipsize-1
                        if board1(row+w,col) == 1
                        er = 1;
                        end
                  end
                  if er == 0
                        for r = (row):(row+shipsize-1)
                              k = 1;set(handles.game_text,'String','Player 1 ships set up'); 
                              board1(r,col) = 1;iteration = i+1;
                              fill([col col-1 col-1 col col],16-[row row row+shipsize row+shipsize row],'k');
                        end
                  else 
                        set(handles.game_text,'String','There already a ship here!'); 
                  end                  
             end
             end  
        end
    end    
end
end
% --- Executes on button press in set_up_button2.
function set_up_button2_Callback(hObject, eventdata, handles)
% hObject    handle to set_up_button2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.game_text,'String','Player 2 ships set up'); 
axes(handles.axes2); global it1 board2 shipname sizes iteration1;
it1 = iteration1;
for i = it1:1:numel(sizes)
    shipsize = sizes(i);
    shiptype = cell2mat(shipname(i));
k = 0;
    while k ~= 1
        if shipsize == 1
            x = inputdlg({'Column:','Row:'},shiptype,[1 50;1 50]);
            col = str2num(cell2mat(x(1))); 
            row = str2num(cell2mat(x(2))); 
            if (row>15) || (col>15)
                set(handles.game_text,'String','Ship exceeded the map');
            else            
                if board2(row,col) == 1
                   set(handles.game_text,'String','There already a ship here!');
                else
                    fill([col-16 col-15 col-15 col-16 col-16],-[row row row-1 row-1 row],'k');  
                    board2(row,col) = 1; 
                    k = 1; iteration1 = i+1;
                    set(handles.game_text,'String','Player 2 ships set up'); 
                end
            end
        else
        x = inputdlg({'Start column:','Start row:','Orientation (odd-vertical, even-horizontal):'},shiptype,[1 50;1 50;1 50]);
        col = str2num(cell2mat(x(1))); %pick a start column 
        row = str2num(cell2mat(x(2))); %pick a start row
        orient = str2num(cell2mat(x(3)));   
        if orient == 2
                if (col>15) || (row>15) || (col+shipsize-1 > 15)
                    set(handles.game_text,'String','Ship exceeded the map');                   
                else  er =0;
                    for w = 0:shipsize-1
                        if board2(row,col+w) == 1
                            er = 1;
                        end
                     end
                     if er == 0
                            for c = (col):(col+shipsize-1)
                                k = 1; set(handles.game_text,'String','Player 2 ships set up'); 
                                board2(row,c) = 1; iteration1 = i +1;
                                fill([col col+shipsize col+shipsize col col]-16,1-[row+1 row+1 row row row+1],'k');
                            end
                     else
                         set(handles.game_text,'String','There already a ship here!');
                     end

                end
                
        else if mod(orient,2) == 1
            if (row>15) || (col>15) || (row+shipsize-1 > 15)
                   set(handles.game_text,'String','Ship exceeded the map');                  
            else  er =0;
                for w = 0:shipsize-1
                        if board2(row+w,col) == 1
                            er = 1;
                        end
                     end
                     if er == 0
                            for r = (row):(row+shipsize-1)
                                k = 1; set(handles.game_text,'String','Player 2 ships set up'); 
                                board2(r,col) = 1; iteration1 = i +1;                               
                                fill([col col-1 col-1 col col]-15,1-[row row row+shipsize row+shipsize row],'k');
                            end
                     else
                         set(handles.game_text,'String','There already a ship here!');
                     end                                  
                end
            end            
           end  
        end
    end    
end


% --- Executes on button press in Save_button.
function Save_button_Callback(hObject, eventdata, handles)
% hObject    handle to Save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global board1 n p1;
ships = 0;
for i = 1:n
    for j = 1:n
        if board1(i,j) == 1
            ships = ships +1;
        end
    end
end
if ships == 20
    set(handles.game_text,'String','Player 1 ready!!!');    
    axes(handles.axes1)
    axis equal off
    hold on 
    for i=0:n-1
        for j=0:n-1
            fill([i i+1 i+1 i i],[j j j+1 j+1 j],[0.2 0.4 1])
        end
    end
    set(handles.set_up_button,'enable','off');
    set(handles.Save_button,'enable','off');
    p1 = 1;
    board1=board1';
else
    set(handles.game_text,'String','Player 1 have not finished set up');
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)ation
global board2 n p2;
ships = 0;
for p = 1:n
    for q = 1:n
        if board2(p,q) == 1
            ships = ships +1;
        end
    end
end
if ships == 20
    axes(handles.axes2)
    axis equal off
    hold on 
    set(handles.game_text,'String','Player 2 ready!!!');
    for i=-n+1:0
        for j=-n+1:0
            fill([i i-1 i-1 i i],[j j j-1 j-1 j],[0.2 0.4 1])
        end
    end
    set(handles.set_up_button2,'enable','off');
    set(handles.pushbutton5,'enable','off');
    p2 = 1;
    board2=board2';
else
    set(handles.game_text,'String','Player 2 have not finished set up');
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in m1.
function m1_Callback(hObject, eventdata, handles)
% hObject    handle to m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global board1 n numhit1 mapstatus1 battlemode turn board2 numhit2 mapstatus2;
if battlemode==1 %check whether play button has been activated or not      %CONSIDER DELEATE   
    if turn==1
        set(handles.game_text,'String','Time to attack map 1');
        [x,y]=ginput(1);
        X=ceil(x);
        Y=n-ceil(y)+1;
        if X<=n && Y<=n && X>=1 && Y>=1 %ensures user clicks within playing field
            if mapstatus1(X,Y)==0 %the cell has not been uncovered
                mapstatus1(X,Y)=1;
                if board1(X,Y)~=0 %the cell contains the part of the ship
                    set(handles.game_text,'String','Player 2 hits!');
                    fill([X-1 X X X-1 X-1],[n-Y n-Y n-Y+1 n-Y+1 n-Y],'r');
                    numhit1=numhit1+1;
                    if numhit1<sum(board1(:)~=0) %Check the number of player 2 ships have been sink (by player 2)
                        turn=2;
                    else
                        set(handles.game_text,'String','PLAYER 2 WINS!!!'); 
                        set(handles.m1,'enable','off'); 
                        battlemode=0; %not really useful because all the button is off except the replay one
                    end
                else %the cell does not contain the part of the ship
                    set(handles.game_text,'String','Player 2 miss!');            
                    fill([X-1 X X X-1 X-1],[n-Y n-Y n-Y+1 n-Y+1 n-Y],'w');
                    turn=2;    
                end
            elseif mapstatus1(X,Y)==1 %the cell has already been uncovered
                set(handles.game_text,'String','The cell has already been chosen. Try again!');
            end
        end
    elseif turn==2
        set(handles.game_text,'String','Time to attack map 2');
        [x,y]=ginput(1);
        X=ceil(x);
        Y=ceil(y)-1;
        if X<=0 && Y<=0 && X>=-n && Y>=-n %ensures user clicks within playing field
            if mapstatus2(X+15,-Y)==0 %the cell has not been uncovered
                mapstatus2(X+15,-Y)=1;
                if board2(X+15,-Y)~=0 %the cell contains the part of the ship
                    set(handles.game_text,'String','Player 1 hits!');
                    fill([X-1 X X X-1 X-1],[Y Y Y+1 Y+1 Y],'r');
                    numhit2=numhit2+1;
                    if numhit2<sum(board2(:)~=0) %Check the number of player 2 ships have been sink (by player 2)
                        turn=1;                  
                    else
                        set(handles.game_text,'String','PLAYER 1 WINS!!!');
                        set(handles.m1,'enable','off');
                        battlemode=0; %not really useful because all the button is off except the replay one
                    end
                else %the cell does not contain the part of the ship
                    set(handles.game_text,'String','Player 1 miss!');
                    fill([X-1 X X X-1 X-1],[Y Y Y+1 Y+1 Y],'w');
                    turn=1;
                end
            elseif mapstatus2(X+15,-Y)==1 %the cell has already been uncovered
                set(handles.game_text,'String','The cell has already been chosen. Try again!');
            end
        end
    end
   
end


% --- Executes during object creation, after setting all properties.
function game_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to game_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in restart.
function restart_Callback(hObject, eventdata, handles)
% hObject    handle to restart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global board1 board2 p1 p2 iteration iteration1 running
set(handles.set_up_button,'Visible','on');
set(handles.set_up_button,'Enable','on');

set(handles.set_up_button2,'Visible','on');
set(handles.set_up_button2,'Enable','on');

set(handles.Save_button,'Visible','on');
set(handles.Save_button,'Enable','on');

set(handles.pushbutton5,'Visible','on');
set(handles.pushbutton5,'Enable','on');
set(handles.m1,'Visible','off');
set(handles.m2,'Visible','off');
iteration=1;
iteration1=1;
board1=zeros(15);
board2=zeros(15);
axes(handles.axes1); title('Map 1','FontSize',16);
axis equal off
hold on
%board
running= 1; % true if game is running, false otherwise
n = 15;
for i=0:n-1
    for j=0:n-1
        % Draw board
        fill([i i+1 i+1 i i],[j j j+1 j+1 j],[0.2 0.4 1])
    end
end
axes(handles.axes2); title('Map 2','FontSize',16);
axis equal off %
hold on 
for i=-n+1:0
    for j=-n+1:0
        fill([i i-1 i-1 i i],[j j j-1 j-1 j],[0.2 0.4 1])
    end
end
p1=0;
p2=0;
set(handles.game_text,'String','Hello players (again)!');
