function [f,p,i]=predict(p,s,hObject,handles)
guidata(hObject,handles);
i=1;
recObj = audiorecorder(p.hz,16,1,p.recd);
char=0;

while char~=2 && strcmp(get(handles.Start,'string'),'Stop')
    record(recObj); 
    char=0;
    first=1;
    while char==0 && strcmp(get(handles.Start,'string'),'Stop')
        if first
            pause((p.spaceWidth+2)/p.hzs);
            first=0;
        else
            pause(0.5*p.spaceWidth/p.hzs);
        end            
        f.xUnfiltRaw{i}= getaudiodata(recObj)';
        [f.x{i},f.E{i}]=filters1(f.xUnfiltRaw{i},p);
        [char,f]=isCharacter(f,p,i);
        if char==1
            stop(recObj);
            f=charStore1(f,p,i);
            [f.answer(i),f.result{i}]=compare1(s.Sseq,f.S{i},s,s.nRepSeq);
            f.text=get(handles.text,'string');
            if get(handles.spellCheck,'Value')
                f.text = sprintf([f.text,'*']);
            else
                f.text = sprintf([f.text,f.answer(i)]);
            end
            set(handles.text,'string',f.text);
            i=i+1;
        end
    end
end
stop(recObj);

