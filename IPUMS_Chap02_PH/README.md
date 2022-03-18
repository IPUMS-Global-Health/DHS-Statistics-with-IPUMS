# Population and Housing Variables

Once you have completed the steps below, executing the main do file will generate tables using household and women's variables. 

- Tables_hh_wash
- Tables_hh_charac
- Tables_hh_poss
- Tables_handwsh
- Tables_schol
- Tables_hh_comps
- Tables_pop
- Tables_livarg_orph
- Table_gini

# Create IPUMS DHS data files that include the variables listed below

#### How to create the tables
First, create IPUMS DHS data files that include the variables listed below. Create a separate data file for each unit of analysis--for this chapter, Household Members and Births. 

Then, inside the main do file, in the areas commented, add in the paths to the household, women's, or birth data from IPUMS. Replace "GEO-REGION" with your sample's region variable name associated with the data sets. Tables will be created in current working directory.


## These are the IPUMS DHS variables you need for each table

##### IPUMS_PH_GINI.do

| Variable                   | Description                           |
|----------------------------|---------------------------------------|
| HOUSEHOLDS AS UNIT OF ANALYSIS
| hhrelate                   | "Relationship to household head"      |
| dejureno                   | "Number of de jure members"           |
| hhweight                   | "Household sample weight"             |
| wealthshh                  | "Wealth index factor score"           | 
| urbanhh                    | "Urban-rural status"                  |
| wealthqhh                  | "Household wealth index in quintiles" |
| region variable geo_CCYEAR | "Single sample geography variables"   | 

##### IPUMS_PH_HNDWSH.do

| Variable                   | Description                                                   |
|----------------------------|---------------------------------------------------------------|
| HOUSEHOLDS AS UNIT OF ANALYSIS
| handwashwtr                | "Water present in observed handwashing place"                 |
| hwsoap                     | "Household has soap or other cleansing agent for handwashing" |
| handwashsand               | "Ash/mud/sand present in observed handwashing place"          |
| handwashplobs              | "Has place for handwashing (observed)"                        |
| idhshid                    | "Unique cross-sample household identifier"                    | 
| urbanhh                    | "Urban-rural status"                                          |
| hhresident                 | "Usual resident or visitor"                                   |
| wealthqhh                  | "Household wealth index in quintiles"                         |
| region variable geo_CCYEAR | "Single sample geography variables"                           | 

##### IPUMS_PH_HOUS.do
| Variable                   | Description                               |
|----------------------------|-------------------------------------------|
| HOUSEHOLDS AS UNIT OF ANALYSIS
| electrchh                  | "Has electricity"                         |
| floor                      | "Main material of floor"                  | 
| sleeprooms                 | "Number of rooms in hh used for sleeping" |
| cookwhere                  | "Where cooking is usually done"           |
| cookfuel                   | "Type of cooking fuel"                    |
| tosmkhhfreq                | "Frequency of smoking at home"            |
| radiohh                    | "Owns a radio"                            |
| tvhh                       | "Owns a tv"                               | 
| mobphone                   | "Owns a mobile phone"                     |
| hhphonehh                  | "Owns a non-mobile telephone"             |
| pc                         | "Owns a computer"                         |
| fridgehh                   | "Owns a refrigerator"                     | 
| bikehh                     | "Owns a bicycle"                          |
| drawncart                  | "Owns an animal drawn cart"               |
| motorcyclhh                | "Owns a motorcycle/scooter"               |
| carhh                      | "Owns a car or truck"                     |
| boatwmotor                 | "Owns a boat with a motor"                |
| aglandyn                   | "Owns agricultural land"                  | 
| livestockyn                | "Owns livestock"                          |
| hhlineno                   | "Line number in household"                |
| hhresident                 | "Usual resident or visitor"               |
| wealthqhh                  | "Household wealth index in quintiles"     |
| urbanhh                    | "Urban-rural status"                      |
| region variable geo_CCYEAR | "Single sample geography variables"       |

