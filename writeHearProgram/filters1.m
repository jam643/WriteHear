function [x,E]=filters1(xUnfiltRaw,p)

xRaw= filter(p.b,p.a,xUnfiltRaw);
xAbs=abs(xRaw);
[x,E]=smooth1(xAbs,p.smoothWidth,p.smoothIncrem);
