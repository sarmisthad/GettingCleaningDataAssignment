This file provides code, data, variable details of "run_analysis.R".

Input files used, as present in supplied dataset : (current working directory is home of these files, unless specific sub-directory path given below )
1. train/X_train.txt
2. train/y_train.txt
3. train/subject_train.txt
4. test/X_test.txt
5. test/y_test.txt
6. test/subject_test.txt
7. train/Inertial Signals/*.txt
8. test/Inertial Signals/*.txt
9. features.txt
10. activity_labels.txt

Output Files Generated (with respect to current working directory path):
1. merged/merged_data.csv
2. merged/new_dataset.csv
3. merged/summary.csv
4. merged/Inertial Signals/<filename>.csv , <filename> represents each file under "Inertial Signals" directory of supplied data.


Step 1:
variable : (dataset_sub_train) : contains data read from file subject_train.txt
variable : (dataset_train ) : contains data read from file X_train.txt
variable : (dataset_y_train  ) : contains data read from file y_train.txt

Step 2:
variable : (dataset_sub_test) : contains data read from file subject_test.txt
variable : (dataset_test ) : contains data read from file X_test.txt
variable : (dataset_y_test ) : contains data read from file y_test.txt

Step 3:
variable : (dataset_sub) : merges data of dataset_sub_train and dataset_sub_test row-wise.
variable : (dataset ) : merges data of dataset_train and dataset_test row-wise.
variable : (dataset_y ) : merges data of dataset_y_train and dataset_y_test row-wise.

variable : (dataset ) : updated to merge data of dataset_y, dataset_sub, and dataset column-wise, in this order. 

Step 4:
New directory : "merged" (created, conditionally if does not exist already)
Output File : "merged_data.csv", created with data in variable "dataset", as in Step 3.

Step 5:
variable : (temp_dataset_train) : contains data set of one file at a time (in a loop) from "train/Inertal Signals" of supplied data.
variable : (temp_dataset_test) : contains data set of one file at a time (in a loop) from "test/Inertal Signals" of supplied data.
New directory : "merged/Inertial Signals"
New Files : "merged/Inertial Signals/<filename>.csv" , <filename> represents-> each file under "Inertial Signals" directory of supplied data.

Step 6:
variable : (dataset_mean_sd) : contains extracted columns from the variable 'dataset", (in Step 3) representing mean or std deviation parameters.In addition to these also takes Activity and Subject columns.
variable : ( column_labels) : Data set read from supplied "features,txt", containing column indices and column names of X_train.txt/ X_test.txt file.

Following column indices are selected from features.txt
1 to 6
41 to 46
81 to 86
121 to 126
161 to 166
201 to 202
214 to 215
227 to 228
240 to 241
253 to 254
266 to 271
294 to 296 
345 to 350
373 to 375 
424 to 429
452 to 454 
503 to 504
513 
516 to 517
526 
529 to 530
539 
542 to 543
552 
555 to 561

Step 7:
variable : ( DT) : same data as in (dataset_mean_sd),type cast to data.table.

Step 8:
variable : (activity_labels ) : contains data read from activity_labels.txt file as supplied.
Output File : merged/new_dataset.csv (created with data as in DT)


Step 9:
variable : (summ) : contains average of each data field in DT, for each Activity and Subject.
Output File : merged/summary.csv (created with data as in summ)