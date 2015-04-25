## ==================== Step 1==================================
# Reading all training data files (X_train, y_train and subject_train)

dataset_sub_train <- read.table("train/subject_train.txt",header = FALSE, sep = "",dec = ".",colClasses = "numeric");
dataset_train <- read.table("train/X_train.txt",header = FALSE, sep = "",dec = ".",colClasses = "numeric");
dataset_y_train <- read.table("train/y_train.txt",header = FALSE, sep = "",dec = ".",colClasses = "numeric");

## ==================== Step 2==================================
# Reading all test data files (X_test, y_test and subject_test)test data files

dataset_sub_test <- read.table("test/subject_test.txt",header = FALSE, sep = "",dec = ".",colClasses = "numeric");
dataset_y_test <- read.table("test/y_test.txt",header = FALSE, sep = "",dec = ".",colClasses = "numeric");
dataset_test <- read.table("test/X_test.txt",header = FALSE, sep = "",dec = ".",colClasses = "numeric");

## ==================== Step 3==================================
# Merging training and test data for subject, features and labels

dataset_sub <- rbind(dataset_sub_train,dataset_sub_test);
dataset_y <- rbind(dataset_y_train,dataset_y_test);
dataset <- rbind(dataset_train,dataset_test);

dataset <- cbind(dataset_y,dataset_sub,dataset);


## ==================== Step 4==================================
## Writing merged data into files under directory "merged"
## Create the directory if does not exist
if(!file.exists("merged")){
  dir.create("merged");
}
## Write the merged content into a new file (.csv, comma separated)

write.table(dataset, file ="merged/merged_data.csv", append = FALSE, quote = FALSE, sep = ",", dec = ".", row.names = FALSE, col.names = FALSE);


## ==================== Step 5==================================

# Merge all Innertial Signal files of Training and Test sets (File wise merging).
# Write all merged contents file-wise into new files (.csv, comma separated format)

file_list_train <- list.files("train/Inertial Signals/");
file_list_test <- list.files("test/Inertial Signals/");

if(!file.exists("merged")){
  dir.create("merged");
  dir.create("merged/Inertial Signals");
}else{
  if(!file.exists("merged/Inertial Signals")){
    dir.create("merged/Inertial Signals");
  }
}


for (i in 1:length(file_list_train)){
  temp_dataset_train <- read.table(paste("train/Inertial Signals/",file_list_train[i],sep=""), header = FALSE, sep = "",dec = ".",colClasses = "numeric");
  temp_dataset_test <- read.table(paste("test/Inertial Signals/",file_list_test[i],sep=""), header = FALSE, sep = "",dec = ".",colClasses = "numeric");
  temp_dataset_train<-rbind(temp_dataset_train, temp_dataset_test);
  
 file_name<- paste("merged/Inertial Signals/",substr(file_list_test[i],1,(nchar(file_list_test[i])-9)),".csv",sep="");
  
  

  write.table(temp_dataset_train, file =file_name, append = FALSE, quote = FALSE, sep = ",", dec = ".", row.names = FALSE, col.names = FALSE); 
  rm(temp_dataset_train);
  rm(temp_dataset_test);
}

## ==================== Step 6==================================

## Extract Subject, Activity and only mean and standard deviation data from the merged dataset
## First two columns are Subject and Activity Labels respectively, in the merged data set.
## Remaining columns are the data of means and standard deviations
dataset_mean_sd <- dataset[,c(1:2,3:8,43:48,83:88,123:128,163:168,203:204,216:217,229:230,242:243,255:256,268:273,296:298,347:352,375:377,426:431,454:456,505:506,515,518:519,528,531:532,541,544,545,554,557:563)];

# Extract column lables of variables having mean and standard deviation data
column_labels <- read.table("features.txt",header = FALSE, sep = "",colClasses = "character");
label_names <- column_labels[c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,513,516:517,526,529:530,539,542,543,552,555:561),2];


## ==================== Step 7==================================

# Assign Column labels to each column in the extracted data set.

colnames(dataset_mean_sd) <- c("Activity","Subject",label_names);

library(data.table);
DT <- data.table(dataset_mean_sd);


## ==================== Step 8==================================

# Read the activity and labels mapping from activity_labels.txt
# Assign respective lables to the activities in the dataset
# Write this dataset into a .csv file (Comma separated)

activity_labels <- read.table("activity_labels.txt",header = FALSE, sep = "",colClasses = "character");

for (n in 1:nrow(activity_labels)){
	DT$Activity[DT$Activity==activity_labels[n,1]] <- activity_labels[n,2];
}

write.table(DT, file ="merged/new_dataset.csv", append = FALSE, quote = TRUE, sep = ",", dec = ".", row.names = FALSE, col.names = TRUE); 

## ==================== Step 9==================================

# Create summary set from the modified data set to get average of each variable for each activity and each subject.

# Rearrange the rows on ascending order of Activity and Subject, respectively.

# Write summary dataset into a .csv file(comma separated)

summ <- DT[, sapply(.SD, function(x) list(mean=mean(x))), by=list(Activity, Subject)];
summ <- summ[with(summ, order(Activity, Subject)), ];


write.table(summ, file ="merged/summary.csv", append = FALSE, quote = TRUE, sep = ",", dec = ".", row.names = FALSE, col.names = TRUE); 



