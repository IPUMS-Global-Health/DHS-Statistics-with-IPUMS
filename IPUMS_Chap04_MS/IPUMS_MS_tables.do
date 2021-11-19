/*****************************************************************************************************
Program: 		  	         IPUMS_MS_tables.do
Purpose: 			            Produce tables for indicators
Author:				            Courtney Allen, modified by Faduma Shaba and Maggie Tran for this project
Date last modified:       		January 2021
*Note this do file will produce the following tables in excel:
	1. 	Tables_Mar_wm:		Contains the tables for knowledge indicators for women
	2. 	Tables_Mar_mn:		Contains the tables for knowledge indicators for men
	3. 	Tables_Sex_wm:		Contains the tables for ever use of family planning for women
	4. 	Tables_Sex_mn:		Contains the tables for current use of family planning for women + timing of sterlization
Notes:
*****************************************************************************************************/

* the total will show on the last row of each table.
* comment out the tables or indicator section you do not want.
****************************************************

//Installing tabout

ssc install tabout

if file == "IR" {
gen wt = perweight/1000000

//Marital status among men age 15-49
tab1 marstat ms_mar_union [iw=wt]

* output to excel
tabout marstat ms_mar_union using Tables_Mar_wm.xls [iw=wt] , oneway cells(cell) f(1) replace

// ADD THE CURRENTLY IN UNION TABLE
****************************************************

//Marital status by background variables

*age and marital status
tab age5year marstat [iw=wt], row nofreq

* output to excel
tabout age5year marstat using Tables_Mar_wm.xls [iw=wt] , c(row) f(1) append

****************************************************
//Currently in union by background variables

*age
tab age5year ms_mar_union [iw=wt], row nofreq

* output to excel
tabout age5year ms_mar_union using Tables_Mar_wm.xls [iw=wt] , c(row) f(1) append



****************************************************
//Number of women's co-wives by background variables
recode wifenum (0=0 "None") (1=1 "1") (2/9=2 "2+") (97=97 "Don't Know") (98=.) (99=.), gen (wifenum2)

*age
tab age5year wifenum2 [iw=wt], row nofreq

*residence
tab urban wifenum2 [iw=wt], row nofreq

*region
tab regionwm wifenum2 [iw=wt], row nofreq

*education
tab educlvl wifenum2 [iw=wt], row nofreq

*wealth
tab wealthq wifenum2 [iw=wt], row nofreq

* output to excel
tabout age5year urban regionwm educlvl wealthq wifenum2 using Tables_Mar_wm.xls [iw=wt], c(row) f(1) append
****************************************************
//Women with one or more co-wives by background variables

*age
tab age5year ms_cowives_any [iw=wt], row nofreq

*residence
tab urban ms_cowives_any [iw=wt], row nofreq

*region
tab regionwm ms_cowives_any [iw=wt], row nofreq 

*education
tab educlvl ms_cowives_any [iw=wt], row nofreq

*wealth
tab wealthq ms_cowives_any [iw=wt], row nofreq

* output to excel
tabout age5year urban regionwm educlvl wealthq ms_cowives_any using Tables_Mar_wm.xls [iw=wt] , c(row) f(1) append

**************************************************************************************************
//Age at first marriage by background variables

* percent married by specific ages, by age group
tab age5year agefrstmar_15 [iw=wt], row nofreq
tab agefrstmar_15 if age5year>=30 [iw=wt]
tab agefrstmar_15 if age5year>=40 [iw=wt]

tab age5year agefrstmar_18 if age5year>=30 [iw=wt], row nofreq
tab agefrstmar_18 if age5year>=30  [iw=wt]
tab agefrstmar_18 if age5year>=40 [iw=wt]

tab age5year agefrstmar_20 if age5year>=30 [iw=wt], row nofreq
tab agefrstmar_20 if age5year>=30 [iw=wt]
tab agefrstmar_20 if age5year>=40 [iw=wt]

tab age5year agefrstmar_22 if age5year>=40 [iw=wt], row nofreq
tab agefrstmar_22 agefrstmar_22 if age5year>=40 [iw=wt]

tab age5year agefrstmar_25 if age5year>=40 [iw=wt], row nofreq
tab agefrstmar_25 if age5year>=40 [iw=wt]


* output to excel
* percent married by specific ages, by age group
tabout age5year agefrstmar_15 using Tables_Mar_wm.xls [iw=wt] , c(row) f(1) append 
tabout age5year agefrstmar_18 using Tables_Mar_wm.xls [iw=wt] , c(row) f(1) append 
tabout age5year agefrstmar_20 using Tables_Mar_wm.xls [iw=wt] , c(row) f(1) append 
tabout age5year agefrstmar_22 using Tables_Mar_wm.xls [iw=wt] , c(row) f(1) append 
tabout age5year agefrstmar_25 using Tables_Mar_wm.xls [iw=wt] , c(row) f(1) append 

* percent married by specific ages, among 20-49 and 25-49 year olds
tabout agefrstmar_15 agefrstmar_18 agefrstmar_20 if age5year>=30 [iw=wt] using Tables_Mar_wm.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append 
tabout agefrstmar_15 agefrstmar_18 agefrstmar_20 agefrstmar_22 agefrstmar_25 if age5year>=40 [iw=wt] using Tables_Mar_wm.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append 
***************************************************************************************************
//Never in union by background variables
* how to calculate never in union, if it's not an option available on surveys?
* never in union by age group
tab age5year marstat_never [iw=wt], row nofreq
tab marstat_never if age5year>=2 [iw=wt] //among 20-49 yr olds
tab marstat_never if age5year>=3 [iw=wt] //among 25-49 yr olds

* output to excel
tabout age5year marstat_never using Tables_Mar_wm.xls [iw=wt] , c(row) f(1) append
tabout marstat_never if age5year>=2 [iw=wt] using Tables_Mar_wm.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append
tabout marstat_never if age5year>=3 [iw=wt] using Tables_Mar_wm.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append

**************************************************************************************************
//Median age at first marraige by background variables

*median age at first marriage by age group
tabout mafm_1519_all1 mafm_2024_all1 mafm_2529_all1 mafm_3034_all1 mafm_3539_all1 mafm_4044_all1 mafm_4549_all1 mafm_2049_all1 mafm_2549_all1 using Tables_Mar_wm.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append

*median age at first marriage among 25-49 yr olds, by subgroup
local subgroup residence region education wealth

foreach y in `subgroup' {
	tabout mafm_2549_`y'*  using Tables_Mar_wm.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append
}



