# Load the X_train data
df_train <- read.table("UCI HAR Dataset/train/X_train.txt")
# Print the dimensions of the data frame
dim(df_train)
# Print the column names of the data frame
# names(df_train)

# Read X_test data
df_test <- read.table("UCI HAR Dataset/test/X_test.txt")
# Print the dimensions of the data frame
dim(df_test)
# Print the column names of the data frame
# names(df_test)

# Concatenate the train and test data
df <- rbind(df_train, df_test)
# Read the features (column names) from text file
features <- read.table("UCI HAR Dataset/features.txt")
# Rename the df name of the columns using the features second column
names(df) <- features$V2
# Print the dimensions of the data frame and assign to variable col_names
dim(df)
col_names <- names(df)

# Extract only the measurements on the mean and standard deviation for each measurement
# Extract the column names that contain mean() or std() using grepl function
col_names_mean_std <- col_names[grepl("mean\\(\\)|std\\(\\)", col_names)]
print(col_names_mean_std)
# Subset the data frame with only the columns that contain mean() or std()
df_mean_std <- df[, col_names_mean_std]
# Print the dimensions of the data frame and column names
dim(df_mean_std)
names(df_mean_std)

# Read the activity labels
df_train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
# Print the dimensions of the data frame
dim(df_train_labels)
# Print the column names of the data frame
names(df_train_labels)

# Load the test labels
df_test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
# Print the dimensions of the data frame
dim(df_test_labels)
# Print the column names of the data frame
names(df_test_labels)

# Concatenate the train and test labels
df_labels <- rbind(df_train_labels, df_test_labels)
# Rename the column name to "activity_names"
names(df_labels) <- "activity_names"
print(names(df_labels))


# Load the activity labels name
df_activity_labels_name <- read.table("UCI HAR Dataset/activity_labels.txt")
print(df_activity_labels_name)

# Replace the activity labels with the activity names ("V1" to "V2")
df_labels$activity_names <- df_activity_labels_name$V2[df_labels$activity_names]
# Merge the data frame with the activity labels
df_mean_std_labels <- cbind(df_mean_std, df_labels)
# Print the dimensions of the data frame and column names
# Load the person_id for the train data
df_train_person <- read.table("UCI HAR Dataset/train/subject_train.txt")
# Print the dimensions of the data frame
dim(df_train_person)
# Print the column names of the data frame
names(df_train_person)

# Load the person_id for the test data
df_test_person <- read.table("UCI HAR Dataset/test/subject_test.txt")
# Print the dimensions of the data frame
dim(df_test_person)
# Print the column names of the data frame
names(df_test_person)

# Concatenate the train and test person_id
df_person <- rbind(df_train_person, df_test_person)

# Rename the column name to "person_id"
names(df_person) <- "person_id"

# Merge the data frame with the person_id
df_mean_std_labels <- cbind(df_mean_std_labels, df_person)
dim(df_mean_std_labels)
names(df_mean_std_labels)
head(df_mean_std_labels)


# Load the dplyr package
library(dplyr)

# Group the data frame and assign to new average_by_person and activity
avarage_by_person_activity <- df_mean_std_labels %>%
  group_by(person_id, activity_names) %>%
  summarise_all(mean)

print(avarage_by_person_activity)

# save the data frame to a text file
write.table(avarage_by_person_activity, "avarage_by_person_activity.txt", row.names = FALSE)
