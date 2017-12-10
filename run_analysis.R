library(dplyr)

# Current file folder - Please replace
directory = "C:\\Users\\ssvp\\Documents\\Personal\\DataScience\\Courses\\Data Cleaning\\Project\\"


# Initialize global variables
fileSub_Train <<- ""
fileSub_Test <<- ""
fileX_Train <<- ""
fileX_Test <<- ""
fileY_Train <<- ""
fileY_Test <<- ""
file_features <<- ""
to_write <<- ""

#*******************************************************
#Function : init variables
#This function initializes global variables 
#*******************************************************
initVariables <- function(wkdirectory)
{
    directory_train <- paste(wkdirectory, "train\\", sep = "")
    directory_test <- paste(wkdirectory, "test\\", sep = "")
    
    # Create file variable names
    fileSub_Train <<- paste(directory_train, "subject_train.txt", sep = "")
    fileSub_Test  <<- paste(directory_test, "subject_test.txt", sep = "")
    fileX_Train <<- paste(directory_train, "X_train.txt", sep = "")
    fileX_Test  <<- paste(directory_test, "X_test.txt", sep = "")
    fileY_Train <<- paste(directory_train, "y_train.txt", sep = "")
    fileY_Test  <<- paste(directory_test, "y_test.txt", sep = "")
    file_features <<- paste(directory, "features.txt", sep = "")
    to_write <<- paste(wkdirectory, "output.txt", sep = "")
    
    
}    

#******************************************************************************
#Function : loadAndMergeData
#Reads data from csv files and loads into data frame
#After the load is completed, the dataframes are merged appropriately to create
# one data frame
#*******************************************************************************
loadAndMergeData <- function(fileSub_Train, fileSub_Test, fileX_Train, fileX_Test , fileY_Train,fileY_Test, file_features)
{
    
    subject_train <- read.table(fileSub_Train, sep="")
    subject_test <- read.table(fileSub_Test, sep="")
    
    X_train <- read.table(fileX_Train, sep="")
    X_test <- read.table(fileX_Test, sep="")
    
    Y_train <- read.table(fileY_Train, sep="")
    Y_test <- read.table(fileY_Test, sep="")
    
    features <- read.table(file_features, sep="")
    
    # Merging like data
    subjectData <- rbind(subject_test,subject_train)
    XData <- rbind(X_test,X_train)
    YData <- rbind(Y_test,Y_train)
    
    # Setting column names
    colnames(XData) <- features$V2
    colnames(subjectData) <- c("subject")
    colnames(YData) <- c("activity")
    
    # Final Merge
    mergedData <- cbind(subjectData, YData,XData)
    return(mergedData)
    
}
#******************************************************************************
#Function : extractMeanAndStd
#Reads in a dataframe and extracts columns that have the word Mean,mean,Std or std
#Returns a dataframe with the extracted columns
#*******************************************************************************
extractMeanAndStd <- function(mergedData)
{
    # Extract mean and std column names
    
    meanStdCol <- grep("*Mean*|*mean*|*Std*|*std*", names(mergedData))
    
    meanStdCol <- union(2,meanStdCol)
    meanStdCol <- union(1,meanStdCol)
    
    subsetData <- mergedData[,meanStdCol]
    
    return(subsetData)    
}


#******************************************************************************
#Function : addActivity
#Reads in a dataframe and replaces the activity numbers with activity labels
#Returns the new dataframe
#*******************************************************************************
addActivity <- function(subsetData)
{    
    subsetData$activity[subsetData$activity == "1"] <- "LAYING"
    subsetData$activity[subsetData$activity == "2"] <- "WALKING"
    subsetData$activity[subsetData$activity == "3"] <- "WALKING_UPSTAIRS"
    subsetData$activity[subsetData$activity == "4"] <- "WALKING_DOWNSTAIRS"
    subsetData$activity[subsetData$activity == "5"] <- "SITTING"
    subsetData$activity[subsetData$activity == "6"] <- "STANDING"
    
    return(subsetData)    
}    

#******************************************************************************
#Function : cleanColumnNames
#Reads in a dataframe and replaces column names with special characters with . or space
#Returns the new dataframe
#*******************************************************************************
cleanColumnNames <- function(subsetData)
{
    # Cleaning up columnNames, removing (), "",
    colnames(subsetData) <- gsub("-", ".", colnames(subsetData))
    colnames(subsetData) <- gsub("\\(", "", colnames(subsetData))
    colnames(subsetData) <- gsub("\\)", "", colnames(subsetData))
    colnames(subsetData) <- gsub(",", ".", colnames(subsetData))
    colnames(subsetData)
    
    return(subsetData)
}

#******************************************************************************
#Function : aggregateData
#Reads in a dataframe and aggregates the data by subject and activity. The aggregate
# function is mean
#*******************************************************************************

aggregateData <- function(subsetData)
{
    # average data
    
    aggData <- subsetData %>% group_by(subject,activity) %>% summarise_all(funs(mean))
    
    return(aggData)
}



#******************************************************************************
#Function : createTidyData
# This is a main function who takes in a working directory, reads the raw data
# and creates a tidy data set.
# After creation, the dataframe is written to an output file in the working director
#*******************************************************************************
createTidyData <- function(workingDir)
{    
    print("Processing Raw Data")
    
    initVariables(workingDir)
    
    mergedData <- loadAndMergeData(fileSub_Train, fileSub_Test, fileX_Train, fileX_Test , fileY_Train,fileY_Test, file_features)
    extractMeanAndStd  <- extractMeanAndStd(mergedData)
    subsetData  <- addActivity(extractMeanAndStd)
    subsetData  <- cleanColumnNames(subsetData)
    aggData <- aggregateData(subsetData)
    
    # write data to file
    write.table(aggData, file = to_write, sep = " ", col.names = TRUE, row.names = FALSE)
    print("Tidy Data Created")
    
}



createTidyData(directory)

