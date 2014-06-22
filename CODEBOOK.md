## CODEBOOK for averages_by_subject.txt

### Overview
The script run_analysis.R generates a tidy data set of average values derived from accelerometer and gyroscope data for 30 different test subjects performing any one of 6 different activities.

The resulting file, averages_by_subject.txt, is ascii text delimited by commas with a header row giving column names. See below for details of what the columns represent.

The data comes from [a study of activity monitoring using smart phones,](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) conducted at UniversitÃ  degli Studi di Genova in Genova, Italy.


### Source data
For the purposes of this current analysis, the raw data taken as input is the [UCI_HAR_Dataset archive.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Unzip it to create directory "UCI HAR Dataset". Set that as your working directory when you run the script run_analysis.R .

The unzipped archive contains files README.txt and features_info.txt with detailed information about how the measurements were generated. Those files are incorporated by reference into this codebook, since they detail how the original raw accelerometer and gyroscope data was filtered and transformed to generate the values that are the input to the current analysis.


### About the analysis
The original data set contains 17 basic measurements types derived from raw accelerometer and gyroscopic data. 8 of these measurement were made on 3 axes (X, Y, and Z), and thus have 3 values each. All in all there are a total of 33 basic measurements. Multiple such measurements were sampled throughout a given activity session with a particular subject. The original researchers calculated the mean and standard deviation of the samples for all 33 measurements during one activity session, resulting in 66 values per each activity session per each subject. They normalized the resulting values to fall in the range [-1, +1], which is desirable for machine learning algorithms.

These 66 normalized values per subject per activity session are taken as inputs to this current analysis. The current analysis calculates the average of each of these 66 values across all sessions for a given activity, for a given subject, and generates a resulting tidy data set. More details about the specific column variables are in the CODEBOOK.md file in this repository.

### Data transformation and processing steps
Here are the additional data transformation and processing steps done to the UCI_HAR_Dataset input in order to generate the averages_by_subject.txt output.

1. Three files containing training data (train/X_train.txt, train/y_train.txt, and train/subject_train.txt) were combined to create a single training set. File X_train.txt contains the values for 561 variables described in the UCI_HAR_Dataset's file features_info.txt, for all activity sessions for a subset of subjects. File y_train.txt identifies the activity for each session, using encoding given in UCI_HAR_Dataset's file activity_labels.txt. File subject_train.txt identifies the subject who performed each activity session given in files X_train and y_train.

2. Similarly, three files containing test data (test/X_test.txt, test/y_test.txt, and test/subject_test.txt) were combined to create a single testing set. These three files are structured the same way as the training data discussed in step 1. They correspond to activity sessions from a different subset of subjects.

3. The testing and training data sets were combined to form a single data set. This combined set contains the data from all activity sessions from all 30 study participants. At this stage the 561 variables from the source data are all present and are all unlabeled, since the source data files X_train.txt and X_test.txt did not have headers.

4. Label the 561 measurement variables using the contents of file features.txt in the UCI_HAR_Dataset. That file has one string per row, with each row corresponding to a column in the original X_train.txt and X_test.txt. Those strings include characters that are no suitable for value names in R. Before applying the labels I did some string processing to remove the undesirable characters.

5. Pare down the original 561 measurement variables to only the 66 of interest. The measurements kept are those whose names included "mean()" and "std()" in the original features.txt file in the UCI_HAR_Dataset. (Some of the variables had names that included "meanFreq" and "gravityMean". These __were not kept__. ) The 66 variables kept are listed below in section "Data columns".

6. Change the activity labels column from a numeric encoding to human-readable labels such as "WALKING", and "SITTING", using the schema given in the original dataset's file activity_labels.txt .

7. Finally, for each of the 66 measurements of interest for each subject, calculate average values for each activity type. This is the average across multiple activity sessions for the same given activity. The resulting values is what is written out to file averages_by_subject.txt

### Data columns
As mentioned in section "About the analysis" above, this analysis is concerned with a subset of the 571 values included in the source data. The original data had 11 basic value types derived from the raw accelerometer and gyroscope data, each measured on the X, Y, and Z axes, for a total of 33 basic measurements. These measurements were sampled repeatedly throughout a single activity session at a frequency of 50 Hz. The mean and standard deviation of these 33 values were calculated across a single session, yielding a total of 66 values per activity session per subject. 

In this analysis the 66 separate values were averaged across all activity sessions of a given type for a given subject. They are grouped by 11 value types.

The following shows the columns in the dataset averages_by_subject.txt. For the 66 measurement values the corresponding column number and name (as given in features.txt) from the original UCI_HAR_Dataset is also shown:

**subject** Subject participant number, from 1 to 30

**activity** Activity performed, one of: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, or LAYING(sic). ("LAYING" is how it was labelled in the original UCI_HAR_Dataset. Presumably they meant "lying down" rather than, say, "laying tile".)

**tBodyAcc.mean.X** 1           tBodyAcc-mean()-X

**tBodyAcc.mean.Y**     2           tBodyAcc-mean()-Y

**tBodyAcc.mean.Z**     3           tBodyAcc-mean()-Z

**tBodyAcc.std.X**     4           tBodyAcc-std()-X

**tBodyAcc.std.Y**     5           tBodyAcc-std()-Y

**tBodyAcc.std.Z**     6           tBodyAcc-std()-Z


**tGravityAcc.mean.X**     41     tGravityAcc-mean()-X

**tGravityAcc.mean.Y**     42     tGravityAcc-mean()-Y

**tGravityAcc.mean.Z**     43     tGravityAcc-mean()-Z

**tGravityAcc.std.X**     44     tGravityAcc-std()-X

**tGravityAcc.std.Y**     45     tGravityAcc-std()-Y

**tGravityAcc.std.Z**     46     tGravityAcc-std()-Z


**tBodyAccJerk.mean.X**     81     tBodyAccJerk-mean()-X

**tBodyAccJerk.mean.Y**     82     tBodyAccJerk-mean()-Y

**tBodyAccJerk.mean.Z**     83     tBodyAccJerk-mean()-Z

**tBodyAccJerk.std.X**     84     tBodyAccJerk-std()-X

**tBodyAccJerk.std.Y**     85     tBodyAccJerk-std()-Y

**tBodyAccJerk.std.Z**     86     tBodyAccJerk-std()-Z


**tBodyGyro.mean.X**     121     tBodyGyro-mean()-X

**tBodyGyro.mean.Y**     122     tBodyGyro-mean()-Y

**tBodyGyro.mean.Z**     123     tBodyGyro-mean()-Z

**tBodyGyro.std.X**     124     tBodyGyro-std()-X

**tBodyGyro.std.Y**     125     tBodyGyro-std()-Y

**tBodyGyro.std.Z**     126     tBodyGyro-std()-Z


**tBodyGyroJerk.mean.X**     161     tBodyGyroJerk-mean()-X

**tBodyGyroJerk.mean.Y**     162     tBodyGyroJerk-mean()-Y

**tBodyGyroJerk.mean.Z**     163     tBodyGyroJerk-mean()-Z

**tBodyGyroJerk.std.X**     164     tBodyGyroJerk-std()-X

**tBodyGyroJerk.std.Y**     165     tBodyGyroJerk-std()-Y

**tBodyGyroJerk.std.Z**     166     tBodyGyroJerk-std()-Z


**tBodyAccMag.mean**     201     tBodyAccMag-mean()

**tBodyAccMag.std**     202     tBodyAccMag-std()

**tGravityAccMag.mean**     214     tGravityAccMag-mean()

**tGravityAccMag.std**     215     tGravityAccMag-std()

**tBodyAccJerkMag.mean**     227     tBodyAccJerkMag-mean()

**tBodyAccJerkMag.std**     228     tBodyAccJerkMag-std()

**tBodyGyroMag.mean**     240     tBodyGyroMag-mean()

**tBodyGyroMag.std**     241     tBodyGyroMag-std()

**tBodyGyroJerkMag.mean**     253     tBodyGyroJerkMag-mean()

**tBodyGyroJerkMag.std**     254     tBodyGyroJerkMag-std()


**fBodyAcc.mean.X**     266     fBodyAcc-mean()-X

**fBodyAcc.mean.Y**     267     fBodyAcc-mean()-Y

**fBodyAcc.mean.Z**     268     fBodyAcc-mean()-Z

**fBodyAcc.std.X**     269     fBodyAcc-std()-X

**fBodyAcc.std.Y**     270     fBodyAcc-std()-Y

**fBodyAcc.std.Z**     271     fBodyAcc-std()-Z


**fBodyAccJerk.mean.X**     345     fBodyAccJerk-mean()-X

**fBodyAccJerk.mean.Y**     346     fBodyAccJerk-mean()-Y

**fBodyAccJerk.mean.Z**     347     fBodyAccJerk-mean()-Z

**fBodyAccJerk.std.X**     348     fBodyAccJerk-std()-X

**fBodyAccJerk.std.Y**     349     fBodyAccJerk-std()-Y

**fBodyAccJerk.std.Z**     350     fBodyAccJerk-std()-Z


**fBodyGyro.mean.X**     424     fBodyGyro-mean()-X

**fBodyGyro.mean.Y**     425     fBodyGyro-mean()-Y

**fBodyGyro.mean.Z**     426     fBodyGyro-mean()-Z

**fBodyGyro.std.X**     427     fBodyGyro-std()-X

**fBodyGyro.std.Y**     428     fBodyGyro-std()-Y

**fBodyGyro.std.Z**     429     fBodyGyro-std()-Z



**fBodyAccMag.mean**     503     fBodyAccMag-mean()

**fBodyAccMag.std**     504     fBodyAccMag-std()

**fBodyBodyAccJerkMag.mean**     516     fBodyBodyAccJerkMag-mean()

**fBodyBodyAccJerkMag.std**     517     fBodyBodyAccJerkMag-std()

**fBodyBodyGyroMag.mean**     529     fBodyBodyGyroMag-mean()

**fBodyBodyGyroMag.std**     530     fBodyBodyGyroMag-std()

**fBodyBodyGyroJerkMag.mean**     542     fBodyBodyGyroJerkMag-mean()

**fBodyBodyGyroJerkMag.std**     543     fBodyBodyGyroJerkMag-std()