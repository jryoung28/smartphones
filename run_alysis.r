library(dplyr)
# Get labels (rownames) and features (colnames) from main directory
labelraw <- read.table("activity_labels.txt")
labels <- as.factor(labelraw[,2]) 

featureraw <- read.table("features.txt")
features <- as.character(featureraw[,2])

#Get test data and list of subject id's from the 2 test files and the 2 train files
testx <- read.table("./test/X_test.txt") 
testy <- read.table("./test/y_test.txt")

trainx <- read.table("./train/X_train.txt") 
trainy <- read.table("./train/y_train.txt")

# assign the column names to the x files
colnames(trainx) <- features
colnames(testx) <- features

# name the y files only column header "activity"
colnames(trainy) <- c("activity")
colnames(testy)  <- c("activity")

#Make the entries in the y dataframes factors and assign an activity label as a level for each factor.
trainy$activity <- as.factor(trainy$activity)
testy$activity <- as.factor(testy$activity)

levels(trainy$activity) <- labels
levels(testy$activity) <- labels

# get the subject id's from the subject files
subtest <- read.table("./test/subject_test.txt")
subtrain <- read.table("./train/subject_train.txt")

colnames(subtest) <- c("subject")
colnames(subtrain) <- c("subject")

# create 2 dataframes for all of the test and train data - bind on columns
testDF <- cbind(testy, subtest, testx )
trainDF <- cbind(trainy, subtrain, trainx)

# change the subject column to a factor
testDF$subject <- as.factor(testDF$subject)
trainDF$subject <- as.factor(trainDF$subject)



# combine the data sets into a single data frame

smartphone <- rbind(testDF, trainDF)

# make the column headers more descriptive
colnames(smartphone) <- gsub("tBody", "TimeBody", colnames(smartphone))
colnames(smartphone) <- gsub("tGravity", "TimeGravity", colnames(smartphone))
colnames(smartphone) <- gsub("fBody", "FrequencyBody", colnames(smartphone))

# create vector for the column numbers that include the text mean or std

colvec1 <- grep("std", colnames(smartphone))
colvec2 <- grep("mean", colnames(smartphone))

smartphone2 <- smartphone[,c(1,2, colvec1, colvec2)]  #limit the columns by column, save in new object 
smartphone3 <- group_by(smartphone2, activity, subject)  #run group by function on activity and subject and save in new object
smartphone_final <- summarize_all(smartphone3, mean)  # run summarize_all function to save mean for each grouping - save in new object

# write the data frames to a file
write.table(smartphone2, "smartphone_data.txt")
write.table(smartphone_final, "smartphone_tidy_subdata")
