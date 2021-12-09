/*****************************************************************************************************
Program: 			        IPUMS_PH_SCHOL.do
Purpose: 			        Code to compute school attendance indicators
Data inputs: 		      		IPUMS DHS Household Variables
Data outputs:		      		coded variables
Author:				        Trevor Croft and Shireen Assaf, modified by Faduma Shaba and Kassandra Fate for this project
Date last modified:   			July 2021
Note:					To produce the net attendance ratios you need to provide country specific information on the year 
						and month of the school calendar and the age range for school attendance. See lines 94-105.
*****************************************************************************************************/

/* DIRECTIONS
1. Create a data extract at dhs.ipums.org that includes the IPUMS variables listed below.
2. On lines 211, 216, 221, and 226 below, replace "GEO-REGION" with your sample's region variable name.
	In IPUMS DHS, each survey's region variable has a unique name to facilitate
	pooling data. These variables can be found in the IPUMS drop down menu under:
		GEOGRAPHY -> SINGLE SAMPLE GEOGRAPHY */
/*----------------------------------------------------------------------------
IPUMS variables used in this file:
Birth File:
clusterno
hhnum
lineno
kiddobcmc
linenokid

Household File:
GEO-REGION variables *see line 14*
hhlineno
hhweight
wealthqhh
urbanhh
idhshid
linenokid
kiddobcmc
hhage
hhslept
hhintcmc
edlevelnow
sex

*----------------------------------------------------------------------------
Variables created in this file:
ph_sch_nar_prim			"Primary school net attendance ratio (NAR)"
ph_sch_nar_sec			"Secondary school net attendance ratio (NAR)"
ph_sch_gar_prim			"Primary school gross attendance ratio (GAR)"
ph_sch_gar_sec			"Secondary school gross attendance ratio (GAR)"
ph_sch_nar_prim_*_gpi		"Gender parity index for NAR primary"
ph_sch_nar_sec_*_gpi		"Gender parity index for NAR secondary"
ph_sch_gar_prim_*_gpi		"Gender parity index for GAR primary"
ph_sch_gar_sec_*_gpi		"Gender parity index for GAR secondary"
----------------------------------------------------------------------------*/
* For net attendance rates (NAR) and gross attendance rates (GAR) we need to know the age of children at the start of the school year.
* For this we need to get date of birth from birth history and attach to children's records in the household file.
* open the birth history data to extract date of birth variables needed.
use "$datapath//$birthdata.dta", clear

* keep only the variables we need
keep clusterno hhnum lineno kiddobcmc linenokid

* drop if the child in the birth history was not in the household or not alive
drop if linenokid==0 | linenokid==.

* rename key variables for matching
rename linenokid hhlineno
rename clusterno idhspsu
rename hhnum hhnumall

* sort on key variables
sort idhspsu hhnumall hhlineno

* if there are some duplicates of line number in household questionnaire, we need to drop the duplicates
gen dup = (idhspsu == idhspsu[_n-1] & hhlineno == hhlineno[_n-1])
drop if dup==1
drop dup

* re-sort to make sure still sorted
sort idhspsu hhnumall hhlineno

* save a temporary file for merging
save tempBR, replace

* use the file for household members for the NAR and GAR indicators
use "$datapath//$householddata.dta", clear

* merge in the date of birth from the women's birth history for the household member
merge 1:1 idhspsu hhnumall hhlineno using tempBR

* there are a few mismatches of line numbers (typically a small number of cases) coming from the Birth file, so let's drop those
drop if _merge==2

* restrict to de facto household members age 5-24, and drop all others
keep if hhslept==1 & inrange(hhage,5,24)

* now we calculate the child's age at the start of the school year
* but first we have to specify the month and year of the start of the school year referred to in the survey
* example, for Zimbabwe 2015 survey this was January 2015
global school_start_yr = 2015
global school_start_mo = 1

* also need the age ranges for primary and secondary
* example, for Zimbabwe 2015, the age range is 6-12 for primary school and 13-18 for secondary school
global age_prim_min = 6
global age_prim_max = 12
global age_sec_min = 13
global age_sec_max = 18

