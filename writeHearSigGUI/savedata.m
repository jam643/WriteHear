function savedata(f,p)
C{1}=f.C;
M{1}=f.M;
time=f.time;

user=p.user;
save(user,'C','M','time');

