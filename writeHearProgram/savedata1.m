function [s]=savedata1(f,p)

if exist([p.user,'.mat']);
    load(p.user)
    if exist('s')
        new=1;
        k=0;
        i=1;
        while new
            k=k+1;
            if k>length(s.seq)
                s.seq=[s.seq,f.char];
                s.nRepSeq=[s.nRepSeq,f.nRep];
                s.Sseq=[s.Sseq,f.S];
%                 s.Fseq=[s.Fseq,f.F];
%                 s.Rseq=[s.Rseq,f.R];
                new=0;            
            elseif uint8(f.char)==uint8(s.seq(k))
                i=i+s.nRepSeq(k);
                s.nRepSeq(k)=s.nRepSeq(k)+f.nRep;
                if k==length(s.seq)
                    s.Sseq=[s.Sseq,f.S];
%                     s.Fseq=[s.Fseq,f.F];
%                     s.Rseq=[s.Rseq,f.R];
                else
                    s.Sseq=[s.Sseq(1:i-1),f.S,s.Sseq(i:end)];
%                     s.Fseq=[s.Fseq(1:i-1),f.F,s.Fseq(i:end)];
%                     s.Rseq=[s.Rseq(1:i-1),f.R,s.Rseq(i:end)];
                end
                new=0;
            elseif uint8(f.char)<uint8(s.seq(k))
                if k==1
                    s.seq=[f.char,s.seq];
                    s.nRepSeq=[f.nRep,s.nRepSeq];
                    s.Sseq=[f.S,s.Sseq];
%                     s.Fseq=[f.F,s.Fseq];
%                     s.Rseq=[f.R,s.Rseq];
                else
                    s.seq=[s.seq(1:k-1),f.char,s.seq(k:end)];
                    s.nRepSeq=[s.nRepSeq(1:k-1),f.nRep,s.nRepSeq(k:end)];
                    s.Sseq=[s.Sseq(1:i-1),f.S,s.Sseq(i:end)];
%                     s.Fseq=[s.Fseq(1:i-1),f.F,s.Fseq(i:end)];
%                     s.Rseq=[s.Rseq(1:i-1),f.R,s.Rseq(i:end)];
                end
                new=0;
            end
            i=i+s.nRepSeq(k);
        end
    else
        s.seq=f.char;
        s.nRepSeq=f.nRep;
        s.Sseq=f.S;
%         s.Fseq=f.F;
%         s.Rseq=f.R;
    end
else
    s.seq=f.char;
    s.nRepSeq=f.nRep;
    s.Sseq=f.S;
%     s.Fseq=f.F;
%     s.Rseq=f.R;
end


