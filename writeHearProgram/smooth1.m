function [x,E]=smooth1(x,width,increm)
temp=zeros(1,length(1:increm:length(x)-width));
E=zeros(1,length(1:increm:length(x)-width));
k=0;
for i=1:increm:length(x)-width
   k=k+1;
   temp(k)=mean(x(i:i+width));
   E(k)=mean(x(i:i+width).^2);
end
x=temp;