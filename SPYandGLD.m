clear all
clc

% GLD data
temp = fopen('C:\Users\User\Documents\GitHub\Gaussian_Plot\financial_data\GLD.csv');
normalRaw = textscan(temp, '%s', 'Delimiter',',');
gld = reshape(normalRaw{1},7,1764/7);
gld = gld(6,2:end);

gldNum = [];
for n =1:length(gld)
    gldNum(n) = str2num(gld{1,n});
end

i =1;
gldDiff = [];
for n =1:length(gldNum)-1
   gldDiff(i) = (gldNum(n+1) - gldNum(n))/gldNum(n);
   i=i+1;
end

gldDiff = normalization(gldDiff);

% SPY data
temp = fopen('C:\Users\User\Documents\GitHub\Gaussian_Plot\financial_data\SPY.csv');
normalRaw = textscan(temp, '%s', 'Delimiter',',');
spy = reshape(normalRaw{1},7,1764/7);
spy = spy(6,2:end);

spyNum = [];
for n =1:length(spy)
    spyNum(n) = str2num(spy{1,n});
end

i =1;
spyDiff = [];
for n =1:length(spyNum)-1
   spyDiff(i) = (spyNum(n+1) - spyNum(n))/spyNum(n);
   i=i+1;
end

spyDiff = normalization(spyDiff);


% fit Gaussian model
Model = fitgmdist([spyDiff; gldDiff]',1);

% plot figure
figure
h = scatter(spyDiff, gldDiff);
haxis = gca;
xlim = haxis.XLim;
ylim = haxis.YLim;
d = (max([xlim ylim])-min([xlim ylim]))/1000;
[X1Grid,X2Grid] = meshgrid(xlim(1):d:xlim(2),ylim(1):d:ylim(2));
hold on
contour(X1Grid,X2Grid,reshape(pdf(Model,[X1Grid(:) X2Grid(:)]),...
    size(X1Grid,1),size(X1Grid,2)),20)
xlabel('SPY')
ylabel('GLD')



