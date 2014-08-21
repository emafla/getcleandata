# R Script for the "Getting and Cleaning Data" course project
# The UCI HAR Dataset (raw) should be in the working directory, unzipped
#    e:/Coursera/GettingCleaningData/project/data (in my case)
# The tidy dataset file after step 5 will be stored in the working directory

# 0. Read test and training data (features, activities, and subjects)
# setwd ("e:/Coursera/GettingCleaningData/project/data") # in my case
test_feat <- read.table ("test/X_test.txt")         # features for test dataset
train_feat <- read.table ("train/X_train.txt")      # features for train dataset
test_act <- read.table("test/y_test.txt")           # activities for test dataset
train_act <- read.table("train/y_train.txt")        # activities for train dataset
test_subj <- read.table("test/subject_test.txt")    # subjects for test dataset
train_subj <- read.table ("train/subject_train.txt") # subjects for train dataset

# 1. Merge test and training datasets
test_ds <- cbind (test_subj, test_act, test_feat)  
train_ds <- cbind(train_subj, train_act, train_feat)
ds <- rbind (test_ds, train_ds)                     # full dataset (test + training)

# 2. Extract measurements on mean and std deviation
features <- read.table ("features.txt", stringsAsFactors = !default.stringsAsFactors())
colnames (ds) <- c("subject", "activity", features[,2])
features_mean <- grep ("mean\\(\\)", features[,2])      # column numbers of mean() vars
features_std <- grep ("std\\(\\)", features[,2])        # column numbers of std() vars
features_ms <- (sort(c(features_mean, features_std)))   # combine, sort column numbers 
idx <- c(1:2, sapply (features_ms, function(x) x<-x+2))
ds_ms <- ds[,idx]                                       # extract requested dataset

# 3. Use descriptive activity names to name the activities in the data set
library(sqldf)
act <- read.table ("activity_labels.txt", stringsAsFactors = !default.stringsAsFactors())
act$V2<- sub("_","",tolower(act$V2))
x <- sqldf ("select * from act join ds_ms where act.V1 = ds_ms.activity", drv="SQLite")
vars <- names(x) %in% c("V1", "activity")
ds_ms <- x[!vars]
colnames(ds_ms) <- c("activity", colnames(ds_ms)[2:68])

# 4. Label the data set with descriptive variable names
v1 <- tolower(colnames(ds_ms))
v2 <- gsub("_|-|\\(|\\)|,","",v1)
v1 <- gsub ("acc","acceleration",v2)
v2 <- gsub("^f","frequency",v1)
colnames(ds_ms) <- gsub ("^t","time",v2)

# 5. Create a tidy data set with the average of each variable for each activity and each subject
library(plyr)
library(reshape2)
ds_msSort <- arrange (ds_ms, activity, subject)
ds_msMelt <- melt(ds_msSort,id=c("activity","subject"))
avg <- dcast(ds_msMelt, activity+subject ~ variable, mean)
colnames(avg)[3:68] <- sapply(colnames(avg)[3:68], function(x) x<-gsub("^", "avg", x))
write.table(avg, file="tidy_ds.txt", row.name=FALSE)
