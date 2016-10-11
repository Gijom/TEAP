function [train_data, normalized_data, num_fact denum_fact] = ...
    normalization_module(data, data_to_normalize, parameters)

%parameters.normalize 0: none 1: min and std  2:minmax 3: zscore
%     data_to_normalize = data;
% end
if ~isfield(parameters,'BoW')
    parameters.BoW = false;
end
num_fact = 0;
denum_fact = ones(1,size(data_to_normalize,2));
train_data = data;
normalized_data = data_to_normalize;
switch(parameters.normalize)
    case 0
        num_fact = 0;
        denum_fact = ones(size(data_to_normalize));
    case 1
        num_fact = min(data);
        denum_fact = std(data);
        train_data = bsxfun(@rdivide, bsxfun(@minus, data, num_fact), denum_fact+eps);
    case 2
        num_fact = min(data);
        denum_fact = max(data)- min(data);
        train_data = bsxfun(@rdivide, bsxfun(@minus, data, num_fact), denum_fact+eps)-0.5;
        
    case 3
        [train_data, num_fact,denum_fact]  = zscore(data);
    case 4
        train_data= rank_normlize(data);
        flag_of = false;
        normalized_data = rank_normlize(data_to_normalize, data);
    case 5
        num_fact = (max(data)+min(data))/2;
        denum_fact = num_fact;
        train_data = bsxfun(@rdivide, bsxfun(@minus, data, num_fact), denum_fact+eps);
        
end
if ~isempty(data_to_normalize)
    normalized_data = bsxfun(@rdivide, bsxfun(@minus, data_to_normalize, num_fact), denum_fact+eps);
end
