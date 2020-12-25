function [p]=updateHandles(p,hObject,handles)
guidata(hObject,handles)
set(handles.settingsB,'enable','on');

set(handles.currentName,'string',p.user);
set(handles.learn,'Enable','on');
if exist([p.user '.mat'],'file')==2
    load([p.user '.mat']);
    if exist('s') && ~isempty(s.seq)
        set(handles.buttonForget,'Enable','on');
        set(handles.Start,'Enable','on');
        set(handles.textSeq,'string',s.seq);
        set(handles.buttonPlot,'Enable','on');
        set(handles.buttonClear,'Enable','on');
        set(handles.sampleE,'string',p.hz);
        set(handles.windowE,'enable','off');
        set(handles.incrementE,'enable','off');
    else
        set(handles.windowE,'enable','on');
        set(handles.incrementE,'enable','on');
        set(handles.buttonForget,'Enable','off');
        set(handles.Start,'Enable','off')
        set(handles.textSeq,'string','');
        set(handles.buttonPlot,'Enable','off');
        set(handles.buttonClear,'Enable','off');
    end
else    
        set(handles.windowE,'enable','on');
        set(handles.incrementE,'enable','on');
    set(handles.buttonForget,'Enable','off');
    set(handles.Start,'Enable','off')
    set(handles.textSeq,'string','');
    set(handles.buttonPlot,'Enable','off');
    set(handles.buttonClear,'Enable','off');
end

%save
