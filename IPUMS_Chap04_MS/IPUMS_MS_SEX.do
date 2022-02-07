/*******************************************************************************
Program: 			        IPUMS_MS_SEX.do
Purpose: 			        Code to use sexual activity indicators
Data inputs: 		      IPUMS DHS First or ever sexual experience variables
Data outputs:		      Variables with no missing values
Author:			  	      Courtney Allen, modified by Faduma Shaba and Maggie Tran for this project
Date last modified:   	January 2021
Note:
*********************************************************************************/

/*----------------------------------------------------------------------------
Variables used in this file:

age1stseximp				Women's: "Age at first intercourse (imputed)"
wealthq						Women: "Household wealth index in quintiles"
edachiever 					Women: "Summary educational achievement"
urban 						Women: "Urban-rural status"
perweight 					Women: "Sample weight for persons"
region variable geo_CCYEAR	"Single sample geography variables"

age1stseximpmn	  			Men's: "Age at first intercourse (imputed)"
wealthqmn					Men: "Household wealth index in quintiles"
edachievermn				Men: "Man's summary educational achievement"
urbanmn						Men: "Type of place of residence"
perweightmn					Men: "Men's sample weight"
region variable geo_CCYEAR	"Single sample geography variables"
----------------------------------------------------------------------------
Variables created in this file:
age1stseximp_never		Women's: "Never had sex"
age1stseximp_15			Women's: "First sex by 15"
age1stseximp_18			Women's: "First sex by 18"
age1stseximp_20			Women's: "First sex by 20"
age1stseximp_22			Women's: "First sex by 22"
age1stseximp_25			Women's: "First sex by 25"

age1stseximpmn_never	Men's: "Never had sex"
age1stseximpmn_15		Men's: "First sex by 15"
age1stseximpmn_18		Men's: "First sex by 18"
age1stseximpmn_20		Men's: "First sex by 20"
age1stseximpmn_22		Men's: "First sex by 22"
age1stseximpmn_25		Men's: "First sex by 25"
*/

program define calc_median_age // consider separating out the calc_median_age function

local subgroup region education wealth residence all

foreach y in `subgroup' {
	levelsof `y', local(`y'lv)
	foreach x of local `y'lv {
	
local a= beg_age
local b= end_age
cap summarize age_new [fweight=weightvar] if agevar>= beg_age & agevar<= end_age & `y'==`x', detail

scalar sp50=r(p50)

gen dummy=.
replace dummy=0 if agevar>= beg_age & agevar<= end_age & `y'==`x'
replace dummy=1 if agevar>= beg_age & agevar<= end_age & `y'==`x' & age_new<sp50 
summarize dummy [fweight=weightvar]
scalar sL=r(mean)

replace dummy=.
replace dummy=0 if agevar>= beg_age & agevar<= end_age &`y'==`x'
replace dummy=1 if agevar>= beg_age & agevar<= end_age & `y'==`x' & age_new<=sp50
summarize dummy [fweight=weightvar]
scalar sU=r(mean)
drop dummy

scalar smedian=round(sp50+(.5-sL)/(sU-sL),.01)
scalar list sp50 sL sU smedian



// warning if sL and sU are miscalculated
if sL>.5 | sU<.5 {
//ERROR IN CALCULATION OF L AND/OR U
}

//create variable for median
gen mafs_`a'`b'_`y'`x'=smedian 

//label subgroup categories
	label var mafs_`a'`b'_`y'`x' "Median age at first sex among `a' to `b' yr olds, `y'"

	if "`y'" != "all" {
	local lab_val: value label `y'
	local lab_cat : label `lab_val' `x'
	label var mafs_`a'`b'_`y'`x' "Median age at first sex among `a' to `b' yr olds, `y': `lab_cat'"
	}
	
	//replace median with O and label "NA" if no median can be calculated for age group
	replace mafs_`a'`b'_`y'`x' = 0 if mafs_`a'`b'_`y'`x'>beg_age
	if mafs_`a'`b'_`y'`x' ==0 {
	label val mafs_`a'`b'_`y'`x' NA
	}

}
}


scalar drop smedian

end
*********************************************************************************

