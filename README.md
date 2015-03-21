# Description:
 Run_analysis is a function that can accept as input or use default files to get and clean Samsung wearable experimental data and output to a new tidied dataset. See the codebook for more information on the variables used and  transformation process.

# Usage:
 run_analysis(
	features = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", strip.white=TRUE),
	xTestData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", strip.white=TRUE),
     	subjectTestData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"),
	yTestData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"),
     	xTrainData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", strip.white=TRUE),
     	subjectTrainData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"),
     	yTrainData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"),
     	activities = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
 )

# Arguments:
     * features: a vector of the features of the data that is used to name variables 
     * xTestData: contains the results from the test subjects
     * yTestData: contains the labels from the test subjects
     * subjectTestData: identifies the subject that performed the test activities
     * xTrainData: contains the results from the training subjects
     * yTrainData: contains the labels from the training subjects
     * subjectTrainData: identifies the subject that performed the training activities
     * activities: identifies activities performed

# Returns:
     * tidyData: returns a cleaned up version of the data
	
# Examples:
* dataSet <- run_analysys()

 OR

* dataSet <- run_analysys(features, xTestData, subjectTestData, yTestData, xTrainData, subjectTrainData, yTrainData, activities)
	
* View(dataSet)

# Notes:
 The following script can be used in R to view tidied data.

 * library(dplyr)
  *address <- "https://s3.amazonaws.com/coursera-uploads/user-85c67ad8b034013c4a59a096/973499/asst-3/880d2200cefc11e481a89d40414a45bb.txt"
 * address <- sub("^https", "http", address)
 * data <- read.table(url(address), header = TRUE) 
 * View(data)