**************************************************************************************************
* Indicators for sex: excel file Tables_Sex_wm will be produced
**************************************************************************************************

**************************************************************************************************
//Age at first sex by background variables

* percent had sex by specific ages, by age group

*percent had sex by age 15
tab age5year age1stseximp_15 [iw=wt], row nofreq //percent married by age 15, by age
tab age1stseximp_15 if age5year>=30 [iw=wt]		//percent married by age 15, by age, among age 20-49
tab age1stseximp_15 if age5year>=40 [iw=wt]		//percent married by age 15, by age, among age 25-49

tab age5year age1stseximp_18 if age5year>=30 [iw=wt], row nofreq   //percent married by age 18, by age
tab age1stseximp_18 if age5year>=30 [iw=wt]		//percent married by age, 18 by age, among age 20-49
tab age1stseximp_18 if age5year>=40 [iw=wt]		//percent married by age, 18 by age, among age 25-49

tab age5year age1stseximp_20 if age5year>=30 [iw=wt], row nofreq  //percent married by age 20, by age
tab age1stseximp_20 if age5year>=30 [iw=wt]		//percent married by age, 20 by age, among age 20-49
tab age1stseximp_20 if age5year>=40 [iw=wt]		//percent married by age, 20 by age, among age 25-49

tab age5year age1stseximp_22 if age5year>=40 [iw=wt], row nofreq  //percent married by age 22, by age
tab age1stseximp_22 if age5year>=40 [iw=wt]		//percent married by age, 22 by age, among age 25-49

