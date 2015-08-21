
#Create directory
if (!file.exists("GCD.project")){
        dir.create("GCD.project")
}
setwd(, "C:/GCD.project")

#download and unzipped data.
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataURL, destfile="ZIPfile")
unzip("ZIPfile")

#List files and show the directory path, so it is easier to copy and paste path
list.files( recursive = TRUE)


#Read Tables Train
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activity.train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
features.train <- read.table("UCI HAR Dataset/train/x_train.txt", header = FALSE)

#read tables Test
subject.test  <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activity.test  <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
features.test  <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

#Read Labels
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
features.labels <- read.table("UCI HAR Dataset/features.txt", header = FALSE )


#check the content of the files.
str(subject.train); str(activity.train); str(features.train) 
str(subject.test); str(activity.test); str(features.test)
str(activity.labels); str(features.labels)

#1. Merges the training and the test sets to create one data set.


#Merge train and test tables and check content (all have the same number of observations)
subject <- rbind(subject.train, subject.test)
str(subject)
activity<- rbind(activity.train, activity.test)
str(activity)
features<- rbind(features.train, features.test)
str(features)


#label columns and Merge subject, activity and features tables and check content 
#(10299 obs. of  563 variables)

names(features)<- features.labels[,2]
str(features)
subject.activity <- cbind(subject, activity)
str(subject.activity)
colnames(subject.activity)<-c("subject", "activity")
all <- cbind(subject.activity, features)
str(all)
dim(all)
#End product: Merged the training and the test sets. So one data set was created. 
#DATASET = "all" dim= [1] 10299   563. Objective 1 of the project is accomplished


#2. Extracts only the measurements on the mean and standard deviation for each measurement.

#select only the column names that contains the words mean, std, subject and activity 
#and put them in a dataset called extract
extract <- all[,grepl("mean|std|subject|activity", colnames(all))]
str(extract)
dim(extract)
#DATASET = "extract" dim= [1] 10299    81. Objective 2 of the project is accomplished


# 3. Uses descriptive activity names to name the activities in the data set

#adding labels to the activity description file. I needed this to merge data by the common variable "activity". 
colnames(activity.labels)<-c("activity", "actdesc")

#merge activity names description and the data extracted. 
extract <- merge(extract, activity.labels, by="activity")
str(extract)
dim(extract)
#merged by activity and add a new column with the description of the activity "actdesc". 
#I did not change the name of the data set
#DATASET = "extract" dim= [1] 10299    82. Objective 3 of the project is accomplished


#4. Appropriately labels the data set with descriptive variable names. 

#I found a nice table with "gsub" expression systax here http://www.endmemo.com/program/R/gsub.php 
# I'm not familiar with the descriptive variable names of this type of data,
# so I only tryed to make them look nicer 

names(extract)<-gsub("[[:punct:]]", "",  names(extract))#delete all punctuation symbols
names(extract)<-gsub("^t", "Time.", names(extract))
names(extract)<-gsub("Body", "Body.", names(extract))
names(extract)<-gsub("Body.Body", "Body", names(extract))
names(extract)<-gsub("Acc", "Accelerometer.", names(extract))
names(extract)<-gsub("mean", "MEAN.", names(extract))
names(extract)<-gsub("MEAN.Freq", "MEAN.Freq", names(extract))
names(extract)<-gsub("std", "STD.", names(extract))
names(extract)<-gsub("^f", "Freq.", names(extract))
names(extract)<-gsub("Gravity", "Gravity.", names(extract))
names(extract)<-gsub("Gyro", "Gyro.", names(extract))
names(extract)<-gsub("Jerk", "Jerk.", names(extract))
names(extract)<-gsub("Mag", "Mag.", names(extract))

dim(extract)
#DATASET = "extract" dim= [1] 10299    82. Objective 4 of the project is accomplished

#5. From the data set in step 4, creates a second, independent tidy data set with the average
#of each variable for each activity and each subject.

#Install needed package
install.packages("plyr")
require(plyr)

#Using ddply to compute means per column. 
tidydataset <- ddply(extract, .(actdesc, subject), numcolwise(mean))
str(tidydataset)

#I have an extra column, "activity" numeric, so I will delete it
tidydataset$activity <- NULL
dim(tidydataset)

#Export tidy data set to a txt file. 
write.table(tidydataset, "tidydataset.txt", row.name=FALSE )
#DATASET = "tidydataset.txt" dim= [1] 180  81. Objective 5 of the project is accomplished