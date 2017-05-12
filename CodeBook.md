## Code book 
## Getting and Cleaning Data Week4 peer review

## Analysis process
he script downloads the data from the internet repository, unzip it and loads each file to its correspondant R variable. 
in Step 1, the script merges the data into one single data set.
in step 2, it extracts the measurement prensenting means or standrad deviation
in Step 3, it repalces the activity codes by their correspondant activity labels
in step 4, it labels appropriately the variables (especially for time and frequency variables)
in step 5, the script melts the data according to the subject id adn activity, then 
reshapes the table in order to have all the varibales in columns.

## Description of the DATA
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

## script code

### Load the required packages
'library(plyr) 
library(reshape2)'

### download and unzip data
'if(!file.exists("./week4data")) {dir.create("./week4data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./week4data/week4data.zip")
unzip("./week4data/week4data.zip", exdir = ".")'

### Load data into R
'features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")'

### Step 1 Merges the training and the test sets
merging and naming X data:
X_data<- rbind(X_train, X_test)
names(X_data)<-features [,2]

merging and naming Y data
y_data<- rbind(y_train, y_test)
names(y_data)<-"Activity"

merging and naming subject id
subject_id<-rbind(subject_train, subject_test)
names(subject_id)<-"subject_id"

formng the data set:
data<-cbind(subject_id,y_data,X_data)

### Step 2: extracting mean and standard deviation data
extracts the measurement prensenting means or standrad deviation:

meanstd<-grepl("mean|std", names(data))
meanstd_data<-data[,meanstd]

### Step 3: Using descriptive activity names for Y data
repalces the activity codes by their correspondant activity labels:

data$Activity<-factor(data$Activity,labels=activity_labels[,2])

### step 4: Appropriately label the data set with descriptive variable names
labels appropriately the variables (especially for time and frequency variables)

names(data) <- gsub("^t", "time_", names(data))
names(data) <- gsub("^f", "frequency_", names(data))


### step 5: tidy data
firest melt the data according to the subject id adn activity, then 
reshapes the table in order to have all the varibales in columns

datamelt<-melt(data, id=c("subject_id","Activity"))
datatidy<-dcast(datamelt,subject_id + Activity ~ variable, mean)
write.csv(datatidy, "tidy.csv")