tab age5year age1stseximp_25 if age5year>=40 [iw=wt], row nofreq  //percent married by age 25, by age
tab age1stseximp_25 if age5year>=40 [iw=wt]		//percent married by age 25, by age, among age 25-49


* output to excel
* percent had sex by specific ages, by age group
tabout age5year age1stseximp_15 using Tables_Sex_wm.xls [iw=wt] , c(row) f(1) replace
tabout age5year age1stseximp_18 if age5year>20 using Tables_Sex_wm.xls [iw=wt] , c(row) f(1) append
tabout age5year age1stseximp_20 if age5year>20 using Tables_Sex_wm.xls [iw=wt] , c(row) f(1) append
tabout age5year age1stseximp_22 if age5year>30 using Tables_Sex_wm.xls [iw=wt] , c(row) f(1) append
tabout age5year age1stseximp_25 if age5year>30 using Tables_Sex_wm.xls [iw=wt] , c(row) f(1) append

* percent had sex by specific ages, among  20-49 and 25-49 year olds
tabout age1stseximp_15 age1stseximp_18  if age5year>=30 [iw=wt] using Tables_Sex_wm.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append
tabout age1stseximp_15 age1stseximp_18 age1stseximp_20 age1stseximp_22 age1stseximp_25 if age5year>=40 [iw=wt] using Tables_Sex_wm.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append

**************************************************************************************************
//Never had sex by background variables

* never had sex by age group
tab age5year age1stseximp_never [iw=wt], row nofreq
tab age1stseximp_never if age5year>=30 [iw=wt] //among 20-49 yr olds
tab age1stseximp_never if age5year>=40 [iw=wt] //among 25-49 yr olds

* output to excel
tabout age5year age1stseximp_never using Tables_Sex_wm.xls [iw=wt] , c(row) f(1) append
tabout age1stseximp_never if age5year>=30 [iw=wt] using Tables_Sex_wm.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append
tabout age1stseximp_never if age5year>=40 [iw=wt] using Tables_Sex_wm.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append

**************************************************************************************************
//Median age at first sex by background variables

//median age at first sex by age group
tabout mafs_1519_all1 mafs_2024_all1 mafs_2529_all1 mafs_3034_all1 mafs_3539_all1 mafs_4044_all1 mafs_4549_all1 mafs_2049_all1 mafs_2549_all1 using Tables_Sex_wm.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none) append

//median age at first sex among 25-49 yr olds, by subgroup
local subgroup residence region education wealth

foreach y in `subgroup' {
	tabout mafs_2549_`y'*  using Tables_Sex_wm.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none) append
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////

* indicators from MR file

