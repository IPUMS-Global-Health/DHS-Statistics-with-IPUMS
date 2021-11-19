# Child Health

Executing the main do file will generate tables using child health variables

- Tables_ARI_FV
- Tables_DIAR
- Tables_KnowORS
- Tables_Size
- Tables_Stool
- Tables_Vac

## How to Run
Download the IPUMS datasets with the variables required (listed down below). Inside the main do file, in the areas commented, add in the path to the women's data file and children's data file from IPUMS. Replace all GEO VARIABLE HERE comments in the main do file with the name of the geography variable associated with the datasets. Check IPUMS_CH_ARI_FV.do, IPUMS_CH_DIAR.do, and IPUMS_CH_VAC.do files for country specific variables and COMMENT OUT (DO NOT DELETE) variables that do not exist in your dataset. Tables will be created in current working directory.

## Known Issues
- birth order numbers and smoke variable numbers are incorrect

## Variables Required

### IPUMS_CH_ARI_FV.do
#### Note: Source of treatment variables are country specific. You must modify the code to include the variables that are available in your country.
#### Below are all the source of treatment variables that can be used.

| Variable                   | Description                                                                    |
|----------------------------|--------------------------------------------------------------------------------|
| CHILD AS UNIT OF ANALYSIS  | All variables from children data                                               |
| kidalive		               | "Child is alive"                                                               |
| fevtrewaitdays 	           | "Number of days after fever started advice/treatment was sought"               |
| couchestprob	             | "Child with cough has problem in chest or sinuses only"                        |
| courecent		               | "Child had cough/difficult breathing recently"                                 |
| coushortbre		             | "Child breathed with short, rapid breaths when had cough"                      |
| fevrecent		               | "Child had fever in last two/four weeks"                                       |
| fevtrpubhp		             | "Source of fever/cough treatment: Public health post"                          |
| fevtrprivdrug	             | "Source of fever/cough treatment: Private pharmacy, drug store, or dispensary" |
| fevtrpubhos		             | "Source of fever/cough treatment: Public hospital"                             |
| fevtrpubhc		             | "Source of fever/cough treatment: Public health center"                        |
| fevtrprivhos               | "Source of fever/cough treatment: Private hospital/clinic"                     |
| fevtrprivdr		             | "Source of fever/cough treatment: Private doctor"                              |
| fevtrpubmob		             | "Source of fever/cough treatment: Public mobile clinic"                        |
| fevtrpubfw		             | "Source of fever/cough treatment: Public fieldworker"                          |
| fevtrpuboth		             | "Source of fever/cough treatment: Other public source"                         |
| fevtrprivmob	             | "Source of fever/cough treatment: Private mobile clinic"                       |
| fevtrprivfw		             | "Source of fever/cough treatment: Private fieldworker"                         |
| fevtrprivoth	             | "Source of fever/cough treatment: Other private sector"                        |
| fevtrshop		               | "Source of fever/cough treatment: Shop (other                                  |
| fevtroth		               | "Source of fever/cough treatment: Other"                                       |

### IPUMS_CH_DIAR.do
#### Note: Source of treatment variables and treatment of diarrhea variables are country specific. You must modify the code to include the variables that are available in your country.
#### Below are all the available variables that can be used

| Variable                   | Description                                                                           |
|----------------------------|---------------------------------------------------------------------------------------|
| CHILD AS UNIT OF ANALYSIS  | All variables from children data                                                      |
| kidalive		               | "Child is alive"                                                                      |
| diarrecent		             | "Child had diarrhea recently"                                                         |
| diatrprivdr		             | "Source of diarrhea treatment: Private doctor"                                        |
| diatrpubhp		             | "Source of diarrhea treatment: Health post (public)"                                  |
| diatrprivmob	             | "Source of diarrhea treatment: Mobile clinic (private)"                               |
| diatrpubmob		             | "Source of diarrhea treatment: Mobile clinic (public)"                                |
| diatrenone		             | "Whether no treatment or advice sought for child's diarrhea"                          |
| diatrpubfw		             | "Source of diarrhea treatment: Fieldworker (public)"                                  |
| diatrprivhl		             | "Source of diarrhea treatment: Traditional Practitioner/Healer"                       |
| diatrpuboth		             | "Source of diarrhea treatment: Other public source"                                   |
| diatroth		               | "Source of diarrhea treatment: Other"                                                 |
| diatrpubhos		             | "Source of diarrhea treatment: Public hospital"                                       |
| diatrprivhos	             | "Source of diarrhea treatment: Private hospital/clinic"                               |
| diatrpubhc		             | "Source of diarrhea treatment: Public health center"                                  |
| diatrprivoth	             | "Source of diarrhea treatment: Other private source"                                  |
| diatrprivdrug	             | "Source of diarrhea treatment: Private pharmacy"                                      |
| diafluidupdn 	             | "Child fed the same, more, or less fluid with diarrhea"                               |
| diafoodupdn		             | "Child got same, increased, or decreased food with diarrhea"                          |
| diagivors		               | "Child given oral rehydration for diarrhea"                                           |
| diagivpplors	             | "Child given pre-packaged ORS liquid for diarrhea"                                    |
| diagivsolut		             | "Child given recommended home solution with salt and sugar for diarrhea"              |
| diagivzinc		             | "Child given zinc for diarrhea"                                                       |
| diagivinjantib	           | "Child given antibiotic injection for diarrhea"                                       |
| diagivpilsyr	             | "Child given pills or syrups (unspecified) for diarrhea"                              |
| diagivantim		             | "Child given antimotility for diarrhea"                                               |
| diagiviv		               | "Child given an IV for diarrhea"                                                      |
| diagivherb		             | "Child given home remedy or herbal medicine for diarrhea"                             |
| diagivothtyppil            | "Child given other type of pill (not antibiotic, antimotility, or zinc) for diarrhea" |
| diagivpilunk	             | "Child given unknown pill/syrup for diarrhea"                                         |
| diagivinjnonantib	         | "Child given non-antibiotic injection for diarrhea"                                   |
| diagivinjunk	             | "Child given unknown injection for diarrhea"                                          |
| diagivother		             | "Child given other treatment for diarrhea"                                            |
| diagivnone	               | "Child given nothing as treatment for diarrhea"                                       |


