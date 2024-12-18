# Data205 Capstone
The primary objective of this project is to create a useful data product that can potentially shed light on the risks of certain changes for a community. To do this, I will be looking at house value changes over time by county and if the demographic applying for morgage loans changes with it. 

## Class Summary
The Data 205 class is designed to teach the students about real-life data science projects and processes. This is done in two ways: by teaching the skills needed for working in a proffesional environment (such as git and SQL), and through internship programs to give the student a proffesional environment to work in and have thm create a real, useful product. 

## Project Information
Note that this project was done as an internship for the CFPB.

### Datasets
This project will be using the HMDA public dataset, which can be found either at their website [cfpb.gov data browser](https://ffiec.cfpb.gov/data-browser/) or via their [data science kit](https://github.com/cfpb/HMDA_Data_Science_Kit). The Home Mortgage Disclosure Act requires covered lenders (the full list of which can be seen in the HMDA panel and transmittal sheets) to submit records of their mortgage loans, and some of that information is released to the public by the CFPB. Note that there was a significant regulation change in 2018, and the list of variables released was altered with it. Due to this, I will only be using the data from 2018 and on as property value was not collected in earlier years.

The variables I will be working with are as follows:
- Property value
- Loan amount
- loan purpose (home purchase vs improvement)
- County code
- Derived Race
- Derived Ethnicity
- Action type (filter to use loan originated to avoid double counting)
- Number of units


In addition to the HMDA dataset, I will be using several external datasets:

Citizens Connect - County Data
- data about the estimated number of commuters by county. Note that as of 10/15/2024, this dataset only includes until 2020.
- The specific variable for this dataset that I am interested in are year and geoid to match it with the hmda data and specifically the types commuter and ethnicity.
- [Dataset at bts.gov](https://data.bts.gov/Research-and-Statistics/Citizen-Connect-County-data-live-/t3kh-5nek/about_data)

Residential Construction Permits by County
- In addition to home improvement loans which may be found in the HMDA dataset, this can also show where people are doing work on properties. 
- For this dataset, I am mainly interested in the count of loans per county.
- [Dataset at arcgis.com](https://hudgis-hud.opendata.arcgis.com/datasets/HUD::residential-construction-permits-by-county/about)

### Research Goals and Questions
My primary goal is to measure housing price changes over time and see how they correlate with changes in the surrounding areas. Briefly, my results indicated that there is little correlation between the p-value of the change in the lending demographic, the current value, previous increase, the number of construction permits, and the p-value for a change in commuters from an area to the likelihood or strength of an upcoming price change. A full overview of my original project plan can be found in projectPlan.txt, and my final report and presentation can be found in the results folder.

## Repository Information

### Loading the HMDA dataset
As mentioned earlier, I used the scripts from the [HMDA data science kit](https://github.com/cfpb/HMDA_Data_Science_Kit) and edited them to load only the most recent versions of the 2018-2023 data. 

Requirements: 
The download scripts require wget to already be installed.
The load-scripts assume that you already have a database installed. The SQL is written for PostgreSQL, using a different version may require modifications.

Assuming everything works as expected, the following scripts can be run in succession to fully setup the database (note that this will take a long time):
```
bash loadData/download_hmda.sh
bash loadData/unzip_all.sh
bash loadData/create_hmda_db.sh -u <username> -p <password>
```
The script above creates a HMDA database on an existing Postgres installation, creates the hmda_public schema, creates tables, and loads data.

Advanced options/troubleshooting: (Note that this section is mostly copied from the HMDA data science kit)

The download script accepts the following option flags:

-a: Prints to console the available files for download.
-s: Allows a specific file to be downloaded if it is not present. The name convention for specific files is as follows: lar_, panel_, or ts_.
-p: Downloads all Panel files that are not present.
-t: Downloads all Transmittal Sheet files that are not present.
-l: Downloads all LAR files that are not present.
-F: Deletes the file or file types to be downloaded (the files are then redownloaded).
-h: Prints to console the instructions for using the script.

Download Troubleshooting
Sometimes files from the National Archives fail to download correctly. An indicator that this happens is the presence of a file with the correct name (such as LAR_20013.zip) that has a file size of 4kb. In these cases, the file must be deleted and re-downloaded. One way to do this is:
```
bash download_scripts/download_hmda.sh -Fs <filename>.
```

Available option flags for the load scripts are as follows:

-u: Sets the user role for the Postgres connection, default is postgres.
-p: Sets the password for the Postgres connection, default is blank.
-d: Sets the database for connection, default is postgres.
-h: Sets the database host, default is localhost.
-o: Sets the database connection port, the default is 5432.
--help: Displays the options available for the script.

### Repository Overview

All of my project code is in the folder projectCode. The visualizations folder includes homework from early on in the semester and demonstrates how to use the database and some of the visualizations that can be made. However, the graphs there may misrepresent the data as they do not filter to ensure they are only comparing like things. the loadData folder includes the download and load scripts, the two external datasets as they were when I did this project, and is where the HMDA data will be stored once it is downloaded.

Project code:
All of the required python packages are in installRequirements. Run that first to avoid any import errors
The data wrangling and cleaning is done in dataDerivations. This is then written to meanMeds.csv (all counties) and meanMedsFiltered.csv (counties that had more than 25 loan applications for each year) to save computation time. Some additional statistical information is derived at the beginning of stats and choropleths so that the meanMeds files don't get too big, and then the rest of those files are dedicated to statistical analysis and regression plots, and choropleths respectively. Note that EDA does its own wrangling and cleaning. EDA and dataDerivations need the HMDA database to be set up, while stats and choropleths pull from meanMeds and the external datasets in loadData.