##### IPUMS_PH_POP.do
| Variable                   | Description                           |
|----------------------------|---------------------------------------|
| HOUSEHOLDS AS UNIT OF ANALYSIS
| hhage                      | "Age of household member"             |
| hhbirthcert                | "Has a birth certificate"             | 
| edsumm                     | "Educational attainment"              |
| edyears                    | "Education in completed years"        |
| wealthqhh                  | "Household wealth index in quintiles" |
| clusternoall               | "Sample-specific cluster number"      |
| hhnumall                   | "Household number in cluster"         |
| hhlineno                   | "Line number in household"            | 
| hhmembers                  | "Number of household members"         |
| urbanhh                    | "Urban-rural status"                  |
| hhrelate                   | "Relationship to household head"      |
| hhresident                 | "Usual resident or visitor"           | 
| hhslept                    | "Slept last night in household"       |
| sex                        | "Sex of household member"             |
| fatheralive                | "Father alive"                        |
| fatherlineno               | "Father's line number"                |
| motheralive                | "Mother alive"                        |
| motherlineno               | "Mother's line number"                | 
| region variable geo_CCYEAR | "Single sample geography variables"   |

##### IPUMS_PH_SANI.do

| Variable                   | Description                           |
|----------------------------|---------------------------------------|
| HOUSEHOLDS AS UNIT OF ANALYSIS
| toilettype                 | "Type of toilet facitlity"            |
| toiletplace                | "Location of toilet facilities"       |
| toiletshareyn              | "Household shares toilet facility"    |
| hhresident                 | "Usual resident or visitor"           |
| wealthqhh                  | "Household wealth index in quintiles" |
| urbanhh                    | "Urban-rural status"                  |
| region variable geo_CCYEAR | "Single sample geography variables"   | 

##### IPUMS_PH_SCHOL.do

| Variable                   | Description                                    |
|----------------------------|------------------------------------------------|
| HOUSEHOLDS AS UNIT OF ANALYSIS
| hhlineno                   | "Line number in household"                     |
| hhweight                   | "Household sample weight"                      |
| wealthqhh                  | "Household wealth index in quintiles"          |
| urbanhh                    | "Urban-rural status"                           |
| idhshid                    | "Unique cross-sample household identifier"     | 
| birthcmclt5                | "Date of birth CMC, under 5"                   |
| linenoparenthhlt5          | "Line number of parent/caretaker"              |
| hhage                      | "Age of household member"                      |
| hhslept                    | "Slept last night in household"                |
| hhintcmc                   | "Century month date of interview"              |
| edlevelnow                 | "Educational level during current school year" |
| sex                        | "Sex of household member"                      |
| BIRTHS AS UNIT OF ANALYSIS
| linenokid                  | "Line number of child in household"            |
| kiddobcmc                  | "Child's date of birth CMC"                    |
| idhshid                    | "Cross-sample household identifier"            |
| region variable geo_CCYEAR | "Single sample geography variables"            | 

##### IPUMS_PH_WATER.do

| Variable                   | Description                                          |
|----------------------------|------------------------------------------------------|
| HOUSEHOLDS AS UNIT OF ANALYSIS
| trboil                     | "Household treats water by boiling"                  |
| trbleach                   | "Household treats water by adding bleach / chlorine" |
| trcloth                    | "Household treats water by straining through cloth"  |
| trfilter                   | "Household treats water by using water filters"      |
| trsolar                    | "Household treats water by solar disinfection"       |
| trstand                    | "Household treats water by letting it stand"         |
| trother                    | "Household treats water by other methods"            |
| treatwtryn                 | "Household uses any method to treat drinking water"  | | drinkwtr                   | "Major source of drinking water"                     |
| timetowtrhh                | "Time to reach water source and return, in minutes"  |
| wtrshortyn                 | "Water shortage or unavailablility, last two weeks"  |
| hhresident                 | "Usual resident or visitor"                          |
| wealthqhh                  | "Household wealth index in quintiles"                |
| urbanhh                    | "Urban-rural status"                                 |
| region variable geo_CCYEAR | "Single sample geography variables"                  |  

