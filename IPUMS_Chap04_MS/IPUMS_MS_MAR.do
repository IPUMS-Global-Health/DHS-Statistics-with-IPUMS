/*******************************************************************************
Program: 			      IPUMS_MS_MAR.do
Purpose: 			      Code to use marital indicators
Data inputs:			      IPUMS DHS marriage and cohabitation variables
Data outputs:		    	      Variables with no missing values
Author:				      Thomas Pullum and Courtney Allen, modified by Faduma Shaba and Maggie Tran for this project
Date last modified: 	  January 2021
Note:
*********************************************************************************/

/*----------------------------------------------------------------------------
Variables used in this file:

marstat						Women: "Current marital status"
wifenum						Women: "Number of other co-wives"
agefrstmar					Women: "Age at first marriage or cohabitation"
urban						Women: "Urban-rural status"
wealthq						Women: "Household wealth index in quintiles"			
edachiever 					Women: "Summary educational achievement"
perweight 					Women: "Sample weight for persons"
age 						Women: "Age"
region variable geo_CC_YEAR	"Single sample geography variables"

marstatmn					Men: "Current martial status"
wifenummn					Men: "Number of other wives"
age1stmarmn					Men: "Age at first marriage or cohabitation"
urbanmn						Men: "Type of place of residence"
wealthqmn					Men: "Household wealth index in quintiles"
edachievermn				Men: "Man's summary educational achievement"
perweightmn					Men: "Men's sample weight"
agemn						Men: "Age"
region variable geo_CCYEAR	"Single sample geography variables"


Variables created:
ms_cowives_any "One or more co-wives"
marstat_never "Never Married"
agefrstmar_15 "First marriage/cohabitation by 15"
agefrstmar_18 "First marriage/cohabitation by 18"
agefrstmar_20 "First marriage/cohabitation by 20"
agefrstmar_22 "First marriage/cohabitation by 22"
agefrstmar_25 "First marriage/cohabitation by 25"
ms_mar_union "Currently in union"

ms_cowives_anymn "One or more co-wives"
marstat_nevermn "Never Married"
agefrstmar_15mn "First marriage/cohabitation by 15"
agefrstmar_18mn "First marriage/cohabitation by 18"
agefrstmar_20mn "First marriage/cohabitation by 20"
agefrstmar_22mn "First marriage/cohabitation by 22"
agefrstmar_25mn "First marriage/cohabitation by 25"
ms_mar_unionmn "Currently in union"
----------------------------------------------------------------------------*/
** scaler median age
program define calc_median_age

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
gen mafm_`a'`b'_`y'`x'=smedian 

//label subgroup categories
	label var mafm_`a'`b'_`y'`x' "Median age at first marriage among `a' to `b' yr olds, `y'"

	if "`y'" != "all" {
	local lab_val: value label `y'
	local lab_cat : label `lab_val' `x'
	label var mafm_`a'`b'_`y'`x' "Median age at first marriage among `a' to `b' yr olds, `y': `lab_cat'"
	}
	
	//replace median with O and label "NA" if no median can be calculated for age group
	replace mafm_`a'`b'_`y'`x' = 0 if mafm_`a'`b'_`y'`x'>beg_age
	if mafm_`a'`b'_`y'`x' ==0 {
	label val mafm_`a'`b'_`y'`x' NA
	}

}
}


scalar drop smedian

end
**Women's variables in IPUMS DHS

