/*****************************************************************************************************
Program: 			CH_VAC.do
Purpose: 			Code vaccination variables.
Data inputs: 		KR survey list
Data outputs:		coded variables
Author:				Shireen Assaf
Date last modified: March 13 2019 by Shireen Assaf 
					March 25 2021 by Trevor Croft to correct spelling of Pneumococcal
Notes:				Estimates can be created for two age groups (12-23) and (24-35). 
					
					!! Please choose the age group of interest in line 100.
					
					Vaccination indicators are country specific. However, most common vaccines are coded below and the same logic can be applied to others.
					When the vaccine is a single dose, the logic for single dose vaccines can be used (ex: bcg).
					When the vaccine has 3 doses, the logic for multiple dose vaccines can be used (ex: dpt)
*****************************************************************************************************/
/*
IPUMS variables used in this file:
Children variables:
kidalive		"Child is alive"
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

----------------------------------------------------------------------------
Variables created in this file:
ch_bcg_card			"BCG vaccination according to card"
ch_bcg_moth			"BCG vaccination according to mother"
ch_bcg_either		"BCG vaccination according to either source"

ch_pent1_card		"Pentavalent 1st dose vaccination according to card"
ch_pent1_moth		"Pentavalent 1st dose vaccination according to mother"
ch_pent1_either		"Pentavalent 1st dose vaccination according to either source"
ch_pent2_card		"Pentavalent 2nd dose vaccination according to card"
ch_pent2_moth		"Pentavalent 2nd dose vaccination according to mother"
ch_pent2_either		"Pentavalent 2nd dose vaccination according to either source"
ch_pent3_card		"Pentavalent 3rd dose vaccination according to card"
ch_pent3_moth		"Pentavalent 3rd dose vaccination according to mother"
ch_pent3_either		"Pentavalent 3rd dose vaccination according to either source"

ch_polio0_card		"Polio at birth vaccination according to card"
ch_polio0_moth		"Polio at birth vaccination according to mother"
ch_polio0_either	"Polio at birth vaccination according to either source"
ch_polio1_card		"Polio 1st dose vaccination according to card"
ch_polio1_moth		"Polio 1st dose vaccination according to mother"
ch_polio1_either	"Polio 1st dose vaccination according to either source"
ch_polio2_card		"Polio 2nd dose vaccination according to card"
ch_polio2_moth		"Polio 2nd dose vaccination according to mother"
ch_polio2_either	"Polio 2nd dose vaccination according to either source"
ch_polio3_card		"Polio 3rd dose vaccination according to card"
ch_polio3_moth		"Polio 3rd dose vaccination according to mother"
ch_polio3_either	"Polio 3rd dose vaccination according to either source"

ch_pneumo1_card		"Pneumococcal 1st dose vaccination according to card"
ch_pneumo1_moth		"Pneumococcal 1st dose vaccination according to mother"
ch_pneumo1_either	"Pneumococcal 1st dose vaccination according to either source"
ch_pneumo2_card		"Pneumococcal 2nd dose vaccination according to card"
ch_pneumo2_moth		"Pneumococcal 2nd dose vaccination according to mother"
ch_pneumo2_either	"Pneumococcal 2nd dose vaccination according to either source"
ch_pneumo3_card		"Pneumococcal 3rd dose vaccination according to card"
ch_pneumo3_moth		"Pneumococcal 3rd dose vaccination according to mother"
ch_pneumo3_either	"Pneumococcal 3rd dose vaccination according to either source"

ch_rotav1_card		"Rotavirus 1st dose vaccination according to card"
ch_rotav1_moth		"Rotavirus 1st dose vaccination according to mother"
ch_rotav1_either	"Rotavirus 1st dose vaccination according to either source"
ch_rotav2_card		"Rotavirus 2nd dose vaccination according to card"
ch_rotav2_moth		"Rotavirus 2nd dose vaccination according to mother"
ch_rotav2_either	"Rotavirus 2nd dose vaccination according to either source"
ch_rotav3_card		"Rotavirus 3rd dose vaccination according to card"
ch_rotav3_moth		"Rotavirus 3rd dose vaccination according to mother"
ch_rotav3_either	"Rotavirus 3rd dose vaccination according to either source"

ch_meas_card		"Measles vaccination according to card"
ch_meas_moth		"Measles vaccination according to mother"
ch_meas_either		"Measles vaccination according to either source"

ch_allvac_card		"All basic vaccinations according to card"
ch_allvac_moth		"All basic vaccinations according to mother"
ch_allvac_either	"All basic vaccinations according to either source"

ch_novac_card		"No vaccinations according to card"
ch_novac_moth		"No vaccinations according to mother"
ch_novac_either		"No vaccinations according to either source"

ch_card_ever_had	"Ever had a vacciation card"
ch_card_seen		"Vaccination card seen"
----------------------------------------------------------------------------*/

