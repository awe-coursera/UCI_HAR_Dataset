How the code works.
The run_analysis.R script needs to be run from the root directory of the Samsung data files. 
These can be installed by downloading the zipped up data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and then unzipping the resulting file to some chosen location on your filesystem. 
The original data sets are described in detail in the following document http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data sets are organised as follows :
The root directory contains the files 
features.txt - which contains a listing of the features in the order in which the corresponding columns appear in the data files obtained by processing the original raw signal data.
The meaning of these features is described in the features_info.txt file.
The subjects in these experiments performed various activities the names of these activities and the corresponding  codes are in the file activity_labels.txt
README.txt - describes the experiments performed to acquire the raw data and also the signal processing performed on the data to obtain the various features that make up the feature set. 

The subjects performing the experiments were organised into two groups - a group the data for which constituted a training data set, and another group, the data for which constituted the testing data set.  The details data sets for the training and testing data are to be found in the corresponding train and test sub-directories. 

These directories contain an Intertial Signals subdirectory that contains the raw data split up over several files, and the following files 
X_?????.txt, y_?????.txt and subject_?????.txt - where ????? is either test or train. 

Each record in the X- files is made up of 561 text formatted floating point numbers - this corresponds to the features.
The features are computed from the files in the Inertial Signals directory. 
Each record in a file in a signals directory contains 128 fields and represents a series of readings for a given sensor value type ... 
There are 2947 sensor reading trace record per testing set file and 7352 records per training set file.
The X- files contain values derived from these traces.
Each X- file record corresponds to a given subject and a given activity.
Thus, a given subject performed each given activity a certain number of times. 
The number of times varies by both student and activity. 

There are 30 subjects and 6 possible activities.
The training data involved 21 subjects and the test data involved 9 subjects 
This can be deduced quite easily by a bash one liner such as the following on the corresponding subject_????.txt files
e.g. 
cat subject_train.txt | sort | uniq | wc -l
Doing the samething on the y_????.txt files reveals 6 possible values 1 .. 6 corresponding to the various types of activity.
Using the X_????.txt , subject_????.txt files and y_????.txt files it is possible to construct a 6 by 30 matrix whose entries corresponded to e.g. the number of times a particular subject carried out a particular activity - a total of 180 <subject_id, activity_id> combinations. 

The run_analysis.R scripts carries out the following sequence of operations on the downloaded data
1. Merges the training and the test sets to create one large data set. (The first two columns are the subject_id and activity_id respectively, where the activity_id is a literal e.g. WALKING as opposed to a numeric code. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Appropriately labels the data set with descriptive variable names - based on the names given in the features.txt file
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject and writes it out as a text file in tabular format with the first row being a header row whose entries name the corresponding columns and the remaining rows being the rows containing the various means of means values. The names for the columns, apart from the subject_id and activity_id columns are formed by taking the column names for the corresponding means and standard deviations and prefixing each name with the prefix MeanForRuns_







