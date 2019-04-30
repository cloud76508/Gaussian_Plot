N = 10.0;
pointsNum = 50;
threshold = 0.25;
sigma = 1;
S1 = -7;
S2 = -3;
T1 = -7;
T2 = -3;


x=linspace(0, N,pointsNum);
y=x;
[X,Y]=meshgrid(x,y);

planeZ = zeros(pointsNum,pointsNum)+threshold;

z1=(1/sqrt(2*pi*sigma^2).*exp(-((X+S1).^2/2*sigma^2)-((Y+T1).^2/2*sigma^2)));
z2=(1/sqrt(2*pi*sigma^2).*exp(-((X+S2).^2/2*sigma^2)-((Y+T2).^2/2*sigma^2)));
z = z1+z2;

%surf(X,Y, z,'FaceAlpha',0.1);

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

xLab = xlabel('S');
xLab.Position = [6 -0.25 -0.05];
yLab = ylabel('T');
yLab.Position = [-0.25 6 -0.05]
XX = yLab.Position;
zlabel('K')

%shading interp
%axis tight