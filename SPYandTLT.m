clear all
clc

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

% TLT data
temp = fopen('C:\Users\User\Documents\GitHub\Gaussian_Plot\financial_data\TLT.csv');
normalRaw = textscan(temp, '%s', 'Delimiter',',');
tlt = reshape(normalRaw{1},7,1764/7);
tlt = tlt(6,2:end);

tltNum = [];
for n =1:length(tlt)
    tltNum(n) = str2num(tlt{1,n});
end

i =1;
tltDiff = [];
for n =1:length(tltNum)-1
   tltDiff(i) = (tltNum(n+1) - tltNum(n))/tltNum(n);
   i=i+1;
end

tltDiff = normalization(tltDiff);

% fit Gaussian model
Model = fitgmdist([spyDiff; tltDiff]',1);

% plot figure
figure
h = scatter(spyDiff, tltDiff);
haxis = gca;
xlim = haxis.XLim;
ylim = haxis.YLim;
d = (max([xlim ylim])-min([xlim ylim]))/1000;
[X1Grid,X2Grid] = meshgrid(xlim(1):d:xlim(2),ylim(1):d:ylim(2));
hold on
contour(X1Grid,X2Grid,reshape(pdf(Model,[X1Grid(:) X2Grid(:)]),...
    size(X1Grid,1),size(X1Grid,2)),20)
xlabel('SPY')
ylabel('TLT')



