function [normalizedData] = normalization(originalData)

maxValue = max(originalData);
minValue = min(originalData);

for n = 1:length(originalData)
    normalizedData(n) =  (originalData(n) - minValue)/(maxValue - minValue);
end
