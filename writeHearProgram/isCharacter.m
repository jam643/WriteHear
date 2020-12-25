function [char,f]=isCharacter(f,p,i)
f.start(i)=1;
f.stop(i)=1;
k=0;
% while f.start(i)==1 && k<length(f.E{i})-p.minWidth
%     k=k+1;
%     if f.E{i}(k+1)>p.Enoise && max(f.E{i}(max(1,k-p.spaceWidth):k))<=p.Enoise
%         f.start(i)=k;
%     end
% end
% while f.start(i)~=1 && f.stop(i)==1 && k<length(f.E{i})-p.spaceWidth
%     k=k+1;
%     if f.E{i}(k-1)>p.Enoise && max(f.E{i}(k:k+p.spaceWidth))<=p.Enoise
%         f.stop(i)=k;
%     end
% end
for k=2:length(f.x{i})-p.spaceWidth
    if f.E{i}(k+1)>p.Enoise && max(f.E{i}(max(1,k-p.spaceWidth):k))<=p.Enoise
        f.start(i)=k;
    end
    if f.E{i}(k-1)>p.Enoise && max(f.E{i}(k:k+p.spaceWidth))<=p.Enoise
        f.stop(i)=k;
    end
end

if f.stop(i)-f.start(i)>=p.minWidth
    char=1;
elseif ((f.start(i)==1 && i~=1 && length(f.x{i})>p.endWidth) || length(f.x{i})>p.stopWidth)
    char=2;
else
    char=0;
end