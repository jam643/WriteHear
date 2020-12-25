function savedata2(f,p)
[s,p]=loaddata(p);
for k=1:length(s.C);
    C{k}=s.C{k};
    M{k}=s.M{k};
    time(k)=s.time(k);
end
l=length(s.C);
C{l+1}=f.C;
M{l+1}=f.M;
time(l+1)=f.time;

user=p.user;
save(user,'C','M','time');