if file=="MR" {
gen wt=perweightmn/1000000

recode wifenummn (1=1 "1") (2/5=2 "2+") (98=.) (99=.), gen (wifenummn2) // get it as 2+ instead of all
**************************************************************************************************
* Indicators for marriage: excel file Tables_Mar_mn will be produced
**************************************************************************************************
//Marital status among men age 15-49
tab1 marstatmn ms_mar_unionmn [iw=wt]

* output to excel
tabout 	marstatmn ms_mar_unionmn using Tables_Mar_mn.xls [iw=wt] , oneway cells(cell) f(1) replace


****************************************************
//Marital status by background variables among men age 15-49

*age (15-49)
tab age5yearmn marstatmn if age5yearmn<8 [iw=wt], row nofreq

* output to excel
tabout age5yearmn marstatmn if age5yearmn<8  using Tables_Mar_mn.xls [iw=wt] , c(row) f(1) append


****************************************************
//Currently in union by background variables among men age 15-49
*age (15-49)
tab age5year ms_mar_unionmn if age5year<8 [iw=wt], row nofreq

* output to excel
tabout age5year ms_mar_unionmn if age5year<8 using Tables_Mar_mn.xls [iw=wt] , c(row) f(1) append


****************************************************
//Number of men's wives by background variables among men age 15-49
//TODO: get rid of nofreq
*age
tab age5yearmn wifenummn2 if age5yearmn<8 [iw=wt], row nofreq

*residence
tab urbanmn wifenummn2 if age5yearmn<8 [iw=wt], row nofreq

*region
tab regionmn wifenummn2 if age5year<8 [iw=wt], row nofreq
* TODO: tab mv wifenummn2 ....
*education
tab educlvlmn wifenummn2 if age5yearmn<8 [iw=wt], row nofreq

*wealth
tab wealthqmn wifenummn2 if age5yearmn<8 [iw=wt], row nofreq

* output to excel
tabout age5yearmn urbanmn regionmn educlvlmn wealthqmn wifenummn2  if age5yearmn<8 using Tables_Mar_mn.xls [iw=wt] , c(row) f(1) append



**************************************************************************************************
//Age at first marriage by background variables

*percent married by specific ages by age group

*percent married by age 15
tab age5yearmn agefrstmar_15mn  [iw=wt], row nofreq 	//percent married by age 15 by age
tab agefrstmar_15mn if age5yearmn>=2 & age5yearmn<8 [iw=wt] //percent married by age 15 by age, among age 20-49
tab agefrstmar_15mn if age5yearmn>=3 & age5yearmn<8 [iw=wt] //percent married by age 15 by age, among age 25-49
tab agefrstmar_15mn if age5yearmn>=2 [iw=wt] 			//percent married by age 15 by age, among age 20-max age
tab agefrstmar_15mn if age5yearmn>=3 [iw=wt]			//percent married by age 15 by age, among age 25-max age

*percent married by age 18
tab age5yearmn agefrstmar_18mn if age5yearmn>=2  [iw=wt], row nofreq //percent married by age 18 by age
tab agefrstmar_18mn if age5yearmn>=2 & age5yearmn<8 [iw=wt]		 //percent married by age 18 by age, among age 20-49
tab agefrstmar_18mn if age5yearmn>=3 & age5yearmn<8 [iw=wt]		 //percent married by age 18 by age, among age 25-49
tab agefrstmar_18mn if age5yearmn>=2 [iw=wt]				 //percent married by age 18 by age, among age 20-max age
tab agefrstmar_18mn if age5yearmn>=3 [iw=wt]				 //percent married by age 18 by age, among age 25-max age

*percent married by age 20
tab age5year agefrstmar_20mn if age5year>=2  [iw=wt], row nofreq //percent married by age 20 by age
tab agefrstmar_20mn if age5yearmn>=2 & age5yearmn<8 [iw=wt]		 //percent married by age 20 by age, among age 20-49
tab agefrstmar_20mn if age5yearmn>=3 & age5yearmn<8 [iw=wt]		 //percent married by age 20 by age, among age 25-49
tab agefrstmar_20mn if age5yearmn>=2 [iw=wt]		 		 //percent married by age 20 by age, among age 20-max age
tab agefrstmar_20mn if age5yearmn>=3 [iw=wt]				 //percent married by age 20 by age, among age 25-max age

*percent married by age 22
tab age5yearmn agefrstmar_22mn if age5yearmn>=3  [iw=wt], row nofreq //percent married by age 22 by age
tab agefrstmar_22mn if age5yearmn>=3 & age5yearmn<8 [iw=wt]		//percent married by age 22 by age, among age 25-49
tab agefrstmar_22mn if age5yearmn>=3 [iw=wt]   			//percent married by age 22 by age, among age 25-max age

*percent married by age 25
tab age5yearmn agefrstmar_25mn if age5yearmn>=3  [iw=wt], row nofreq //percent married by age 25 by age
tab agefrstmar_25mn if age5yearmn>=3 & age5yearmn<8 [iw=wt]  	//percent married by age 25 by age, among age 25-49
tab agefrstmar_25mn if age5yearmn>=3 [iw=wt]  			 	//percent married by age 25 by age, among age 25-max age


* output to excel
* percent married by specific ages, by age group
tabout age5yearmn agefrstmar_15mn using Tables_Mar_mn.xls [iw=wt] , c(row) f(1) append
tabout age5yearmn agefrstmar_18mn if age5yearmn>1 using Tables_Mar_mn.xls [iw=wt] , c(row) f(1) append
tabout age5yearmn agefrstmar_20mn if age5yearmn>1 using Tables_Mar_mn.xls [iw=wt] , c(row) f(1) append
tabout age5yearmn agefrstmar_22mn if age5yearmn>2 using Tables_Mar_mn.xls [iw=wt] , c(row) f(1) append
tabout age5yearmn agefrstmar_25mn if age5yearmn>2 using Tables_Mar_mn.xls [iw=wt] , c(row) f(1) append

* percent married by specific ages, among 20-49 and 25-49 year olds
tabout agefrstmar_15mn agefrstmar_18mn agefrstmar_20mn if age5yearmn>=2 & age5yearmn<8 [iw=wt] using Tables_Mar_mn.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append
tabout agefrstmar_15mn agefrstmar_18mn agefrstmar_20mn agefrstmar_22mn agefrstmar_25mn if age5yearmn>=3 & age5yearmn<8 [iw=wt] using Tables_Mar_mn.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append
tabout agefrstmar_15mn agefrstmar_18mn agefrstmar_20mn if age5yearmn>=2 [iw=wt] using Tables_Mar_mn.xls, oneway c(cell) clab(Among_20-59_yr_olds) f(1) append
tabout agefrstmar_15mn agefrstmar_18mn agefrstmar_20mn agefrstmar_22mn agefrstmar_25mn if age5yearmn>=3 [iw=wt] using Tables_Mar_mn.xls, oneway c(cell) clab(Among_25-59_yr_olds) f(1) append


**************************************************************************************************
//Never in union by background variables

* never in union by age group

tab age5yearmn marstatmn_never  [iw=wt], row nofreq
tab marstatmn_never if age5yearmn>=2 & age5yearmn<8 [iw=wt] //among 20-49 yr olds
tab marstatmn_never if age5yearmn>=3 & age5yearmn<8 [iw=wt] //among 25-49 yr olds
tab marstatmn_never if age5yearmn>=2 [iw=wt] //among 20-49 yr olds
tab marstatmn_never if age5yearmn>=3 [iw=wt] //among 25-49 yr olds

* output to excel
tabout age5yearmn marstatmn_never using Tables_Mar_mn.xls [iw=wt] , c(row) f(1) append
tabout marstatmn_never if age5yearmn>=2 & age5yearmn<8 [iw=wt] using Tables_Mar_mn.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append
tabout marstatmn_never if age5yearmn>=3 & age5yearmn<8 [iw=wt] using Tables_Mar_mn.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append
tabout marstatmn_never if age5yearmn>=2 [iw=wt] using Tables_Mar_mn.xls, oneway c(cell) clab(Among_20-59_yr_olds) f(1) append
tabout marstatmn_never if age5yearmn>=3 [iw=wt] using Tables_Mar_mn.xls, oneway c(cell) clab(Among_25-59_yr_olds) f(1) append


**************************************************************************************************
//Median age at first marriage by background variables

*median age at first marriage by age group
tabout mafm_1519_all1 mafm_2024_all1 mafm_2529_all1 mafm_3034_all1 mafm_3539_all1 mafm_4044_all1 mafm_4549_all1 mafm_2049_all1 mafm_2549_all1 mafm_2059_all1 mafm_2559_all1 using Tables_Mar_mn.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append

*median age at first marriage among 25-49 yr olds, by subgroup
local subgroup residence region education wealth

*median ages by subgroups, CHANGE AGE RANGE HERE IF NEEDED (change var from mafm_2549_ to mafm_20-49_ for median age among those age 20-49 yrs old)
foreach y in `subgroup' {
	tabout mafm_2549_`y'*  using Tables_Mar_mn.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append
	}



