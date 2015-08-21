#CodeBook
In this document I explained the data manipulation performed for the Project of the Course Getting and Cleaning Data

##Source of Data

Here is a full descript of the data 

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

And here is the source of the data

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>


##Brief study explanation
Human Activity Recognition database contains the recordings of 30 volunteers within an age bracket of 19-48 years performing activities of daily living, while carrying a waist-mounted smartphone with embedded inertial sensors. The sensor signals (accelerometer and gyroscope) recorded the 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. Data was validated using video recording of 30% of the subjects.

Each record in the dataset provides: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Referecnce: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

#Data

Data sets are divided into different tables. Tables with information of the subjects and activity for the training data (70% of the subjects), data with the the subjects and activity of the test data (30% of the subjects). Data with the measured information was also contained in 2 files for the training and test subjects.

The files used in this project were:  

1. subject_train.txt and subject_test.txt   for subject IDs
2. y_train.txt and y_test.txt for coded activities coded
3. x_train.txt and X_test.txt for  measured observations 

Labels for the activities and measured observations were in activity_labels.txt and features.txt files, respectively.

All these files were included in R as R objects

#Objectives of the Project

###1. Merges the training and the test sets to create one data set.

1. Training and test files were merged by rows, so I only have one file for subjects, activity and measured observations.

2. Labels were added to the first row in each file

3. Finally, The 3 files (subjects, activity and measured observations) were merged to accomplish objective 1 of the project

Objective 1 outcome data frame "all"

###2. Extracts only the measurements on the mean and standard deviation for each measurement.

1. Column names that contains the words "mean", "std", "subject" and "activity" were selected and included in a new R-object

Objective 2 outcome data frame "extract"

###3. Uses descriptive activity names to name the activities in the data set

1. I added column names to the file "activity.labels". One of the columns activity was use as merging key.   

2. I merged activity labels with extract data by variable "activity". 

Objective 3 outcome data frame "extract" with a new column with the description of the activities "actdesc"

###4. Appropriately labels the data set with descriptive variable names. 

1. I used find and replace function of r (gsub) to look for specific strings in the column names and I replaced with a different name. I am not very familiar with this type of data so I could not use an appropriated name to describe the variables.

Objective 4 outcome data frame "extract" with new column descriptive names.

###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. Installed the plyr package

2. Use the function ddply to compute the mean of EACH columns by activity and subject in a new r-object called "tidydataset".

3. I have an extra column from step 3 "activity numerical" which I deleted

4. I exported tidydataset to a txt file

Objective 5 outcome txt file "tidydataset
```{r, include=FALSE}
   # add this chunk to end of mycode.rmd
   file.rename(from="C:\\Users\\Espejo-Arikawa\\Documents\\Luis\\GCD.project\\CodeBook.rmd", 
               to="CodeBook.md")

```
