/*****************************************************************************************************
Program: 			CH_tables_vac.do
Purpose: 			produce tables for vaccination indicators
Author:				Shireen Assaf
Date last modified: May 14 2019 by Shireen Assaf 

*Note this do file will produce the following tables in excel:
	1. 	Tables_Vac:		Contains the tables for child's vaccination indicators
	
	Note:	These tables will be produced for the age group selection in the CH_VAC.do file. 
			The default section is children 12-23 months. If estimates are requried for children 24-35 months, 
			the CH_VAC.do file needs to be run again with that age group selection and then this do file to produce files
			can be run agian. 
*****************************************************************************************************/

* the total will show on the last row of each table.
* comment out the tables or indicator section you do not want.
***IPUMS variables used in this file: ***
/*Children variables:
region variable geo_CCYEAR		"Single sample geography variables"
perweight		"Sample weight for persons"
kidbord			"Child's birth order number"
kidsex			"Sex of Child"
urban			"Urban-rural status"
educlvl			"Highest educational level"
wealthq			"Household wealth index in quintiles"
*/
****************************************************

cap gen wt=perweight

* Non-standard background variable to add to tables
* birth order: 1, 2-3, 4-5, 6+
cap gen birth_order=1
replace birth_order=2 if kidbord>1 
replace birth_order=3 if kidbord>3
replace birth_order=4 if kidbord>5 
replace birth_order=. if kidbord==.
cap label define birth_order 1 "1" 2"2-3" 3 "4-5" 4 "6+"
label values birth_order birth_order

**************************************************************************************************
* Table for vaccines by source
**************************************************************************************************
//BCG
tab1 ch_bcg_card ch_bcg_moth ch_bcg_either [iw=wt]

//DPT
tab1	ch_pent1_card ch_pent1_moth ch_pent1_either ///
		ch_pent2_card ch_pent2_moth	ch_pent2_either	///
		ch_pent3_card ch_pent3_moth ch_pent3_either	[iw=wt]	

//Polio
tab1	ch_polio0_card ch_polio0_moth ch_polio0_either ///	
		ch_polio1_card ch_polio1_moth ch_polio1_either ///
		ch_polio2_card ch_polio2_moth ch_polio2_either ///
		ch_polio3_card ch_polio3_moth ch_polio3_either [iw=wt]

//Pneumococcal
tab1	ch_pneumo1_card ch_pneumo1_moth ch_pneumo1_either ///	
		ch_pneumo2_card ch_pneumo2_moth ch_pneumo2_either ///
		ch_pneumo3_card ch_pneumo3_moth ch_pneumo3_either [iw=wt]

//Rotavirus
tab1	ch_rotav1_card ch_rotav1_moth ch_rotav1_either ///	
		ch_rotav2_card ch_rotav2_moth ch_rotav2_either ///	
		ch_rotav3_card ch_rotav3_moth ch_rotav3_either [iw=wt]

//Measles
tab1 ch_meas_card ch_meas_moth ch_meas_either [iw=wt]

//All basic vaccinations
tab1 ch_allvac_card ch_allvac_moth ch_allvac_either	[iw=wt]

//No vaccinations
tab1 ch_novac_card ch_novac_moth ch_novac_either [iw=wt]	

* output to excel
tabout	ch_bcg_card ch_bcg_moth ch_bcg_either ch_pent1_card ch_pent1_moth ch_pent1_either ///
		ch_pent2_card ch_pent2_moth	ch_pent2_either	ch_pent3_card ch_pent3_moth ch_pent3_either	 ///
		ch_polio0_card ch_polio0_moth ch_polio0_either ch_polio1_card ch_polio1_moth ch_polio1_either ///
		ch_polio2_card ch_polio2_moth ch_polio2_either ch_polio3_card ch_polio3_moth ch_polio3_either ///
		ch_pneumo1_card ch_pneumo1_moth ch_pneumo1_either ch_pneumo2_card ch_pneumo2_moth ch_pneumo2_either ///
		ch_pneumo3_card ch_pneumo3_moth ch_pneumo3_either ch_rotav1_card ch_rotav1_moth ch_rotav1_either ///	
		ch_rotav2_card ch_rotav2_moth ch_rotav2_either ch_rotav3_card ch_rotav3_moth ch_rotav3_either ///
		ch_meas_card ch_meas_moth ch_meas_either ch_allvac_card ch_allvac_moth ch_allvac_either ///
		ch_novac_card ch_novac_moth ch_novac_either using Tables_Vac.xls [iw=wt] , oneway cells(cell) f(1) replace 
		
		
