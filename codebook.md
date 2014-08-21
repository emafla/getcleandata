# Code Book

This document describes the main variables used in the script *run_analysis.R*, which takes a raw dataset (the Samsung dataset) and produces a tidy dataset.

## Files from the raw dataset
The script uses the Samsung data, as the raw dataset. This dataset contains 561 measurements for 6 activities performed by 30 subjects. The dataset is divided in two datasets: training and test; which contain the measurements for 21 and 9 subjects, respectively. 

* activity_labels.txt. This is a 6-row, 2-column file, which contains, in each row, the id and the name (label) for each of the 6 activities.
* features.txt. This is a 561-row, 2-column file, that stores, in each row, the id and name (label) for each of the 561 features (variables)

* test/subject_test.txt. This is a 2947-row, 561-column file with the ids of 9 subjects
* test/X_test.txt. This is a 2947-row, 561-column with the measurements of the 561 variables corresponding to the 6 activities of 9 subjects
* test/y_test.txt. This is a 2947-row, 561-column file with the ids of the 6 activities

* train/subject_train.txt. This is a 7352-row, 561-column file with the ids of 9 subjects
* train/X_train.txt. This is a 7352-row, 561-column file with the measurements of the 561 variables corresponding to the 6 activities of 9 subjects
* train/y_train.txt. This is a 7352-row, 561-column file with the ids of the 6 activities


## Script variables

#### Step 0
* test_feat - data.frame, with the contents of the "test/X_test.txt" file 
* train_feat - data.frame, with the contents of the "train/X_train.txt" file
* test_act - data.frame, with the contents of the "test/y_test.txt" file
* train_act - data.frame, with the contents of the "train/y_train.txt" file
* test_subj - data.frame, with the contents of the "test/subject_test.txt" file
* train_subj - data.frame, with the contents of the "train/subject_train.txt" file

#### Step 1
* test_ds - data.frame, contains the merging of the subject, activity and measurement data for the test dataset
* train_ds - data.frame, contains the merging of the subject, activity and measurement data for the training dataset
* ds - data.frame, stores the full dataset (test + training)

#### Step 2
* features - data.frame, stores the  contents of the "features.txt" file. the feature names are stored as strings
* features_mean - integer vector, stores the column numbers of the mean() variables
* features_std - integer vector, stores the column numbers of the std() variables
* features_ms - integer vector, stores sorted column numbers of the mean() and std() variables
* idx - integer vector, contains the column numbers for subject, activity, and the 66 mean() and std() variables
* ds_ms <- ds[,idx] - data.frame, subset of the ds data.frame, contains the extracted dataset requested in step 2

#### Step 3
library(sqldf)
act - data.frame, stores the  contents of the "activity_labels.txt" file. the activity names are stored as strings
x - data.frame, contains the join of the act and ds_ms datasets.

#### Step 4
v1, v2 - char vectors, store the column names, during the process of their transformation to tidy names.

#### Step 5
library(plyr)
library(reshape2)
ds_msSort - data.frame, stores the ds_ms data.frame, sorted by activity and subject
ds_msMelt - melted data.frame, using activity andsubject" as id
avg - tidy data.frame
  

## Files produced - tidy dataset

tidy_ds.txt - file that contains the tidy dataset. 