##Prep has 3 steps - loading dplyr package, checking if exist then downloading files, assigns text files to dataframes

library(dplyr)
filename <- "getdat_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,filename, method = "curl")
}

if (!file.exist("UCI HAR Dataset")){
  unzip(filename)
}

##assign .txt files to data frames
features <- read.table("UCI Har Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI Har Dataset/activity_labels.txt", col.names = c("code","activity"))
subject_test <- read.table("UCI Har Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


## Step one of assignment is to merge the data sets to create on data set this is done by:

X_Data <- rbind(x_train, x_test)
Y_Data <- rbind(y_train, y_test)
Subjects <- rbind(subject_train, subject_test)
Merged <- cbind(Subjects, Y_Data, X_Data)

## Step two of assignment it to extract only measures of mean and standard deviations ("std"):

Tidydata <- Merged %>% select(subject, code, contains("mean"), contains("std"))


## Step three of assignment is to use the descriptive activities name to replace the "code" variable

Tidydata$code <- activities[Tidydata$code, 2]

## Step four of the assignment is to label the Tidydata with descriptive variable names

names(Tidydata) [2] = "Activity"
names(Tidydata) <- gsub("^t", "Time", names(Tidydata))
names(Tidydata) <- gsub("Acc", "Accelerometer", names(Tidydata))
names(Tidydata) <- gsub("Gyro", "Gyroscope", names(Tidydata))
names(Tidydata) <- gsub("Mag", "Magnitude", names(Tidydata))
names(Tidydata) <- gsub("^f", "Frequency", names(Tidydata))
names(Tidydata) <- gsub("tBody", "TimeBody", names(Tidydata))
names(Tidydata) <- gsub("angle", "Angle", names(Tidydata))
names(Tidydata) <- gsub("gravity", "Gravity", names(Tidydata))
names(Tidydata) <- gsub("BodyBody", "Body", names(Tidydata))

## Step 5 - take the Tidydata set and create an independent tidy data set with the average of each 
##          variable for each activity and each subject. (IE Grouped by Subject & Activity)

FinalTidyData <- Tidydata %>% 
    group_by(subject, Activity) %>% 
    summarise_all(funs(mean))

write.table(FinalTidyData, "FinalTidyData.txt", row.names = FALSE)

## End of Project