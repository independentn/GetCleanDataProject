# Codebook

* Background
* Process to get raw data
* Process to clean data
* What each variable represent in the raw data
* What each variable represent in tidy data
* What tidy_data represents

## 1.Background

This is a coursera homework submitted by Nicholas Metaxas
The information below serve as background info for this dataset

Human Activity Recognition Using Smartphones Dataset
###Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
###www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

###For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


## 2.Process to get raw data

Data were given from the coursera website through a link


## 3.Process to clean data

There are 5 steps to clean the data

### Part 1: First the test and train data were combined
  Assumed that the working direcotyr UCI HAR DATASET is already defined. script then automatically
  goes into test and train folders and grabs data to combine.

### Part 2: Extracts the mean and st dev from each of these variables
 HERE I ASSUME THAT mean AND std IS THE CORRECT NAMES
 TO FILTER. THERE ARE SOME COLUMNS WITH (,Mean) BUT IT DOESNT
 SEEM TO GIVE ACTUAL MEAN OR STANDARD DEVIATION.
 HENCE FOR THE PURPOSES OF THIS H/W I WILL ONLY FILTER ON mean AND std.
 	Features file is used and following logic applied:
    * get key words 'mean' and 'std' from features file
    * get position of 'mean' and 'std' 
    * position in 2. translates to column position in full_data + 2
          Note the PLUS 2, since we added subject and activity in first 2 columns
    * keep only mean and std position in full_data

### Part 3: the activity numbers were changed to labels using activity file 
        Logic is as follows:
    * 1. read in activities txt
    * 2. find which numbers correspond to which activity
    * 3. change the numbers in data_mean_std to activity description
       the activity numbers are at the second to last column in data_mean_std

### Part 4: The column names are added using the features file and their description was changed to be more user friendly
This step is very subjective and has a lot of personal judgment.
 In my opinion, the data labels under features are very well described.
 	The only thing changed is the following:
     * get rid of the two parenthesis '()'
     * make id to 'test_train'

### Part 5: Finally for each combination of activity and subjet the average of each mean and standard deviation is computed
 	 The aggregate function was used:
    * first you put the combination levels which is subject number and activity
    * then you put the numbers you want to summarize these combinations which
      is all the means and std
    * then you assign the function which is the mean i.e. average

Final file is saved as tidy_data


## 4.What each variable represents in the raw data

###Feature Selection 
=================

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

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

###Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

###For more information about this dataset contact: activityrecognition@smartlab.ws


## 5.What each variable represents in the tidy data

* subject_number:				the subject unique id from 1-30/ no units
* activity_description:			description of what activity the subject was doing/ no units

All the variables below represent the AVERAGE for each combination of subject and activity
The variables are all mean and standard deviation from the variables description in the raw data

Units: All variables below are unitless since they were normalized/averaged to go from [-1,1]

* tBodyAcc-mean-X
* tBodyAcc-mean-Y
* tBodyAcc-mean-Z
* tBodyAcc-std-X
* tBodyAcc-std-Y
* tBodyAcc-std-Z
* tGravityAcc-mean-X
* tGravityAcc-mean-Y
* tGravityAcc-mean-Z
* tGravityAcc-std-X
* tGravityAcc-std-Y
* tGravityAcc-std-Z
* tBodyAccJerk-mean-X
* tBodyAccJerk-mean-Y
* tBodyAccJerk-mean-Z
* tBodyAccJerk-std-X
* tBodyAccJerk-std-Y
* tBodyAccJerk-std-Z
* tBodyGyro-mean-X
* tBodyGyro-mean-Y
* tBodyGyro-mean-Z
* tBodyGyro-std-X
* tBodyGyro-std-Y
* tBodyGyro-std-Z
* tBodyGyroJerk-mean-X
* tBodyGyroJerk-mean-Y
* tBodyGyroJerk-mean-Z
* tBodyGyroJerk-std-X
* tBodyGyroJerk-std-Y
* tBodyGyroJerk-std-Z
* tBodyAccMag-mean
* tBodyAccMag-std
* tGravityAccMag-mean
* tGravityAccMag-std
* tBodyAccJerkMag-mean
* tBodyAccJerkMag-std
* tBodyGyroMag-mean
* tBodyGyroMag-std
* tBodyGyroJerkMag-mean
* tBodyGyroJerkMag-std
* fBodyAcc-mean-X
* fBodyAcc-mean-Y
* fBodyAcc-mean-Z
* fBodyAcc-std-X
* fBodyAcc-std-Y
* fBodyAcc-std-Z
* fBodyAcc-meanFreq-X
* fBodyAcc-meanFreq-Y
* fBodyAcc-meanFreq-Z
* fBodyAccJerk-mean-X
* fBodyAccJerk-mean-Y
* fBodyAccJerk-mean-Z
* fBodyAccJerk-std-X
* fBodyAccJerk-std-Y
* fBodyAccJerk-std-Z
* fBodyAccJerk-meanFreq-X
* fBodyAccJerk-meanFreq-Y
* fBodyAccJerk-meanFreq-Z
* fBodyGyro-mean-X
* fBodyGyro-mean-Y
* fBodyGyro-mean-Z
* fBodyGyro-std-X
* fBodyGyro-std-Y
* fBodyGyro-std-Z
* fBodyGyro-meanFreq-X
* fBodyGyro-meanFreq-Y
* fBodyGyro-meanFreq-Z
* fBodyAccMag-mean
* fBodyAccMag-std
* fBodyAccMag-meanFreq
* fBodyBodyAccJerkMag-mean
* fBodyBodyAccJerkMag-std
* fBodyBodyAccJerkMag-meanFreq
* fBodyBodyGyroMag-mean
* fBodyBodyGyroMag-std
* fBodyBodyGyroMag-meanFreq
* fBodyBodyGyroJerkMag-mean
* fBodyBodyGyroJerkMag-std
* fBodyBodyGyroJerkMag-meanFreq





## 6.What tidy_data represents

For each unique combination of subject and activity, you get the mean for each measure outlined in each column








