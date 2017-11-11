# smartphones
Accelerometer smartphone assignment
This script will read, combine, and analyze specific data files from the working directory; these files must be unzipped before running the script. These files come from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The resulting data files are named smartpohone_data.txt and smartphone_tidy_subdata.txt

These files represent data collected from recording forces reported by a phone's accelerometer while subjects performed specific activities.  

smartphone_data.txt combines the test and training data sets from the original data set.  This file lists each activity, user_id, and the recorded mean and standard deviation variables for each type of measurement

smartphone_tidy_subdata.txt groups the data elements of smartphone_data.txt by activity and user and lists the mean of each of the remaining variables for each group.

See the codebook file (codebook.txt for a description of the variables in each file)