**************************************************************************************************
* Indicators for sex: excel file Tables_Sex_mn will be produced
**************************************************************************************************

**************************************************************************************************
//Age at first sex by background variables

* percent had sex by specific ages, by age group

*percent married by age 15
tab age5yearmn age1stseximpmn_15 if age5yearmn<8  [iw=wt], row nofreq //percent married by age 15, by age
tab age1stseximpmn_15 if age5yearmn>=2 & age5yearmn<8 [iw=wt]	//percent married by age 15, by age, among age 20-49
tab age1stseximpmn_15 if age5yearmn>=3 & age5yearmn<8 [iw=wt]	//percent married by age 15, by age, among age 25-49
tab age1stseximpmn_15 if age5yearmn>=2 [iw=wt]			//percent married by age 15, by age, among age 20-59
tab age1stseximpmn_15 if age5yearmn>=3 [iw=wt]			//percent married by age 15, by age, among age 25-59

tab age5yearmn age1stseximpmn_18 if age5yearmn>=2 & age5yearmn<8  [iw=wt], row nofreq   //percent married by age 18, by age
tab age1stseximpmn_18 if age5yearmn>=2 & age5yearmn<8 [iw=wt]	//percent married by age 18, by age, among age 20-49
tab age1stseximpmn_18 if age5yearmn>=3 & age5yearmn<8 [iw=wt]	//percent married by age 18, by age, among age 25-49
tab age1stseximpmn_18 if age5yearmn>=2 [iw=wt]			//percent married by age 18, by age, among age 20-59
tab age1stseximpmn_18 if age5yearmn>=3 [iw=wt]			//percent married by age 18, by age, among age 25-59