*** Two age groups used for reporting. 
	* choose age group of interest	
	*
	gen agegroup=0
	replace agegroup=1 if age>=12 & age<=23
	

	/*
	gen agegroup=0
	replace agegroup=1 if age>=24 & age<=35
	*/

* selecting children 
keep if agegroup==1
keep if kidalive==1
*******************************************************************************

* Source of vaccination information. We need this variable to code vaccination indicators by source.
recode healthcardkid (21=1 "card") (else=2 "mother"), gen(source)

*** BCG ***
//BCG either source
recode vacbcg (22 23 24=1) (else=0), gen(ch_bcg_either)

//BCG mother's report
gen ch_bcg_moth=ch_bcg_either 
replace ch_bcg_moth=0 if source==1

//BCG by card
gen ch_bcg_card=ch_bcg_either
replace ch_bcg_card=0 if source==2

label var ch_bcg_card	"BCG vaccination according to card"
label var ch_bcg_moth	"BCG vaccination according to mother"
label var ch_bcg_either	"BCG vaccination according to either source"

*** Pentavalent ***
//DPT 1, 2, 3 either source
* pentavalent vaccine variable name could be either vacdptpen1, vacdptpen2, vacdptpen3 OR vacdpt1, vacdpt2, & vacdpt3 depending on the survey. VACDPTPEN variables are likely to be found in surveys that were administered in late 2012 or later. Change below code based on which variable the survey uses.
recode vacdptpen1 (20/24=1) (else=0), gen(dpt1) //
recode vacdptpen2 (20/24=1) (else=0), gen(dpt2)
recode vacdptpen3 (20/24=1) (else=0), gen(dpt3)
gen dptsum= dpt1+dpt2+dpt3

* this step is performed for multi-dose vaccines to take care of any gaps in the vaccination history. See DHS guide to statistics 
* for further explanation
gen ch_pent1_either=dptsum>=1
gen ch_pent2_either=dptsum>=2
gen ch_pent3_either=dptsum>=3

//DPT 1, 2, 3 mother's report
gen ch_pent1_moth=ch_pent1_either
replace ch_pent1_moth=0 if source==1

gen ch_pent2_moth=ch_pent2_either
replace ch_pent2_moth=0 if source==1

gen ch_pent3_moth=ch_pent3_either
replace ch_pent3_moth=0 if source==1

//DPT 1, 2, 3 by card
gen ch_pent1_card=ch_pent1_either
replace ch_pent1_card=0 if source==2

gen ch_pent2_card=ch_pent2_either
replace ch_pent2_card=0 if source==2

gen ch_pent3_card=ch_pent3_either
replace ch_pent3_card=0 if source==2

drop dpt1 dpt2 dpt3 dptsum

label var ch_pent1_card	"Pentavalent 1st dose vaccination according to card"
label var ch_pent1_moth	"Pentavalent 1st dose vaccination according to mother"
label var ch_pent1_either "Pentavalent 1st dose vaccination according to either source"
label var ch_pent2_card	"Pentavalent 2nd dose vaccination according to card"
label var ch_pent2_moth	"Pentavalent 2nd dose vaccination according to mother"
label var ch_pent2_either "Pentavalent 2nd dose vaccination according to either source"
label var ch_pent3_card	"Pentavalent 3rd dose vaccination according to card"
label var ch_pent3_moth	"Pentavalent 3rd dose vaccination according to mother"
label var ch_pent3_either	"Pentavalent 3rd dose vaccination according to either source"

*** Polio ***

//polio 0, 1, 2, 3 either source
* for surveys that do not have vacopv0
cap gen vacopv0=.

recode vacopv0 (22/24=1) (else=0), gen(ch_polio0_either)

recode vacopv1 (22/24=1) (else=0), gen(polio1)
recode vacopv2 (22/24=1) (else=0), gen(polio2)
recode vacopv3 (22/24=1) (else=0), gen(polio3)
gen poliosum=polio1 + polio2 + polio3

