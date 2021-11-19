/*******************************************************************************************************************************
Program: 				CHmain.do
Purpose: 				Main file for the Child Health Chapter. 
						The main file will call other do files that will produce the CH indicators and produce tables.
Data outputs:			coded variables and table output on screen and in excel tables.  
Author: 				Shireen Assaf	modified by Amber Nguyen for this project
Date last modified:		May 14 2019 by Shireen Assaf

*******************************************************************************************************************************/

/* Variables used: 
***children variables: ***
region variable geo_CCYEAR		"Single sample geography variables"
age				"Age"
perweight		"Sample weight for persons"
bfeedanynow		"Women currently breastfeeding any child"
kidbord			"Child's birth order number"
kidsex			"Sex of Child"
kidalive		"Child is alive"
kiddobcmc		"Child's date of birth (CMC)"
dobcmc			"Respondent's date of birth in century months"
** smoking variables country specific, check which ones are avail for country **
tosmoke			"Smokes cigarettes"
tosnuff			"Uses snuff"
tocigar			"smoke's cigars"
touseoth		"uses other tobacco"
topipe			"Smokes pipe"
toshisha		"Uses water pipe"
toghutka		"Uses ghutka (betal quid with tobacco)"
cookfuel		"Type of fuel household uses for cooking"
urban			"Urban-rural status"
educlvl			"Highest educational level"
wealthq			"Household wealth index in quintiles"

caseid			"Sample specific respondent identifier"
kidliveswith	"Child lives with female respondent or others"
disposestool	"Disposal of youngest child's stools (when not using toilet)"

birthsz			"Size of child at birth (subjective report)"
birthwt			"Birthweight in kilos"

healthcardkid 	"Child has health card"
vacbcg			"Child received BCG (TB) vaccination"
** check which var country uses for vacdpt **
vacdpt1 or vacdptpen1 		"Child received DPT (diphtheria, pertussis, tetanus) 1 vaccination" or "Child received DPT or Pentavalent (DPT-HepB-Hib) 1 vaccination"
vacdpt2 or vacdptpen2 		"Child received DPT (diphtheria, pertussis, tetanus) 2 vaccination" or "Child received DPT or Pentavalent (DPT-HepB-Hib) 2 vaccination"
vacdpt3 or vacdptpen3 		"Child received DPT (diphtheria, pertussis, tetanus) 3 vaccination" or "Child received DPT or Pentavalent (DPT-HepB-Hib) 3 vaccination"
vacopv0			"Child received oral polio 0 vaccination"
vacopv1			"Child received oral polio 1 vaccination"
vacopv2			"Child received oral polio 2 vaccination"
vacopv3			"Child received oral polio 3 vaccination"
*** vacpneum is country specific ***
vacpneum1		"Child received pneumococcal 1 vaccination"
vacpneum2		"Child received pneumococcal 2 vaccination"
vacpneum3		"Child received pneumococcal 3 vaccination"
*** vacrota is country specific ***
vacrota1		"Child received rotavirus 1 vaccination"
vacrota2		"Child received rotavirus 2 vaccination"
vacrota3		"Child received rotavirus 3 vaccination"
vacmeas1		"Child received measles (or measles containing) 1 vaccination"

fevtrewaitdays 	"Number of days after fever started advice/treatment was sought"
couchestprob	"Child with cough has problem in chest or sinuses only"
courecent		"Child had cough/difficult breathing recently"
coushortbre		"Child breathed with short, rapid breaths when had cough"
fevrecent		"Child had fever in last two/four weeks"
** following variables are country specific, check which variables country has **
fevtrpubhp		"Source of fever/cough treatment: Public health post"
fevtrprivdrug	"Source of fever/cough treatment: Private pharmacy, drug store, or dispensary"
fevtrpubhos		"Source of fever/cough treatment: Public hospital"
fevtrpubhc		"Source of fever/cough treatment: Public health center"
fevtrprivhos	"Source of fever/cough treatment: Private hospital/clinic"
fevtrprivdr		"Source of fever/cough treatment: Private doctor"
fevtrpubmob		"Source of fever/cough treatment: Public mobile clinic"
fevtrpubfw		"Source of fever/cough treatment: Public fieldworker"
fevtrpuboth		"Source of fever/cough treatment: Other public source"
fevtrprivmob	"Source of fever/cough treatment: Private mobile clinic"
fevtrprivfw		"Source of fever/cough treatment: Private fieldworker"
fevtrprivoth	"Source of fever/cough treatment: Other private sector"
fevtrshop		"Source of fever/cough treatment: Shop (other)"
fevtroth		"Source of fever/cough treatment: Other"
**

diarrecent		"Child had diarrhea recently"
** following variables are country specific, check which variables country has **
diatrprivdr		"Source of diarrhea treatment: Private doctor"
diatrpubhp		"Source of diarrhea treatment: Health post (public)"
diatrprivmob	"Source of diarrhea treatment: Mobile clinic (private)"
diatrpubmob		"Source of diarrhea treatment: Mobile clinic (public)"
diatrenone		"Whether no treatment or advice sought for child's diarrhea"
diatrpubfw		"Source of diarrhea treatment: Fieldworker (public)"
diatrprivhl		"Source of diarrhea treatment: Traditional Practitioner/Healer"
diatrpuboth		"Source of diarrhea treatment: Other public source"
diatroth		"Source of diarrhea treatment: Other"
diatrpubhos		"Source of diarrhea treatment: Public hospital"
diatrprivhos	"Source of diarrhea treatment: Private hospital/clinic"
diatrpubhc		"Source of diarrhea treatment: Public health center"
diatrprivoth	"Source of diarrhea treatment: Other private source"
diatrprivdrug	"Source of diarrhea treatment: Private pharmacy"
diafluidupdn 	"Child fed the same, more, or less fluid with diarrhea"
diafoodupdn		"Child got same, increased, or decreased food with diarrhea"
diagivors		"Child given oral rehydration for diarrhea"
diagivpplors	"Child given pre-packaged ORS liquid for diarrhea"
diagivsolut		"Child given recommended home solution with salt and sugar for diarrhea"
diagivzinc		"Child given zinc for diarrhea"
diagivinjantib	"Child given antibiotic injection for diarrhea"
diagivpilsyr	"Child given pills or syrups (unspecified) for diarrhea"
diagivantim		"Child given antimotility for diarrhea"
diagiviv		"Child given an IV for diarrhea"
diagivherb		"Child given home remedy or herbal medicine for diarrhea"
diagivothtyppil "Child given other type of pill (not antibiotic, antimotility, or zinc) for diarrhea"
diagivpilunk	"Child given unknown pill/syrup for diarrhea"
diagivinjnonantib	"Child given non-antibiotic injection for diarrhea"
diagivinjunk	"Child given unknown injection for diarrhea"
diagivother		"Child given other treatment for diarrhea"
diagivnone		"Child given nothing as treatment for diarrhea"

***Women variables: ***
region variable geo_CCYEAR		"Single sample geography variables"
perweight		"Sample weight for persons"
age				"Age"
age5year		"Age in 5 year groups"
urban			"Urban-rural status"
educlvl			"Highest educational level"
wealthq			"Household wealth index in quintiles"
diatrorsheard	"Heard of ORS for diarrhea treatment"
birthsin5yrs	"Number of births in last 5 years"

----------------------------------------------------------------
Variables created:

*/
set more off

