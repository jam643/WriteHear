function [s,p]=loaddata(p)
user=p.user;
load(user);
if iscell(C)

    for k=1:length(C)
        s.C{k}=C{k};
        s.M{k}=M{k};
        s.time(k)=time(k);
    end
else
    l=1;
    s.C=C;
    s.M=M;
    s.time=time;
end