#loading plyr and dplyr package
library(plyr)
library(dplyr)
dir<-getwd()

#Loadind txt files
file<-paste(dir,"UCI HAR Dataset/features.txt", sep="/")
features<-read.table(file)
activityLabels<-read.table(paste(dir,"UCI HAR Dataset/activity_labels.txt", sep="/"))
testData<-read.table(paste(dir,"UCI HAR Dataset/test/X_test.txt", sep="/"))
testActivities<-read.table(paste(dir,"UCI HAR Dataset/test/y_test.txt", sep="/"))
testSubject<-read.table(paste(dir,"UCI HAR Dataset/test/subject_test.txt", sep="/"))
trainData<-read.table(paste(dir,"UCI HAR Dataset/train/X_train.txt", sep="/"))
trainActivities<-read.table(paste(dir,"UCI HAR Dataset/train/y_train.txt", sep="/"))
trainSubject<-read.table(paste(dir,"UCI HAR Dataset/train/subject_train.txt", sep="/"))
#adding columns names to data from features txt
colnames(testData)<-make.names(features[,2],unique=TRUE)
colnames(trainData)<-make.names(features[,2],unique=TRUE)
#adding columns names
colnames(testActivities)<-"idActivity"
colnames(trainActivities)<-"idActivity"
colnames(testSubject)<-"Subject"
colnames(trainSubject)<-"Subject"
colnames(activityLabels)<-c("idActivity","Activity")
#adding activities column to data
testData<-cbind(testData,testActivities,testSubject)
trainData<-cbind(trainData,trainActivities,trainSubject)
#adding trainData to testData
data<-rbind(testData,trainData)
#Extracting only the measurements on the mean and standard deviation for each measurement.
meanStdData<-cbind(select(data,contains("mean")), select(data,contains("std")))
#grouping by Activity and Subject
byActSubj<-data %>% group_by(Activity,Subject)
#Creating new tidy data frame
newTidyData<-byActSubj %>% summarise_each(funs(mean))
#writing the new Tidy Data
write.table(newTidyData, "UCI HAR Dataset/newTidyData.txt", row.name=FALSE)