* this step is performed for multi-dose vaccines to take care of any gaps in the vaccination history. See DHS guide to statistics 
* for further explanation
gen ch_polio1_either=poliosum>=1
gen ch_polio2_either=poliosum>=2
gen ch_polio3_either=poliosum>=3

//polio 0, 1, 2, 3 mother's report
gen ch_polio0_moth=ch_polio0_either
replace ch_polio0_moth=0 if source==1

gen ch_polio1_moth=ch_polio1_either
replace ch_polio1_moth=0 if source==1

gen ch_polio2_moth=ch_polio2_either
replace ch_polio2_moth=0 if source==1

gen ch_polio3_moth=ch_polio3_either
replace ch_polio3_moth=0 if source==1

//polio 0, 1, 2, 3 by card
gen ch_polio0_card=ch_polio0_either
replace ch_polio0_card=0 if source==2

gen ch_polio1_card=ch_polio1_either
replace ch_polio1_card=0 if source==2

gen ch_polio2_card=ch_polio2_either
replace ch_polio2_card=0 if source==2

gen ch_polio3_card=ch_polio3_either
replace ch_polio3_card=0 if source==2

drop poliosum polio1 polio2 polio3

label var ch_polio0_card "Polio at birth vaccination according to card"
label var ch_polio0_moth "Polio at birth vaccination according to mother"
label var ch_polio0_either "Polio at birth vaccination according to either source"
label var ch_polio1_card "Polio 1st dose vaccination according to card"
label var ch_polio1_moth "Polio 1st dose vaccination according to mother"
label var ch_polio1_either "Polio 1st dose vaccination according to either source"
label var ch_polio2_card "Polio 2nd dose vaccination according to card"
label var ch_polio2_moth "Polio 2nd dose vaccination according to mother"
label var ch_polio2_either "Polio 2nd dose vaccination according to either source"
label var ch_polio3_card "Polio 3rd dose vaccination according to card"
label var ch_polio3_moth "Polio 3rd dose vaccination according to mother"
label var ch_polio3_either "Polio 3rd dose vaccination according to either source"

*** Pneumococcal  ***
//Pneumococcal 1, 2, 3 either source
* for surveys that do not have information on this vaccine.
cap gen vacpneum1=.
cap gen vacpneum2=.
cap gen vacpneum3=.

recode vacpneum1 (22/24=1) (else=0), gen(Pneumo1)
recode vacpneum2 (22/24=1) (else=0), gen(Pneumo2)
recode vacpneum3 (22/24=1) (else=0), gen(Pneumo3)
gen Pneumosum= Pneumo1+Pneumo2+Pneumo3

* this step is performed for multi-dose vaccines to take care of any gaps in the vaccination history. See DHS guide to statistics 
* for further explanation
gen ch_pneumo1_either=Pneumosum>=1
gen ch_pneumo2_either=Pneumosum>=2
gen ch_pneumo3_either=Pneumosum>=3

//Pneumococcal 1, 2, 3 mother's report
gen ch_pneumo1_moth=ch_pneumo1_either
replace ch_pneumo1_moth=0 if source==1

gen ch_pneumo2_moth=ch_pneumo2_either
replace ch_pneumo2_moth=0 if source==1

gen ch_pneumo3_moth=ch_pneumo3_either
replace ch_pneumo3_moth=0 if source==1

//Pneumococcal 1, 2, 3 by card
gen ch_pneumo1_card=ch_pneumo1_either
replace ch_pneumo1_card=0 if source==2

gen ch_pneumo2_card=ch_pneumo2_either
replace ch_pneumo2_card=0 if source==2

gen ch_pneumo3_card=ch_pneumo3_either
replace ch_pneumo3_card=0 if source==2

drop Pneumo1 Pneumo2 Pneumo3 Pneumosum

label var ch_pneumo1_card "Pneumococcal 1st dose vaccination according to card"
label var ch_pneumo1_moth "Pneumococcal 1st dose vaccination according to mother"
label var ch_pneumo1_either "Pneumococcal 1st dose vaccination according to either source"
label var ch_pneumo2_card "Pneumococcal 2nd dose vaccination according to card"
label var ch_pneumo2_moth "Pneumococcal 2nd dose vaccination according to mother"
label var ch_pneumo2_either "Pneumococcal 2nd dose vaccination according to either source"
label var ch_pneumo3_card "Pneumococcal 3rd dose vaccination according to card"
label var ch_pneumo3_moth "Pneumococcal 3rd dose vaccination according to mother"
label var ch_pneumo3_either "Pneumococcal 3rd dose vaccination according to either source"

