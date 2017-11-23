## How to get the stock data

That is done by running the following code.

I have a backup zip folder on my personal drive as well.

```r
#imports
library(tidyverse)
library(readr)
library(data.table)
library(readxl)
library(stringr)
library(ineq)

#download files
zip_file_name = "zipped_sp500_data.zip"
if(!file.exists(zip_file_name)){
  download.file("http://quantquote.com/files/quantquote_daily_sp500_83986.zip",zip_file_name)
  unzip(zip_file_name)
}

# create summary of all stock names
data_folder = "quantquote_daily_sp500_83986/daily"
filenames = list.files(data_folder)
stock_names = sub("table_","",sub(".csv","",filenames))
stock_str = paste( stock_names,collapse=", ")

fileConn<-file("output.txt")
writeLines(stock_str, fileConn)
close(fileConn)
```
