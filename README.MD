##Getting and Cleaning Data Course Project ReadMe

#The __run_analysis.R__ script is preforms all the data tidiing as such:
1. Downloads and unzips the data set in the working directory.
2. Reads all the relevant files containg the accelerometer data and
   the labels for the train and test data sets.
3. Finds the indices of the mean and std containing rows in the features.txt file
4. Matches the features indices to both datasets
5. Binds the subject number from the subject_test.txt and subject_train.txt files, the activity from
   y_test.txt and y_train.txt files.
6. Gives a descriptive header based on the features.txt file
7. Gives descriptive name instead of number to the activity based on activity_labels.txt
8. Writes the clean data set into __tidy_data.txt__
9. Avrages the data based on activity and subject
10. Splits the avearage data into 6 new tables containing the mean per subject per activity.
11. Writes the 6 new tables into __ACTIVITY.CSV__

   