**************************************************************************************************
* Table for vaccinations by background variables: 
* Note: this table is for children age 12-23. If you have 
* selected the 24-35 age group in the CH_VAC.do file, then you must rerun the do file with selecting the 12-23
* age group in order to match the table.
**************************************************************************************************
//BCG

*child's sex
tab kidsex ch_bcg_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_bcg_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_bcg_either [iw=wt], row nofreq 

*residence
tab urban ch_bcg_either [iw=wt], row nofreq 

*region
tab regionkr ch_bcg_either [iw=wt], row nofreq 

*education
tab educlvl ch_bcg_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_bcg_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_bcg_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//DPT1

*child's sex
tab kidsex ch_pent1_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_pent1_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_pent1_either [iw=wt], row nofreq 

*residence
tab urban ch_pent1_either [iw=wt], row nofreq 

*region
tab regionkr ch_pent1_either [iw=wt], row nofreq 

*education
tab educlvl ch_pent1_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_pent1_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_pent1_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//DPT2

*child's sex
tab kidsex ch_pent2_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_pent2_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_pent2_either [iw=wt], row nofreq 

*residence
tab urban ch_pent2_either [iw=wt], row nofreq 

*region
tab regionkr ch_pent2_either [iw=wt], row nofreq 

*education
tab educlvl ch_pent2_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_pent2_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_pent2_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//DPT3

*child's sex
tab kidsex ch_pent3_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_pent3_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_pent3_either [iw=wt], row nofreq 

*residence
tab urban ch_pent3_either [iw=wt], row nofreq 

*region
tab regionkr ch_pent3_either [iw=wt], row nofreq 

*education
tab educlvl ch_pent3_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_pent3_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_pent3_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Polio0

*child's sex
tab kidsex ch_polio0_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_polio0_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_polio0_either [iw=wt], row nofreq 

*residence
tab urban ch_polio0_either [iw=wt], row nofreq 

*region
tab regionkr ch_polio0_either [iw=wt], row nofreq 

*education
tab educlvl ch_polio0_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_polio0_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_polio0_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Polio1

*child's sex
tab kidsex ch_polio1_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_polio1_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_polio1_either [iw=wt], row nofreq 

*residence
tab urban ch_polio1_either [iw=wt], row nofreq 

*region
tab regionkr ch_polio1_either [iw=wt], row nofreq 

*education
tab educlvl ch_polio1_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_polio1_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_polio1_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Polio2

*child's sex
tab kidsex ch_polio2_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_polio2_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_polio2_either [iw=wt], row nofreq 

*residence
tab urban ch_polio2_either [iw=wt], row nofreq 

*region
tab regionkr ch_polio2_either [iw=wt], row nofreq 

*education
tab educlvl ch_polio2_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_polio2_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_polio2_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Polio3

*child's sex
tab kidsex ch_polio3_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_polio3_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_polio3_either [iw=wt], row nofreq 

*residence
tab urban ch_polio3_either [iw=wt], row nofreq 

*region
tab regionkr ch_polio3_either [iw=wt], row nofreq 

*education
tab educlvl ch_polio3_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_polio3_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_polio3_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Pneumococcal1

*child's sex
tab kidsex ch_pneumo1_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_pneumo1_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_pneumo1_either [iw=wt], row nofreq 

*residence
tab urban ch_pneumo1_either [iw=wt], row nofreq 

*region
tab regionkr ch_pneumo1_either [iw=wt], row nofreq 

*education
tab educlvl ch_pneumo1_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_pneumo1_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_pneumo1_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Pneumococcal2

*child's sex
tab kidsex ch_pneumo2_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_pneumo2_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_pneumo2_either [iw=wt], row nofreq 

*residence
tab urban ch_pneumo2_either [iw=wt], row nofreq 

*region
tab regionkr ch_pneumo2_either [iw=wt], row nofreq 

