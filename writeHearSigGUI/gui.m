function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 18-Apr-2014 13:37:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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



% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
p=initVar;
axis('off');
imshow('logopaper.png','Parent',handles.axes4);

handles.p=p;
guidata(hObject,handles)
clc

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in WriteSignature.
function WriteSignature_Callback(hObject, eventdata, handles)
% hObject    handle to WriteSignature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=handles.p;
[s,p]=loaddata(p);
if strcmp(get(handles.WriteSignature,'string'),'Stop')
    stop(p.recObj);
    f.xUnfiltRaw = getaudiodata(p.recObj)';
    set(handles.WriteSignature,'string','Start');
    [f,p]=filters(f,p);
    f=sigStore(f,p);
    [f,p]=compare(s,f,p);
    disp(f.comp);
    if f.res==1
        set(handles.Granted,'visible','on');
        set(handles.Granted,'string','Access Granted');
        color='g';
        set(handles.Granted,'ForegroundColor','g')
    else
        set(handles.Granted,'visible','on');
        set(handles.Granted,'string','Access Denied');
        color='r';
        set(handles.Granted,'ForegroundColor','r')
    end
    set(handles.Granted,'ForegroundColor',color)
    cla(handles.axes1);
    for k=1:length(s.C)
    plot(handles.axes1,linspace(0,1,length(s.C{k})),s.C{k}-mean(s.C{k}),'LineWidth',1);
    hold('on');
    end
    plot(handles.axes1,linspace(0,1,length(f.C)),f.C-mean(f.C),color,'LineWidth',4);
    axis off
    handles.f=f;
    guidata(hObject,handles)
    set(handles.Save,'Enable','on');

else
    set(handles.Granted,'visible','off');
    p.recObj = audiorecorder(p.hz,16,1,p.recd);
    set(handles.WriteSignature,'string','3');
    pause(0.7);
    set(handles.WriteSignature,'string','2');
    pause(0.7);
    set(handles.WriteSignature,'string','1');
    pause(0.7);
    set(handles.WriteSignature,'string','Stop');
    record(p.recObj);
    handles.p=p;
    guidata(hObject,handles)
end




function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name as text
%        str2double(get(hObject,'String')) returns contents of name as a double


% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Enter.
function Enter_Callback(hObject, eventdata, handles)
% hObject    handle to Enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=handles.p;
p.user=get(handles.name,'string');
set(handles.none,'string',p.user);
set(handles.LearnSignature,'Enable','on');
set(handles.Granted,'visible','off');
if exist([p.user '.mat'],'file')
    [s,p]=loaddata(p);
    set(handles.WriteSignature,'Enable','on');
    cla(handles.axes1);
    plot(handles.axes1,linspace(0,1,length(s.M{1})),s.M{1});
    hold('on');
    plot(handles.axes1,linspace(0,1,length(s.C{1})),s.C{1},'r','LineWidth',4)
    axis off
else
    set(handles.WriteSignature,'Enable','off')
end
set(handles.name,'string','');
handles.p=p;
guidata(hObject,handles)

% --- Executes on button press in LearnSignature.
function LearnSignature_Callback(hObject, eventdata, handles)
% hObject    handle to LearnSignature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=handles.p;

set(handles.Granted,'visible','off');
if strcmp(get(handles.LearnSignature,'string'),'Stop Listening')
    stop(p.recObj);
    f.xUnfiltRaw = getaudiodata(p.recObj)';
    set(handles.LearnSignature,'string','Learn Signature');
    [f,p]=filters(f,p);
    f=sigStore(f,p);
    cla(handles.axes1);
    plot(handles.axes1,linspace(0,p.t,length(f.M)),f.M);
    hold('on');
    plot(handles.axes1,linspace(0,p.t,length(f.C)),f.C,'r','LineWidth',4)
    axis off
    savedata(f,p);
    set(handles.WriteSignature,'Enable','on');
    soundsc(f.M,p.hz,16);
    pause(p.t);
else
    p.recObj = audiorecorder(p.hz,16,1,p.recd);
    set(handles.LearnSignature,'string','3');
    pause(0.7);
    set(handles.LearnSignature,'string','2');
    pause(0.7);
    set(handles.LearnSignature,'string','1');
    pause(0.7);
    set(handles.LearnSignature,'string','Stop Listening');
    record(p.recObj);
    handles.p=p;
    guidata(hObject,handles)
end


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=handles.p;
f=handles.f;
set(handles.Save,'Enable','off');
savedata2(f,p);
