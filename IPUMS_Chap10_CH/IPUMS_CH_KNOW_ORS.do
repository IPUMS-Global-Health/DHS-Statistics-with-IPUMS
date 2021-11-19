/*****************************************************************************************************
Program: 			IPUMS_CH_KNOW_ORS.do
Purpose: 			Code knowledge of ORS variable.
Data inputs: 		IR survey list
Data outputs:		coded variables
Author:				Shireen Assaf, modified by Faduma Shaba for this project
Date last modified: June 2020
Notes:
*****************************************************************************************************/
/* IPUMS Variables used in this file:
Women variables: 
diatrorsheard	"Heard of ORS for diarrhea treatment"
birthsin5yrs	"Number of births in last 5 years"
----------------------------------------------------------------------------
Variables created in this file:
ch_know_ors		"Know about ORS as treatment for diarrhea among women with birth in the last 5 years"
----------------------------------------------------------------------------*/

//Know ORS
gen ch_know_ors=0
replace ch_know_ors=1 if diatrorsheard>10 & diatrorsheard<98
replace ch_know_ors=. if birthsin5yrs==0
label var ch_know_ors "Know about ORS as treatment for diarrhea among women with birth in the last 5 years"
