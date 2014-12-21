# Constructing a Tidy Data Set from the Human activity Recognition Using Smartphone Dataset
# This script was developed after a lot of initial exploring and probing in Python ... to get familiar with the datasets 
# and to cross- check that numbers of records were consistent etc. 
# This showed that not all subjects carried out the same numbers of tests ...
# The only cross checking against the Inertial signals ... was to check that numbers of records tallied ... 
# This script does not carry out any of the above exploratory steps ... it assumes that the data is in a consistent state. 

# The requirements analysis for this project ... 

# You should create one R script called run_analysis.R that does the following. 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# When working in RStudio 
# root_data_directory = "/Users/student/JohnsHopkins-Stats-Courses-Projects-2014/Getting_Data/UCI_HAR_Dataset/"
# root_dir <- setwd(root_data_directory)

# test_data_directory = "/Users/student/JohnsHopkins-Stats-Courses-Projects-2014/Getting_Data/UCI_HAR_Dataset/test/"
# train_data_directory = "/Users/student/JohnsHopkins-Stats-Courses-Projects-2014/Getting_Data/UCI_HAR_Dataset/train/"

# Property names for the columns ... one way to get them might be to replace '-' with '_' and to replace '()' with ''
# and to replace ',' with '_' globally. Also to replace the leading series of digits followed by a space by ''
# No need to go for a fancy all embracing regular expression substitution ... 
# take your time and do it as a series of relatively simply patterns and substitutions ... 
# The script is assumed to be run from the root directory for the data set ...
# A more refined version could be implemented that can use  e.g. command line arguments or environment variable to locate the data
root_dir <- getwd()
test_data_directory <- as.character(paste0(root_dir,"/test/"),collapse)
train_data_directory <- as.character(paste0(root_dir,"/train/"),collapse)  


# Property names for the columns ... one way to get them might be to replace '-' with '_' and to replace '()' with ''
# and to replace ',' with '_' globally. Also to replace the leading series of digits followed by a space by ''
# No need to go for a fancy all embracing regular expression substitution ... 
# take your time and do it as a series of relatively simply patterns and substitutions ... 
con <- file("features.txt",open="r")
featureList <- readLines(con)
close(con)
# print(length(featureList))
as.character(featureList)
featureList_original <- featureList
# print(featureList)
featureList <- gsub("^[0-9]+[ \t]+","",featureList)
# print('After gsub("^[0-9]+[-\t]+","",featureList)')
# print(featureList)
featureList <- gsub("-|,","_",featureList)
# print(featureList)
featureList <- gsub("\\(\\)","",featureList)
# print(featureList)
featureList <- gsub("\\)$","",featureList)
featureList <- gsub("\\(|\\)","_",featureList)
# print(featureList)

# Now to get the test data sorted out ... 
# We have to get a data frame of exactly one column with the subject_ID's 
# and a data frame with the activity_IDs
# and probably map the activity_IDs to their corresponding string literals ... (for readability)

setwd(test_data_directory)
con <- file("subject_test.txt",open="r")
subject_ID <- readLines(con)
close(con)
# print(subject_ID_List)
subject_ID_DF <- as.data.frame(subject_ID)
# print(dim(subject_ID_DF))
# print(names(subject_ID_DF))
# print(subject_ID_DF[,"subject_ID"])

