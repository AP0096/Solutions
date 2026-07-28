# deviation_grouping_upload.m

In unsupervised learning, grouping 1D numerical data without knowing the number of clusters beforehand can be challenge. I made a MATLAB algorithm that addresses this by grouping data based on mathematical deviation constraints.

The Process 

The algorithm relies on a fundamental mathematical property of deviation: if every element in a group must be within a specific limit (d/2) of the group's mean, the maximum difference between any two elements in that group cannot exceed (d).

Using this, the grouping process follows the following path:

1.	The dataset is sorted in ascending order.
2.	The algorithm iterates through the sorted array, building a contiguous block starting from the first element.
3.	As it moves to the next element, it tentatively adds it to the current block and calculates the new prospective mean.
4.	It verifies if the elements in this expanded block still fall within the allowed deviation limit.
5.	If the constraint holds, the block continues to grow. If it breaks, the current block is finalized, stored, and a new block is initiated.

The Results 

The algorithm outputs a structured cell array where every subset represents a mathematically sound group. Within each group, every element deviates from the group's specific mean by less than the defined threshold. Through structuring the logic around sorted contiguous blocks rather than heuristic masking, the algorithm natively ingests and accurately clusters datasets that contain zero values without data corruption.

#Matlab #Algorithm #DataScience #UnsupervisedLearning #DataClustering #Programming