*education
tab educlvl ch_pneumo2_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_pneumo2_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_pneumo2_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Pneumococcal3

*child's sex
tab kidsex ch_pneumo3_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_pneumo3_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_pneumo3_either [iw=wt], row nofreq 

*residence
tab urban ch_pneumo3_either [iw=wt], row nofreq 

*region
tab regionkr ch_pneumo3_either [iw=wt], row nofreq 

*education
tab educlvl ch_pneumo3_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_pneumo3_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_pneumo3_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Rotavirus1

*child's sex
tab kidsex ch_rotav1_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_rotav1_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_rotav1_either [iw=wt], row nofreq 

*residence
tab urban ch_rotav1_either [iw=wt], row nofreq 

*region
tab regionkr ch_rotav1_either [iw=wt], row nofreq 

*education
tab educlvl ch_rotav1_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_rotav1_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_rotav1_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Rotavirus2

*child's sex
tab kidsex ch_rotav2_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_rotav2_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_rotav2_either [iw=wt], row nofreq 

*residence
tab urban ch_rotav2_either [iw=wt], row nofreq 

*region
tab regionkr ch_rotav2_either [iw=wt], row nofreq 

*education
tab educlvl ch_rotav2_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_rotav2_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_rotav2_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Rotavirus3

*child's sex
tab kidsex ch_rotav3_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_rotav3_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_rotav3_either [iw=wt], row nofreq 

*residence
tab urban ch_rotav3_either [iw=wt], row nofreq 

*region
tab regionkr ch_rotav3_either [iw=wt], row nofreq 

*education
tab educlvl ch_rotav3_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_rotav3_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_rotav3_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Measles

*child's sex
tab kidsex ch_meas_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_meas_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_meas_either [iw=wt], row nofreq 

*residence
tab urban ch_meas_either [iw=wt], row nofreq 

*region
tab regionkr ch_meas_either [iw=wt], row nofreq 

*education
tab educlvl ch_meas_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_meas_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_meas_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//All basic vaccinations

*child's sex
tab kidsex ch_allvac_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_allvac_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_allvac_either [iw=wt], row nofreq 

*residence
tab urban ch_allvac_either [iw=wt], row nofreq 

*region
tab regionkr ch_allvac_either [iw=wt], row nofreq 

*education
tab educlvl ch_allvac_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_allvac_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_allvac_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//No vaccinations

*child's sex
tab kidsex ch_novac_either [iw=wt], row nofreq 

*birth order
tab birth_order ch_novac_either [iw=wt], row nofreq 

*vaccination card seen
tab ch_card_seen ch_novac_either [iw=wt], row nofreq 

*residence
tab urban ch_novac_either [iw=wt], row nofreq 

*region
tab regionkr ch_novac_either [iw=wt], row nofreq 

*education
tab educlvl ch_novac_either [iw=wt], row nofreq 

*wealth
tab wealthq ch_novac_either [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_novac_either using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
**************************************************************************************************
* Table for possession and observation of vaccination cards
**************************************************************************************************
//Ever had a vaccination card

*child's sex
tab kidsex ch_card_ever_had [iw=wt], row nofreq 

*birth order
tab birth_order ch_card_ever_had [iw=wt], row nofreq 

*residence
tab urban ch_card_ever_had [iw=wt], row nofreq 

*region
tab regionkr ch_card_ever_had [iw=wt], row nofreq 

*education
tab educlvl ch_card_ever_had [iw=wt], row nofreq 

*wealth
tab wealthq ch_card_ever_had [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_card_ever_had using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
//Vaccination card seen

*child's sex
tab kidsex ch_card_seen [iw=wt], row nofreq 

*birth order
tab birth_order ch_card_seen [iw=wt], row nofreq 

*residence
tab urban ch_card_seen [iw=wt], row nofreq 

*region
tab regionkr ch_card_seen [iw=wt], row nofreq 

*education
tab educlvl ch_card_seen [iw=wt], row nofreq 

*wealth
tab wealthq ch_card_seen [iw=wt], row nofreq 

* output to excel
tabout kidsex birth_order ch_card_seen urban educlvl regionkr wealthq ch_card_seen using Tables_Vac.xls [iw=wt], c(row) f(1) append 
*/
****************************************************