* produce century month code of start of school year for each state and phase
gen cmcSch = ($school_start_yr - 1900)*12 + $school_start_mo

* calculate the age at the start of the school year, using the date of birth from the birth history if we have it
gen school_age = int((cmcSch - kiddobcmc) / 12) if kiddobcmc != .

* Impute an age at the beginning of the school year when CMC of birth is unknown
* the random imputation below means that we won't get a perfect match with the report, but it will be close
gen xtemp = hhintcmc - (hhage * 12) if kiddobcmc == .
gen cmctemp = xtemp - int(uniform()*12) if kiddobcmc == .
replace school_age = int((cmcSch - cmctemp) / 12) if kiddobcmc == .

* Generate variables for whether the child is in the age group for primary or seconary school
gen prim_age = inrange(school_age,$age_prim_min,$age_prim_max)
gen sec_age  = inrange(school_age,$age_sec_min ,$age_sec_max )

* create the school attendance variables, not restricted by age
gen prim = (edlevelnow == 1)
gen sec  = (edlevelnow == 2)

* set sample weight
cap gen wt = hhweight

* For NAR we can use this as just regular variables and can tabulate as follows, but can't do this for GAR as the numerator is not a subset of the denominator
* NAR is just the proportion attending primary/secondary school of children in the correct age range, for de facto children
gen nar_prim = prim if prim_age == 1
gen nar_sec  = sec  if sec_age  == 1
lab var nar_prim	"Primary school net attendance ratio (NAR)"
lab var nar_sec	"Secondary school net attendance ratio (NAR)"

* tabulate primary school attendance
tab sex nar_prim [iw=wt] , row
tab urbanhh nar_prim [iw=wt] , row

* tabulate secondary school attendance
tab sex nar_sec [iw=wt] , row
tab urbanhh nar_sec [iw=wt] , row

* Program for calculating NAR or GAR
* NAR just uses a mean of one variable
* GAR uses a ratio of two variables
* Program to produce NAR or GAR for background characteristics (including total) for both sex, combined and separately
cap program drop nar_gar
program define nar_gar
  * parameters
  * type of rate - nar or gar
  * type of schooling - prim or sec
  * background variable for disaggregation
  * generates variables of the following format
  * ph_sch_`rate'_`sch'_`backvar'_`sex'
  * e.g. ph_sch_nar_prim_total_0
  * or   ph_sch_gar_sec_urbanhh_2
  * sex: 0 = both sexes combined, 1=male, 2=female
  * type of rate - nar or gar
  local rate `1'
  if "`rate'" != "nar" & "`rate'" != "gar" {
	di as error "specify type of rate as nar or gar"
	exit 198
  }
  * type of schooling - prim or sec only
  local sch `2'
  if "`sch'" != "prim" & "`sch'" != "sec" {
	di as error "specify schooling as prim or sec"
	exit 198
  }
  * name of background variable
  local backvar `3'
  * do for total = 0, and each sex male = 1, female = 2
  foreach sex in 0 1 2 {
    if `sex' == 0 local select 0==0 /* always true */
    else          local select sex==`sex'
	if "`rate'" == "nar" { /* Net Attendance Rate (NAR) */
	  mean `sch' [iw=wt] if `select' & `sch'_age == 1, over(`backvar')
	  * results matrix for mean - used for NAR
	  mat x = e(b)
	}
	else { /* Gross Attendance Rate (GAR) */
      ratio `sch' / `sch'_age [iw=wt] if `select', over(`backvar')
	  * results matrix for ratio - used for GAR
      mat x = r(table)
	}
	* generate the output variable we will fill
    gen ph_sch_`rate'_`sch'_`backvar'_`sex' = .
	* get all of the characteristics of the background variable
    cap levelsof `backvar'
    local ix = 1
    local lev `r(levels)'
	* loop through the characteristics and get the result from matrix x
    foreach i in `lev' {
	  * capture the result for this characteristic
      replace ph_sch_`rate'_`sch'_`backvar'_`sex' = 100*x[1,`ix'] if `backvar' == `i'
      local ix = `ix' + 1
    }
	* label the resulting variable
	local schooling primary
	if "`sch'" == "sec" local schooling secondary
	local sexlabel both sexes
	if `sex' == 1 local sexlabel males
	if `sex' == 2 local sexlabel females
	lab var ph_sch_`rate'_`sch'_`backvar'_`sex' "`rate' for `schooling' education for background characteristic `backvar' for `sexlabel'"
  }
  * gender parity index for a rate for a characteristic - female (2) rate divided by male (1) rate
  gen ph_sch_`rate'_`sch'_`backvar'_gpi = 100 * (ph_sch_`rate'_`sch'_`backvar'_2 / ph_sch_`rate'_`sch'_`backvar'_1)
  lab var ph_sch_`rate'_`sch'_`backvar'_gpi "gender parity index for `rate' for `schooling' education for background characteristic `backvar'"
