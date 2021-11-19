/*****************************************************************************************************
Program: 			IPUMS_CH_STOOL.do
Purpose: 			Code disposal of child's stook variable
Data inputs: 			IPUMS DHS Children's Variables
Data outputs:			coded variables
Author:				Shireen Assaf, modified by Faduma Shaba for this project
Date last modified: 		July 2020
Notes:				This do file will drop cases.
					This is because the denominator is the youngest child under age 2 living with the mother.
					The do file will also produce the tables for these indicators.
*****************************************************************************************************/
/*
IPUMS DHS Variables:
Children variables:
region variable geo_CCYEAR		"Single sample geography variables"
perweight		"Sample weight for persons"
age				"Age"
caseid			"Sample specific respondent identifier"
kidliveswith	"Child lives with female respondent or others"
disposestool	"Disposal of youngest child's stools (when not using toilet)"

*/
/*----------------------------------------------------------------------------
Variables created in this file:
ch_stool_dispose	"How child's stool was disposed"
ch_stool_safe		"Child's stool was disposed of appropriately"
----------------------------------------------------------------------------*/

* keep if under 24 months and living with mother
keep if age < 24 & kidliveswith == 10

* and keep the last born of those.
* if caseid is the same as the prior case, then not the last born
keep if _n == 1 | caseid != caseid[_n-1]

//Stool disposal method
recode disposestool	(10=1 "Child used toilet or latrine") (21=2 "Put/rinsed into toilet or latrine") (40=3 "Buried") (22=4 "Put/rinsed into drain or ditch") ///
			(33=5 "Thrown into garbage") (34=6 "Left in the open") (70=96 "Other") (99=99 "DK/Missing") , gen(ch_stool_dispose)
label var ch_stool_dispose "How child's stool was disposed among youngest children under age 2 living with mother"

//Safe stool disposal
recode ch_stool_dispose	(1 2 3 =1 "Safe disposal") (else=0 "not safe") , gen(ch_stool_safe)
label var ch_stool_safe	"Child's stool was disposed of appropriately among youngest children under age 2 living with mother"

****************************************************************************
* Produce tables for the above indicators
****************************************************************************

*Age in months
drop agecats
recode age (0/5=1 " <6") (6/11=2 " 6-11") (12/23=3 " 12-23") (24/35=4 " 24-35") (36/47=5 " 36-47") (48/59=6 " 48-59"), gen(agecats)

drop wt
gen wt=perweight

//Disposal of children's stool

*Age in months (this may need to be recoded for this table)
tab agecats ch_stool_dispose [iw=wt], row nofreq

*residence
tab urban ch_stool_dispose [iw=wt], row nofreq

*region
tab regionkr ch_stool_dispose [iw=wt], row nofreq

*education
tab educlvl ch_stool_dispose [iw=wt], row nofreq

*wealth
tab wealthq ch_stool_dispose [iw=wt], row nofreq

* output to excel
tabout agecats urban educlvl regionkr wealthq ch_stool_dispose using Tables_Stool.xls [iw=wt], c(row) f(1) replace
**************************************************************************************************
//Safe disposal of stool

*Age in months (this may need to be recoded for this table)
tab agecats ch_stool_safe [iw=wt], row nofreq

*residence
tab urban ch_stool_safe [iw=wt], row nofreq

*region
tab regionkr ch_stool_safe [iw=wt], row nofreq

*education
tab educlvl ch_stool_safe [iw=wt], row nofreq

*wealth
tab wealthq ch_stool_safe [iw=wt], row nofreq

* output to excel
tabout agecats urban educlvl regionkr wealthq ch_stool_safe using Tables_Stool.xls [iw=wt], c(row) f(1) append
**************************************************************************************************
