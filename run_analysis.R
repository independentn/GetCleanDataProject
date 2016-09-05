
##
## run_analysis.R

#
#
# part 1
###################################################################################

# I ASSUME THAT YOU ARE IN THE WORKING DIRECTORY UCI HAR DATASET
# THEN IT WILL AUTOMATICALLY GO INTO TRAIN AND TEST FOLDERS TO READ DATA


# set working directory to train folder
#setwd("C:/Users/NMetaxas/Desktop/Coursera/3. Data/project/UCI HAR Dataset/train")
setwd("./train")
# read the x train, y train and subject data
train<- read.table("X_train.txt")
y_train <-read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

# check dimensions of each one
dim(train)
dim(y_train)
dim(subject_train)

# great! all have same number of rows hence combine using column bind ;cbind
train_dataset <- cbind(subject_train, y_train, train)

# check dimensions
dim(train_dataset)

#
#
# set working directory to test folder
setwd("..")
setwd("./test")
# read the x test, y test and subject data
test<- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

# check dimensions of each one
dim(test)
dim(y_test)
dim(subject_test)

# great! once again same number of rows hence combine using column bind ;cbind
test_dataset <- cbind(subject_test, y_test, test)

#
#
# now check both test and train datasets dimensions
dim(test_dataset)
dim(train_dataset)

# as expected have same number of columns; combine using row bind
# before do that we need to create an identifier to separate between
# test and train data

# call identifier id; test and train
test_dataset$id <- "test"
train_dataset$id <- "train"

# check dimensions again
dim(test_dataset)
dim(train_dataset)

# great, one more column is added to both; the id column
# now can combine using row bind

full_data <- rbind(train_dataset,test_dataset)

# get dimensions to double check!
dim(full_data)

# extra step that relates to Part 4
# give names to 1st and 2nd column as subject and activity respectively
names(full_data)[1] <- "subject_number"
names(full_data)[2] <- "activity_number"

#
#
# Part 2 #########################################3

# now we need to extract the mean and st dev from each of these variables
# I will use the 'features' file and apply the following logic
#    1. get key words 'mean' and 'std' from features file
#    2. get position of 'mean' and 'std' 
#    3. position in 2. translates to column position in full_data + 2
#          Note the PLUS 2, since we added subject and activity in first 2 columns
#    4. keep only mean and std position in full_data
# 

# let's read features

# set working directory where features file is
setwd("..")

# read features
features<-read.table("features.txt")

# see what is included
head(features,10)


# extra step: related to part 4
# let's first set all columns with features names
# col 1 and col2 already have names
# subtracting 1 because last column is id (test or train)
names(full_data)[3:(ncol(full_data)-1)] <- as.character(features[,2])


# let's keep rows that have mean or std in them as names
##########################################################################3
# HERE I ASSUME THAT mean AND std IS THE CORRECT NAMES
# TO FILTER. THERE ARE SOME COLUMNS WITH (,Mean) BUT IT DOESNT
# SEEM TO GIVE ACTUAL MEAN OR STANDARD DEVIATION
# HENCE FOR THE PURPOSES OF THIS H/W I WILL ONLY FILTER ON mean AND std
##########################################################################3
# names are in the second column of features hence the [,2]
means_i <- grep("mean", features[,2])
std_i   <- grep("std", features[,2])

# combine the means and std indexes
# and add the 2 to match the columns index in full_data
key_words_i <- c(means_i,std_i)+2


# since we don't want to lose the y_test and y_train i.e. activities
# and we don't want to lose the subject train and test
# must add the first two column index from full data as well and last one since id

key_words_i <- c(1,2,key_words_i,ncol(full_data))

# and sort them to be tidier!! :)
key_words_i <- sort(key_words_i)

# apply these indexes to the full data and get only columns
# from full data that correspond to only mean and standard dev

data_mean_std <- full_data[,key_words_i]


# check that column number matches key words i length
ncol(data_mean_std) == length(key_words_i)