tab age5yearmn age1stseximpmn_20 if age5yearmn>=2 & age5yearmn<8  [iw=wt], row nofreq  //percent married by age 20, by age
tab age1stseximpmn_20 if age5yearmn>=2 & age5yearmn<8 [iw=wt]	//percent married by age 20, by age, among age 20-49
tab age1stseximpmn_20 if age5yearmn>=3 & age5yearmn<8 [iw=wt]	//percent married by age 20, by age, among age 25-49
tab age1stseximpmn_20 if age5yearmn>=2 [iw=wt]			//percent married by age 20, by age, among age 20-59
tab age1stseximpmn_20 if age5yearmn>=3 [iw=wt]			//percent married by age 20, by age, among age 25-59

tab age5yearmn age1stseximpmn_22 if age5yearmn>=3 & age5yearmn<8  [iw=wt], row nofreq  //percent married by age 22, by age
tab age1stseximpmn_22 if age5yearmn>=3 & age5yearmn<8 [iw=wt]	//percent married by age 22, by age, among age 25-49
tab age1stseximpmn_22 if age5yearmn>=3 [iw=wt]			//percent married by age 22, by age, among age 25-59

tab age5yearmn age1stseximpmn_25 if age5yearmn>=3  [iw=wt], row nofreq  //percent married by age 25, by age
tab age1stseximpmn_25 if age5yearmn>=3 & age5yearmn<8 [iw=wt]	//percent married by age 25, by age, among age 25-49
tab age1stseximpmn_25 if age5yearmn>=3 [iw=wt]			//percent married by age 25, by age, among age 25-59


* output to excel
* percent had sex by specific ages, by age group
tabout age5yearmn age1stseximpmn_15 using Tables_Sex_mn.xls [iw=wt] , c(row) f(1) replace
tabout age5yearmn age1stseximpmn_18 if age5yearmn>1 using Tables_Sex_mn.xls [iw=wt] , c(row) f(1) append
tabout age5yearmn age1stseximpmn_20 if age5yearmn>1 using Tables_Sex_mn.xls [iw=wt] , c(row) f(1) append
tabout age5yearmn age1stseximpmn_22 if age5yearmn>2 using Tables_Sex_mn.xls [iw=wt] , c(row) f(1) append
tabout age5yearmn age1stseximpmn_25 if age5yearmn>2 using Tables_Sex_mn.xls [iw=wt] , c(row) f(1) append