*** Rotavirus  ****
//Rotavirus 1, 2, 3 either source
* for surveys that do not have information on this vaccine.
cap gen vacrota1=.
cap gen vacrota2=.
cap gen vacrota3=.

recode vacrota1 (22/24=1) (else=0), gen(rotav1)
recode vacrota2 (22/24=1) (else=0), gen(rotav2)
recode vacrota3 (22/24=1) (else=0), gen(rotav3)
gen rotavsum= rotav1+rotav2+rotav3

* this step is performed for multi-dose vaccines to take care of any gaps in the vaccination history. See DHS guide to statistics 
* for further explanation
gen ch_rotav1_either=rotavsum>=1
gen ch_rotav2_either=rotavsum>=2
gen ch_rotav3_either=rotavsum>=3

//Rotavirus 1, 2, 3 mother's report
gen ch_rotav1_moth=ch_rotav1_either
replace ch_rotav1_moth=0 if source==1

gen ch_rotav2_moth=ch_rotav2_either
replace ch_rotav2_moth=0 if source==1

gen ch_rotav3_moth=ch_rotav3_either
replace ch_rotav3_moth=0 if source==1

//Rotavirus 1, 2, 3 by card
gen ch_rotav1_card=ch_rotav1_either
replace ch_rotav1_card=0 if source==2

gen ch_rotav2_card=ch_rotav2_either
replace ch_rotav2_card=0 if source==2

gen ch_rotav3_card=ch_rotav3_either
replace ch_rotav3_card=0 if source==2

drop rotav1 rotav2 rotav3 rotavsum

label var ch_rotav1_card "Rotavirus 1st dose vaccination according to card"
label var ch_rotav1_moth "Rotavirus 1st dose vaccination according to mother"
label var ch_rotav1_either "Rotavirus 1st dose vaccination according to either source"
label var ch_rotav2_card "Rotavirus 2nd dose vaccination according to card"
label var ch_rotav2_moth "Rotavirus 2nd dose vaccination according to mother"
label var ch_rotav2_either "Rotavirus 2nd dose vaccination according to either source"
label var ch_rotav3_card "Rotavirus 3rd dose vaccination according to card"
label var ch_rotav3_moth "Rotavirus 3rd dose vaccination according to mother"
label var ch_rotav3_either "Rotavirus 3rd dose vaccination according to either source"

*** Measles ***
//measles either source
recode vacmeas1 (22/24=1) (else=0), gen(ch_meas_either)

//measles mother's report
gen ch_meas_moth=ch_meas_either
replace ch_meas_moth=0 if source==1

//measles by card
gen ch_meas_card=ch_meas_either
replace ch_meas_card=0 if source==2

label var ch_meas_card "Measles vaccination according to card"
label var ch_meas_moth "Measles vaccination according to mother"
label var ch_meas_either "Measles vaccination according to either source"

*** All vaccinations ***
gen ch_allvac_either=ch_bcg_either==1&ch_pent3_either==1&ch_polio3_either==1&ch_meas_either==1
label var ch_allvac_either "All basic vaccinations according to either source"

gen ch_allvac_moth=ch_allvac_either
replace ch_allvac_moth=0 if source==1
label var ch_allvac_moth "All basic vaccinations according to mother"

gen ch_allvac_card=ch_allvac_either
replace ch_allvac_card=0 if source==2
label var ch_allvac_card "All basic vaccinations according to card"

*** No vaccinations ***
gen ch_novac_either=ch_bcg_either==0&ch_pent1_either==0&ch_pent2_either==0&ch_pent3_either==0 ///
					&ch_polio0_either==0&ch_polio1_either==0&ch_polio2_either==0&ch_polio3_either==0&ch_meas_either==0
label var ch_novac_either "No vaccinations according to either source"

gen ch_novac_moth=ch_novac_either
replace ch_novac_moth=0 if source==1
label var ch_novac_moth "No vaccinations according to mother"

gen ch_novac_card=ch_novac_either
replace ch_novac_card=0 if source==2
label var ch_novac_card "No vaccinations according to card"

*** vaccination card possession ***
recode healthcardkid(11/22=1) (else=0), gen(ch_card_ever_had)
label var ch_card_ever_had "Ever had a vacciation card"

recode healthcardkid(21=1) (else=0), gen(ch_card_seen)
label var ch_card_seen "Vaccination card seen"
