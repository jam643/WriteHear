function varargout = gui(varargin)

% Last Modified by GUIDE v2.5 16-Jul-2014 13:10:29

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
initHandles(hObject,handles);
p=initVar;
axis('off');
imshow('back2.png','Parent',handles.axes1);
handles.p=p;
guidata(hObject,handles)
clc


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
if ~isempty(get(handles.name,'string'))
    p=handles.p;
    p.user=get(handles.name,'string');
    [p]=updateHandles(p,hObject,handles);
    set(handles.name,'string','');
    handles.p=p;
    guidata(hObject,handles)
end


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.Start,'string'),'Start')
    p=handles.p;
    load([p.user,'.mat']);
    set(handles.menuSpell,'string',' ','value',1);
    set(handles.Start,'enable','off');
    p=countdown(p,hObject,handles);
    set(handles.Start,'enable','on','string','Stop','BackgroundColor',[0.68,0.92,1]);
    set(handles.character,'visible','off');
    go=1;
    while go==1 && strcmp(get(handles.Start,'string'),'Stop')
        clear f
        [f,p,i]=predict(p,s,hObject,handles);
        f.text=get(handles.text,'string');
        if i==1
            go=0;
        else
            set(handles.menuSpell,'string',' ','value',1);
            if get(handles.spellCheck,'Value')
                [f,p]=spellCheck(f,p,s,hObject,handles);
            end
            f.text=sprintf([f.text,'_'],'Interpreter','none');
            set(handles.text,'string',f.text);
        end
    end
    set(handles.Start,'String','Start','BackgroundColor','w');
elseif strcmp(get(handles.Start,'string'),'Stop')
    set(handles.Start,'string','Start','BackgroundColor','w')
end



function editChar_Callback(hObject, eventdata, handles)
% hObject    handle to editChar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function editChar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editChar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in learn.
function learn_Callback(hObject, eventdata, handles)
% hObject    handle to learn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

p=handles.p;
f.char=lower(get(handles.editChar,'string'));
f.nRep=str2double(get(handles.nRep,'string'));
if isnan(f.nRep) || f.nRep>7 || f.nRep<1
    f.nRep=3;
    set(handles.nRep,'string','3');
end
if length(f.char)==1 && strcmp(get(handles.learn,'string'),'+')
    set(handles.learn,'enable','off');
    p=countdown(p,hObject,handles);
    set(handles.learn,'string','Quit','enable','on','FontSize',7,'BackgroundColor',[0.68,0.92,1]);
    set(handles.write,'Visible','on');
    [f,p,i]=learn(f,p,hObject,handles);
    set(handles.character,'Visible','off');
    set(handles.write,'Visible','off');
    if i-1==f.nRep
        [s]=savedata1(f,p);
        save(p.user,'p','s');
        [p]=updateHandles(p,hObject,handles);
        set(handles.editChar,'string','');
        plots1(f,p);
    end
    handles.p=p;
    guidata(hObject,handles);
    set(handles.learn,'string','+','FontSize',16,'BackgroundColor','w');
elseif strcmp(get(handles.learn,'string'),'Quit')
    set(handles.learn,'string','+','FontSize',16,'BackgroundColor','w');
end


% --- Executes on button press in spellCheck.
function spellCheck_Callback(hObject, eventdata, handles)
% hObject    handle to spellCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function dictionary_Callback(hObject, eventdata, handles)
% hObject    handle to dictionary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function dictionary_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dictionary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.add,'Enable','off');
ar=addRem(get(handles.dictionary,'string'),1);
if ar
    set(handles.dictionary,'string','');
end
set(handles.add,'Enable','on');


% --- Executes on button press in remove.
function remove_Callback(hObject, eventdata, handles)
% hObject    handle to remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.remove,'Enable','off');
ar=addRem(get(handles.dictionary,'string'),0);
if ar
    set(handles.dictionary,'string','');
end
set(handles.remove,'Enable','on');


% --- Executes on selection change in list.
function list_Callback(hObject, eventdata, handles)
% hObject    handle to list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in view.
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.view,'string'),'View')
    load('words','W');
    set(handles.list,'string',W,'visible','on')
    set(handles.view,'string','Close')
    set(handles.view,'BackgroundColor',[.68,.92,1]);
else
    set(handles.list,'string','','visible','off')
    set(handles.view,'string','View');
    set(handles.view,'BackgroundColor','w');
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.reset,'enable','off')
load('words','W');
load('wordsDup','WD');
W=WD;
save('words','W');
set(handles.reset,'enable','on')


