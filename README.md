# Getting and Cleaning Data Assignment

This is a project assignment for the Coursera course "Getting and Cleaning Data". 

The objective of this project is to demonstrate the collection, manipulation, and cleaning of dataset from wearable devices. 

The goal is to prepare tidy data that can be used for analysis.

Wearables from companies such as Fitbit, Jawbone Up, Nike, and Apple produces a lot of data. Example is the one provided in this link from the Samsung Galaxy S smartphones:
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Files in this repository

README.md -- providing a brief description of the assignment
CodeBook.md -- codebook describing variables, the data and the transformations
run_analysis.R -- actual R code for tidying up the dataset

# run_analysis.R script
This is the R script that does the following:

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measuremen;
Uses descriptive activity names to name the activities in the data set;
Appropriately labels the data set with descriptive activity name;
Creates a second, independent tidy data set with the average of each variable for each activity and each subject;

It runs in the directory of the data by unzipping into the directory: UCI HAR Dataset. 

The R script needs the following files and directories:

activity_labels.txt
features.txt
test/
train/

The results of the tidy dataset is stored in tidytext.txt

#Flow of run_analysis.R 
The script follows the steps below:

Step 1:

Download the files from the data source and unzip onto the current directory.

Read all the test and training files from y_test.txt, subject_test.txt and X_test.txt.

Merge the files to a data frame from the text and train directory in the structure of subjects, labels, and the data.

Step 2:

Read and filter the mean and standard deviation features from features.txt file and store in a new data frame with subjects and labels as the variable.

Step 3:

Read the activity labels from activity_labels.txt and replace the numbers with the text.

Step 4:

Creates new columns for "subjects" and "labels" at the start then tidy te list by removing all non-alphanumeric characters and converting the result to lowercases and apply the new columns to the data frame.

Step 5:

Create a new data frame by finding the mean for each combination of subject and label. It's done by aggregate() function

Step 6:

Write the new tidy data set into a text file called tidytext.txt.
