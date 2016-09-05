# GetCleanDataProject

# README for GetCleanDataProject depository

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
