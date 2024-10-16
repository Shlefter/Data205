# Data205 Capstone
The primary objective of this project is to create a useful data product that can potentially shed light on the risks of certain changes for a community. To do this, I will be looking at house value changes over time and if the demographic applying for morgage loans changes with it. 

## Class Summary
The Data 205 class is designed to teach the students about real-life data science projects and processes. This is done in two ways: by teaching the skills needed for working in a proffesional environment (such as git and SQL), and through internship programs to give the student a proffesional environment to work in and have thm create a real, useful product.

## Project Information

### Datasets
This project will be using the HMDA public dataset, which can be found either at their website [cfpb.gov data browser](https://ffiec.cfpb.gov/data-browser/) or via their [data science kit](https://github.com/cfpb/HMDA_Data_Science_Kit). The Home Morgage Disclosure Act requires all lenders to submit records of their morgage loans, and some of that information is released to the public by the CFPB. Note that there was a significant policy change in 2018, and the list of variables released was altered with it. Due to this, I will only be using the data from 2018 and on as property value was not released for earlier years.

The variables I will be working with are as follows:
- Property value
- County code
- Derived Race
- Derived Ethnicity
- Action type (filter for only applications)


In addition to the HMDA dataset, I will be using several external datasets for different measures of gentrification:

Citizens Connect - County Data
- data about the estimated number of commuters by county. Not that as of 10/15/2024, this dataset only includes until 2020.
- The pecific variable for this dataset that I am interested in are year and geoid to match it with the hmda data and specifically the types commuter and ethnicity.
- [Dataset at bts.gov](https://data.bts.gov/Research-and-Statistics/Citizen-Connect-County-data-live-/t3kh-5nek/about_data)

Residential Construction Permits by County
- In addition to home improvement loans which may be found in the HMDA dataset, this can also show where people are doing work on properties. 
- For this dataset I am mainly interested in the count of loans per county.
- [Dataset at arcgis.com](https://hudgis-hud.opendata.arcgis.com/datasets/HUD::residential-construction-permits-by-county/about)

### Project
In this project, I will analyze the median property values where people have applied for loans between 2018 and 2023. In places with vast changes in pricing, I will look at the demographics that have been applying for loans before and after. This is intended to find places that have experienced gentrification and see if we can correlate it with certain changes, such as construction, non-person borrowers, or commuter statistics.
