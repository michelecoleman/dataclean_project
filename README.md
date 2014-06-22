## Analysis of Human Activity Monitoring Data

### Overview
The script run_analysis.R generates a tidy data set of average sensor readings of accelerometer data for 30 different test subjects while performing any one of 6 different activities.

The resulting file, averages_by_subject.txt, can be read into R using the read.table or read.csv file. The file is ascii text delimited by commas with a header row giving column names. See the accompanying file CODEBOOK.md for details of what the columns represent.

The data comes from a study of activity monitoring using smart phones, conducted at UniversitÃ  degli Studi di Genova in Genova, Italy.

### Requirements to run the script
This script requires the R package reshape2.

It also requires the source data (see below) to be unzipped in the current working directory. Specifically it requires the following files (including some in 2 sub-directories, test/ and train/):

* features.txt
* activity_labels.txt
* test/X_test.txt
* test/y_test.txt
* test/subject_test.txt
* train/X_train.txt
* train/y_train.txt
* train/subject_train.txt

### Source data
[Download the source data here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) Unzip it to create directory "UCI HAR Dataset". Set that as your working directory when you run the script run_analysis.R .

The unzipped archive contains files README.txt and features_info.txt with detailed information about how the measurements were generated.  

[Further background information about the project.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### About the analysis
The original data set contains 17 basic measurements types derived from raw accelerometer and gyroscopic data. 8 of these measurement were made on 3 axes (X, Y, and Z), and thus have 3 values each. All in all there are a total of 33 basic measurements. Multiple such measurements were sampled throughout a given activity session with a particular subject. The original researchers calculated the mean and standard deviation of the samples for all 33 measurements during one activity session, resulting in 66 values per each activity session per each subject. They normalized the resulting values to fall in the range [-1, +1], which is desirable for machine learning algorithms.

These 66 normalized values per subject per activity session are taken as inputs to this current analysis. The current analysis calculates the average of each of these 66 values across all sessions for a given activity, for a given subject, and generates a resulting tidy data set. More details about the specific column variables are in the CODEBOOK.md file in this repository.

### A note about tidy data
Whether it is more desirable for a given tidy data set to be "narrow" or "wide" depends on how it will be subsequently used. It would also have been plausible to create separate columns for each different activity (so for example, to have one column for tBodyAcc.mean.X_LAYING and a different column for tBodyAcc.mean.X_SITTING, etc.). Having a narrower data set makes is easier to compare values for different activity types, whether by directly comparing values "by eye" or by generating visualizations such as scatter plots. For this reason I chose to go with a narrower result set, with two dimensions (subject and activity) per each row.

Hadley Wickham's [paper on tidy data](http://vita.had.co.nz/papers/tidy-data.pdf) includes a discussion of how the same data could be presented both in narrow and wide forms, with both options being considered equally tidy. See also [this discussion in the Coursera class forum](https://class.coursera.org/getdata-004/forum/thread?thread_id=262) (Coursera login required).




