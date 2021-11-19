/*****************************************************************************************************
Program: 			  IPUMS_PH_HNDWSH.do
Purpose: 			  Code to compute handwashing indicators
Data inputs: 		IPUMS DHS HH survey list
Data outputs:		coded variables
Author:				  Shireen Assaf, modified by Faduma Shaba and Kassandra Fate for this project
Date last modified: May 2021
*****************************************************************************************************/

/*----------------------------------------------------------------------------
IPUMS DHS Variables used in this file:
handwashwtr			"Place observed for handwashing with water"
hwsoap				"Place observed for handwashing with soap"
handwashsand		"Place observed for handwashing with cleansing agent other than soap"
handwashplobs		"Household has place for handwashing (observed)"
idhshid				"Unique cross-sample household identifier"
----------------------------------------------------------------------------
Variables Created:
handwashfxd			"Fixed place for handwashing"
handwashmob			"Mobile place for handwashing"
handwashany			"Either fixed or mobile place for handwashing"
hwbasic				"Basic handwashing facility"
hwlimited			"Limited handwashing facility"
----------------------------------------------------------------------------*/

cap label define yesno 0"No" 1"Yes"


//Fixed place for handwashing
gen ph_hndwsh_place_fxd= handwashplobs==21
replace ph_hndwsh_place_fxd=. if hhresident!=1
label values ph_hndwsh_place_fxd yesno
label var ph_hndwsh_place_fxd "Fixed place for handwashing"

//Mobile place for handwashing
gen ph_hndwsh_place_mob= handwashplobs==22
replace ph_hndwsh_place_mob=. if hhresident!=1
label values ph_hndwsh_place_mob yesno
label var ph_hndwsh_place_mob "Mobile place for handwashing"

//Fixed or mobile place for handwashing
gen ph_hndwsh_place_any= inlist(handwashplobs,21,22)
replace ph_hndwsh_place_any=. if hhresident!=1
label values ph_hndwsh_place_any yesno
label var ph_hndwsh_place_any "Either fixed or mobile place for handwashing"

//Place observed for handwashing with water
gen ph_hndwsh_water= 0 if inlist(handwashplobs,21,22)
replace ph_hndwsh_water= 1 if handwashwtr==1
replace ph_hndwsh_water=. if hhresident!=1
label values ph_hndwsh_water yesno
label var ph_hndwsh_water "Place observed for handwashing with water"

//Place observed for handwashing with soap
gen ph_hndwsh_soap= 0 if inlist(handwashplobs,21,22)
replace ph_hndwsh_soap=1 if hwsoap==1
replace ph_hndwsh_soap=. if hhresident!=1
label values ph_hndwsh_soap yesno
label var ph_hndwsh_soap "Place observed for handwashing with soap"

//Place observed for handwashing with cleansing agent other than soap
gen ph_hndwsh_clnsagnt= 0 if inlist(handwashplobs,21,22)
replace ph_hndwsh_clnsagnt=1 if handwashsand==1
replace ph_hndwsh_clnsagnt=. if hhresident!=1
label values ph_hndwsh_clnsagnt yesno
label var ph_hndwsh_clnsagnt "Place observed for handwashing with cleansing agent other than soap"

//Basic handwashing facility
gen ph_hndwsh_basic= 0 if inlist(handwashplobs,21,22,10)
replace ph_hndwsh_basic=1 if handwashwtr==1 & hwsoap==1
replace ph_hndwsh_basic=. if hhresident!=1
label values ph_hndwsh_basic yesno
label var ph_hndwsh_basic "Basic handwashing facility"

//Limited handwashing facility
gen ph_hndwsh_limited= 0 if inlist(handwashplobs,21,22,10)
replace ph_hndwsh_limited=1 if handwashwtr==0 | hwsoap==0
replace ph_hndwsh_limited=. if hhresident!=1
label values ph_hndwsh_limited yesno
label var ph_hndwsh_limited	"Limited handwashing facility"
