##------------------------------------------------------------------------------
##
## The purpose of this project is to demonstrate learned ability to collect, 
## work with, and clean a data set.
## The goal is to prepare tidy data that can be used for later analysis.
##
## To prepare working environment and load requiered libraries
library(reshape2)

##------------------------------------------------------------------------------

## To get the data from the websource
baseUrl <- "https://d396qusza40orc.cloudfront.net"
pathToData <- "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileUrl <- file.path(baseUrl,pathToData)

zipFile <- "getdata_projectfiles_UCI HAR Dataset.zip"
folderName <- "UCI HAR Dataset"

## To check if zip file already exists to use or to download a new one.
if(!file.exists(zipFile)){
    download.file(fileUrl, zipFile, method="curl")
}

## To check if data is unziped already or we require to unzip it.
if(!file.exists(folderName)){
    unzip(zipFile)
}

##------------------------------------------------------------------------------

## To read the features labels from the text file.
features <- read.table(file.path(folderName,"features.txt"), 
                       header = FALSE, sep = " ")
features[,2] <- as.character(features[,2])

## To read the activity labels.
activity_labels <- read.table(file.path(folderName,"activity_labels.txt"),
                              header = FALSE)
activity_labels[,2] <- as.character(activity_labels[,2])

## To extract only the data required and rename column names
features_indices <- grep(".*mean.*|.*std.*", features[,2])
features_labels <- features[features_indices,2]
features_labels  = gsub('-mean', 'Mean', features_labels )
features_labels  = gsub('-std', 'Std', features_labels )
features_labels  <- gsub('[-()]', '', features_labels )

##------------------------------------------------------------------------------

## To read train data given riquired indices.
train <- read.table(file.path(folderName,"train/X_train.txt"))[features_indices]
train_activities <- read.table(file.path(folderName,"train/Y_train.txt"))
train_subjects <- read.table(file.path(folderName,"train/subject_train.txt"))
train_data <- cbind(train_subjects, train_activities, train)

## To read test data given riquired indices.
test <- read.table(file.path(folderName,"test/X_test.txt"))[features_indices]
test_activities <- read.table(file.path(folderName,"test/Y_test.txt"))
test_subjects <- read.table(file.path(folderName,"test/subject_test.txt"))
test_data <- cbind(test_subjects, test_activities, test)

##------------------------------------------------------------------------------

## To merge data into one big data.frame with train and test data.
data <- rbind(train_data, test_data)
colnames(data) <- c("subject", "activity", features_labels)

## To transform data into factors.
data$activity <- factor(data$activity,
                        levels = activity_labels[,1],
                        labels = activity_labels[,2])
data$subject <- as.factor(data$subject)

##------------------------------------------------------------------------------

## To melt the data and transpose it.
melted <- melt(data, id = c("subject", "activity"))

## To get the mean
dataWithMean <- dcast(melted, subject + activity ~ variable, mean)

##------------------------------------------------------------------------------

## To create the text file with the resulting data.
write.table(dataWithMean, "tidyData.txt", 
            row.names = FALSE, quote = FALSE)

##------------------------------------------------------------------------------