capture confirm variable age1stseximpmn
if !_rc {
//Men's variables in IPUMS DHS


//Median age at first sex
	//make subgroups here//
	gen all = 1
	clonevar region = regionmn
	clonevar wealth = wealthqmn
	clonevar education = edachievermn
	clonevar residence = urbanmn
	label define NA 0 "NA" //for sub groups where no median can be defined

	
	//setup variables for median age at first sex calculated from v531, for women age 20 to 49
	gen afs=age1stseximpmn
	replace afs=99 if age1stseximpmn==0
	gen age_new=afs
	gen agevar = agemn
	tostring(perweightmn), gen(weightvar)
	replace weightvar=subinstr(weightvar,".","",.)
	destring weightvar, replace

	//create median age at first sex for each 5 yr age group - Men typically have higher age groups
	tokenize 	  19 24 29 34 39 44 49 49 49 59 59 59
	foreach x in  15 20 25 30 35 40 45 20 25 20 25 30{
				scalar beg_age = `x'
				scalar end_age = `1'
				calc_median_age
				
				macro shift
				}
				
//Never had sex
recode age1stseximpmn (96=.) (98=.) (97 .=0) (0 = 1 "yes") (1/max = 0 "no"), gen (age1stseximpmn_never)
label var age1stseximpmn_never "Never had sex"

***Had sex by specific ages***

//First sex by age 15
//recode age1stseximpmn (96=.) (98=.) (97 .=0) (1/14 = 1 "yes") (15/49 = 0 "no"), gen (age1stseximpmn_15)
recode age1stseximpmn (96 .=0) (1/14 = 1 "yes") (15/max = 0 "no"), gen (age1stseximpmn_15)
label var age1stseximpmn_15 "First sex by age 15"

//First sex by age 18
//recode age1stseximpmn (96=.) (98=.) (97 .=0) (1/17 = 1 "yes") (18/49 = 0 "no"), gen (age1stseximpmn_18)
recode age1stseximpmn (96 .=0) (1/17 = 1 "yes") (18/max = 0 "no"), gen (age1stseximpmn_18)
replace age1stseximpmn_18 = . if agemn<18
label var age1stseximpmn_18 "First sex by age 18"

//First sex by age 20
//recode age1stseximpmn (96=.) (98=.) (97 .=0) (1/19 = 1 "yes") (20/49 = 0 "no"), gen (age1stseximpmn_20)
recode age1stseximpmn (96 .=0) (1/19 = 1 "yes") (20/max = 0 "no"), gen (age1stseximpmn_20)
replace age1stseximpmn_20 = . if agemn<20
label var age1stseximpmn_20 "First sex by age 20"

//First sex by age 22
//recode age1stseximpmn (96=.) (98=.) (97 .=0) (1/21 = 1 "yes") (22/49 = 0 "no"), gen (age1stseximpmn_22)
recode age1stseximpmn (96 .=0) (1/21 = 1 "yes") (22/max = 0 "no"), gen (age1stseximpmn_22)
replace age1stseximpmn_22 = . if agemn<22
label var age1stseximpmn_22 "First sex by age 22"

//First sex by age 25
//recode age1stseximpmn (96=.) (98=.) (97 .=0) (1/24 = 1 "yes") (25/49 = 0 "no"), gen (age1stseximpmn_25)
recode age1stseximpmn (96 .=0) (1/24 = 1 "yes") (25/max = 0 "no"), gen (age1stseximpmn_25)
replace age1stseximpmn_25 = . if agemn<25
label var age1stseximpmn_25 "First sex by age 25"

drop all region residence education wealth age_new agevar weightvar
label drop NA

} 
else {
	//Women's variables in IPUMS DHS
//Median age at first sex
	//make subgroups here//
	gen all = 1
	clonevar region = regionwm // region geo var
	clonevar wealth = wealthq
	clonevar education = edachiever
	clonevar residence = urban
	label define NA 0 "NA" //for sub groups where no median can be defined

	
	//setup variables for median age at first sex calculated from v531, for women age 20 to 49
	gen afs=age1stseximp
	replace afs=99 if age1stseximp==0 
	gen age_new =afs
	gen agevar = age
	tostring(perweight), gen(weightvar)
	replace weightvar=subinstr(weightvar,".","",.)
	destring weightvar, replace

	//create median age at first sex for each 5 yr age group
	tokenize 	  19 24 29 34 39 44 49 49 49
	foreach x in  15 20 25 30 35 40 45 20 25 {
				scalar beg_age = `x'
				scalar end_age = `1'
				calc_median_age
				
				macro shift
				}

//Never had sex
recode age1stseximp (96=.) (98=.) (97 .=0) (0 = 1 "yes") (1/49 = 0 "no"), gen (age1stseximp_never)
label var age1stseximp_never "Never had sex"		
				
***Had sex by specific ages***

//First sex by age 15
//recode age1stseximp (96=.) (98=.) (97 .=0)(1/14 = 1 "yes") (15/49 = 0 "no"), gen (age1stseximp_15)
recode age1stseximp (96 .=0) (98 .=0) (1/14 = 1 "yes") (15/49 = 0 "no"), gen (age1stseximp_15)
label var age1stseximp_15 "First sex by age 15"

//First sex by age 18
//recode age1stseximp (96=.) (98=.) (97 .=0) (1/17 = 1 "yes") (18/49 = 0 "no"), gen (age1stseximp_18)
recode age1stseximp (96 .=0) (98 .=0) (1/17 = 1 "yes") (18/49 = 0 "no"), gen (age1stseximp_18)
replace age1stseximp_18 = . if age<18
label var age1stseximp_18 "First sex by age 18"

//First sex by age 20
//recode age1stseximp (96=.) (98=.) (97 .=0) (1/19 = 1 "yes") (20/49 = 0 "no"), gen (age1stseximp_20)
recode age1stseximp (96 .=0) (98 .=0) (1/19 = 1 "yes") (20/49 = 0 "no"), gen (age1stseximp_20)
replace age1stseximp_20 = . if age<20
label var age1stseximp_20 "First sex by age 20"

//First sex by age 22
//recode age1stseximp (96=.) (98=.) (97 .=0) (1/21 = 1 "yes") (22/49 = 0 "no"), gen (age1stseximp_22)
recode age1stseximp (96 .=0) (98 .=0) (1/21 = 1 "yes") (22/49 = 0 "no"), gen (age1stseximp_22)
replace age1stseximp_22 = . if age<22
label var age1stseximp_22 "First sex by age 22"

//First sex by age 25
//recode age1stseximp (96=.) (98=.) (97 .=0) (1/24 = 1 "yes") (25/49 = 0 "no"), gen (age1stseximp_25)
recode age1stseximp (96 .=0) (98 .=0) (1/24 = 1 "yes") (25/49 = 0 "no"), gen (age1stseximp_25)
replace age1stseximp_25 = . if age<25
label var age1stseximp_25 "First sex by age 25"

drop all region residence education wealth age_new agevar weightvar
label drop NA

}