* percent married by specific ages, among  20-49 and 25-49 year olds
tabout age1stseximpmn_15 age1stseximpmn_18 age1stseximpmn_20 if age5yearmn>=2 & age5yearmn<8 [iw=wt] using Tables_Sex_mn.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append
tabout age1stseximpmn_15 age1stseximpmn_18 age1stseximpmn_20 if age5yearmn>=2 [iw=wt] using Tables_Sex_mn.xls, oneway c(cell) clab(Among_20-59_yr_olds) f(1) append
tabout age1stseximpmn_15 age1stseximpmn_18 age1stseximpmn_20 age1stseximpmn_22 age1stseximpmn_25 if age5yearmn>=3 & age5yearmn<8 [iw=wt] using Tables_Sex_mn.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append
tabout age1stseximpmn_15 age1stseximpmn_18 age1stseximpmn_20 age1stseximpmn_22 age1stseximpmn_25 if age5yearmn>=3 [iw=wt] using Tables_Sex_mn.xls, oneway c(cell) clab(Among_25-59_yr_olds) f(1) append

**************************************************************************************************
//Never had sex by background variables

* never had sex by age group
tab age5yearmn age1stseximpmn_never  [iw=wt], row nofreq
tab age1stseximpmn_never if age5yearmn>=2 & age5yearmn<8 [iw=wt] //among 20-49 yr olds
tab age1stseximpmn_never if age5yearmn>=3 & age5yearmn<8 [iw=wt] //among 25-49 yr olds
tab age1stseximpmn_never if age5yearmn>=2 [iw=wt] //among 20-49 yr olds
tab age1stseximpmn_never if age5yearmn>=3 [iw=wt] //among 25-49 yr olds

* output to excel
tabout age5yearmn age1stseximpmn_never using Tables_sex_mn.xls [iw=wt] , c(row) f(1) append
tabout age1stseximpmn_never if age5yearmn>=2 & age5yearmn<8 [iw=wt] using Tables_Sex_mn.xls, oneway c(cell) clab(Among_20-49_yr_olds) f(1) append
tabout age1stseximpmn_never if age5yearmn>=3 & age5yearmn<8 [iw=wt] using Tables_Sex_mn.xls, oneway c(cell) clab(Among_25-49_yr_olds) f(1) append
tabout age1stseximpmn_never if age5yearmn>=2 [iw=wt] using Tables_Sex_mn.xls, oneway c(cell) clab(Among_20-59_yr_olds) f(1) append
tabout age1stseximpmn_never if age5yearmn>=3 [iw=wt] using Tables_Sex_mn.xls, oneway c(cell) clab(Among_25-59_yr_olds) f(1) append

**************************************************************************************************
//Median age at first sex by background variables

*median age at first sex by age group
tabout mafs_1519_all1 mafs_2024_all1 mafs_2529_all1 mafs_3034_all1 mafs_3539_all1 mafs_4044_all1 mafs_4549_all1 mafs_2049_all1 mafs_2549_all1 mafs_2059_all1 mafs_2559_all1 using Tables_Sex_mn.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none)  append

*median age at first sex among 25-49 yr olds, by subgroup
local subgroup residence region education wealth

*median age by subgroup CHANGE AGE RANGE HERE IF NEEDED (change var from mafm_2549_ to mafm_20-49_ for median age among those age 20-49 yrs old)
foreach y in `subgroup' {
	tabout mafs_2549_`y'*  using Tables_Sex_mn.xls [iw=wt] , oneway  c(cell) f(1) ptotal(none) append
	}
}

