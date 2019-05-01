clear all
SPYandTLT
close all
clearvars -except spyDiff tltDiff Model
clc

N = 1.0;
threshold = 6;
pointsNum = 50;
sigma = Model.Sigma;
mu = Model.mu;

% N = 1.0;
% pointsNum = 50;
% threshold = 3;
% sigma = [0.03 -0.005; -0.005 0.03];
% mu = [0.5 0.5];

x=linspace(0, N,pointsNum);
y=x;
[X,Y]=meshgrid(x,y);

meshPoint = [reshape(X,[],1) reshape(Y,[],1)];


for n =1:size(meshPoint,1)
    z(n)= (1/sqrt((2*pi)^2*det(sigma)))*exp((-1/2)*(meshPoint(n,:)-mu)*sigma^-1*(meshPoint(n,:)-mu)');
end

z = reshape(z,50,50);

%surf(X,Y, z,'FaceAlpha',0.1);

planeZ = zeros(pointsNum,pointsNum)+threshold;
zLower = z;
zLower(zLower>= threshold) = threshold;

s1 = surf(X,Y, zLower,'FaceAlpha',0);

hold on

zUpper = z;
zUpper(zUpper<= threshold) = threshold;
s2 = surf(X,Y, zUpper,'FaceAlpha',1,'FaceColor', 'flat');
c2 = s2.CData;
c2(z < threshold) = 0;
s2.CData = c2;
s2.EdgeColor = 'none';

hold on

zProject =  zeros(pointsNum,pointsNum);
s3 = surf(X,Y, zProject,'FaceColor', 'flat');
c3 = s3.CData;
c3(z >= threshold) = 1;
c3(z < threshold) = 0;
s3.CData = c3;

xLab = xlabel('SPY');
xLab.Position = [0.4 -0.2 -0.05];
yLab = ylabel('TLT');
yLab.Position = [-0.2 0.4 0.05];
XX = yLab.Position;
%zlabel('K')

%shading interp
%axis tight