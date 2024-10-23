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

### Research Goals and Questions
My primary goal is to measure gentrification and see how it changes the affected areas. Secondarily, I would like to use these findings to attempt to find early indicators of gentrification and what can be changed to mitigate the affect on the community.
Questions:
1.	Which counties’ median/mean house prices change by significantly more than average each year? (t-tests of percentage of median/mean increase between two years, derived from median/mean house price of all loan applications by county)
2.	Do these increased change rates persist (i. e. If a county increases home value by a large amount one year, is it likely to increase similarly the next year)? (strength and slope of correlation by county from the above derived data)
3.	Do these counties have a consistent distance to a large city? (i. e. Are people working in major cities moving slightly further away and commuting?) (Mean, median, and standard deviation of the distance for each highlighted county to the closest major city)
4.	Do these counties experience a change in the demographics applying for loans? (Chi-squared test of demographics)
5.	Do an increase in home improvement loans and non-person lenders accompany rising prices? (correlation analysis, price by amount of loans)
6.	Does the number of commuters change in these counties?  (correlation analysis, price by number of commuters)
7.	Do these counties have an unusually high number of building permits? (Poisson Regression, count of permits and price)
8.	When do the above changes start appearing (same year as price increase, before, after)? (Granger Causality, price by the above variables)
9.	Are there other counties showing some of the above patterns but not experiencing housing price increases? (k-mean clustering of the patterns found)
10.	Due to the policy changes in 2018, I don’t have much longitudinal data to look at. However, to test my findings, can I find older occurrences of the same patterns and match it with historical gentrification? (k-mean clustering with older data and then researching housing prices in notable areas)
11.	Are there counties that are exhibiting the early sign of gentrification right now? (k-mean clustering of found patterns)

