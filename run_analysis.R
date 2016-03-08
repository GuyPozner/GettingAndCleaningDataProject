#Download and Unzip the data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCIdata.zip")
unzip("UCIdata.zip")

#Load the data
features <- read.table(paste0(getwd(), "/UCI HAR Dataset/features.txt"), header = FALSE)
trainDat <- read.table(paste0(getwd(), "/UCI HAR Dataset/train/X_train.txt"), header = FALSE)
testDat <- read.table(paste0(getwd(), "/UCI HAR Dataset/test/X_test.txt"), header = FALSE)
trainSubject <- read.table(paste0(getwd(), "/UCI HAR Dataset/train/subject_train.txt"), header = FALSE)
testSubject <- read.table(paste0(getwd(), "/UCI HAR Dataset/test/subject_test.txt"), header = FALSE)
trainActivity <- read.table(paste0(getwd(), "/UCI HAR Dataset/train/y_train.txt"), header = FALSE)
testActivity <- read.table(paste0(getwd(), "/UCI HAR Dataset/test/y_test.txt"), header = FALSE)
activityLabels <- read.table(paste0(getwd(), "/UCI HAR Dataset/activity_labels.txt"), header = FALSE)

#Find only mean and std containing features
features$V2 <- as.character(features$V2)
indices <- grep("mean|std", features$V2)

#Bind the two data sets(train and test) for variables containing only 
#the mean and the standard deviation
dat <- rbind(trainDat[,indices], testDat[,indices])
subject <- rbind(trainSubject, testSubject)
activity <- rbind(trainActivity, testActivity)

#Arrange in a single table
tidyDat <- cbind(subject, dat, activity)

#Change the headers to be descriptive
names(tidyDat) <- c("subject", features$V2[indices], "activity")

#Substitute the activity number with a descriptive name
activityLabels$V2 <- as.character(activityLabels$V2)
for(i in 1:nrow(activityLabels)){
  activity[activity == activityLabels$V1[i]] <- activityLabels$V2[i]
}
tidyDat$activity <- activity$V1

#Store the tidy data
write.csv(tidyDat, file = "tidy_data.csv")

#Mean per subject Dataset
meanDat <- aggregate(tidyDat[,features$V2[indices]], by = list(tidyDat$subject, tidyDat$activity), FUN = mean, na.rm = TRUE) 
names(meanDat) <- c("subject", "activity",features$V2[indices])

#Splits the meanDat based on the activity
splitDat <- split(meanDat, meanDat$activity)

#Stores relevant files in .csv format
lapply(1:length(splitDat), function(i) write.csv(splitDat[[i]][,-2], 
                                                file = paste0(names(splitDat[i]), ".csv"), 
                                                row.names = FALSE)
       )







