# Load the datasets of training, testing, activities and features.

testdata<-read.table("./UCI HAR Dataset/test/X_test.txt")
testsub<-read.table("./UCI HAR Dataset/test/subject_test.txt")
testlab<-read.table("./UCI HAR Dataset/test/y_test.txt")

traindata<-read.table("./UCI HAR Dataset/train/X_train.txt")
trainsub<-read.table("./UCI HAR Dataset/train/subject_train.txt")
trainlab<-read.table("./UCI HAR Dataset/train/y_train.txt")

colname<- read.table("./UCI HAR Dataset/features.txt")
actname<- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merge the testing and training datasets.
tdata<-rbind(traindata,testdata)
tsub<-rbind(trainsub,testsub)
tlab<-rbind(trainlab,testlab)

# Extract the coulmns containing mean or standard deviation measurements
colidx = grep("std|mean",colname$V2)
colnam = grep("std|mean",colname$V2,value = T)
trdata<-tdata[,colidx]

# Uses descriptive activity names to name the activities in the data set.
l = nrow(tlab)
trlab = rep(0,l)
for (i in actname$V1) {
        id1 = which(actname$V1==i)
        id = which(tlab$V1==i)
        trlab[id] = as.character(actname$V2[id1])
}
trsub = tsub$V1

# A 'fintab' data frame with the required columns is created 
# for different subjects and their respective activities.
fintab = cbind(subject = trsub, activity = trlab, trdata)

# The 'fintab' is divided into groups according to different 
# subjects and activities
lv1 = as.factor(fintab$subject)
lv2 = as.factor(fintab$activity)
s = split(fintab,list(lv1,lv2))

# Calculate Column mean for each subject and activity.
L = length(names(fintab))
t1 = sapply(s,function(x)colMeans(x[,3:L]))
rnm = colnames(t1)
t1 = data.frame(t(t1))
rownames(t1) = NULL
colnames(t1) = paste("Mean of",colnam)
subcol = rep(1:30,6)
actcol = gl(6,30,labels = 
                    c("LAYING","SITTING","STANDING",
                      "WALKING","WALKING_DOWNSTAIRS",
                      "WALKING_UPSTAIRS"))

# Generate tidy data set 'result' with proper variable names
result <- cbind(Subject = subcol, Activity = actcol, 
                t1[,2:length(names(t1))])

# Write the tidy dataset into text file and turn off the pc for food and water.
write.table(result, file = "./result.txt", row.names = F)
