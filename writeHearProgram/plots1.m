function plots1(f,p)

xUnfiltRaw=[];
xSmooth=[];
E=[];
for i=1:length(f.xUnfiltRaw)
    xUnfiltRaw=[xUnfiltRaw f.xUnfiltRaw{i}];
    xSmooth=[xSmooth f.x{i}];
    E=[E f.E{i}];
end
xRaw = filter(p.b,p.a,xUnfiltRaw);

p.runtime=length(xUnfiltRaw)/p.hz;
if max(findobj==1)
    close figure 1
end
h=figure(1);
set(h,'units','normalized','outerposition',[.5 0 .5 1])
subplot(3,1,1)
plot(linspace(0,p.runtime,length(xUnfiltRaw)),xUnfiltRaw)
title('Input Signal','Fontsize',12,'FontWeight','Bold')
ylabel('Amplitude','Fontsize',10)
xlabel('Time (sec)','Fontsize',10)
subplot(3,1,2)
title('Signal Energy','Fontsize',12,'FontWeight','Bold')
ylabel('Energy','Fontsize',10)
xlabel('Time (sec)','Fontsize',10)
hold on
plot(linspace(0,p.runtime,length(E)),E,'r','LineWidth',2);
plot([0,p.runtime],[p.Enoise,p.Enoise],'color','k','LineWidth',2);
legend('Signal Energy','Noise Energy Thresh.');
subplot(3,1,3)
plot(linspace(0,p.runtime,length(xRaw)),xRaw);
hold on
% plot(linspace(0,p.runtime,length(xSmooth)),xSmooth,'-xr','LineWidth',2);
if isfield(f,'S')
    for j=1:length(f.S)
        beg=0;
        if j>1;
            for k=1:j-1
                beg=beg+length(f.xUnfiltRaw{k})/p.hz;
            end
        end
        plot(linspace(f.start(j)+1,f.stop(j)+1,length(f.S{j}))/p.hzs+beg,(f.S{j})*max(xRaw)/max(f.S{j}),'-xg','LineWidth',2)
    end
    legend('Filtered Signal','Char. Envelope','Location','SouthEast');
else
    legend('Filtered Signal','Location','SouthEast');
end
title('Filtered Signal','Fontsize',12,'FontWeight','Bold')
ylabel('Amplitude','Fontsize',10)
xlabel('Time (sec)','Fontsize',10)
