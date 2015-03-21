run_analysis <- function(
    features = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", strip.white=TRUE),
    xTestData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", strip.white=TRUE),
    subjectTestData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"),
    yTestData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"),
    xTrainData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", strip.white=TRUE),
    subjectTrainData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"),
    yTrainData = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"),
    activities = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
    ){

    ## Function to take in messy data from Samsung wearable and return a cleaned up version as tidy data
    ##
    ## Arguments:
    ##   features: a vector of the features of the data that is used to name variables 
    ##   xTestData: contains the results from the test subjects
    ##   yTestData: contains the labels from the test subjects
    ##   subjectTestData: identifies the subject that performed the test activities
    ##   xTrainData: contains the results from the training subjects
    ##   yTrainData: contains the labels from the training subjects
    ##   subjectTrainData: identifies the subject that performed the training activities
    ##   activities: identifies activities performed
    ##
    ## Returns:
    ##   tidyData: returns a cleaned up version of the data
    
    features <- features[,-1] ## removes the numbered row names from the features dataset
    
    colnames(xTestData) <- as.factor(features) ## assigns the features list as the name of variables
    
    colnames(yTestData) <- c("Activity") ## assigns the appropriate variable name
    
    colnames(subjectTestData) <- c("Subject") ## assigns the appropriate variable name
    
    meanTestData <- xTestData[grepl(glob2rx("*mean()*"), names(xTestData))] 
    ##extracts the mean measurements from the test data
    
    stdTestData <- xTestData[grepl(glob2rx("*std()*"), names(xTestData))]
    ##extracts the standard deviation measurements from the test data
    
    mergedTestData <- cbind(subjectTestData, yTestData, meanTestData, stdTestData)
    ## merges the test data (mean and standard deviation) with the subjects and activities lists
    
    colnames(xTrainData) <- as.factor(features) ## assigns the features list as the name of variables
    
    colnames(yTrainData) <- c("Activity") ## assigns the appropriate variable name
    
    colnames(subjectTrainData) <- c("Subject") ## assigns the appropriate variable name
    
    meanTrainData <- xTrainData[grepl(glob2rx("*mean()*"), names(xTrainData))]
    ##extracts the standard deviation measurements from the training data
    
    stdTrainData <- xTrainData[grepl(glob2rx("*std()*"), names(xTrainData))]
    ##extracts the standard deviation measurements from the training data
    
    mergedTrainData <- cbind(subjectTrainData, yTrainData, meanTrainData,stdTrainData)
    ## merges the training data (mean and standard deviation) with the subjects and activities lists
    
    mergedData <- rbind(mergedTestData, mergedTrainData)
    ## merges test data results with the training data results
    
    if(class(mergedData$Activity) == "integer"){
        ## if statement that will check to see if Activity is its native integer format. If so, it will 
        ## replace the activity numbers with descriptive activity names according to activities list
        
        for(i in 1:nrow(activities)){           
            mergedData$Activity[mergedData$Activity == i] <- as.character(activities[i,2])
        }
    }
    
    tidyData <- group_by(mergedData, Subject, Activity) 
    ## groups combined data set by subject and activity
    
    tidyData <- summarise_each(tidyData, funs(mean))
    ## summarises data by their averages for each column by subject and activity
    
    return(tidyData) ## returns the now tidied data!
}
