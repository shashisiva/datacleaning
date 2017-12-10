# README for data cleaning project



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



## Code Transformations
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



## To Run this project
1. load script run_analysis.R
2. Replace the value in ```directory``` with the path you have where your files are extracted
3. Optionally if you want to name the output file you can replace the value in ```to_write```
4. Run the entire script
5. Go to the path specified in ```directory```
6. Check for file ```output.txt``` or the name you have overriden in step # 3
7. Open the file 
8. The content of the file should match the information in the CodeBook.md (Section : Final List of Variables)