* select your survey

* KR Files
global krdata "PATH TO CHILDREN DATA FILE"
* MMKR71FL TJKR70FL GHKR72FL UGKR7AFL

* IR Files
global irdata "PATH TO WOMEN DATA FILE"
* MMIR71FL TJIR70FL GHIR72FL UGIR7AFL
****************************

* KR file variables

* open dataset
use "$krdata", clear

gen file="$krdata"
clonevar regionkr = /* INSERT REGION VARIABLE HERE */

*** Child's age ***
gen age = intdatecmc - kiddobcmc
	* to check if survey has kidcuragemo, which should be used instead to compute age. 
	scalar kidcuragemo_included=0
		capture confirm numeric variable kidcuragemo, exact 
		if _rc>0 {
		* kidcuragemo is not present
		scalar intdatecmc_included=0
		}
		if _rc==0 {
		* kidcuragemo is present; check for values
		summarize kidcuragemo
		  if r(sd)==0 | r(sd)==. {
		  scalar kidcuragemo_included=0
		  }
		}
	if kidcuragemo_included==1 {
	drop age
	gen age=kidcuragemo
	}
**************************
	
do IPUMS_CH_SIZE.do
*Purpose: 	Code child size indicators

do IPUMS_CH_ARI_FV.do
// *Purpose: 	Code ARI indicators

do IPUMS_CH_DIAR.do
*Purpose: 	Code diarrhea indicators

do IPUMS_CH_tables.do
*Purpose: 	Produce tables for indicators computed from above do files. 

do IPUMS_CH_VAC.do
*Purpose: 	Code vaccination indicators
*Note: This do file drops children that are not in a specific age group. 

do IPUMS_CH_tables_vac.do
*Purpose: 	Produce tables for vaccination indicators.

do IPUMS_CH_STOOL.do
// Purpose:	Safe disposal of stool
// Notes:				This do file will drop cases. 
// 					This is because the denominator is the youngest child under age 2 living with the mother. 			
// 					The do file will also produce the tables for these indicators. 


*******************************************************************************************************************************
*******************************************************************************************************************************

* IR file variables

* open dataset
use "$irdata", clear

gen file="$irdata"
clonevar regionir = /* INSERT REGION VARIABLE HERE */

do IPUMS_CH_KNOW_ORS.do
*Purpose: 	Code knowledge of ORS

do IPUMS_CH_tables.do
*Purpose: 	Produce tables for indicators computed from above do files. 


*******************************************************************************************************************************
*******************************************************************************************************************************

