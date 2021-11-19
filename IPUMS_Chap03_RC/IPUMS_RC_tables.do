/*****************************************************************************************************
Program: 			IPUMS_RC_tables.do
Purpose: 			produce tables for indicators
Author:				Shireen Assaf, modified by Kassandra Fate for this project
Date last modified: August 23 2021 by Kassandra Fate
*This do file will produce the following tables in excel:
1. Tables_background_wm:		Contains the tables for background variables for women
2. Tables_background_mn:		Contains the tables for background variables for men
3. Tables_educ_wm:			Contains the tables for education indicators for women
4. Tables_educ_mn:			Contains the tables for education indicators for women
5.Tables_media_wm:			Contains the tables for media exposure and internet use for women
6.Tables_media_mn:			Contains the tables for media exposure and internet use for men
7.Tables_employ_wm:			Contains the tables for employment and occupation indicators for women
8.Tables_employ_mn:			Contains the tables for employment and occupation indicators for men
9.  Tables_insurance_wm:		Contains the tables for health insurance indicators for women
10. Tables_insurance_mn:		Contains the tables for health insurance indicators for men
11. Tables_tobac_wm:			Contains the tables for tobacco use indicators for women
12. Tables_tobac_mn:			Contains the tables for tobacco use indicators for men
Notes: 	For women and men the indicators are outputed for age 15-49 in line 31 and 583. This can be commented out if the indicators are required for all women/men.				 						
*****************************************************************************************************/

/* DIRECTIONS
1. Create a data extract at dhs.ipums.org that includes the IPUMS variables listed below.
2. Replace "GEO-REGION"
 with your sample's region variable name.
	In IPUMS DHS, each survey's region variable has a unique name to facilitate
	pooling data. These variables can be found in the IPUMS drop down menu under:
		GEOGRAPHY -> SINGLE SAMPLE GEOGRAPHY */

* the total will show on the last row of each table.
* comment out the tables or indicator section you do not want.
****************************************************/

