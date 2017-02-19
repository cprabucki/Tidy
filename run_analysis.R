#Loads dplyr
library(dplyr)

# Sets the working directory (only for my use)
#setwd("C:\\Users\\a212857\\Documents\\GitHub\\ProgrammingAssignment4.Cleaning\\wd")

## ******************************************************************
## 1.  Merges the training and the test sets to create one data set
## ******************************************************************

# Loads the test and train datasets (one after the other)

test   <-read.table("X_test.txt",   sep='')
train  <-read.table("X_train.txt",  sep='')

# Merges the 2 files of observations and free up train and test
total <- rbind(test, train)
ls(test, train)

## *******************************************************************************************
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## *******************************************************************************************

# Load the file into the DF
features <-read.table("features.txt", sep="")

# Identify wich features are linked to "mean" or "std" and keep both the index and the description
features <- features [grepl("(-mean|-std)", features[,2]), ]

# Extracts only the desired measurements
total <- select(total, features[,1])

## ***************************************************************************
## 3. Uses descriptive activity names to name the activities in the data set
## ***************************************************************************

#Retrieves the Activities from the 'y_test.txt' and 'y_train.txt' files and merges them in a single vector
ytest   <-read.table("y_test.txt",   sep='')
ytrain  <-read.table("y_train.txt",  sep='')
ytotal <- rbind(ytest, ytrain)
ls(ytest, ytrain)
names(ytotal) <- c("activity_index")

# Adds the column to the main dataset 'total' as lasts column 
total <-cbind(total, ytotal)

# For each activity index we find out the right activity label 
activ <- read.table("activity_labels.txt", sep="")
names(activ) <- c("activity_index", "activity")

# Before we merge the activity (loosing original order) we include the subject column for point 5)
stest   <-read.table("subject_test.txt",  sep='')
strain  <-read.table("subject_train.txt", sep='')
stotal <- rbind(stest, strain)
ls(stest, strain)
names(stotal) <- c("subject")
total <-cbind(total, stotal)


# Finally we merge the main dataset and the activities labels. Beware that from this point on the original order is lost
total <- merge(total, activ)

## ***************************************************************************
## 4. Appropriately labels the data set with descriptive variable names
## ***************************************************************************

# Assign the right measurement names taking them from the 'features' selection coming from point 2)
names(total) <- c("activity_index", as.character(features[,2]), "subject", "activity")


## ******************************************************************************************
## From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.
## ******************************************************************************************


# This function returns the summary of the mean of each variable for 1 activity
# Please note that index is the number code for each activity as described in the activity_labels.txt file
summ <- function(df, i){
        df <- filter(df, activity_index==i)
        df <- group_by(df, subject)
        return(summarise_each(df, funs(mean), -activity))
}

# Here we iterate on the activities through the index and append the resulting summaries into the new data frame
lrefin <- data.frame()
for (i in 1:6){
        lrefin <- rbind(lrefin, summ(total, i))
}

## ******************************************************************************************
## 6. Writes the final tidy data frame
## ******************************************************************************************


# Write the file as requested
write.table(lrefin, "Final_Tidy.txt", row.name=FALSE)

