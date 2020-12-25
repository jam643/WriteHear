function [f,p]=compare(s,f,p)
count=0;
for k=1:length(s.C)
    sig=interp1(s.C{k},linspace(1,length(s.C{k}),length(f.C)));
    comp(1,k)=max(xcorr(sig-mean(sig),f.C-mean(f.C),round(0.1*p.hzs),'coeff'));
    [Dist,D]=dtw(s.C{k},f.C,0.08,0);
    comp(2,k)=abs(f.time-s.time(k))/(f.time*.5+s.time(k)*.5);
    comp(3,k)=min(size(D))/Dist;
    if comp(1,k)-comp(2,k)>0.4
        count=count+1;
    end
end
if count>=0.5*length(s.C)
    f.res=1;
else
    f.res=0;
end
f.comp=comp;