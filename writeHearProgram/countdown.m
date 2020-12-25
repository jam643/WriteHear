function p=countdown(p,hObject,handles)
guidata(hObject,handles)
set(handles.character,'string','3','visible','on','ForegroundColor','k');
pause(1);
set(handles.character,'string','2');
pause(1);
set(handles.character,'string','1');
pause(0.7)
recObj = audiorecorder(p.hz,16,1,p.recd);
record(recObj);
pause(0.15);
stop(recObj);
record(recObj);
pause(0.15);
stop(recObj);
noiseRem= getaudiodata(recObj)';
[~,E]=filters1(noiseRem,p);
p.Enoise=p.noiseC*mean(E);