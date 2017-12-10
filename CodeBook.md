
# Code Book for Project

## Analysis

The intent of this project is to make tidy data by gathering data from various files and structuring it appropriately
The data that were given to us was collected from wearable computer devices that tracked the movements of several people and recorded the data

There two were two sets of file

*   Train set
*   Test set


Within each set, the following files were found

* subject_x : A numeric number given to an individual for whom the data was collected
* y : Signifies the activities for an individual
* x : recorded measurements such  body linear accelration, angular velocity, etc

In addition there were the following

* features_text : meaningful column names for x
* activity_labels : meaningful column names for y  ( example, walking, laying, etc)


## Intent
To create a Tidy data by
1. Merging the data
2. Adding columns and cleaning column names
3. Extracting the columns we need
4. Aggregating the data



## Transformations
In the code run_analysis.R each of the transformation is handled by a function. The main method ```createTidyData```
1. ```loadAndMergeData``` 
   * Reads files from working directory and creates dataframe
   * Merges subject_x from train and test via ```rbind```
   * Merges y from train and test via ```rbind```
   * Merges x from train and test via ```rbind```
   * places the following in order subject_x , y, x via ```cbind```
   * Add column name "subject" for first column [subject_x]
   * Add column name "activty" for second column [y]
   * Add column names from feature_txt to rest of the columns [x]
   * returns the dataset
2. ```extractMeanAndStd```
   * extract columns that contain the word "mean", "Mean", "Std", "std"
3. ```addActivity```
   * Replace the numeric values in column "activity" with the mapping in activity_labels
4. ```cleanColumnNames```
   * Clean the column names to remove "_", "-" , "()" and replace it with "."
5. ```aggregateData```
    * Group the data by subject, then activity and summarize the rest of the measurements.
    * We will need mean as the summarize function.
    * This way, there will only be one row for a subject and activity combination

## Final List of Variables 
The final list of variables is as follows

* subject : This is the indvidual whose mesaurements are recorded
* activity : The activity when the measurements were recorded

The following are the average measurements per indiviudal, per activity
* tBodyAcc.mean.X
* tBodyAcc.mean.Y
* tBodyAcc.mean.Z
* tBodyAcc.std.X
* tBodyAcc.std.Y
* tBodyAcc.std.Z
* tGravityAcc.mean.X
* tGravityAcc.mean.Y
* tGravityAcc.mean.Z
* tGravityAcc.std.X
* tGravityAcc.std.Y
* tGravityAcc.std.Z
* tBodyAccJerk.mean.X
* tBodyAccJerk.mean.Y
* tBodyAccJerk.mean.Z
* tBodyAccJerk.std.X
* tBodyAccJerk.std.Y
* tBodyAccJerk.std.Z
* tBodyGyro.mean.X
* tBodyGyro.mean.Y
* tBodyGyro.mean.Z
* tBodyGyro.std.X
* tBodyGyro.std.Y
* tBodyGyro.std.Z
* tBodyGyroJerk.mean.X
* tBodyGyroJerk.mean.Y
* tBodyGyroJerk.mean.Z
* tBodyGyroJerk.std.X
* tBodyGyroJerk.std.Y
* tBodyGyroJerk.std.Z
* tBodyAccMag.mean
* tBodyAccMag.std
* tGravityAccMag.mean
* tGravityAccMag.std
* tBodyAccJerkMag.mean
* tBodyAccJerkMag.std
* tBodyGyroMag.mean
* tBodyGyroMag.std
* tBodyGyroJerkMag.mean
* tBodyGyroJerkMag.std
* fBodyAcc.mean.X
* fBodyAcc.mean.Y
* fBodyAcc.mean.Z
* fBodyAcc.std.X
* fBodyAcc.std.Y
* fBodyAcc.std.Z
* fBodyAcc.meanFreq.X
* fBodyAcc.meanFreq.Y
* fBodyAcc.meanFreq.Z
* fBodyAccJerk.mean.X
* fBodyAccJerk.mean.Y
* fBodyAccJerk.mean.Z
* fBodyAccJerk.std.X
* fBodyAccJerk.std.Y
* fBodyAccJerk.std.Z
* fBodyAccJerk.meanFreq.X
* fBodyAccJerk.meanFreq.Y
* fBodyAccJerk.meanFreq.Z
* fBodyGyro.mean.X
* fBodyGyro.mean.Y
* fBodyGyro.mean.Z
* fBodyGyro.std.X
* fBodyGyro.std.Y
* fBodyGyro.std.Z
* fBodyGyro.meanFreq.X
* fBodyGyro.meanFreq.Y
* fBodyGyro.meanFreq.Z
* fBodyAccMag.mean
* fBodyAccMag.std
* fBodyAccMag.meanFreq
* fBodyBodyAccJerkMag.mean
* fBodyBodyAccJerkMag.std
* fBodyBodyAccJerkMag.meanFreq
* fBodyBodyGyroMag.mean
* fBodyBodyGyroMag.std
* fBodyBodyGyroMag.meanFreq
* fBodyBodyGyroJerkMag.mean
* fBodyBodyGyroJerkMag.std
* fBodyBodyGyroJerkMag.meanFreq
* angletBodyAccMean.gravity
* angletBodyAccJerkMean.gravityMean
* angletBodyGyroMean.gravityMean
* angletBodyGyroJerkMean.gravityMean
* angleX.gravityMean
* angleY.gravityMean
* angleZ.gravityMean


