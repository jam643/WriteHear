function [f,p]=testAudio(p,hObject,handles)
guidata(hObject,handles)
i=1;
recObj = audiorecorder(p.hz,16,1,p.recd);
recObj2 = audiorecorder(p.hz,16,1,p.recd);
record(recObj2);

while strcmp(get(handles.testB,'string'),'Stop')
    record(recObj);
    char=0;
    first=1;
    while char==0 && strcmp(get(handles.testB,'string'),'Stop')
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
            i=i+1;
        end
    end
end
stop(recObj);
stop(recObj2);
plots1(f,p)

% 
% figure
% plot(linspace(0,p.runtime,length(f.x{1})),f.x{1},'-x','color','k','markersize',16,'linewidth',4)
% set(gcf,'color','w');
% set(gca,'XTick',[],'YTick',[])
% ylabel('Amplitude','Fontsize',36,'Fontname','Gulim')
% xlabel('Time','Fontsize',36,'Fontname','Gulim')
% 
% figure
% plot(linspace(0,1,length(s.Sseq{1})),s.Sseq{1},'-x','color','b','markersize',16,'linewidth',4)
% hold on
% plot(linspace(0,1,length(s.Sseq{2})),s.Sseq{2},'-+','color','r','markersize',16,'linewidth',4)
% set(gcf,'color','w');
% set(gca,'XTick',[],)
% ylabel('Amplitude','Fontsize',36,'Fontname','Gulim')
% xlabel('Time','Fontsize',36,'Fontname','Gulim')
% h=legend('Query','Template')
% set(h,'Fontsize',36,'Fontname','Gulim')

play(recObj2);
pause(recObj2.TotalSamples/p.hz)