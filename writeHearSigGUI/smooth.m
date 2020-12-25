function x=smooth(x,width)
k=0;
for i=width+1:width:length(x)-width
   k=k+1;
   temp(k)=mean(x(i-width:i+width));
end
x=temp;