% --- Executes on button press in buttonPlot.
function buttonPlot_Callback(hObject, eventdata, handles)
% hObject    handle to buttonPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=handles.p;
load([p.user,'.mat']);
if max(findobj==2)
    close figure 2
end
h=figure(2);
set(h,'units','normalized','outerposition',[0 .1 1 .9])
color='krgbmcy';
k=0;
for j=1:length(s.seq)
    scrollsubplot(2,2,j)
    hold on
    title(s.seq(j),'fontWeight','Bold','fontSize',16);
    for i=1:s.nRepSeq(j)        
        k=k+1;
        if s.nRepSeq(j)<=length(color)
            plot(linspace(0,(length(s.Sseq{k})-1)/p.hzs,length(s.Sseq{k})),s.Sseq{k},color(i),'LineWidth',3);
        else
            plot(linspace(0,(length(s.Sseq{k})-1)/p.hzs,length(s.Sseq{k})),s.Sseq{k},'k','LineWidth',2);
        end
    end
end

s=calcAccuracy(s);

save(p.user,'s','p');
for i=1:length(s.seq)
    xlab{i}=s.seq(i);
end
if max(findobj==3)
    close figure 3
end
h=figure(3);
set(h,'units','normalized','outerposition',[0 .1 1 .9])
bar(s.accuracy);
set(gca,'XTick',1:length(s.seq),'XTickLabel',xlab)
ylim([0,100]);
xlabel('Characters')
ylabel('Accuracy')
title(sprintf('Average Accuracy=%.1f%% Number of Comparisons=%d',mean(s.accuracy),min(s.nRepSeq)-1));

% --- Executes on button press in buttonClear.
function buttonClear_Callback(hObject, eventdata, handles)
% hObject    handle to buttonClear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=handles.p;
load([p.user,'.mat']);
save(p.user,'p');
[p]=updateHandles(p,hObject,handles);


% --- Executes on button press in buttonForget.
function buttonForget_Callback(hObject, eventdata, handles)
% hObject    handle to buttonForget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=handles.p;
load([p.user,'.mat'])
start=1;
done=0;
k=0;
while done==0 && k<length(s.seq)
    k=k+1;
    if strcmp(get(handles.editChar,'string'),s.seq(k))
        i=str2double(get(handles.nRep,'string'));
        s.Sseq(max(start,start-i+s.nRepSeq(k)):start+s.nRepSeq(k)-1)=[];
%         s.Fseq(max(start,start-i+s.nRepSeq(k)):start+s.nRepSeq(k)-1)=[];
        %         s.Fseq(start:start+s.nRepSeq(k)-1)=[];
        %         s.Rseq(start:start+s.nRepSeq(k)-1)=[];
        if s.nRepSeq(k)<i+1
            s.seq(k)=[];
            s.nRepSeq(k)=[];
        else
            s.nRepSeq(k)=s.nRepSeq(k)-i;
        end
        done=1;
    end
    if done==0;
        start=start+s.nRepSeq(k);
    end
end

save(p.user,'s','p');
[p]=updateHandles(p,hObject,handles);
set(handles.editChar,'string','');



function nRep_Callback(hObject, eventdata, handles)
% hObject    handle to nRep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nRep as text
%        str2double(get(hObject,'String')) returns contents of nRep as a double


% --- Executes during object creation, after setting all properties.
function nRep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nRep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in menuSpell.
function menuSpell_Callback(hObject, eventdata, handles)
% hObject    handle to menuSpell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menuSpell contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menuSpell
i=get(handles.menuSpell,'value');
f.text=get(handles.text,'string');
f.guess=get(handles.menuSpell,'string');
if i==length(get(handles.menuSpell,'string'));
    f.text(length(f.text)-length(f.guess{1}):length(f.text))='';
    set(handles.menuSpell,'value',1);
    set(handles.menuSpell,'string',' ')
    set(handles.text,'string',f.text);
else
    f.text(length(f.text)-length(f.guess{1}):length(f.text))= [f.guess{i},'_'];
    set(handles.text,'string',f.text);
end


% --- Executes during object creation, after setting all properties.
function menuSpell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuSpell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clearText.
function clearText_Callback(hObject, eventdata, handles)
% hObject    handle to clearText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text,'string','');
set(handles.menuSpell,'string',' ','value',1);


