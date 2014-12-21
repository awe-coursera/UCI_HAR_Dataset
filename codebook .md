Codebook - Describing the run_analysis.R script
The script assumes that the data is organised as described in the README.md document and the links to further documentation contained therein. 

The various stages of processing (as detailed in the comments in the script) are
1. Obtain the value of the current working directory and save it in a variable called root_dir
2. Create variables that will hold the paths to the the test and train subdirectories. 
3. Starting with a list of feature performs various substitutions to produce more readable list of feature names.  
4. The test data processing is as follows : The script
4a) Reads in the subject_test.txt file and creates a subject_ID_DF data frame containing the subject_id values and having a column title of subject_ID
4b)  Reads in y_test.txt to create as  numeric codes and maps them to the corresponding descriptive strings and creats a one column activity data frame, activity_ID_DF, with the with the title activity_ID
4c) Reads in the X_test.txt file and creates a data frame with column names corresponding to those in the readable list of feature names. 
4d) Creates a more complete data frame by pre-pending the subject_ID and activity_ID to the dataframe constructed in step 4d. 
5. A subset dataframe of the one created in step 4d which contains only those columns corresponding to features/properties which refer to means and standard deviations is constructed.
6. The  train data  is processed in the same way. 
7. The data frames produced in steps 5 and 6 are then row-wise merged 
8. The data in the resulting large dataframe is then processed by grouping by <subject_id, activity_id> values and computing the means for the various measurements in each group. 
9. The names of the summarised mesurement columns are then modified by prepending MeanForRuns_ to the name for each column to indicate that the values are e.g. a mean of means or a mean of standard deviations. 
10. The resulting dataframe is then written out as a tabular text file with row names omitted. 