* indicators from Women's file
if file=="Women" {
* limiting to women age 15-49
drop if age<15 | age>49

gen wt=perweight
**************************************************************************************************
* Background characteristics: excel file Tables_background_wm will be produced
**************************************************************************************************

*age
tab age5year [iw=wt] 

*marital status
tab marstat [iw=wt] 

*residence
tab urban [iw=wt] 

*region
tab GEO-REGION [iw=wt] 

*education
tab educlvl [iw=wt] 

*wealth
tab wealthq [iw=wt] 

* output to excel
tabout age5year marstat urban educlvl GEO-REGION wealthq using Tables_background_wm.xls [iw=wt] , oneway cells(cell freq) replace 
*/
**************************************************************************************************
* Indicators for education and literacy: excel file Tables_educ_wm will be produced
**************************************************************************************************
//Highest level of schooling

*age
tab age5year rc_edu [iw=wt], row nofreq 

*residence
tab urban rc_edu [iw=wt], row nofreq 

*region
tab GEO-REGION rc_edu [iw=wt], row nofreq 

*wealth
tab wealthq rc_edu [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION wealthq rc_edu using Tables_educ_wm.xls [iw=wt] , c(row) f(1) replace 

//Median years of schooling
tab rc_edu_median 

tabout rc_edu_median using Tables_educ_wm.xls [iw=wt] , oneway cells(cell) append 

****************************************************
//Literacy levels

*age
tab age5year rc_litr_cats [iw=wt], row nofreq 

*residence
tab urban rc_litr_cats [iw=wt], row nofreq 

*region
tab GEO-REGION rc_litr_cats [iw=wt], row nofreq 

*wealth
tab wealthq rc_litr_cats [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION wealthq rc_litr_cats using Tables_educ_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Literate 

*age
tab age5year rc_litr [iw=wt], row nofreq 

*residence
tab urban rc_litr [iw=wt], row nofreq 

*region
tab GEO-REGION rc_litr [iw=wt], row nofreq 

*wealth
tab wealthq rc_litr [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION wealthq rc_litr using Tables_educ_wm.xls [iw=wt] , c(row) f(1) append 

**************************************************************************************************
* Indicators for media exposure and internet use: excel file Tables_media_wm will be produced
**************************************************************************************************
//Reads a newspaper

*age
tab age5year rc_media_newsp [iw=wt], row nofreq 

*residence
tab urban rc_media_newsp [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_newsp [iw=wt], row nofreq 

*education
tab educlvl rc_media_newsp [iw=wt], row nofreq 

*wealth
tab wealthq rc_media_newsp [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_media_newsp using Tables_media_wm.xls [iw=wt] , c(row) f(1) replace 

****************************************************
//Watches TV

*age
tab age5year rc_media_tv [iw=wt], row nofreq 

*residence
tab urban rc_media_tv [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_tv [iw=wt], row nofreq 

*education
tab educlvl rc_media_tv [iw=wt], row nofreq 

*wealth
tab wealthq rc_media_tv [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_media_tv using Tables_media_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Listens to radio

*age
tab age5year rc_media_radio [iw=wt], row nofreq 

*residence
tab urban rc_media_radio [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_radio [iw=wt], row nofreq 

*education
tab educlvl rc_media_radio [iw=wt], row nofreq 

*wealth
tab wealthq rc_media_radio [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_media_radio using Tables_media_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//All three media

*age
tab age5year rc_media_allthree [iw=wt], row nofreq 

*residence
tab urban rc_media_allthree [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_allthree [iw=wt], row nofreq 

*education
tab educlvl rc_media_allthree [iw=wt], row nofreq 

*wealth
tab wealthq rc_media_allthree [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_media_allthree using Tables_media_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//None of the media forms

*age
tab age5year rc_media_none [iw=wt], row nofreq 

*residence
tab urban rc_media_none [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_none [iw=wt], row nofreq 

*education
tab educlvl rc_media_none [iw=wt], row nofreq 

*wealth
tab wealthq rc_media_none [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_media_none using Tables_media_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Ever used the internet
* Indicator not available in all surveys so will add cap
*age
cap tab age5year rc_intr_ever [iw=wt], row nofreq 

*residence
cap tab urban rc_intr_ever [iw=wt], row nofreq 

*region
cap tab GEO-REGION rc_intr_ever [iw=wt], row nofreq 

*education
cap tab educlvl rc_intr_ever [iw=wt], row nofreq 

*wealth
cap tab wealthq rc_intr_ever [iw=wt], row nofreq 

* output to excel
cap tabout age5year urban GEO-REGION educlvl wealthq rc_intr_ever using Tables_media_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Internet use in the last 12 months
* Indicator not available in all surveys so will add cap
*age
cap tab age5year rc_intr_use12mo [iw=wt], row nofreq 

*residence
cap tab urban rc_intr_use12mo [iw=wt], row nofreq 

*region
cap tab GEO-REGION rc_intr_use12mo [iw=wt], row nofreq 

*education
cap tab educlvl rc_intr_use12mo [iw=wt], row nofreq 

*wealth
cap tab wealthq rc_intr_use12mo [iw=wt], row nofreq 

* output to excel
cap  tabout age5year urban GEO-REGION educlvl wealthq rc_intr_use12mo using Tables_media_wm.xls [iw=wt] , c(row) f(1) append 
****************************************************
//Internet use frequency
* Indicator not available in all surveys so will add cap
*age
cap tab age5year rc_intr_usefreq [iw=wt], row nofreq 

*residence
cap tab urban rc_intr_usefreq [iw=wt], row nofreq 

*region
cap tab GEO-REGION rc_intr_usefreq [iw=wt], row nofreq 

*education
cap tab educlvl rc_intr_usefreq [iw=wt], row nofreq 

*wealth
cap tab wealthq rc_intr_usefreq [iw=wt], row nofreq 

* output to excel
cap tabout age5year urban GEO-REGION educlvl wealthq rc_intr_usefreq using Tables_media_wm.xls [iw=wt] , c(row) f(1) append 

**************************************************************************************************
* Indicators for employment and occupation: excel file Tables_employ_wm will be produced
**************************************************************************************************
//Employment status

*age
tab age5year rc_empl [iw=wt], row nofreq 

*marital status
tab currmarr rc_empl [iw=wt], row nofreq 

*residence
tab urban rc_empl [iw=wt], row nofreq 

*region
tab GEO-REGION rc_empl [iw=wt], row nofreq 

*education
tab educlvl rc_empl [iw=wt], row nofreq 

*wealth
tab wealthq rc_empl [iw=wt], row nofreq 

* output to excel
tabout age5year currmarr urban GEO-REGION educlvl wealthq rc_empl using Tables_employ_wm.xls [iw=wt] , c(row) f(1) replace 

****************************************************************************
//Occupation

*age
tab age5year rc_occup [iw=wt], row nofreq 

*marital status
tab currmarr rc_occup [iw=wt], row nofreq 

*residence
tab urban rc_occup [iw=wt], row nofreq 

*region
tab GEO-REGION rc_occup [iw=wt], row nofreq 

*education
tab educlvl rc_occup [iw=wt], row nofreq 

*wealth
tab wealthq rc_occup [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_occup using Tables_employ_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************************************

recode wkcurrjob (10/22 41/52 96/99 .=0 "Non-Agriculture") (31/32=1 "Agriculture") if inlist(wkworklastyr,11,12,13), gen(agri)

//Type of employer
tab rc_empl_type agri [iw=wt], col nofreq 

//Type of earnings
tab rc_empl_earn agri [iw=wt], col nofreq 

*Continuity of employment
tab rc_empl_cont agri [iw=wt], col nofreq 

* output to excel
cap tabout rc_empl_type rc_empl_earn rc_empl_cont agri using Tables_employ_wm.xls [iw=wt], c(col) f(1) append 

**************************************************************************************************
* Indicators for health insurance: excel file Tables_insurance_wm will be produced
**************************************************************************************************
//Social security

*age
tab age5year rc_hins_ss [iw=wt], row nofreq 

*residence
tab urban rc_hins_ss [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_ss [iw=wt], row nofreq 

*education
tab educlvl rc_hins_ss [iw=wt], row nofreq 

*wealth
tab wealthq rc_hins_ss [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_hins_ss using Tables_insurance_wm.xls [iw=wt] , c(row) f(1) replace 

****************************************************
//Other employer based insurance

*age
tab age5year rc_hins_empl [iw=wt], row nofreq 

*residence
tab urban rc_hins_empl [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_empl [iw=wt], row nofreq 

*education
tab educlvl rc_hins_empl [iw=wt], row nofreq 

*wealth
tab wealthq rc_hins_empl [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_hins_empl using Tables_insurance_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Community-based insurance

*age
tab age5year rc_hins_comm [iw=wt], row nofreq 

*residence
tab urban rc_hins_comm [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_comm [iw=wt], row nofreq 

*education
tab educlvl rc_hins_comm [iw=wt], row nofreq 

*wealth
tab wealthq rc_hins_comm [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_hins_comm using Tables_insurance_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Private insurance

*age
tab age5year rc_hins_priv [iw=wt], row nofreq 

*residence
tab urban rc_hins_priv [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_priv [iw=wt], row nofreq 

*education
tab educlvl rc_hins_priv [iw=wt], row nofreq 

*wealth
tab wealthq rc_hins_priv [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_hins_priv using Tables_insurance_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Other type of insurance

*age
tab age5year rc_hins_other [iw=wt], row nofreq 

*residence
tab urban rc_hins_other [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_other [iw=wt], row nofreq 

*education
tab educlvl rc_hins_other [iw=wt], row nofreq 

*wealth
tab wealthq rc_hins_other [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_hins_other using Tables_insurance_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Have any insurance

*age
tab age5year rc_hins_any [iw=wt], row nofreq 

*residence
tab urban rc_hins_any [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_any [iw=wt], row nofreq 

*education
tab educlvl rc_hins_any [iw=wt], row nofreq 

*wealth
tab wealthq rc_hins_any [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_hins_any using Tables_insurance_wm.xls [iw=wt] , c(row) f(1) append 

**************************************************************************************************
* Indicators for tobacco use: excel file Tables_tobac_wm will be produced
**************************************************************************************************
//Smokes cigarettes

*age
tab age5year rc_tobc_cig [iw=wt], row nofreq 

*residence
tab urban rc_tobc_cig [iw=wt], row nofreq 

*region
tab GEO-REGION rc_tobc_cig [iw=wt], row nofreq 

*education
tab educlvl rc_tobc_cig [iw=wt], row nofreq 

*wealth
tab wealthq rc_tobc_cig [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_tobc_cig using Tables_tobac_wm.xls [iw=wt] , c(row) f(1) replace 

****************************************************
//Smokes other type of tobacco

*age
tab age5year rc_tobc_other [iw=wt], row nofreq 

*residence
tab urban rc_tobc_other [iw=wt], row nofreq 

*region
tab GEO-REGION rc_tobc_other [iw=wt], row nofreq 

*education
tab educlvl rc_tobc_other [iw=wt], row nofreq 

*wealth
tab wealthq rc_tobc_other [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_tobc_other using Tables_tobac_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Smokes any tobacco

*age
tab age5year rc_tobc_smk_any [iw=wt], row nofreq 

*residence
tab urban rc_tobc_smk_any [iw=wt], row nofreq 

*region
tab GEO-REGION rc_tobc_smk_any [iw=wt], row nofreq 

*education
tab educlvl rc_tobc_smk_any [iw=wt], row nofreq 

*wealth
tab wealthq rc_tobc_smk_any [iw=wt], row nofreq 

* output to excel
tabout age5year urban GEO-REGION educlvl wealthq rc_tobc_smk_any using Tables_tobac_wm.xls [iw=wt] , c(row) f(1) append 

****************************************************
* Smokeless tobacco use
* These indicators are not available in all surveys so will add cap
//Snuff by mouth
cap tab rc_tobc_snuffm [iw=wt]

//Snuff by nose
cap tab rc_tobc_snuffn [iw=wt]

//Chews tobacco
cap tab rc_tobc_chew [iw=wt]

//Betel quid with tobacco
cap tab rc_tobv_betel [iw=wt]

//Other type of smokless tobacco
cap tab rc_tobc_osmkless [iw=wt]

//Any smokeless tobacco
cap tab rc_tobc_anysmkless [iw=wt]

//Uses any type of tobacco
cap tab rc_tobc_any [iw=wt]

* output to excel
cap tabout rc_tobc_snuffm rc_tobc_snuffn rc_tobc_chew rc_tobv_betel rc_tobc_osmkless rc_tobc_anysmkless rc_tobc_any using Tables_tobac_wm.xls [iw=wt] , oneway cells(cell freq) append 

}

****************************************************************************
****************************************************************************

* indicators from Men's file
if file=="Men" {
* limiting to men age 15-49
drop if agemn<15 | agemn>49

gen wt=perweightmn
**************************************************************************************************
* Background characteristics: excel file Tables_background_mn will be produced
**************************************************************************************************

*age
tab age5yearmn [iw=wt] 

*marital status
tab marstatmn [iw=wt] 

*residence
tab urbanmn [iw=wt] 

*region
tab GEO-REGION [iw=wt] 

*education
tab educlvlmn [iw=wt] 

*wealth
tab wealthqmn [iw=wt] 

* output to excel
tabout age5yearmn marstatmn urbanmn educlvlmn GEO-REGION wealthqmn using Tables_background_mn.xls [iw=wt] , oneway cells(cell freq) replace 
*/
**************************************************************************************************
* Indicators for education and literacy: excel file Tables_educ_mn will be produced
**************************************************************************************************
//Highest level of schooling

*age
tab age5yearmn rc_edu [iw=wt], row nofreq 

*residence
tab urbanmn rc_edu [iw=wt], row nofreq 

*region
tab GEO-REGION rc_edu [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_edu [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION wealthqmn rc_edu using Tables_educ_mn.xls [iw=wt] , c(row) f(1) replace 

//Median years of schooling
tab rc_edu_median 

tabout rc_edu_median using Tables_educ_mn.xls [iw=wt] , oneway cells(cell) append 

****************************************************
//Literacy levels

*age
tab age5yearmn rc_litr_cats [iw=wt], row nofreq 

*residence
tab urbanmn rc_litr_cats [iw=wt], row nofreq 

*region
tab GEO-REGION rc_litr_cats [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_litr_cats [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION wealthqmn rc_litr_cats using Tables_educ_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Literate 

*age
tab age5yearmn rc_litr [iw=wt], row nofreq 

*residence
tab urbanmn rc_litr [iw=wt], row nofreq 

*region
tab GEO-REGION rc_litr [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_litr [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION wealthqmn rc_litr using Tables_educ_mn.xls [iw=wt] , c(row) f(1) append 

**************************************************************************************************
* Indicators for media exposure and internet use: excel file Tables_media_mn will be produced
**************************************************************************************************
//Reads a newspaper

*age
tab age5yearmn rc_media_newsp [iw=wt], row nofreq 

*residence
tab urbanmn rc_media_newsp [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_newsp [iw=wt], row nofreq 

*education
tab educlvlmn rc_media_newsp [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_media_newsp [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_media_newsp using Tables_media_mn.xls [iw=wt] , c(row) f(1) replace 

****************************************************
//Watches TV

*age
tab age5yearmn rc_media_tv [iw=wt], row nofreq 

*residence
tab urbanmn rc_media_tv [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_tv [iw=wt], row nofreq 

*education
tab educlvlmn rc_media_tv [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_media_tv [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_media_tv using Tables_media_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Listens to radio

*age
tab age5yearmn rc_media_radio [iw=wt], row nofreq 

*residence
tab urbanmn rc_media_radio [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_radio [iw=wt], row nofreq 

*education
tab educlvlmn rc_media_radio [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_media_radio [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_media_radio using Tables_media_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//All three media

*age
tab age5yearmn rc_media_allthree [iw=wt], row nofreq 

*residence
tab urbanmn rc_media_allthree [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_allthree [iw=wt], row nofreq 

*education
tab educlvlmn rc_media_allthree [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_media_allthree [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_media_allthree using Tables_media_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//None of the media forms

*age
tab age5yearmn rc_media_none [iw=wt], row nofreq 

*residence
tab urbanmn rc_media_none [iw=wt], row nofreq 

*region
tab GEO-REGION rc_media_none [iw=wt], row nofreq 

*education
tab educlvlmn rc_media_none [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_media_none [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_media_none using Tables_media_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Ever used the internet
* Indicator not available in all surveys so will add cap
*age
cap tab age5yearmn rc_intr_ever [iw=wt], row nofreq 

*residence
cap tab urbanmn rc_intr_ever [iw=wt], row nofreq 

*region
cap tab GEO-REGION rc_intr_ever [iw=wt], row nofreq 

*education
cap tab educlvlmn rc_intr_ever [iw=wt], row nofreq 

*wealth
cap tab wealthqmn rc_intr_ever [iw=wt], row nofreq 

* output to excel
cap tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_intr_ever using Tables_media_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Internet use in the last 12 months
* Indicator not available in all surveys so will add cap
*age
cap tab age5yearmn rc_intr_use12mo [iw=wt], row nofreq 

*residence
cap tab urbanmn rc_intr_use12mo [iw=wt], row nofreq 

*region
cap tab GEO-REGION rc_intr_use12mo [iw=wt], row nofreq 

*education
cap tab educlvlmn rc_intr_use12mo [iw=wt], row nofreq 

*wealth
cap tab wealthqmn rc_intr_use12mo [iw=wt], row nofreq 

* output to excel
cap tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_intr_use12mo using Tables_media_mn.xls [iw=wt] , c(row) f(1) append 
****************************************************
//Internet use frequency
* Indicator not available in all surveys so will add cap
*age
cap tab age5yearmn rc_intr_usefreq [iw=wt], row nofreq 

*residence
cap tab urbanmn rc_intr_usefreq [iw=wt], row nofreq 

*region
cap tab GEO-REGION rc_intr_usefreq [iw=wt], row nofreq 

*education
cap tab educlvlmn rc_intr_usefreq [iw=wt], row nofreq 

*wealth
cap tab wealthqmn rc_intr_usefreq [iw=wt], row nofreq 

* output to excel
cap tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_intr_usefreq using Tables_media_mn.xls [iw=wt] , c(row) f(1) append 

**************************************************************************************************
* Indicators for employment and occupation: excel file Tables_employ_mn will be produced
**************************************************************************************************
//Employment status

*age
tab age5yearmn rc_empl [iw=wt], row nofreq 

*marital status
tab currmarrmn rc_empl [iw=wt], row nofreq 

*residence
tab urbanmn rc_empl [iw=wt], row nofreq 

*region
tab GEO-REGION rc_empl [iw=wt], row nofreq 

*education
tab educlvlmn rc_empl [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_empl [iw=wt], row nofreq 

* output to excel
tabout age5yearmn currmarrmn urbanmn GEO-REGION educlvlmn wealthqmn rc_empl using Tables_employ_mn.xls [iw=wt] , c(row) f(1) replace 

****************************************************************************
//Occupation

*age
tab age5yearmn rc_occup [iw=wt], row nofreq 

*marital status
tab currmarrmn rc_occup [iw=wt], row nofreq 

*residence
tab urbanmn rc_occup [iw=wt], row nofreq 

*region
tab GEO-REGION rc_occup [iw=wt], row nofreq 

*education
tab educlvlmn rc_occup [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_occup [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_occup using Tables_employ_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************************************
*
recode wkcurrjobmn (10/22 41/52 96/99 .=0 "Non-Agriculture") (31/32=1 "Agriculture") if inlist(wkworklastyrmn,11,12,13), gen(agri)

//Type of employer
tab rc_empl_type agri [iw=wt], col nofreq 

//Type of earnings
tab rc_empl_earn agri [iw=wt], col nofreq 

*Continuity of employment
tab rc_empl_cont agri [iw=wt], col nofreq 

* output to excel
cap tabout rc_empl_type rc_empl_earn rc_empl_cont agri using Tables_employ_mn.xls [iw=wt], c(col) f(1) append 
*/

**************************************************************************************************
* Indicators for health insurance: excel file Tables_insurance_wm will be produced
**************************************************************************************************
//Social security

*age
tab age5yearmn rc_hins_ss [iw=wt], row nofreq 

*residence
tab urbanmn rc_hins_ss [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_ss [iw=wt], row nofreq 

*education
tab educlvlmn rc_hins_ss [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_hins_ss [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_hins_ss using Tables_insurance_mn.xls [iw=wt] , c(row) f(1) replace 

****************************************************
//Other employer based insurance

*age
tab age5yearmn rc_hins_empl [iw=wt], row nofreq 

*residence
tab urbanmn rc_hins_empl [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_empl [iw=wt], row nofreq 

*education
tab educlvlmn rc_hins_empl [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_hins_empl [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_hins_empl using Tables_insurance_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Community-based insurance

*age
tab age5yearmn rc_hins_comm [iw=wt], row nofreq 

*residence
tab urbanmn rc_hins_comm [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_comm [iw=wt], row nofreq 

*education
tab educlvlmn rc_hins_comm [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_hins_comm [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_hins_comm using Tables_insurance_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Private insurance

*age
tab age5yearmn rc_hins_priv [iw=wt], row nofreq 

*residence
tab urbanmn rc_hins_priv [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_priv [iw=wt], row nofreq 

*education
tab educlvlmn rc_hins_priv [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_hins_priv [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_hins_priv using Tables_insurance_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Other type of insurance

*age
tab age5yearmn rc_hins_other [iw=wt], row nofreq 

*residence
tab urbanmn rc_hins_other [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_other [iw=wt], row nofreq 

*education
tab educlvlmn rc_hins_other [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_hins_other [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_hins_other using Tables_insurance_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Have any insurance

*age
tab age5yearmn rc_hins_any [iw=wt], row nofreq 

*residence
tab urbanmn rc_hins_any [iw=wt], row nofreq 

*region
tab GEO-REGION rc_hins_any [iw=wt], row nofreq 

*education
tab educlvlmn rc_hins_any [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_hins_any [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_hins_any using Tables_insurance_mn.xls [iw=wt] , c(row) f(1) append 

**************************************************************************************************
* Indicators for tobacco use: excel file Tables_tobac_mn will be produced
**************************************************************************************************
//Smokes cigarettes

*age
tab age5yearmn rc_tobc_cig [iw=wt], row nofreq 

*residence
tab urbanmn rc_tobc_cig [iw=wt], row nofreq 

*region
tab GEO-REGION rc_tobc_cig [iw=wt], row nofreq 

*education
tab educlvlmn rc_tobc_cig [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_tobc_cig [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_tobc_cig using Tables_tobac_mn.xls [iw=wt] , c(row) f(1) replace 

****************************************************
//Smokes other type of tobacco

*age
tab age5yearmn rc_tobc_other [iw=wt], row nofreq 

*residence
tab urbanmn rc_tobc_other [iw=wt], row nofreq 

*region
tab GEO-REGION rc_tobc_other [iw=wt], row nofreq 

*education
tab educlvlmn rc_tobc_other [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_tobc_other [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_tobc_other using Tables_tobac_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Smokes any tobacco

*age
tab age5yearmn rc_tobc_smk_any [iw=wt], row nofreq 

*residence
tab urbanmn rc_tobc_smk_any [iw=wt], row nofreq 

*region
tab GEO-REGION rc_tobc_smk_any [iw=wt], row nofreq 

*education
tab educlvlmn rc_tobc_smk_any [iw=wt], row nofreq 

*wealth
tab wealthqmn rc_tobc_smk_any [iw=wt], row nofreq 

* output to excel
tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_tobc_smk_any using Tables_tobac_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Smoking frequency

*age
cap tab age5yearmn rc_smk_freq [iw=wt], row nofreq 

*residence
cap tab urbanmn rc_smk_freq [iw=wt], row nofreq 

*region
cap tab GEO-REGION rc_smk_freq [iw=wt], row nofreq 

*education
cap tab educlvlmn rc_smk_freq [iw=wt], row nofreq 

*wealth
cap tab wealthqmn rc_smk_freq [iw=wt], row nofreq 

* output to excel
cap tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_smk_freq using Tables_tobac_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
//Average number of cigarettes per day

*age
cap tab age5yearmn rc_cig_day [iw=wt], row nofreq 

*residence
cap tab urbanmn rc_cig_day [iw=wt], row nofreq 

*region
cap tab GEO-REGION rc_cig_day [iw=wt], row nofreq 

*education
cap tab educlvlmn rc_cig_day [iw=wt], row nofreq 

*wealth
cap tab wealthqmn rc_cig_day [iw=wt], row nofreq 

* output to excel
cap tabout age5yearmn urbanmn GEO-REGION educlvlmn wealthqmn rc_cig_day using Tables_tobac_mn.xls [iw=wt] , c(row) f(1) append 

****************************************************
* Smokeless tobacco use

//Snuff by mouth
cap tab rc_tobc_snuffm [iw=wt]

//Snuff by nose
cap tab rc_tobc_snuffn [iw=wt]

//Chews tobacco
cap tab rc_tobc_chew [iw=wt]

//Betel quid with tobacco
cap tab rc_tobv_betel [iw=wt]

//Other type of smokless tobacco
cap tab rc_tobc_osmkless [iw=wt]

//Any smokeless tobacco
cap tab rc_tobc_anysmkless [iw=wt]

//Uses any type of tobacco
cap tab rc_tobc_any [iw=wt]

* output to excel
cap tabout rc_tobc_snuffm rc_tobc_snuffn rc_tobc_chew rc_tobv_betel rc_tobc_osmkless rc_tobc_anysmkless rc_tobc_any using Tables_tobac_mn.xls [iw=wt] , oneway cells(cell freq) append 

}
