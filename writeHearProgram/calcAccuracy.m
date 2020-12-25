function [s]=calcAccuracy(s)

k=min(s.nRepSeq);

if k>1
    s.accuracy=zeros(1,length(s.seq));
    nRepSeq=(k-1)*ones(length(s.seq));
    start=1;
    for r=1:length(s.seq)
        temp(r,1:k)=s.Sseq(start:start+k-1);
        start=start+s.nRepSeq(r);
    end
    for r=1:length(s.seq)
        for c=1:k
            query=temp{r,c};
            temp2=temp;
            temp2(:,c)=[];
            m=0;
            for r2=1:length(s.seq)
                for c2=1:k-1
                    m=m+1;
                    template{m}=temp2{r2,c2};
                end
            end
            [answer,~]=compare1(template,query,s,nRepSeq);
            s.accuracy(r)=s.accuracy(r)+(100/(k))*(s.seq(r)==answer);
        end
    end
else
    s.accuracy=nan;
end