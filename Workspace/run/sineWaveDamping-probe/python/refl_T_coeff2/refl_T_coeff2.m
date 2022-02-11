function varargout = refl_T_coeff2(varargin)
%REFL_T_COEFF2 M-file for refl_T_coeff2.fig
%      REFL_T_COEFF2, by itself, creates a new REFL_T_COEFF2 or raises the existing
%      singleton*.
%
%      H = REFL_T_COEFF2 returns the handle to a new REFL_T_COEFF2 or the handle to
%      the existing singleton*.
%
%      REFL_T_COEFF2('Property','Value',...) creates a new REFL_T_COEFF2 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to refl_T_coeff2_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      REFL_T_COEFF2('CALLBACK') and REFL_T_COEFF2('CALLBACK',hObject,...) call the
%      local function named CALLBACK in REFL_T_COEFF2.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help refl_T_coeff2

% Last Modified by GUIDE v2.5 04-May-2012 11:57:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @refl_T_coeff2_OpeningFcn, ...
                   'gui_OutputFcn',  @refl_T_coeff2_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before refl_T_coeff2 is made visible.
function refl_T_coeff2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for refl_T_coeff2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes refl_T_coeff2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = refl_T_coeff2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Horizontal.
function Horizontal_Callback(hObject, eventdata, handles)
% hObject    handle to Horizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Horizontal
if (get(hObject,'Value') == get(hObject,'Max'))   
        guidata(hObject,handles)
        handles.Horizontal;
end

% --- Executes on button press in Vertical.
function Vertical_Callback(hObject, eventdata, handles)
% hObject    handle to Vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Vertical
if (get(hObject,'Value') == get(hObject,'Max'))   
        guidata(hObject,handles)
        handles.Vertical;
end


function frequency_Callback(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency as text
%        str2double(get(hObject,'String')) returns contents of frequency as a double
frequency = str2double(get(hObject,'string'));
handles.frequency=frequency;
if isnan(frequency)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
	return
end
guidata(hObject,handles)
handles.frequency;

% --- Executes during object creation, after setting all properties.
function frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in brick.
function brick_Callback(hObject, eventdata, handles)
% hObject    handle to brick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of brick
if (get(hObject,'Value') == get(hObject,'Max'))   
        guidata(hObject,handles)
        handles.brick;
end

% --- Executes on button press in copper.
function copper_Callback(hObject, eventdata, handles)
% hObject    handle to copper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of copper
if (get(hObject,'Value') == get(hObject,'Max'))   
        guidata(hObject,handles)
        handles.copper;
end


function meters_Callback(hObject, eventdata, handles)
% hObject    handle to meters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meters as text
%        str2double(get(hObject,'String')) returns contents of meters as a double
meters = str2double(get(hObject,'string'));
handles.meters=meters;
if isnan(meters)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
	return
end
guidata(hObject,handles)
handles.meters;

% --- Executes during object creation, after setting all properties.
function meters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_plot_btn.
function show_plot_btn_Callback(hObject, eventdata, handles)
% hObject    handle to show_plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Horizontal=get(handles.Horizontal,'value');
Vertical=get(handles.Vertical,'value');
brick=get(handles.brick,'value');
copper=get(handles.copper,'value');
meters=handles.meters;
frequency=handles.frequency;
frequency=frequency.*10.^9;
if(brick);
    
    er=5.4;
    s=0.018;
    
end

if(copper);
    
    er=5.4;
    s=100;
    
end

%/////Other Input Variables//////
e0=8.854e-12;
c=3e8;
WL=c/frequency;

%/////Computing e_complex//////
ecomplex=er*(1-j*(s/(er*2*pi*frequency*e0)));


%/////Define angle///
theta=0:pi/200:pi/2;

delta=(2.*pi./WL).*meters.*sqrt(ecomplex-sin(theta).^2);

if(Vertical);
    R_tonos=(cos(theta)-sqrt(ecomplex-(sin(theta)).^2))./(cos(theta)+sqrt(ecomplex-(sin(theta)).^2));
elseif(Horizontal)
    R_tonos=(ecomplex.*cos(theta)-sqrt(ecomplex-(sin(theta)).^2))./(ecomplex.*cos(theta)+sqrt(ecomplex-(sin(theta)).^2));
end

R=((1-exp(-j.*2.*delta))./(1-(R_tonos.^2.*exp(-j.*2.*delta)))).*R_tonos;
T=(((1-R_tonos.^2).*exp(-j.*(delta-(2.*pi./WL).*meters)))./(1-(R_tonos.^2.*exp(-j.*2.*delta))));

axes(handles.axes1)
plot(handles.axes1,theta*180/pi,abs(R),'black')
xlabel('Angle')
ylabel('Reflection coefficient')

axes(handles.axes2)
plot(handles.axes2,theta*180/pi,abs(T),'black')
xlabel('Angle')
ylabel('Transmission coefficient')


% --- Executes on button press in contact_btn.
function contact_btn_Callback(hObject, eventdata, handles)
% hObject    handle to contact_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('george.koutitas@gmail.com,alexiosfourlis@gmail.com','Email');

% --- Executes on button press in about_btn.
function about_btn_Callback(hObject, eventdata, handles)
% hObject    handle to about_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Source code by Dr G.Koutitas,GUI develepment by Alexios Fourlis','About');