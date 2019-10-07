# movielens
MovieLens Data Analysis Project

Clone Repository

1. Navigate to the root folder where you want to Install this project
2. Run
   $ git clone https://github.com/geek0075/movielens.git
3. This will download a copy of this repository into a 'movielens' folder

Create data and rda directories

1. Navigate to the root folder where you installed this project
2. Run
   $ cd movielens
   $ mkdir data
   $ mkdir rda
   
Open project in RStudio

1. Make sure you have R and RStudio installed
2. Navigate to the root folder where you installed this project
3. Run
   $ cd movielens
4. Find or locate the file 'movielens.Rproj'
5. From your Finder (Mac) or Explorer (Windows) double click on 'movielens.Rproj' to open the project in RStudio

Download MovieLens 10M data

1. Make sure you have created the 'data' directory as described in 'Create data and rda directories' above
2. Make sure you have the project open in RStudio as described in 'Open project in RStudio' above
3. In RStudio look for and click on the file 'download-data.R' to open the download data R script
4. From the toolbar in the 'download-data.R' window select 'Source'
5. The MovieLens 10M dataset is downloaded to the file 'ml-10m.zip' in the './data' directory

Wrangle MovieLens 10M data (Process and extract R data objects)

1. Make sure you have created the 'rda' directory as described in 'Create data and rda directories' above
2. Make sure you have the project open in RStudio as described in 'Open project in RStudio' above
3. In RStudio look for and click on the file 'wrangle-data.R' to open the wrangle data R script
4. From the toolbar in the 'wrangle-data.R' window select 'Source'
5. The relevant R data objects are extracted from the file 'ml-10m.zip', processed and saved in the './rda' directory

Run the Analysis

The analysis trains a machine learning model using data in the training data set (edx) and predicts ratings in the validation data set for evaluation. The analysis outputs a single number which is the RMSE.

1. Make sure you have downloaded and wrangled data as described in 'Download MovieLens 10M data' and 'Wrangle MovieLens 10M data'
2. In RStudio look for and click on the file 'analysis.R' to open the analysis R script
3. From the toolbar in the 'analysis.R' window select 'Source'.
4. The analysis is ran and outputs the RMSE 

