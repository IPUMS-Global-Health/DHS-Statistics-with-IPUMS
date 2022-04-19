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

| Variable                   | Description                                                   |
|----------------------------|---------------------------------------------------------------|
| HOUSEHOLDS AS UNIT OF ANALYSIS
| TECHNICAL -> IDENTIFIERS  
| idhshid                    | "Unique cross-sample household identifier"                    |
| hhlineno                   | "Line number in household"                                    |
| clusternoall               | "Sample-specific cluster number"                              |
| hhnumall                   | "Household number in cluster"                                 |
| TECHNICAL -> WEIGHTS AND SUBSAMPLE SELECTION
| hhweight                   | "Household sample weight"                                     |
| GEOGRAPHY -> GEOGRAPHY, GENERAL  
| urbanhh                    | "Urban-rural status"                                          |
| GEOGRAPHY -> SINGLE SAMPLE GEOGRAPHY
| region variable geo_CCYEAR | "Single sample geography variables"                           |
| HOUSEHOLD CHARACTERISTICS -> TOILET AND WATER   
| handwashwtr                | "Water present in observed handwashing place"                 |
| hwsoap                     | "Household has soap or other cleansing agent for handwashing" |
| handwashsand               | "Ash/mud/sand present in observed handwashing place"          |
| handwashplobs              | "Has place for handwashing (observed)"                        |
| toilettype                 | "Type of toilet facitlity"                                    |
| toiletplace                | "Location of toilet facilities"                               |
| toiletshareyn              | "Household shares toilet facility"                            |
| trboil                     | "Household treats water by boiling"                           |
| trbleach                   | "Household treats water by adding bleach / chlorine"          |
| trcloth                    | "Household treats water by straining through cloth"           |
| trfilter                   | "Household treats water by using water filters"               |
| trsolar                    | "Household treats water by solar disinfection"                |
| trstand                    | "Household treats water by letting it stand"                  |
| trother                    | "Household treats water by other methods"                     |
| treatwtryn                 | "Household uses any method to treat drinking water"           |
| drinkwtr                   | "Major source of drinking water"                              |
| timetowtrhh                | "Time to reach water source and return, in minutes"           |
| wtrshortyn                 | "Water shortage or unavailability, last two weeks"            |
| HOUSEHOLD CHARACTERISTICS -> HOUSEHOLD DEMOGRAPHIC    
| dejureno                   | "Number of de jure members"                                   |
| hhmembers                  | "Number of household members"                                 |
| HOUSEHOLD CHARACTERISTICS -> WEALTH INDEX
| wealthqhh                  | "Household wealth index in quintiles"                         |
| wealthshh                  | "Wealth index factor score"                                   |
| HOUSEHOLD CHARACTERISTICS -> HOUSING
| electrchh                  | "Has electricity"                                             |
| floor                      | "Main material of floor"                                      |
| sleeprooms                 | "Number of rooms in hh used for sleeping"                     |
| cookwhere                  | "Where cooking is usually done"                               |
| cookfuel                   | "Type of cooking fuel"                                        |
| HOUSEHOLD CHARACTERISTICS -> POSSESSIONS
| radiohh                    | "Owns a radio"                                                |
| tvhh                       | "Owns a tv"                                                   |
| mobphone                   | "Owns a mobile phone"                                         |
| hhphonehh                  | "Owns a non-mobile telephone"                                 |
| pc                         | "Owns a computer"                                             |
| fridgehh                   | "Owns a refrigerator"                                         |
| bikehh                     | "Owns a bicycle"                                              |
| motorcyclhh                | "Owns a motorcycle/scooter"                                   |
| carhh                      | "Owns a car or truck"                                         |
| boatwmotor                 | "Owns a boat with a motor"                                    |
| HOUSEHOLD CHARACTERISTICS -> AGRICULTURAL POSSESSIONS
| aglandyn                   | "Owns agricultural land"                                      |
| livestockyn                | "Owns livestock"                                              |
| drawncart                  | "Owns an animal drawn cart"                                   |
| DEMOGRAPHIC -> CORE DEMOGRAPHIC
| hhresident                 | "Usual resident or visitor"                                   |
| hhrelate                   | "Relationship to household head"                              |
| hhage                      | "Age of household member"                                     |
| hhbirthcert                | "Has a birth certificate"                                     |
| hhslept                    | "Slept last night in household"                               |
| sex                        | "Sex of household member"                                     |
| fatheralive                | "Father alive"                                                |
| fatherlineno               | "Father's line number"                                        |
| motheralive                | "Mother alive"                                                |
| motherlineno               | "Mother's line number"                                        |
| HEALTH BEHAVIORS -> TOBACCO
| tosmkhhfreq                | "Frequency of smoking at home"                                |
| SOCIOECONOMIC STATUS -> EDUCATION
| edsumm                     | "Educational attainment"                                      |
| edyears                    | "Education in completed years"                                |
| BIOMETRICS -> CHILD BIOMETRICS, GENERAL  
| birthcmclt5                | "Date of birth CMC, under 5"                                  |
| linenoparenthhlt5          | "Line number of parent/caretaker"                             |
| BIRTHS AS UNIT OF ANALYSIS
| CHILD DEMOGRAPHY -> CHILD DEMOGRAPHY CORE
| linenokid                  | "Line number of child in household"                           |
| kiddobcmc                  | "Child's date of birth CMC"                                   |
