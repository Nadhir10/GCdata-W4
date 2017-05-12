## Getting and Cleaning Data Week4 peer review

### package
the repo contains :
* run_analysis. R script
* COdeBook.md file

### What you need to do
You just need to Run the script "run_analysis.R" from your R enviorement

### The used data
The script downloads data of Human Activity Recognition Using Smartphones Data Set. it is a data 
collected from the accelerometers from the Samsung Galaxy S smartphone for people having different 
activities (like walking, laying...)

### The script
The script downloads the data from the internet repository, unzip it and loads each file to its
correspondant R variable. 
in Step 1, the script merges the data into one single data set.
in step 2, it extracts the measurement prensenting means or standrad deviation
in Step 3, it repalces the activity codes by their correspondant activity labels
in step 4, it labels appropriately the variables (especially for time and frequency variables)
in step 5, the script melts the data according to the subject id adn activity, then 
reshapes the table in order to have all the varibales in columns.