# GetAndCleanDataAssignment

The purpose of this project is to demonstrate learned ability to collect, work with, and clean a data set.
The goal is to prepare tidy data that can be used for later analysis.

You can run the analysis by using the following code in an R Studio console:

`setwd(pathtofile)`

`source("run_analysis.R")`

The run_analysis.R, does the following:

1. Gets the data from the websource
2. Unzips the file if folderName is not found in working directory.
3. Reads the features labels from the text file.
4. Read the activity labels.
5. Extracts only the data required and renames column names
6. Reads the Train data giving required indices.
7. Reads the Test data giving required indices.
8. Merges data into one big data.frame with train and test data.
9. Transforms data activity and subject into factors.
10. Melts the data and transpose it.
11. Calculates the mean
12. Creates a text file with the resulting data named tidyData.txt
