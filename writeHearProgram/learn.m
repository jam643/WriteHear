function [f,p,i]=learn(f,p,hObject,handles)
guidata(hObject,handles)
color='krgbmcy';
i=1;
recObj = audiorecorder(p.hz,16,1,p.recd);

while i<=f.nRep && strcmp(get(handles.learn,'string'),'Quit')
    record(recObj); 
    char=0;
    first=1;
    set(handles.character,'string',f.char,'ForegroundColor',color(i))
    while char==0 && strcmp(get(handles.learn,'string'),'Quit')
        if first
            pause((p.spaceWidth+2)/p.hzs);
            first=0;
        else
            pause(0.5*p.spaceWidth/p.hzs);
        end     
        f.xUnfiltRaw{i}= getaudiodata(recObj)';
        [f.x{1,i},f.E{1,i}]=filters1(f.xUnfiltRaw{i},p);
%         [f.x{2,i},f.E{2,i}]=filters1(f.xUnfiltRaw{i},p);
        [char,f]=isCharacter(f,p,i);
        if char==1
            stop(recObj);
            f=charStore1(f,p,i);            
            i=i+1;
        end
    end
end
stop(recObj);
