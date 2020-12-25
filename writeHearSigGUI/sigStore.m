function f=sigStore(f,p)
start=1;
k=0;
while start==1 && k<length(f.x)-1
    k=k+1;
    if f.x(k+1)~=0 && f.x(k)==0
        start=k;
    end
end
stop=length(f.x);
k=length(f.x)+1;
while stop==length(f.x) && k>start+1
    k=k-1;
    if f.x(k-1)~=0 && f.x(k)==0
        stop=k;
    end
end
f.time=(stop-start)/p.hzs;
f.C=f.xSmooth(start:stop)/mean(f.xSmooth(start:stop));
for k=1:length(f.C)
    f.S(k)=sum(f.C(1:k));
end
f.M=f.xRaw(start*p.smoothWidth+1:stop*p.smoothWidth+1)/max(f.xRaw(start*p.smoothWidth+1:stop*p.smoothWidth+1));
