function initHandles(hObject,handles)
guidata(hObject,handles);

set(handles.settingsB,'enable','off','string','Settings','BackgroundColor','w');
set(handles.settingsP,'visible','off');
set(handles.menuSpell,'string',' ','value',1);
set(handles.buttonPlot,'Enable','off');
set(handles.buttonClear,'Enable','off');
set(handles.textSeq,'string','');
set(handles.text,'string','','visible','on');
set(handles.Start,'string','Start');
set(handles.currentName,'string','');
set(handles.editChar,'string','');
set(handles.learn,'Enable','off','string','+');
set(handles.listenP,'visible','on');
set(handles.dictionaryP,'visible','on');
set(handles.teachP,'visible','on');
set(handles.buttonForget,'Enable','off');
set(handles.name,'string','');
set(handles.list,'visible','off','string','');
set(handles.character,'Visible','off');
set(handles.write,'Visible','off');
set(handles.micM,'string',' ','value',1);
set(handles.helpL,'visible','off')