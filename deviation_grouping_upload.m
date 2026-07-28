tic;

% >> Initialize Data
n_size = 1e6;
n = randi([-1000, 1000], 1, n_size); % Includes 0 and negative numbers
allowed_deviation = 2; % Now handles large deviations efficiently
dev_limit = allowed_deviation / 2;

% >> Sort the data
n_sorted = sort(n);

% >> Group contiguous blocks using pointers and O(1) math
n_ordered = cell(1, n_size); % Preallocate cell array
group_idx = 1;

% Initialize pointers and running stats for the first group
start_idx = 1;
current_sum = n_sorted(1);
current_count = 1;
current_mean = n_sorted(1);

for i = 2:n_size
    % Calculate new prospective mean in O(1) time
    new_sum = current_sum + n_sorted(i);
    new_count = current_count + 1;
    new_mean = new_sum / new_count;
    
    % Mathematical optimization: In a sorted array, the maximum deviation 
    % from the new mean can ONLY occur at the extremes (first element or new element).
    % We only need to check these two bounds instead of the whole array.
    if abs(n_sorted(start_idx) - new_mean) <= dev_limit && ...
       abs(n_sorted(i) - new_mean) <= dev_limit
       
        % Constraint met: extend the group logically (no memory copying)
        current_sum = new_sum;
        current_count = new_count;
        current_mean = new_mean;
    else
        % Constraint broken: extract the finished group using index pointers
        n_ordered{group_idx} = n_sorted(start_idx : i-1);
        group_idx = group_idx + 1;
        
        % Start a new group at the current element
        start_idx = i;
        current_sum = n_sorted(i);
        current_count = 1;
        current_mean = n_sorted(i);
    end
end

% Extract the final group
n_ordered{group_idx} = n_sorted(start_idx : n_size);

% Trim the cell array down to actual size
n_ordered = n_ordered(1:group_idx);
number_of_groups = group_idx;

% >> Verification
out = sum(cellfun(@sum, n_ordered));
sum_n = sum(n);
sum_difference = sum_n - out;

% Clean up workspace
% clearvars -except n n_ordered sum_difference number_of_groups

toc