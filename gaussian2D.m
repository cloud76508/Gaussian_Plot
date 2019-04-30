x1 = [0:.01:10];
y1 = normpdf(x1,4,1);

x2 = [0:.01:10];
y2 = normpdf(x2,6,1);

x = [0:.01: 10];
y= y1+y2;
figure;
plot(x1,y1)
hold on
plot(x2,y2)
hold on
threshold = 0.25;
line([0,10],[threshold,threshold],'LineStyle','--')
hold on
regionX = x(y>0.25);
if sum(diff(regionX)>0.010001) ==0 
   line([regionX(1),regionX(end)],[0,0], 'Color',[1 0.8 0.3],'LineWidth',4)
   hold off
else
   midPoint = find(diff(regionX)>0.01001);
   line([regionX(1),regionX(midPoint)],[0,0], 'Color',[1 0.8 0.3],'LineWidth',4)
   hold on
   line([regionX(midPoint+1),regionX(end)],[0,0], 'Color',[1 0.8 0.3],'LineWidth',4)
   hold off
end
% line([t1,t2],[y,y])
% hold off
legend('N1', 'N2')
ylabel('K')
xlabel('T')