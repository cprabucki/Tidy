###################################################################
# Read-me file for Getting and Cleaning Data Course Project
# Carlos // 2017
###################################################################


The present script makes us of the dplyr library

Local working directory must be set in each case, all files should be placed here

Source files requiered are: 
	activity_lables.txt
	features.txt
	subject_test.txt
	subject_train.txt
	X_test.txt
	Y_test.txt
	y_test.txt
	y_train.txt

Both train and test datasets are merged in order to work with all data in a single file

Subject and Activity are asigned to each observation so as to be able to summarize as requested

Columns selected are all containing 'mean' or 'std' regardless the positions the strings are showing up

No use has been made of the Inertial Signal folders contents

Final result is stored in the Tidy.txt file. Please refer to the Codebook included in this pack to get file structure and contents details.