con <- file("Y_test.txt",open="r")
activity_ID <- readLines(con)
activity_ID <- as.character(activity_ID)
close(con)
# print(subject_ID_List)
activity_ID_DF <- as.data.frame(activity_ID)
# print(dim(activity_ID_DF))
# print(names(activity_ID_DF))
# print(activity_ID_DF[,"activity_ID"])
require(plyr)
activity_ID_DF$activity_ID <- mapvalues(activity_ID_DF$activity_ID, 
                               from=c("1","2","3","4","5","6"), 
                               to=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
# print(activity_ID_DF[,"activity_ID"])

# Now we need to handle the X_test.txt records ...
# read.table reads a file in table format and creates a dataframe 
X_Activity_RecordsDF <- read.table("X_test.txt")
# print(dim(X_Activity_RecordsDF))
# print(names(X_Activity_RecordsDF))

# Now to replace the automatically generated column names with those constructed from the feature list

for(i in 1:561) {
  names(X_Activity_RecordsDF)[i] <- featureList[i]
}
# print(names(X_Activity_RecordsDF))
# Now create a subset retaining only columns pertaining to means and standard deviations
mean_and_std_features_onlyDF <- subset(X_Activity_RecordsDF, select = grepl("(mean)|(std)", names(X_Activity_RecordsDF),ignore.case=TRUE))
# print(names(mean_and_std_features_onlyDF))
# print(dim(mean_and_std_features_onlyDF))

# Now to add in the subject and activity columns ....
CompleteTestDataFrame <- cbind(subject_ID_DF,activity_ID_DF, mean_and_std_features_onlyDF )
# print(dim(CompleteTestDataFrame))
# print(names(CompleteTestDataFrame))



# Now to create a complete data frame for the training data
# Now to get the train data sorted out ... 
# We have to get a data frame of exactly one column with the subject_ID's 
# and a data frame with the activity_IDs
# and probably map the activity_IDs to their corresponding string literals ... (for readability)
setwd(train_data_directory)
con <- file("subject_train.txt",open="r")
subject_ID <- readLines(con)
close(con)
# print(subject_ID_List)
subject_ID_DF <- as.data.frame(subject_ID)
# print(dim(subject_ID_DF))
# print(names(subject_ID_DF))
# print(subject_ID_DF[,"subject_ID"])

con <- file("Y_train.txt",open="r")
activity_ID <- readLines(con)
activity_ID <- as.character(activity_ID)
close(con)
# print(subject_ID_List)
activity_ID_DF <- as.data.frame(activity_ID)
# print(dim(activity_ID_DF))
# print(names(activity_ID_DF))
# print(activity_ID_DF[,"activity_ID"])
require(plyr)
activity_ID_DF$activity_ID <- mapvalues(activity_ID_DF$activity_ID, 
                                        from=c("1","2","3","4","5","6"), 
                                        to=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
# print(activity_ID_DF[,"activity_ID"])
# Now we need to handle the X_test.txt records ...
#  read.table reads a file in table format and creates a dataframe 
X_Activity_RecordsDF <- read.table("X_train.txt")
# print(dim(X_Activity_RecordsDF))
# print(names(X_Activity_RecordsDF))

# Now to replace the automatically generated column names with those constructed from the feature list

for(i in 1:561) {
  names(X_Activity_RecordsDF)[i] <- featureList[i]
}
# print(names(X_Activity_RecordsDF))
mean_and_std_features_onlyDF <- subset(X_Activity_RecordsDF, select = grepl("(mean)|(std)", names(X_Activity_RecordsDF),ignore.case=TRUE))
# print(names(mean_and_std_features_onlyDF))
# print(dim(mean_and_std_features_onlyDF))
# Now to add in the subject and activity columns ....
CompleteTrainDataFrame <- cbind(subject_ID_DF,activity_ID_DF, mean_and_std_features_onlyDF )
# print(dim(CompleteTrainDataFrame))
# print(names(CompleteTrainDataFrame))

# Now to merge the CompleteTrainDataFrame and the CompleteTestDataFrame data frames together ... 
CompleteCombinedDataFrame <- rbind(CompleteTestDataFrame, CompleteTrainDataFrame)

# Finally group and summarise to create a new summary data frame ...

if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
library(dplyr)


summarisedDF <- CompleteCombinedDataFrame %>% group_by(subject_ID,activity_ID) %>% summarise_each(funs(mean))
# print(dim(summarisedDF))
# print(names(summarisedDF))
# print(head(summarisedDF))
# The number of groupings checks out ... 

summarisedDF_feature_list <- names(summarisedDF)
summarisedDF_feature_list <- gsub("(.*(mean|std).*)",("MeanForRuns_\\1"),summarisedDF_feature_list,ignore.case=TRUE)

# The first two columns are subject_ID and activity_ID and their meanings to not change.
# Threr are 88 features pertaining to means and standard deviations of signal traces obtained after Digital Signal Processing
for(i in 3:88) {
  names(summarisedDF)[i] <- summarisedDF_feature_list[i]
}
# print(names(summarisedDF))
# Create file name for destination of write.table()
fileName = as.character(paste0(root_dir,"/summarisedDF.txt"),collapse)
# Write out the table ... 
write.table(summarisedDF,fileName,row.name = FALSE)
