function [f,p]=spellCheck(f,p,s,hObject,handles)
guidata(hObject,handles)
load('words','W');
nw=length(W);
ns=length(f.result);
ssW={};
sW={};
f.guess={};
j=0;

for k=1:nw
    if ns==length(W{k})
        j=j+1;
        sW{j}=W{k};
    end
end

if ~isempty(sW)
    n=0;
    for k=1:length(sW)
        m=0;
        index=1;
        while m<length(sW{k}) && ~isempty(index)
            m=m+1;
            index=strfind(s.seq,sW{k}(m));
        end
        if ~isempty(index)
            n=n+1;
            ssW{n}=sW{k};
        end
    end    

    if ~isempty(ssW);
        for k=1:length(ssW)
            m=0;
            while m<length(ssW{k})
                m=m+1;
                index=findstr(s.seq,ssW{k}(m));
                scoreL{k}(m)=f.result{m}(index);
            end
            scoreW(k)=sum(scoreL{k});
        end
 
        k=0;
        while k<5 && ~isempty(ssW)
            k=k+1;
            [~,index]=max(scoreW);
            f.guess{k}=ssW{index};
            ssW(index)=[]; scoreW(index)=[];
        end
        
        f.text(length(f.text)-length(f.guess{1})+1:length(f.text))= f.guess{1};
        set(handles.text,'string',f.text);
        if length(f.guess)>1
            set(handles.menuSpell,'string',[f.guess '<<delete']);
        end
    else
        f.text(length(f.text)-length(f.answer)+1:length(f.text))= f.answer;
        set(handles.text,'string',f.text);
    end
else
    f.text(length(f.text)-length(f.answer)+1:length(f.text))= f.answer;
    set(handles.text,'string',f.text);
end