### IPUMS_CH_SIZE.do
| Variable                   | Description                                  |
|----------------------------|----------------------------------------------|
| CHILD AS UNIT OF ANALYSIS  | All variables from children data             |
| birthsz			               | "Size of child at birth (subjective report)" |
| birthwt			               | "Birthweight in kilos"                       |


### IPUMS_CH_STOOL.do
| Variable                   | Description                                                   |
|----------------------------|---------------------------------------------------------------|
| CHILD AS UNIT OF ANALYSIS  | All variables from children data                              |
| region variable geo_CCYEAR | "Single sample geography variables"                           |
| perweight		               | "Sample weight for persons"                                   |
| age				                 | "Age"                                                         |                    
| caseid			               | "Sample specific respondent identifier"                       |
| kidliveswith            	 | "Child lives with female respondent or others"                |
| disposestool	             | "Disposal of youngest child's stools (when not using toilet)" |


### IPUMS_CH_VAC.do
####Note: Pentavalent vaccine variable names could be either vacdptpen1, vacdptpen2, vacdptpen3 OR vacdpt1, vacdpt2, & vacdpt3 depending on the survey. VACDPTPEN variables are likely to be found in surveys that were administered in late 2012 or later. Change code accordingly.
| Variable                   | Description                                                            |
|----------------------------|------------------------------------------------------------------------|
| CHILD AS UNIT OF ANALYSIS  | All variables from children data                                       |
| kidalive		               | "Child is alive"                                                       |
| healthcardkid 	           | "Child has health card"                                                |
| vacbcg			               | "Child received BCG (TB) vaccination"                                  |
| vacdpt1 or vacdptpen1 		 | "Child received DPT (diphtheria, pertussis, tetanus) 1 vaccination" or |
|                            | "Child received DPT or Pentavalent (DPT-HepB-Hib) 1 vaccination"       |
| vacdpt2 or vacdptpen2 		 | "Child received DPT (diphtheria, pertussis, tetanus) 2 vaccination" or |
|                            | "Child received DPT or Pentavalent (DPT-HepB-Hib) 2 vaccination"       |
| vacdpt3 or vacdptpen3 		 | "Child received DPT (diphtheria, pertussis, tetanus) 3 vaccination" or |
|                            | "Child received DPT or Pentavalent (DPT-HepB-Hib) 3 vaccination"       |
| vacopv0		                 | "Child received oral polio 0 vaccination"                              |
| vacopv1			               | "Child received oral polio 1 vaccination"                              |
| vacopv2			               | "Child received oral polio 2 vaccination"                              |
| vacopv3						         | "Child received oral polio 3 vaccination"                              |
| vacpneum1		               | "Child received pneumococcal 1 vaccination"                            |
| vacpneum2		               | "Child received pneumococcal 2 vaccination"                            |
| vacpneum3		               | "Child received pneumococcal 3 vaccination"                            |
| vacrota1		               | "Child received rotavirus 1 vaccination"                               |
| vacrota2		               | "Child received rotavirus 2 vaccination"                               |
| vacrota3		               | "Child received rotavirus 3 vaccination"                               |
| vacmeas1		               | "Child received measles (or measles containing) 1 vaccination"         |

### IPUMS_CH_KNOW_ORS.do
| Variable                   | Description                                   |
|----------------------------|-----------------------------------------------|
| diatrorsheard              | Women: "Heard of ORS for diarrhea treatment"  |
| birthsin5yrs               | Women: "Number of births in last 5 years"     |
