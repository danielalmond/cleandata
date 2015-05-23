# cleandata
clean data assignment for coursera

The script works likes this:

1. Read in the 3 files of test data.
2. Read in the features.txt file and use the information in this file as labels for the columns in the test data frame. #STEP 4
3. Filter away any unwanted measurements by grepping the col names for std() and mean() #STEP 2
4. Add columns to the df for subject_id and activity
5. Repeat for the training data.
6. Now the dfs are cleaned and compatible, so merge them with all=TRUE #STEP 1 of assignment
7. Label the activity column with labels from the activity info file. #STEP 3
8. Make the avgs df by sapplying the function of sapplying split (x) by subject id and activity and calculating the mean over each column of the joint df #STEP 5
