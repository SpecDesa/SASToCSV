#install.packages("haven")
library(haven)
#install.packages("stringr")
library(stringr)
#install.packages("svDialogs")
library(svDialogs)

#options(encoding = "UTF-8")

# Set working directory
setwd(choose.dir(default = "", caption = "Select folder"));


# Choose SAS file
tmpSas <- choose.files(default = "", caption = "Select files",
                         multi = FALSE, filters = Filters,
                         index = nrow(Filters));


# Change name of excel end to SAS
sasName <- basename(tmpSas) %>% str_replace(., ".sas7bdat", ".csv");
# Read SAS
sasFile <- read_sas(tmpSas)

#sasFileTest <- sasFile[1:20000,]

# choose if first row should be column names
userInput <- dlgInput("Is first row columnnames?", Sys.info()["Y/N"])$res;



if(userInput == 'Y' || userInput == 'y' || userInput == 'Yes' || userInput == 'yes'){
  write.csv2(sasFile, sasName, row.names = FALSE, #fileEncoding = 'UTF-8', 
             na = '')
} else if (userInput == 'N' || userInput == 'n' || userInput == 'No' || userInput == 'no'){
  write.csv2(sasFile, sasName, row.names = FALSE, column.names = FALSE  , #fileEncoding = 'UTF-8', 
             na = 'NULL')
} else{
  write.csv2(sasFile, sasName, row.names = TRUE, #fileEncoding = 'UTF-8' , 
             na = 'NULL')
}


