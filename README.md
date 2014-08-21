# _Getting and Cleaning Data_ Project

This project is part of the Coursera course *Getting and Cleaning Data* (https://class.coursera.org/getdata-006). The object of the project is the creation of an R script called *run_analysis.R* that does the following:

1. Merge the training and the test sets to create one data set
2. Extract only the measurements on the mean and standard deviation
3. Use descriptive activity names to name the activities in the data set
4. Label the data set with descriptive variable names
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

## *run_analysis* R Script

The R script *run_analysis.R* contains the R code that implements the five steps of the project, listed above. We process each part in sequence:

0. Read the raw test and training dataset (features, subjects, and activities) into 6 data.frames.

1. Merge the test and training datasets. *cbind* is used to merge the subjects, activities, and features data.frames for the test and training datasets, and then *rbind* is used to merge both data.frames. The column names were replaced with the names in the "features.txt" file.

2. Extract the mean() and std() columns, along with the subject and activity columns from the merged data.frame.

3. Replace the activity numbers with the activity name, using the activity names in *activity_labels.txt* file, which was read into a data.frame. A join of the activities dataset and the the dataset produced in step 2 was performed, using *sqldf*

4. Replace the original variable names, found in the *features.txt* file with descriptive variable names, using the *tolower* and *gsub* functions.

5. Create a tidy dataset with the average of each variable extracted in step 2, for each activity and each subject. The *plyr* and *reshape* libraries were used to *arrange*, *melt*, and *dcast* the dataset extracted in step 2, to create the tidy dataset. The substring *avg* was prepended to the variable names.

The script was developed and tested in RStudio for Windows, version 0.98.976. 

The script assumes that its working directory contains the Samsung (raw) dataset, unzipped.

## Raw Dataset

The raw dataset for this project is the "UCI HAR Dataset (Samsung Data)", which was downloaded from the following URL, specified in the course website:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The downloaded zip file *getdata-projectfiles-UCI HAR Dataset.zip* contains the raw dataset for the project. The cygwin *unzip* command was used to unzip the file:

unzip getdata-projectfiles-UCI\ HAR\ Dataset.zip

The directory created by the above command should be the working directory for the "run_analysis.R" script.

The following files from the raw dataset are used by the script:

* activity_labels.txt - names of activities
* features.txt - names of features (variables)

* test/subject_test.txt -subjects for the test dataset
* test/X_test.txt - features for the test dataset
* test/y_test.txt - activities for the test dataset

* train/subject_train.txt - subjects for the training dataset
* train/X_train.txt - features for the training dataset
* train/y_train.txt - activities for the training dataset


## Tidy Dataset

The *run_analysis.R* script produces the text file *tidy_ds.txt*, which contains a tidy dataset with the average for the *mean* and *standard deviation* variables (features) in the raw dataset, for each activity and each subject.