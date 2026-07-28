# deviation_grouping_upload.m

In unsupervised learning, grouping 1D numerical data without knowing the number of clusters beforehand can be challenge. i made a MATLAB program that addresses this by grouping data based on deviation constraints.

The Process 

The program utilizes a property of deviation: if every element in a group must be within a specific limit (d/2) of the group's mean, the maximum difference between any two elements in that group cannot exceed (d).

The Results 

The program outputs a structured cell array where every subset represents a group. Within each group, every element deviates from the group's specific mean by less than the defined threshold.
