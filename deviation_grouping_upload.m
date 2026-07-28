tic;

% >> Initialize Data
n_size = 1e4;
% Changed to include negative numbers and 0 to prove 0s are now included and processed
n = randi([-1000, 1000], 1, n_size); 
allowed_deviation = 5;

% >> Sort the data
% Because the max deviation from the mean is < allowed_deviation/2, 
% the total range of any valid group is < allowed_deviation.
% Therefore, in a sorted array, valid groups MUST be contiguous blocks.
n_sorted = sort(n);

% >> Group contiguous blocks that meet the deviation criteria
n_ordered = cell(1, n_size); % Preallocate cell array (max possible groups)
group_idx = 1;

% Initialize the first group
current_group = n_sorted(1);

for i = 2:n_size
    % Temporarily add the next sorted element to the current group
    temp_group = [current_group, n_sorted(i)];
    current_mean = mean(temp_group);
    
    % Check if ALL elements in the new group meet the deviation criteria
    % (No need to exclude 0s anymore, they are evaluated normally)
    if all(abs(temp_group - current_mean) < allowed_deviation / 2)
        current_group = temp_group; % Keep building the group
    else
        % Group is complete, save it and start a new one
        n_ordered{group_idx} = current_group;
        group_idx = group_idx + 1;
        current_group = n_sorted(i);
    end
end

% Don't forget to save the final group
n_ordered{group_idx} = current_group;

% Trim the cell array down to actual size
n_ordered = n_ordered(1:group_idx);
number_of_groups = group_idx;

% >> Verification
% Verify summation of input and output array
out = sum(cellfun(@sum, n_ordered));
sum_n = sum(n);
sum_difference = sum_n - out;

% Clean up workspace to match original script's output constraints
% clearvars -except n n_ordered sum_difference number_of_groups

toc