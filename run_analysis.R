## Run_analysis.R for peer review

## loading needed packages
library(plyr) 
library(reshape2)

## getting data
if(!file.exists("./week4data")) {dir.create("./week4data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./week4data/week4data.zip")
unzip("./week4data/week4data.zip", exdir = ".")

## Loading data
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Step 1: Merges the training and the test sets
    ## merging and naming X data
X_data<- rbind(X_train, X_test)
names(X_data)<-features [,2]

    ## merging and naming Y data
y_data<- rbind(y_train, y_test)
names(y_data)<-"Activity"

    ## merging and naming subject id
subject_id<-rbind(subject_train, subject_test)
names(subject_id)<-"subject_id"

data<-cbind(subject_id,y_data,X_data)

## Step 2: extracting mean and standard deviation data
meanstd<-grepl("mean|std", names(data))
meanstd_data<-data[,meanstd]

## Step 3: Using descriptive activity names for Y data
data$Activity<-factor(data$Activity,labels=activity_labels[,2])

## step 4: Appropriately label the data set with descriptive variable names
names(data) <- gsub("^t", "time_", names(data))
names(data) <- gsub("^f", "frequency_", names(data))


## step 5: tidy data
datamelt<-melt(data, id=c("subject_id","Activity"))
datatidy<-dcast(datamelt,subject_id + Activity ~ variable, mean)
write.csv(datatidy, "tidy.csv")