end
* create total background characteristic
gen total = 0
lab var total "total"
* Caculate indicators and save them in the dataset
nar_gar nar prim total /* NAR primary   - total population */
nar_gar nar prim urbanhh /* NAR primary   - urban/rural */
nar_gar nar prim GEO-REGION /* NAR primary   - region */
nar_gar nar prim wealthqhh /* NAR primary   - wealth index */

nar_gar nar sec  total /* NAR secondary - total population */
nar_gar nar sec  urbanhh /* NAR secondary - urban/rural */
nar_gar nar sec  GEO-REGION /* NAR secondary - region */
nar_gar nar sec  wealthqhh /* NAR secondary - wealth index */

nar_gar gar prim total /* GAR primary   - total population */
nar_gar gar prim urbanhh /* GAR primary   - urban/rural */
nar_gar gar prim GEO-REGION /* GAR primary   - region */
nar_gar gar prim wealthqhh /* GAR primary   - wealth index */

nar_gar gar sec  total /* GAR secondary - total population */
nar_gar gar sec  urbanhh /* GAR secondary - urban/rural */
nar_gar gar sec  GEO-REGION /* GAR secondary - region */
nar_gar gar sec  wealthqhh /* GAR secondary - wealth index */

* Dividing GPI indicators by 100
foreach x in ph_sch_nar_prim_total_gpi ph_sch_nar_prim_urbanhh_gpi ph_sch_nar_prim_GEO-REGION_gpi ph_sch_nar_prim_wealthqhh_gpi ph_sch_nar_sec_total_gpi ph_sch_nar_sec_urbanhh_gpi ph_sch_nar_sec_GEO-REGION_gpi ph_sch_nar_sec_wealthqhh_gpi  ph_sch_gar_prim_total_gpi ph_sch_gar_prim_urbanhh_gpi ph_sch_gar_prim_GEO-REGION_gpi ph_sch_gar_prim_wealthqhh_gpi ph_sch_gar_sec_total_gpi ph_sch_gar_sec_urbanhh_gpi ph_sch_gar_sec_GEO-REGION_gpi ph_sch_gar_sec_wealthqhh_gpi {
	replace `x'=`x'/100
}
erase tempBR.dta
*****************************************************************************************************
*****************************************************************************************************
*Tabulating indicators by background variables and exporting estimates to excel table Tables_edu
*the tabulations will provide the estimates for the indicators for the total, males, and females and by urbanhh, GEO-REGION, and wealthqhh
//Primary school net attendance ratio (NAR) and gender parity index
tab1 ph_sch_nar_prim* [iw=wt]
tabout ph_sch_nar_prim* using Tables_schol.xls [iw=wt] , oneway cells(cell) replace

//Secondary school net attendance ratio (NAR) and gender parity index
tab1 ph_sch_nar_sec* [iw=wt]
tabout ph_sch_nar_sec* using Tables_schol.xls [iw=wt] , oneway cells(cell) append

//Primary school gross attendance ratio (GAR) and gender parity index
tab1 ph_sch_gar_prim* [iw=wt]
tabout ph_sch_gar_prim* using Tables_schol.xls [iw=wt] , oneway cells(cell) append

//Secondary school gross attendance ratio (GAR) and gender parity index
tab1 ph_sch_gar_sec* [iw=wt]
tabout ph_sch_gar_sec* using Tables_schol.xls [iw=wt] , oneway cells(cell) append
