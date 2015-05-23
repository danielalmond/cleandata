library(plyr)
library(dplyr)

#read in this shitty test data
x_test = read.table("X_test.txt",sep="", header=FALSE)
y_test = read.table("y_test.txt",sep="", header=FALSE)
subject_test = read.table("subject_test.txt",sep="", header=FALSE)

#read in the column lables(measurement descriptions)
features = read.table("features.txt",sep="", header=FALSE)
feature_label_vec = as.character(features$V2)

# set data frame test measurements
test_df = x_test
#DO STEP 4:set column names to measurement descriptions
colnames(test_df) = feature_label_vec

#DO STEP 2: filter away unwanted measurements
expression = "mean\\(\\)|std\\(\\)"
test_df = test_df[,grep(expression,colnames(test_df), perl=TRUE)]

# add in subject id and activity id data on the end of the frame
subject_test = rename(subject_test, subject_id=V1)
test_df = mutate(test_df, subject_id=subject_test$subject_id)
y_test = rename(y_test, activity=V1)
test_df = mutate(test_df, activity=y_test$activity)

#read in the shitty training data
x_train = read.table("X_train.txt",sep="", header=FALSE)
y_train = read.table("y_train.txt",sep="", header=FALSE)
subject_train = read.table("subject_train.txt",sep="", header=FALSE)

#########################
#####################
##############

# set data frame test measurements
training_df = x_train
#DO STEP 4:set column names to measurement descriptions
colnames(training_df) = feature_label_vec

#DO STEP 2: filter away unwanted measurements
training_df = training_df[,grep(expression,colnames(training_df), perl=TRUE)]

# add in subject id and activity id data on the end of the frame
subject_train = rename(subject_train, subject_id=V1)
training_df = mutate(training_df, subject_id=subject_train$subject_id)
y_train = rename(y_train, activity=V1)
training_df = mutate(training_df, activity=y_train$activity)

#DO STEP #1 : merge datasets
joint_df = merge(training_df,test_df,all=TRUE)

# DO STEP #4 : Label activities using factorization
joint_df$activity = factor(joint_df$activity, levels= c(1,2,3,4,5,6), labels = c("WALKING","WALKING UPSTAIRS","WALKING DOWNSTAIRS","SITTING","STANDING","LAYING"))

# DO STEP #5 : Create a new tidy data set with the avgs of each measurement broken down by subject and activity
avgs_df = sapply(select(joint_df, -(activity:subject_id)), function (x) sapply(split(x, list(joint_df$subject_id, joint_df$activity)), mean))

write.table(avgs_df, "avgs_df.txt", row.names=FALSE)