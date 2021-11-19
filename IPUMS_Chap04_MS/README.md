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
| marstat                    | Women: "Current marital status"               |
| wifenum                    | Women: "Number of other co-wives"             |
| agefrstmar                 | Women: "Age at first marriage orcohabitation" |
| urban                      | Women: "Urban-rural status"                   |
| wealthq                    | Women: "Household wealth index in quintiles"  | 
| edachiever                 | Women: "Summary educational achievement"      |
| perweight                  | Women: "Sample weight for persons"            |
| age                        | Women: "Age"                                  |
| region variable geo_CCYEAR | Both: "Single sample geography variables"     |
| MEN AS UNIT OF ANALYSIS    |                                               |
| marstatmn                  | Men: "Current martial status"                 |
| wifenummn                  | Men: "Number of other wives"                  |
| age1stmarmn                | Men: "Age at first marriage or cohabitation"  |
| urbanmn                    | Men: "Type of place of residence"             |
| wealthqmn                  | Men: "Household wealth index in quintiles"    |
| edachievermn               | Men: "Man's summary educational achievement"  | 
| perweightmn                | Men: "Men's sample weight"                    |
| agemn                      | Men: "Age"                                    |
| region variable geo_CCYEAR | Both: "Single sample geography variables"     |

##### IPUMS_MS_SEX.do
| Variable                   | Description                                   |
|----------------------------|-----------------------------------------------|
| age1stseximp               | Women: "Age at first intercourse (imputed)"   |
| wealthq                    | Women: "Household wealth index in quintiles"  | 
| edachiever                 | Women: "Summary educational achievement"      |
| urban                      | Women: "Urban-rural status"                   |
| perweight                  | Women: "Sample weight for persons"            |
| age1stseximpmn             | Men: "Age at first intercourse (imputed)"     |
| wealthqmn                  | Men: "Household wealth index in quintiles"    |
| edachievermn               | Men: "Man's summary educational achievement"  | 
| urbanmn                    | Men: "Type of place of residence"             |
| perweightmn                | Men: "Men's sample weight"                    |
| region variable geo_CCYEAR | Both: "Single sample geography variables"     |

#### How to Run
Inside the main do file, in the areas commented, add in the path to women's data and men's data from IPUMS. Also in the two spots commented, add in the name of the geography variable associated with the data sets. Tables will be created in current working directory.
