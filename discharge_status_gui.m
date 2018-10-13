global data


delete(instrfindall);
seriallist;
instrhwinfo;
s=serial('COM2');
fopen(s);


while(toc-b<100)
fwrite(s,data);
pause(1);
end


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

end
% --- Executes just before dsc_en is made visible.
function dsc_en_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dsc_en (see VARARGIN)

% Choose default command line output for dsc_en
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dsc_en wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = dsc_en_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end
% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
	data=1;
    display('up');
    display(data);
elseif button_state == get(hObject,'Min')
	data=0;
    display('down');
    display(data);
end

guidata(hObject, handles);
end
% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
end