capture confirm variable agefrstmar
if !_rc {
//Median age at first marriage
	//make subgroups here//
	gen all = 1
	clonevar region = regionwm
	clonevar wealth = wealthq
	clonevar education = edachiever
	clonevar residence = urban
	label define NA 0 "NA" //for sub groups where no median can be defined

	
	//setup variables for median age at first marriage calculated from v511, for women age 20 to 49
	gen afm=agefrstmar
	replace afm=99 if agefrstmar==. 
	gen age_new=afm
	gen agevar = age
	tostring(perweight), gen(weightvar)
	replace weightvar=subinstr(weightvar,".","",.)
	destring weightvar, replace
	//create median age at first marriage for each 5 yr age group
	tokenize 	  19 24 29 34 39 44 49 49 49
	foreach x in  15 20 25 30 35 40 45 20 25 {
				scalar beg_age = `x'
				scalar end_age = `1'
				calc_median_age
				
				macro shift
				}

//Marital status
replace marstat=. if marstat > 97

recode marstat (31/max =0 "Not in union") (21=1 "In union"), gen(ms_mar_union)
label var ms_mar_union "Currently in union"

//Co-wives
replace wifenum=. if wifenum > 98.

recode wifenum (98 99 = .)(0 97 = 0 "None or DK") (1/96 = 1 "1+"), gen(ms_cowives_any)
label var ms_cowives_any "One or more co-wives"

***Married by specific ages***

recode marstat (98=.) (10 = 1 "yes") (11/max = 0 "no"), gen (marstat_never)
label var marstat_never "Never married"

//First marriage by age 15
recode agefrstmar (1/14 = 1 "yes") (15/max = 0 "no"), gen(agefrstmar_15)
label var agefrstmar_15 "First marriage/cohabitation by 15"

//First marriage by age 18
recode agefrstmar (1/17 = 1 "yes") (18/max = 0 "no"), gen(agefrstmar_18)
replace agefrstmar_18 = . if age<18 
label var agefrstmar_18 "First marriage/cohabitation by 18"

//First marriage by age 20
recode agefrstmar (1/19 = 1 "yes") (20/max = 0 "no"), gen(agefrstmar_20)
replace agefrstmar_20 = . if age<20 
label var agefrstmar_20 "First marriage/cohabitation by 20"

//First marriage by age 22
recode agefrstmar (1/21 = 1 "yes") (22/max = 0 "no"), gen(agefrstmar_22)
replace agefrstmar_22 = . if age<22 
label var agefrstmar_22 "First marriage/cohabitation by 22"

//First marriage by age 25
recode agefrstmar (1/24 = 1 "yes") (25/max = 0 "no"), gen(agefrstmar_25)
replace agefrstmar_25 = . if age<25 
label var agefrstmar_25 "First marriage/cohabitation by 25"

drop all region residence education wealth age_new agevar weightvar
label drop NA
}
else {
**Men's variables in IPUMS DHS
//Median age at first marriage
	//make subgroups here//
	gen all = 1
	clonevar region = regionmn
	clonevar wealth = wealthqmn
	clonevar education = edachievermn
	clonevar residence = urbanmn
	label define NA 0 "NA" //for sub groups where no median can be defined

	
	//setup variables for median age at first marriage calculated from v511, for women age 20 to 49
	gen afm=age1stmarmn
	replace afm=99 if age1stmarmn==. 
	gen age_new=afm
	gen agevar = agemn
	//gen weightvar = perweightmn
	tostring(perweightmn), gen(weightvar)
	replace weightvar=subinstr(weightvar,".","",.)
	destring weightvar, replace
	//create median age at first marriage for each 5 yr age group - Men typically have higher age groups
	tokenize 	  19 24 29 34 39 44 49 49 49 59 59 59
	foreach x in  15 20 25 30 35 40 45 20 25 20 25 30{
				scalar beg_age = `x'
				scalar end_age = `1'
				calc_median_age
				
				macro shift
				}
				
//Marital status
replace marstatmn=. if marstatmn > 97

recode marstatmn (21/max =0 "Not in union") (11=1 "In union"), gen(ms_mar_unionmn)
label var ms_mar_unionmn "Currently in union"

//Number of wives
replace wifenummn=. if wifenummn > 98

recode wifenummn (98 99 = .)(0 97 = 0 "None or DK") (1/96 = 1 "1+"), gen(ms_cowives_anymn)
label var ms_cowives_anymn "One or more wives"

// Never married
recode marstatmn (98=.) (10 = 1 "yes") (11/max = 0 "no"), gen (marstatmn_never)
label var marstatmn_never "Never married"

***Married by specific ages***


//First marriage by age 15
recode age1stmarmn (1/14 = 1 "yes") (15/max = 0 "no"), gen(agefrstmar_15mn)
label var agefrstmar_15mn "First marriage/cohabitation by 15"

//First marriage by age 18
recode age1stmarmn (1/17 = 1 "yes") (18/max = 0 "no"), gen(agefrstmar_18mn)
replace agefrstmar_18mn = . if agemn<18 
label var agefrstmar_18mn "First marriage/cohabitation by 18"

//First marriage by age 20
recode age1stmarmn (1/19 = 1 "yes") (20/max = 0 "no"), gen(agefrstmar_20mn)
replace agefrstmar_20mn = . if agemn<20 
label var agefrstmar_20mn "First marriage/cohabitation by 20"

//First marriage by age 22
recode age1stmarmn (1/21 = 1 "yes") (22/max = 0 "no"), gen(agefrstmar_22mn)
replace agefrstmar_22mn = . if agemn<22 
label var agefrstmar_22mn "First marriage/cohabitation by 22"

//First marriage by age 25
recode age1stmarmn (1/24 = 1 "yes") (25/max = 0 "no"), gen(agefrstmar_25mn)
replace agefrstmar_25mn = . if agemn<25 
label var agefrstmar_25mn "First marriage/cohabitation by 25"

drop all region residence education wealth age_new agevar weightvar
label drop NA
}
