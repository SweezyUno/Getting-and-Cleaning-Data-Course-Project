---
title: "codebook"
author: "SweezyUno"
date: "10/9/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

The run_analysis.R scipt performs the data download and prep to preform the 5 steps required as laid out in the projects tasks. 

  1. Prep and Download 
      + Load the dplyr package used
      + Download and extract the data into the folder called "UCI HAR Dataset
      
  2. Assign .txt files to variables
      + activities <- activity labels.txt : 6 rows, 2 columns
        List of activities preformed when the measurements were taken an it code(label)
      + features <- features.txt: 561 rows, 2 columns
        The features in this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ
      + suject_test <- test/subject_test.txt: 2947 rows, 1 column
        Contains the test data of the 9/30 volunteer test subjects being observed
      + x_test <- test/X_test: 2947 rows, 561 columns
        Contains recorded features for test data
      + y_test <- test/y_test.txt: 2947 rows, 1 coulum
        Contains test date of activities code labels
      + subject_train <- test/subject_train.txt: 7352 rows, 1 column
        Contains train data of 12/30 volunteer subject being observed
      + x_train <- test/X_train.txt: 7352 rows, 561 columns
        Contains the recorded fearures for train data
      + y_train <- test/y_train.txt: 7352 rows, 1 column
        contains train data of activities code labels
        
    3. Merges the training and test sets into one data set
      + X_Data (10299 rows, 561 columns) is formed by mering x_train and x_test using rbind()
      + Y_Data (10299 rows, 1 column) is formed by merging y_train and y_test using rbind()
      + Subjects (10299 rows, 1 column) is formed by merging subject_train and subject_test using rbind()
      + Merged (10299 rows, 563 columns) is formed by merging Subject, Y_Data, and X_Data using cbind()
    
    4. Extract only the measurments of mean and standard deviation for each measurement
      + "Tidydata" (10299 rows, 88 columns) is formed by subseting "Merged" and selecting columns: "subject", "code" and the measurements of including "mean" or "standard deviation"
    
    5. Uses the descriptive activities name to replace the "code" variable
      + The "code" column of "Tidydata" is replaces with the correct activity based on the second column in the "activites" variable
      
    6. Label the dataset with descriptive variable names
      + Using gsub() on column name to replace "code" with "activities"
      + Using gsub() on column name to replace all start with "t" to "time
      + Using gsub() on column name to replace "Acc" with "Accelerometer"
      + Using gsub() on column name to replace "Gyro" with "Gyroscope"
      + Using gsub() on column name to replace "Mag" with "Magnitude"
      + Using gsub() on column name to replace all start with "f" to "Frequency"
      + Using gsub() on column name to replace "tBody" with "TimeBody"
      + Using gsub() on column name to replace "angle" with "Angle"
      + Using gsub() on column name to replace "gravity" with "Gravity"
      + Using gsub() on column name to replace "BodyBody" with "Body"
      
    7. Create a second and independent tidy data set with the average of each variable for each activity and each subject
      + FinalTidyData (180 rows, 88 columns) is formed by grouping Tidydata by subject and activity and then applying the means funtion to each variable for each activity and each subject
      + FinalTidyData.txt is created using write.table() on FinalTidyData
      
      