clear all
clc

N = 1.0;
pointsNum = 30;

% generate data
sigma = [0.01 0; 0 0.02]; %independent variable
%sigma = [0.01 -0.01; -0.01 0.02]; %dependent variable

mu = [0.5 0.5];
data = mvnrnd(mu,sigma,500);
data(:,1) = normalization(data(:,1));
data(:,2) = normalization(data(:,2));
Model = fitgmdist(data,1);



x=linspace(0, N,pointsNum);
y=x;
[X,Y]=meshgrid(x,y);

meshPoint = [reshape(X,[],1) reshape(Y,[],1)];

% generate 3D PDF
for n =1:size(meshPoint,1)
    z(n)= (1/sqrt((2*pi)^2*det(sigma)))*exp((-1/2)*(meshPoint(n,:)-mu)*sigma^-1*(meshPoint(n,:)-mu)');
end
z = reshape(z,pointsNum,pointsNum);

% 2D plot
figure
h = scatter(data(:,1),data(:,2));
haxis = gca;
xlim = haxis.XLim;
ylim = haxis.YLim;
d = (max([xlim ylim])-min([xlim ylim]))/1000;
[X1Grid,X2Grid] = meshgrid(xlim(1):d:xlim(2),ylim(1):d:ylim(2));
hold on
contour(X1Grid,X2Grid,reshape(pdf(Model,[X1Grid(:) X2Grid(:)]),...
    size(X1Grid,1),size(X1Grid,2)),20)
xlabel('X1')
ylabel('X2')

% 3D plot
f=figure;
f.Position = [200, 50, 800, 600];
s1 = surf(X,Y, z,'FaceAlpha',0);
hold on

h = scatter(data(:,1), data(:,2));
haxis = gca;
xlim = haxis.XLim;
ylim = haxis.YLim;
d = (max([xlim ylim])-min([xlim ylim]))/1000;
[X1Grid,X2Grid] = meshgrid(xlim(1):d:xlim(2),ylim(1):d:ylim(2));
hold on

contour(X1Grid,X2Grid,reshape(pdf(Model,[X1Grid(:) X2Grid(:)]),...
    size(X1Grid,1),size(X1Grid,2)),20)
hold off

xLab = xlabel('X1');
xLab.Position = [0.4 -0.2 -0.05];
yLab = ylabel('X2');
yLab.Position = [-0.2 0.4 0.05];
XX = yLab.Position;