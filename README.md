# README for run_analysis.R script

## created by Nicholas Metaxas
### this was part of a Coursera Project homework

## Idea
The Idea is to get two sets of data that are raw data and make them tidy. The raw data are train and test, with 
no column names and activity and subject data are also in different files. The idea is to combine all this
data and give them descriptive and clear names so that the user can understand.
Extra is to provide summaries of the average of the measures by activity and subject.


## Files included

* CodeBook.md : explains purpose and backgorund, how the data was gathered, how the data was cleaned. It
also describes the columns for both raw and tidy data, and explains the final output.
* README.md : explains what each file represents and the idea behind the project
* run_analysis.R : script that reads data, combines raw data, manipulates data in such a way that names are
 descriptive and more user friendly. Finally it summarizes data by each subject and activity. Logic of 
the R script can also be found inside the script as comments.
* tidy_data.txt : final output file that has each measure's AVERAGE value by subject and by activity.
 This forms the basis of tidy data where each row represents a unique combination of subject and activity
and an observation of the average value of each measurement.


## How R scipt run_analysis works

First you need to have the Samsung data and set your working directory to that folder.

The following can be found in the CodeBook.md as well.

There are 5 steps in the code:

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


