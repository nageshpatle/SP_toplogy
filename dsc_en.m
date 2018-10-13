function varargout = dsc_en(varargin)
% DSC_EN MATLAB code for dsc_en.fig
%      DSC_EN, by itself, creates a new DSC_EN or raises the existing
%      singleton*.
%
%      H = DSC_EN returns the handle to a new DSC_EN or the handle to
%      the existing singleton*.
%
%      DSC_EN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSC_EN.M with the given input arguments.
%
%      DSC_EN('Property','Value',...) creates a new DSC_EN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dsc_en_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dsc_en_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dsc_en

% Last Modified by GUIDE v2.5 17-Aug-2018 16:29:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @dsc_en_OpeningFcn, ...
    'gui_OutputFcn',  @dsc_en_OutputFcn, ...
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


% --- Executes just before dsc_en is made visible.
function dsc_en_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dsc_en (see VARARGIN)
delete(instrfindall);
s=serial('COM2');
handles.portname=s;
fopen(s);


% Choose default command line output for dsc_en
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dsc_en wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dsc_en_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1

%hObject.Value=1-hObject.Value;

button_state = get(hObject,'Value');

if button_state == 1.0
    
    fwrite(handles.portname,1);
    set(handles.currstatus,'String','Enabled');
elseif button_state == 0.0
    fwrite(handles.portname,0);
    set(handles.currstatus,'String','Disabled');
    %pause(3);
end

guidata(hObject, handles);
% --- Executes on key press with focus on figure1 or any of its controls.
