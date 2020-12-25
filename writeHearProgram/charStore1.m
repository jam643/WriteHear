function f=charStore1(f,p,i)

f.S{i}=f.x{i}(f.start(i):f.stop(i));
% f.S{i}=f.S{i}-mean(f.S{i});
f.S{i}=f.S{i}/mean(f.S{i});
% f.F{i}=f.xUnfiltRaw{i};
% f.F{i}=abs(f.xRaw{i}((f.start(i)-1)*p.smoothWidth+1:(f.stop(i)+1)*p.smoothWidth));
% f.R{i}=f.xUnfiltRaw{i}((f.start(i)-1)*p.smoothWidth+1:(f.stop(i)+1)*p.smoothWidth);