% --- Executes on button press in helpB.
function helpB_Callback(hObject, eventdata, handles)
% hObject    handle to helpB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.helpB,'string'),'Help')
    set(handles.helpB,'string','Close')
    set(handles.helpL,'visible','on')
    set(handles.helpB,'BackgroundColor',[0.68,0.92,1]);
    set(handles.Start,'visible','off');
    set(handles.text,'visible','off');
else
    set(handles.helpL,'visible','off')
    set(handles.helpB,'BackgroundColor','w');
    set(handles.helpB,'string','Help')
    set(handles.Start,'visible','on');
    set(handles.text,'visible','on');
end


% --- Executes on button press in settingsB.
function settingsB_Callback(hObject, eventdata, handles)
% hObject    handle to settingsB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=handles.p;
if strcmp(get(handles.settingsB,'string'),'Settings')
    nDevices = audiodevinfo(1);
    for k=1:nDevices
        info=audiodevinfo;
        ID=info.input(1,k).ID;
        mic{k}=audiodevinfo(1,ID);
        mic{k}=sprintf([mic{k},'%d'],ID);
    end
    set(handles.micM,'string',mic)
    set(handles.teachP,'visible','off');
    set(handles.listenP,'visible','off');
    set(handles.text,'visible','off');
    set(handles.dictionaryP,'visible','off');
    set(handles.settingsP,'visible','on')
    set(handles.settingsB,'string','Close')
    set(handles.settingsB,'BackgroundColor',[0.68,0.92,1]);
    v=1;
    while v<nDevices && p.recd~=str2double(mic{v}(end))
        v=v+1;
    end        
    set(handles.micM,'value',v);
    set(handles.sampleE,'string',p.hz);
    set(handles.lowE,'string',p.lowhz);
    set(handles.highE,'string',p.highz);
    set(handles.windowE,'string',p.smoothWidth*1000/p.hz);
    set(handles.incrementE,'string',p.smoothIncrem*1000/p.hz);
    set(handles.characterE,'string',p.minWidth/p.hzs);
    set(handles.endcharE,'string',p.spaceWidth/p.hzs);
    set(handles.endwordE,'string',p.endWidth/p.hzs);
    set(handles.endwriteE,'string',p.stopWidth/p.hzs);  
    set(handles.noiseE,'string',p.noiseC);
    set(handles.Start,'visible','off');
else
    set(handles.settingsP,'visible','off')
    set(handles.settingsB,'BackgroundColor','w');
    set(handles.settingsB,'string','Settings')
    set(handles.teachP,'visible','on');
    set(handles.listenP,'visible','on');
    set(handles.dictionaryP,'visible','on');
    set(handles.text,'visible','on');
    set(handles.Start,'visible','on');
end


% --- Executes on selection change in micM.
function micM_Callback(hObject, eventdata, handles)
% hObject    handle to micM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns micM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from micM


% --- Executes during object creation, after setting all properties.
function micM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to micM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sampleE_Callback(hObject, eventdata, handles)
% hObject    handle to sampleE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sampleE as text
%        str2double(get(hObject,'String')) returns contents of sampleE as a double


% --- Executes during object creation, after setting all properties.
function sampleE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampleE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowE_Callback(hObject, eventdata, handles)
% hObject    handle to lowE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowE as text
%        str2double(get(hObject,'String')) returns contents of lowE as a double


% --- Executes during object creation, after setting all properties.
function lowE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function highE_Callback(hObject, eventdata, handles)
% hObject    handle to highE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of highE as text
%        str2double(get(hObject,'String')) returns contents of highE as a double


% --- Executes during object creation, after setting all properties.
function highE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to highE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function windowE_Callback(hObject, eventdata, handles)
% hObject    handle to windowE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windowE as text
%        str2double(get(hObject,'String')) returns contents of windowE as a double


% --- Executes during object creation, after setting all properties.
function windowE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function incrementE_Callback(hObject, eventdata, handles)
% hObject    handle to incrementE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of incrementE as text
%        str2double(get(hObject,'String')) returns contents of incrementE as a double


% --- Executes during object creation, after setting all properties.
function incrementE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to incrementE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function characterE_Callback(hObject, eventdata, handles)
% hObject    handle to characterE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of characterE as text
%        str2double(get(hObject,'String')) returns contents of characterE as a double


% --- Executes during object creation, after setting all properties.
function characterE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to characterE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endcharE_Callback(hObject, eventdata, handles)
% hObject    handle to endcharE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endcharE as text
%        str2double(get(hObject,'String')) returns contents of endcharE as a double


% --- Executes during object creation, after setting all properties.
function endcharE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endcharE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endwordE_Callback(hObject, eventdata, handles)
% hObject    handle to endwordE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endwordE as text
%        str2double(get(hObject,'String')) returns contents of endwordE as a double


