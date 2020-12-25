char=14;
close all
N=s.nRepSeq(char);
S=sum(s.nRepSeq(1:char-1));
Smean=s.Sseq{S+1};
figure
for i=2:N
    pause(.2)
    sig=s.Sseq{i+S};
    [Dist,D,rw,tw,k]=dtw(Smean,sig,0.1,1);
    mw=sum([(i-1)*rw;tw],1)/i;
    ml=round(sum([(i-1)*length(Smean),length(sig)])/i);
    Smean=resample(mw,ml,length(mw));
    plot(sig,'r')
    hold on
end
plot(Smean)