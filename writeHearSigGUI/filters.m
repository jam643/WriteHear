function [f,p]=filters(f,p)

f.xUnfilt=abs(f.xUnfiltRaw/max(f.xUnfiltRaw));

p.t=length(f.xUnfilt)/p.hz;
p.hzs=1/.05;
p.smoothWidth=round(p.hz/p.hzs);
f.xUnfilt=smooth(f.xUnfilt,p.smoothWidth);

[p.b,p.a] = butter(5, 2*[p.hzl p.hzh]/p.hz, 'bandpass');

f.xRaw = filter(p.b,p.a,f.xUnfiltRaw);
f.xAbs=abs(f.xRaw);
% f.xSmooth=smooth(f.xAbs,p.smoothWidth);
f.xSmooth=smooth1(f.xAbs,round(p.hz*0.1),round(p.hz*0.05));
f.x=f.xSmooth-min(f.xSmooth);
f.x=max(0,f.x-0.05*max(f.x));