% --- Executes during object creation, after setting all properties.
function endwordE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endwordE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endwriteE_Callback(hObject, eventdata, handles)
% hObject    handle to endwriteE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endwriteE as text
%        str2double(get(hObject,'String')) returns contents of endwriteE as a double


% --- Executes during object creation, after setting all properties.
function endwriteE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endwriteE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveB.
function saveB_Callback(hObject, eventdata, handles)
% hObject    handle to saveB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=handles.p;
if exist([p.user '.mat'],'file')==2
    load([p.user '.mat']);
end
mic=get(handles.micM,'string');
i=get(handles.micM,'value');
p.recd=str2double(mic{i}(end));
p.hz=str2double(get(handles.sampleE,'string'));
p.lowhz=max(1,str2double(get(handles.lowE,'string')));
p.highz=min(ceil(0.5*p.hz)-1,str2double(get(handles.highE,'string')));
p.smoothWidth=round(str2double(get(handles.windowE,'string'))*p.hz/1000);
p.smoothIncrem=round(str2double(get(handles.incrementE,'string'))*p.hz/1000);
p.hzs=p.hz/p.smoothIncrem;
p.minWidth=round(str2double(get(handles.characterE,'string'))*p.hzs);
p.spaceWidth=round(str2double(get(handles.endcharE,'string'))*p.hzs);
p.endWidth=round(str2double(get(handles.endwordE,'string'))*p.hzs);
p.stopWidth=round(str2double(get(handles.endwriteE,'string'))*p.hzs);
p.noiseC=str2double(get(handles.noiseE,'string'));
[p.b,p.a] = butter(5, 2*[p.lowhz p.highz]/p.hz, 'bandpass');
if exist('s')
    save(p.user,'s','p');
else
    save(p.user,'p')
end
set(handles.settingsP,'visible','off')
set(handles.settingsB,'BackgroundColor','w');
set(handles.settingsB,'string','Settings')
set(handles.teachP,'visible','on');
set(handles.listenP,'visible','on');
set(handles.dictionaryP,'visible','on');
set(handles.text,'visible','on');
set(handles.Start,'visible','on');
handles.p=p;
guidata(hObject,handles)



% --- Executes on button press in defaultB.
function defaultB_Callback(hObject, eventdata, handles)
% hObject    handle to defaultB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=initVar;
set(handles.micM,'value',p.recd);
set(handles.sampleE,'string',p.hz);
set(handles.lowE,'string',p.lowhz);
set(handles.highE,'string',p.highz);
if strcmp('on',get(handles.windowE,'enable'))
    set(handles.windowE,'string',p.smoothWidth*1000/p.hz);
    set(handles.incrementE,'string',p.smoothIncrem*1000/p.hz);
end
set(handles.characterE,'string',p.minWidth/p.hzs);
set(handles.endcharE,'string',p.spaceWidth/p.hzs);
set(handles.endwordE,'string',p.endWidth/p.hzs);
set(handles.endwriteE,'string',p.stopWidth/p.hzs);
set(handles.noiseE,'string',p.noiseC);


% --- Executes on button press in testB.
function testB_Callback(hObject, eventdata, handles)
% hObject    handle to testB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~strcmp(get(handles.testB,'string'),'Stop')
    p=handles.p;
    set(handles.Start,'visible','off');
    set(handles.testB,'enable','off');
    p=countdown(p,hObject,handles);
    set(handles.testB,'enable','on','string','Stop','BackgroundColor',[0.68,0.92,1]);
    set(handles.character,'visible','off');
    [f,p]=testAudio(p,hObject,handles);
    set(handles.testB,'String','Test Audio','BackgroundColor','w');
elseif strcmp(get(handles.testB,'string'),'Stop')
    set(handles.Start,'visible','on');
    set(handles.testB,'string','Test Audio','BackgroundColor','w')
end


% --- Executes on selection change in helpL.
function helpL_Callback(hObject, eventdata, handles)
% hObject    handle to helpL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns helpL contents as cell array
%        contents{get(hObject,'Value')} returns selected item from helpL


% --- Executes during object creation, after setting all properties.
function helpL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to helpL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function noiseE_Callback(hObject, eventdata, handles)
% hObject    handle to noiseE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noiseE as text
%        str2double(get(hObject,'String')) returns contents of noiseE as a double


% --- Executes during object creation, after setting all properties.
function noiseE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noiseE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
