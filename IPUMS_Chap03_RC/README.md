# Respondent's Characteristics Variables

Executing the main do file will generate tables using women's and men's variables. 

- Tables_background_wm
- Tables_background_mn
- Tables_educ_wm
- Tables_educ_mn
- Tables_media_wm
- Tables_media_mn
- Tables_employ_wm
- Tables_employ_mn
- Tables_insurance_wm
- Tables_insurance_mn
- Tables_tobac_wm
- Tables_tobac_mn

#### How to Run
First go to www.idhs.com and create data files with the variables listed below. Create a separate data file for each unit of analysis.

Then, inside the main do file, in the areas commented, add in the path to the women's or men's data from IPUMS. Replace "GEO-REGION" with your sample's region variable name associated with the data sets. Tables will be created in current working directory.## Variables Required

##### IPUMS_RC_CHAR.do

| Variable                   | Description                                                                    |
|----------------------------|--------------------------------------------------------------------------------|
| WOMEN AS UNIT OF ANALYSIS
| edachiever                 | Women: "Summary educational achievement"                                       |
| edyrtotal                  | Women: "Total years education"                                                 |
| lit2                       | Women: "Literacy, based on reading passage"                                    |
| educlvl                    | Women: "Highest education level"                                               |
| newsfq                     | Women: "Frequency of reading newspaper or magazine"                            | 
| tvfq                       | Women: "Frequency of watching television"                                      |
| radiofq                    | Women: "Frequency of listening to radio"                                       |
| internetevyr               | Women: "Used the internet ever and in past year"                               |
| internetmo                 | Women: "Frequency of using internet in last month"                             |
| wkworklastyr               | Women: "Respondent worked recently"                                            |
| wkcurrjob                  | Women: "Woman's occupation"                                                    |
| whoworkfor                 | Women: "Whom the respondent works for"                                         |
| wkearntype                 | Women: "Type of earnings for respondent's work"                                | 
| wkemploywhen               | Women: "Respondent works all year, seasonally, or occasionally"                |
| inssocs                    | Women: "Has health insurance from government / social security"                |
| insemployer                | Women: "Has health insurance through employer"                                 |
| insorg                     | Women: "Has health insurance from mutual / community organization"             |
| insprivate                 | Women: "Has private / commercially purchased health insurance"                 |
| insother                   | Women: "Has health insurance from other source"                                |
| inscoveryn                 | Women: "Covered by health insurance"                                           |
| tocigfq                    | Women: "Frequency smokes cigarettes"                                           | 
| tosmoke                    | Women: "Smokes cigarettes"                                                     |
| tosnuff                    | Women: "Uses snuff"                                                            |
| topipe                     | Women: "Smokes pipe"                                                           |
| tocigar                    | Women: "Smokes cigars"                                                         |
| toshisha                   | Women: "Uses water pipe"                                                       |
| tosnuffm                   | Women: "Uses snuff by mouth"                                                   |
| tosnuffn                   | Women: "Uses snuff by nose"                                                    |
| tochew                     | Women: "Uses chewing tobacco"                                                  | 
| toghutka                   | Women: "Uses ghutka (betal quid with tobacco)"                                 |
| touseoth                   | Women: "Uses other tobacco"                                                    |
| tosmokeothfq               | Women: "Frequency smokes / uses non-cigarette tobacco product"                 |
| currmarr                   | Women: "Woman never, currently, or formerly married"                           |
| region variable geo_CCYEAR | Both: "Single sample geography variables"                                      |
| MEN AS UNIT OF ANALYSIS    |                                                                                |
| edachievermn               | Men: "Man's summary educational achievement"                                   |
| edyrtotalmn                | Men: "Man's total years of education"                                          |
| lit2mn                     | Men: "Literacy, based on reading passage"                                      |
| educlvlmn                  | Men: "Highest educational level"                                               |
| newsfqmn                   | Men: "Frequency of reading newspaper or magazine"                              |
| tvfqmn                     | Men: "Frequency of watching television"                                        | 
| radiofqmn                  | Men: "Frequency of listening to radio"                                         |
| internetevyrmn             | Men: "Used the internet ever and in past year"                                 |
| internetmomn               | Men: "Frequency of using internet in last month"                               |
| wkworklastyrmn             | Men: "Respondent worked recently"                                              |
| wkcurrjobmn                | Men: "Man's occupation"                                                        |
| whoworkformn               | Men: "Works for family, others, or self"                                       |
| wkearntypemn               | Men: "Type of earnings from respondent's work"                                 |
| wkemploywhenmn             | Men: "Respondent works all year, seasonally, or occasionally"                  | 
| inssocsmn                  | Men: "Health insurance type: government / social security"                     |
| insemployermn              | Men: "Health insurance type: through employer"                                 |
| insorgmn                   | Men: "Health insurance type: mutual / community organization"                  |
| insprivatemn               | Men: "Health insurance type: private / commercially purchased"                 |
| insothermn                 | Men: "Health insurance type: other"                                            |
| inscoverynmn               | Men: "Covered by health insurance"                                             |
| tociginddaymn              | Men: "Number of manufactured cigarettes usually smoke each day"                |
| tohandrolldaymn            | Men: "Number of hand-rolled cigarettes usually smoke each day"                 | 
| tokretekdaymn              | Men: "Number of kreteks usually smoke each day"                                |
| tocigindwkmn               | Men: "Number of manufactured cigarettes usually smoke each week"               |
| tohandrollwkmn             | Men: "Number of hand-rolled cigarettes usually smoke each week"                |
| tokretekwkmn               | Men: "Number of kreteks usually smoke each week"                               |
| tosmokemn                  | Men: "Current tobacco use: cigarettes"                                         |
| topipedaymn                | Men: "Number of pipes usually smoke each day"                                  |
| tocigardaymn               | Men: "Number of cigars, cheroots, or cigarellos usually smoke each day"        |
| toshishadaymn              | Men: "Number of hookah, shisha, or water pipe sessions usually have each day"  | 
| tosmokeothdaymn            | Men: "Number of times usually smoke other types of tobacco each day"           |
| topipewkmn                 | Men: "Number of pipes usually smoke each week"                                 |
| tocigarwkmn                | Men: "Number of cigars, cheroots, or cigarellos usually smoke each week"       |
| toshishawkmn               | Men: "Number of hookah, shisha, or water pipe sessions usually have each week" |
| tosmokeothwkmn             | Men: "Number of times usually smoke other types of tobacco each week"          |
| topipemn                   | Men: "Current tobacco use: pipe"                                               |
| touseothmn                 | Men: "Current tobacco use: other"                                              |
| tosmokefqmn                | Men: "Frequently currently smokes tobacco"                                     | 
| tosnuffmdaymn              | Men: "Times usually use snuff by mouth each day"                               |
| tosnuffmwkmn               | Men: "Times usually use snuff by mouth each week"                              |
| tosnuffndaymn              | Men: "Times usually use snuff by nose each day"                                |
| tosnuffnwkmn               | Men: "Times usually use snuff by nose each week"                               |
| tochewdaymn                | Men: "Times usually use chewing tobacco each day"                              |
| tochewwkmn                 | Men: "Times usually use chewing tobacco each week"                             |
| tobeteldaymn               | Men: "Times usually use betel quid with tobacco each day"                      |
| tobetelwkmn                | Men: "Times usually use betel quid with tobacco each week"                     | 
| tosmokelessdaymn           | Men: "Times usually use other smokeless tobacco each day"                      |
| tosmokelesswkmn            | Men: "Times usually use other smokeless tobacco each week"                     |
| tosmokelessfqmn            | Men: "Frequency uses smokeless tobacco"                                        |
| agemn                      | Men: "Age"                                                                     |
| age5yearmn                 | Men: "Age in 5-year groups"                                                    |
| urbanmn                    | Men: "Type of place of residence"                                              |
| wealthqmn                  | Men: "Household wealth in quintiles"                                           |
| marstatmn                  | Men: "Man's current marital or union status"                                   | 
| region variable geo_CCYEAR | Both: "Single sample geography variables"                                      |


