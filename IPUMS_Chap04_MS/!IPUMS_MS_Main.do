/*******************************************************************************************************************************
Program: 				!IPUMS_MSmain.do
Purpose: 				Main file for the Marriage and Sexual Activity Chapter. 
						The main file will call other do files that will produce the MS indicators and produce tables.
Data outputs:			coded variables and table output on screen and in excel tables.  
Author: 				Courtney Allen, modified by Maggie Tran for this project
Date last modified:		January 2021

*******************************************************************************************************************************/

/*
Variables Used:

age1stseximp      	Women's: "Age at first intercourse (imputed)"
marstat			Women: "Current marital status"
wifenum			Women: "Number of other co-wives"
agefrstmar		Women: "Age at first marriage or cohabitation"


age1stseximpmn	  	Men's: "Age at first intercourse (imputed)"
marstatmn		Men: "Current martial status"
wifenummn		Men: "Number of other wives"
age1stmarmn		Men: "Age at first marriage or cohabitation"

wealthq			Women: "Household wealth index in quintiles"
edachiever 		Women: "Summary educational achievement"
urban 			Women: "Urban-rural status"
perweight 		Women: "Sample weight for persons"
region variable geo_CCYEAR "Single sample geography variables"

wealthqmn		Men: "Household wealth index in quintiles"
edachievermn		Men: "Man's summary educational achievement"
urbanmn			Men: "Type of place of residence"
perweightmn		Men: "Men's sample weight"
region variable geo_CCYEAR	"Single sample geography variables"
----------------------------------------------------------------------------
Variables created:
age1stseximp_never	Women's: "Never had sex"
age1stseximp_15		Women's: "First sex by 15"
age1stseximp_18		Women's: "First sex by 18"
age1stseximp_20		Women's: "First sex by 20"
age1stseximp_22		Women's: "First sex by 22"
age1stseximp_25		Women's: "First sex by 25"

age1stseximpmn_never	Men's: "Never had sex"
age1stseximpmn_15	Men's: "First sex by 15"
age1stseximpmn_18	Men's: "First sex by 18"
age1stseximpmn_20	Men's: "First sex by 20"
age1stseximpmn_22	Men's: "First sex by 22"
age1stseximpmn_25	Men's: "First sex by 25"

ms_cowives_any "One or more co-wives"
agefrstmar_15 "First marriage/cohabitation by 15"
agefrstmar_18 "First marriage/cohabitation by 18"
agefrstmar_20 "First marriage/cohabitation by 20"
agefrstmar_22 "First marriage/cohabitation by 22"
agefrstmar_25 "First marriage/cohabitation by 25"

ms_cowives_anymn "One or more co-wives"
agefrstmar_15mn "First marriage/cohabitation by 15"
agefrstmar_18mn "First marriage/cohabitation by 18"
agefrstmar_20mn "First marriage/cohabitation by 20"
agefrstmar_22mn "First marriage/cohabitation by 22"
agefrstmar_25mn "First marriage/cohabitation by 25"
*/

****** select your survey *****

global womendata /* INSERT PATH TO WOMEN'S DATA SET HERE */

global mendata /* INSERT PATH TO MEN'S DATA SET HERE */

****** IR file variables *****

* open dataset
use "$womendata", clear
gen file="IR"
clonevar regionwm = /* INSERT REGION VARIABLE NAME HERE */

*Purpose: 	Code marital status variables
cap program drop calc_median_age
do IPUMS_MS_MAR.do

*Purpose: 	Code sexual activity variables
cap program drop calc_median_age
do IPUMS_MS_SEX.do

*Purpose: 	Produce tables for indicators computed from above do files. 
do IPUMS_MS_tables.do

******* MR file variables *******

* open dataset

use "$mendata", clear
gen file="MR"
clonevar regionmn = /* INSERT REGION VARIABLE NAME HERE */

*Purpose: 	Code marital status variables
cap program drop calc_median_age
do IPUMS_MS_MAR.do

*Purpose: 	Code sexual activity variables
cap program drop calc_median_age
do IPUMS_MS_SEX.do

*Purpose: 	Produce tables for indicators computed from above do files. 
do IPUMS_MS_tables.do

