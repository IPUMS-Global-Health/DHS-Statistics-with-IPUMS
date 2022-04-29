# Marriage and Sex Variables

Executing the main do file will generate tables using marriage and sex variables for both men and women.

- Tables_Mar_wm
- Tables_Mar_mn
- Tables_Sex_wm
- Tables_Sex_mn

## Variables Required

##### IPUMS_MS_MAR.do

| Variable                   | Description                                   |
|----------------------------|-----------------------------------------------|
| WOMEN AS UNIT OF ANALYSIS
| DEMOGRAPHIC -> CORE DEMOGRAPHIC
| age                        | Women: "Age"                                  |
| DEMOGRAPHIC -> MARRIAGE AND COHABITATION
| marstat                    | Women: "Current marital status"               |
| wifenum                    | Women: "Number of other co-wives"             |
| agefrstmar                 | Women: "Age at first marriage orcohabitation" |
| SEX PRACTICE AND ATTITUDES -> FIRST OR EVER SEXUAL EXPERIENCE
| age1stseximp               | Women: "Age at first intercourse (imputed)"   |
| Household CHARACTERISTICS -> WEALTH INDEX
| wealthq                    | Women: "Household wealth index in quintiles"  |
| SOCIOECONOMIC -> EDUCATION
| edachiever                 | Women: "Summary educational achievement"      |
| TECHNICAL -> WEIGHTS AND SUBSAMPLE SELECTION
| perweight                  | Women: "Sample weight for persons"            |
| GEOGRAPHY -> GEOGRAPHY, GENERAL
| urban                      | Women: "Urban-rural status"                   |
| GEOGRAPHY -> SINGLE SAMPLE GEOGRAPHY
| region variable geo_CCYEAR | Both: "Single sample geography variables"     |
| MEN AS UNIT OF ANALYSIS     
| DEMOGRAPHIC -> CORE DEMOGRAPHIC
| agemn                      | Men: "Age"                                    |
| DEMOGRAPHIC -> MARRIAGE AND COHABITATION
| marstatmn                  | Men: "Current martial status"                 |
| wifenummn                  | Men: "Number of other wives"                  |
| age1stmarmn                | Men: "Age at first marriage or cohabitation"  |
| SEX PRACTICE AND ATTITUDES -> FIRST OR EVER SEXUAL EXPERIENCE
| age1stseximpmn             | Men: "Age at first intercourse (imputed)"     |
| Household CHARACTERISTICS -> WEALTH INDEX
| wealthqmn                  | Men: "Household wealth index in quintiles"    |
| SOCIOECONOMIC -> EDUCATION
| edachievermn               | Men: "Man's summary educational achievement"  |
| TECHNICAL -> WEIGHTS AND SUBSAMPLE SELECTION
| perweightmn                | Men: "Men's sample weight"                    |
| GEOGRAPHY -> GEOGRAPHY, GENERAL
| urbanmn                    | Men: "Type of place of residence"             |
| GEOGRAPHY -> SINGLE SAMPLE GEOGRAPHY
| region variable geo_CCYEAR | Both: "Single sample geography variables"     |


#### How to Run
Inside the main do file, in the areas commented, add in the path to women's data and men's data from IPUMS. Also in the two spots commented, add in the name of the geography variable associated with the data sets. Tables will be created in current working directory.
