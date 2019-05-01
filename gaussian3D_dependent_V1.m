clear all
SPYandTLT
close all
clearvars -except spyDiff tltDiff Model
clc

N = 1.0;
pointsNum = 50;
sigma = Model.Sigma;
mu = Model.mu;

x=linspace(0, N,pointsNum);
y=x;
[X,Y]=meshgrid(x,y);

meshPoint = [reshape(X,[],1) reshape(Y,[],1)];


for n =1:size(meshPoint,1)
    z(n)= (1/sqrt((2*pi)^2*det(sigma)))*exp((-1/2)*(meshPoint(n,:)-mu)*sigma^-1*(meshPoint(n,:)-mu)');
end

z = reshape(z,50,50);

%surf(X,Y, z,'FaceAlpha',0.1);

s1 = surf(X,Y, z,'FaceAlpha',0);

hold on

h = scatter(spyDiff, tltDiff);
haxis = gca;
xlim = haxis.XLim;
ylim = haxis.YLim;
d = (max([xlim ylim])-min([xlim ylim]))/1000;
[X1Grid,X2Grid] = meshgrid(xlim(1):d:xlim(2),ylim(1):d:ylim(2));
hold on
contour(X1Grid,X2Grid,reshape(pdf(Model,[X1Grid(:) X2Grid(:)]),...
    size(X1Grid,1),size(X1Grid,2)),20)
 
xLab = xlabel('SPY');
xLab.Position = [0.4 -0.2 -0.05];
yLab = ylabel('TLT');
yLab.Position = [-0.2 0.4 0.05];
XX = yLab.Position;
% zlabel('K')

%shading interp
%axis tight