clc
clear all
close all
rt=3;
r1 = audiorecorder(44100,16,1,3);
r2 = audiorecorder(44100,16,1,1);
disp('3')
pause(.7)
disp('2')
pause(.7)
disp('1')
pause(.7)
disp('go')
record(r1);
record(r2);
pause(rt);
stop(r1);
stop(r2);
r1=getaudiodata(r1);
r2=getaudiodata(r2);
[p.b,p.a] = butter(5, 2*[17500 18500]/44100, 'bandpass');
ml=max(length(r1),length(r2));
x1=zeros(ml,1); x2=zeros(ml,1);
x1(1:length(r1))=filter(p.b,p.a,r1);
x2(1:length(r2))=filter(p.b,p.a,r2);
x1(1:1000)=0;
x2(1:1000)=0;
% figure
% plot(x1,'r')
% hold on
% plot(x2,'b')
[cor,lag]=xcorr(x1,x2,2000);
[~,index]=max(cor);
index=lag(index);
y1=zeros(length(x1)+2*abs(index),1);
y2=zeros(length(x1)+2*abs(index),1);
y1(abs(index)+1:abs(index)+length(x1))=x1;
y2(abs(index)+index+1:abs(index)+index+length(x2))=x2;
% figure
% plot(y1,'r')
% hold on
% plot(y2,'b')
w=length(y2)/(rt*5);
j=0;
for k=1:rt*5
    z2=zeros(length(y2),1);
    z2((k-1)*w+1:k*w)=y2((k-1)*w+1:k*w);
    if max(z2)>0.2*max(y2)
        j=j+1;
        [cor,lag]=xcorr(y1,z2,100);
        [~,i]=max(cor);
        index(j)=lag(i);
        v1=zeros(length(y1)+2*abs(index(j)),1);
        v2=zeros(length(y1)+2*abs(index(j)),1);
        v1(abs(index(j))+1:abs(index(j))+length(y1))=y1;
        v2(abs(index(j))+index(j)+1:abs(index(j))+index(j)+length(z2))=z2;
%         figure
%         plot(y1,'r');
%         hold on
%         plot(z2,'b');
%         figure
%         plot(v1,'k');
%         hold on
%         plot(v2,'g');
    end
end
for k=1:length(index)
    dist(k)=(index(1)-index(k))*34000/44100;
end
clc
if mean(dist)<0
    fprintf('AWAY FROM COMPUTER ~%.0f cm\n',abs(dist(end)))
else
    fprintf('TOWARDS COMPUTER ~%.0f cm\n',abs(dist(end)))
end
% figure
% plot(dist,'-x','MarkerSize',6)


