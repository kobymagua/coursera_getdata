#Loading required packages

library(dplyr)
library(plyr)
library(data.table)

#Source of data for the assignment

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFileName <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"

#setting the directory of the data set
dir_data_set <- "./DATA_SET"
UCI_HAR_Dataset <- "UCI HAR Dataset"

#download data file to application environment
if(!file.exists(dataFileName)) {
  download.file(fileUrl, destfile = dataFileName)
  unzip(dataFileName, overwrite = TRUE, exdir = dir_data_set)
}

#read the data from the test subfolder
test_labels <- read.table("DATA_SET/UCI HAR Dataset/test/y_test.txt", col.names = "label")
test_subjects <- read.table("DATA_SET/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_data <- read.table("DATA_SET/UCI HAR Dataset/test/X_test.txt")

#read the data from the train subfolder
train_labels <- read.table("DATA_SET/UCI HAR Dataset/train/y_train.txt", col.names = "label")
train_subjects <- read.table("DATA_SET/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train_data <- read.table("DATA_SET/UCI HAR Dataset/train/X_train.txt")

#merging data from test subfolder with that of train subfolder data

data <- rbind(cbind(test_subjects, test_labels, test_data), cbind(train_subjects, train_labels, train_data))

#extract features of the dataset

features <- read.table("DATA_SET/UCI HAR Dataset/features.txt", strip.white = TRUE, stringsAsFactors = FALSE)

#extracting the mean and standard deviation for each measurement

features_mean_std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

data_mean_std <- data[, c(1, 2, features_mean_std$V1+2)]

#reading the labels for the activities

labels <- read.table("DATA_SET/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

data_mean_std$label <- labels[data_mean_std$label, 2]

good_colnames <- c("subject", "label", features_mean_std$V2)

good_colnames <- tolower(gsub("[^[:alpha:]]", "", good_colnames))


colnames(data_mean_std) <- good_colnames

#aggregating the extracted data and writing it into tidytext.txt

aggr_data <- aggregate(data_mean_std[, 3:ncol(data_mean_std)], by = list(subject = data_mean_std$subject, label = data_mean_std$label), mean)

write.table(format(aggr_data, scientific = T), "tidytext.txt", row.names = F, col.names = F, quote = 2)