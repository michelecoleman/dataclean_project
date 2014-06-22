## run_analysis.R
## Groom and summarize data from "UCI HAR Dataset"

require(reshape2)

# First load in the list of variables in the original data set
# and convert to valid R column names

col_labels = read.table("features.txt")

# Obfuscate variable names that have (M|m)ean but aren't
# ones we want to keep, for ease of later filering
col_labels$V2 <- gsub('Mean', 'Mn', col_labels$V2)  # upper-case M don't want to keep
col_labels$V2 <- gsub('meanFreq', 'mnFreq', col_labels$V2)  # don't want to keep these means either

# Get rid of troublesome characters that won't work well in column names
col_labels$V2 <- gsub('-', '.', col_labels$V2)  # convert hyphens to dots
col_labels$V2 <- gsub('\\(|\\)|,', '', col_labels$V2) # delete commas and parentheses


# Read in the test data set, which is spread across 3 files
x <- read.table("test/X_test.txt", header = FALSE, col.names = col_labels$V2)
activity <- read.table("test/y_test.txt", header = FALSE, col.names = c('act_code'))
subject <- read.table("test/subject_test.txt", header = FALSE, col.names = c('subject'))
test <- cbind(subject, activity, x)

# Read in the training data set, which is spread across 3 files
x <- read.table("train/X_train.txt", header = FALSE, col.names = col_labels$V2)
activity <- read.table("train/y_train.txt", header = FALSE, col.names = c('act_code'))
subject <- read.table("train/subject_train.txt", header = FALSE, col.names = c('subject'))
train <- cbind(subject, activity, x)

# Now combine the testing and training data into a single dataframe
combined <- rbind(test, train)

# Select out just the columns with "mean" or "std" in the name, plus the 2 dimension columns
keep <- grep("subject|act_code|mean|std",names(combined))
data <- subset(combined,select = keep)

# Add a plain-text label of the activity to each row, then delete original number coding column
activities <- read.table("activity_labels.txt", header = FALSE, col.names = c('act_code','activity'))
with_labels <- merge(activities, data)
with_labels <- with_labels[,!(names(with_labels) %in% c("act_code"))]

# Use reshape2's melt/dcast functions to create final tidy dataset
melted <- melt(with_labels, id.vars = c("subject","activity"))
#final <- dcast(melted, subject ~ variable + activity, fun.aggregate = mean)
final <- dcast(melted, subject + activity ~ variable, fun.aggregate = mean)

# Finally, write out the resulting tidy data set to a file
write.csv(final,"averages_by_subject.txt", quote = FALSE, row.names = FALSE)