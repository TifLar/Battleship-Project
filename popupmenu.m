function varargout = popupmenu(varargin)
% POPUPMENU MATLAB code for popupmenu.fig
%      POPUPMENU, by itself, creates a new POPUPMENU or raises the existing
%      singleton*.
%
%      H = POPUPMENU returns the handle to a new POPUPMENU or the handle to
%      the existing singleton*.
%
%      POPUPMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POPUPMENU.M with the given input arguments.
%
%      POPUPMENU('Property','Value',...) creates a new POPUPMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before popupmenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to popupmenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help popupmenu

% Last Modified by GUIDE v2.5 13-Dec-2021 15:41:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @popupmenu_OpeningFcn, ...
                   'gui_OutputFcn',  @popupmenu_OutputFcn, ...
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


% --- Executes just before popupmenu is made visible.
function popupmenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to popupmenu (see VARARGIN)

% Choose default command line output for popupmenu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes popupmenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = popupmenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu.
function popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu
%gets the selected option
switch get(handles.popupmenu,'Value')
    case 1
        set(handles.testing,'FontSize',8);
    case 2
        set(handles.testing,'FontSize',10);
    case 3
        set(handles.testing,'FontSize',12);
    case 4
        set(handles.testing,'FontSize',14);
    case 5
        set(handles.testing,'FontSize',16);
    otherwise
end



% --- Executes during object creation, after setting all properties.
function popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
