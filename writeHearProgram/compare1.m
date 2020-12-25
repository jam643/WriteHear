function [answer,result]=compare1(template,query,s,nRepSeq)

% k goes through each character in learnt series in the 's' structure compares it 
% to the current letter 'i' in the 'f' structure. M is the raw signal while
% C is the smoothed signal

for k=1:length(template)
%     sig=interp1(s.M{k},linspace(1,length(s.M{k}),length(f.F{i})));
%     comp(1,k)=max(xcorr(sig,f.F{i},round(p.lagWidth*length(f.F{i})),'coeff'));        
%         
%     sig=interp1(template{k},linspace(1,length(template{k}),length(query)));
%     comp(2,k)=max(xcorr(sig,query,0,'coeff'));
%         
    e=.5;
    [Dist,D]=dtw(template{k}.^e,query.^e,0.08,0);
    comp(1,k)=min(size(D))/Dist;
end
    [nr,~]=size(comp);
for m=1:nr
    comp(m,:)=comp(m,:)/max(comp(m,:));
end
result=zeros(1,length(s.seq));
start=1;
for k=1:length(s.seq);
    result(k)=mean(comp(:,start:start+nRepSeq(k)-1));
    start=start+nRepSeq(k);
end

[~,maxindex]=max(result(:));
answer=s.seq(maxindex);
