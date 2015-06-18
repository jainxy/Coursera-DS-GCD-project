# Description

The requirements are:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
## How the script works
1. The script first loads the datasets of training, testing, activities and features.

2. Both the training and testing data frames are then combined into a single data frame. This completes the 1st requirement.

4. The required features for 2nd requirement are first extracted into the vector 'colnam' and their index in 'colidx'. Data is subsetted using these indices toget desired columns only.

5. The descriptive activity names as mentioned in 'activity_labels.txt' is mapped to numeric value in dataset and descriptive activity vector 'trsub' is generated . This completes 3rd requirement.

6. 'fintab' data frame is generated which is required data set with descriptive variable names.

7. A new tidy data is then created by grouping 'fintab' according to activity and subject and then calculating the mean. The result is then assigned to a new variable 'result' and the data contained is then written into a 'result.txt' file.

phew.