#
#
# Part 3 ####################################################

# in this part we need to change numbers to activities
# the second to last column of our data correspond to activities
# Logic is as follows:
#  1. read in activities txt
#  2. find which numbers correspond to which activity
#  3. change the numbers in data_mean_std to activity description
#       the activity numbers are at the second to last column in data_mean_std

# set working directory to where activity txt file is
# ASSUME NO WD WILL CHANGE IN THE MEANTIME

# read activity
activity<-read.table("activity_labels.txt")

# see what is included
head(activity,10)
# perfect! labels are in the second column

# let's make all of them lowercase
activity[,2] <- tolower(activity[,2])

# now remove '_' underscore
activity[,2] <- sub("_","",activity[,2])

# let's check result
activity
# great as expected

# now let's replace the numbers in data_mean_std activity column with labels

# to verify that the activity labels are in the second column of our data
summary(data_mean_std[,2])
# this shows that numbers go from 1 to 6 as expected

# let's replace them with labels
mean_std <- merge( data_mean_std, activity , by.x= names(data_mean_std)[2],by.y= names(activity)[1])#

# note that merge function changes the order of:
#    1. the columns; having the key we joined first which is the activity
#    2. the rows order since it merges and sorts automatically

# to demonstrate the first change
names(mean_std)
names(data_mean_std)

# activity is now in the 1st column
# subject is in the second
# last column has activity labels

# to demonstrate the second change
plot(data_mean_std[,2])
# this shows that 1-6 were random

plot (mean_std[,1])
# this shows that now they are in order 1-6

# check that totals of each column are the same
sapply(data_mean_std[,1:81],sum)-sapply(mean_std[,1:81],sum)

# all columns are zero except first two that are reversed ;
# as expected; let's see it graphically too
plot(sapply(data_mean_std[,1:81],sum)-sapply(mean_std[,1:81],sum))
# correct!

# finally let's get rid of activity number and replace it with activity label
mean_std[,1] <- mean_std[,ncol(mean_std)]
# give it a proper name
names(mean_std)[1] <- "activity_description"
# get rid of last column since it is now reduntant
mean_std <- mean_std[,-ncol(mean_std)]

#
#
# Part 4
####################################################################
#

# This step is very subjective and has a lot of personal judgment
# In my opinion, the data labels under features are very well described
# the only thing I would change is the following
#       1. get rid of the two parenthesis '()'
#       2. make id to 'test_train'
# the rest pretty much make sense the way they are
# X, Y and Z are important to be there
# Std definitely stands out as 'standard dev'
# I don't see a reason to change Acc to acceleration since it will be too big
# neither Mag to magnitude etc.

# get rid of ()
# must add \\ for same reason as .
names(mean_std)<-gsub("\\()","",names(mean_std))

# replace id with test_train
names(mean_std)[ncol(mean_std)] <- "test_train"

# check
names(mean_std)


#
#
# Part 5
######################################################################


# I will use the aggregate function
# 1. first you put the combination levels which is subject number and activity
# 2. then you put the numbers you want to summarize these combinations which
#       is all the means and std
# 3. then you assign the function which is the mean i.e. average
# and ... magic!!

part5 <-aggregate(. ~ mean_std$subject_number+mean_std$activity_description,
                         data=mean_std[3:(ncol(mean_std)-1)], 
                         mean)

# rename columns 1 and 2
names(part5)[1] <- "subject_number"
names(part5)[2] <- "activity_description"
     
head(part5)

# round decimal places to 3 dec places
part5[,3:ncol(part5)] <- round(part5[,3:ncol(part5)],3)

# for me the way the data is makes sense
# each row represents a unique combination of subject number and activity
# and then displays the average of each mean and std dev for this combination
# sorted by activity description!!!


# let's write it 

# write csv without row names
write.table(part5,"tidy_data.txt",row.names=FALSE)

# check/ I commented it out but you can use it to double check
#tt<-read.table("tidy_data.txt",header=T)
#View(tt)







