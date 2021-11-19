/*****************************************************************************************************
Program: 			IPUMS_RC_CHAR.do
Purpose: 			Code to compute respondent characteristics in men and women using IPUMS DHS variables
Credits:			This file replaces files created by The DHS Program, for use with IPUMS DHS
Data inputs: 		IPUMS DHS Women or Men Variables
Data outputs:		coded variables
Author:				Shireen Assaf, modified by Faduma Shaba and Kassandra Fate for this project		
Date last modified:	August 2021
Note:				The indicators below can be computed for women or for men. Please check the note on health insurance. This can be country specific and also reported for specific populations.
*****************************************************************************************************/

/*----------------------------------------------------------------------------
WOMEN'S IPUMS DHS variables used in this file:
educlvl			"Highest level of schooling attended or completed"
edyrtotal		"Total years of education"
edachiever		"Summary educational achievement"
lit2			"Level of literacy"
newsfq			"Frequency of reading newspaper or magazine"
tvfq			"Frequency of watching television"
radiofq			"Frequency of listening to radio"
internetevyr	"Ever used the internet / Used the internet in the past 12 months"
internetmo		"Internet use frequency in the past month - among users in the past 12 months"
wkcurrjob		"Occupation among those employed in the past 12 months"
whoworkfor		"Type of employer among those employed in the past 12 months"
wkearntype		"Type of earnings among those employed in the past 12 months"
wkworklastyr	"Continuity of employment among those employed in the past 12 months"
wkemploywhen	"Respondent works all year. seasonally, or occasionally"
inssocs			"Health insurance coverage - social security"
insemployer		"Health insurance coverage - other employer-based insurance"
insorg			"Health insurance coverage - mutual health org. or community-based insurance"
insprivate		"Health insurance coverage - privately purchased commercial insurance"
insother		"Health insurance coverage - other type of insurance"
inscoveryn		"Have any health insurance"
tosmoke			"Smokes cigarettes"
tocigfq			"Frequency smokes cigarettes"
to snuff		"Uses snuff"
tosnuffm		"Uses snuff smokeless tobacco by mouth"
tosnuffn		"Uses snuff smokeless tobacco by nose"
topipe			"Smokes pipe"
tocigar			"Smokes cigars"
toshisha		"Uses water pipe"
tochew			"Chews tobacco"
toghutka		"Uses betel quid with tobacco"
touseoth		"Uses other tobacco"
tosmokeothfq	"Frequency smokes / uses non-cigarette tobacco product"
----------------------------------------------------------------------------
MEN'S IPUMS DHS variables used in this file:
edachievermn	"Man's summary educational achievement"
edyrtotalmn		"Man's total years of education"
lit2mn			"Literacy, based on reading passage"
educlvlmn		"Highest educational level"
newsfqmn		"Frequency of reading newspaper or magazine"
tvfqmn			"Frequency of watching television"
radiofqmn		"Frequency of listening to radio"
internetevyrmn	"Used the internet ever and in past year"
internetmomn	"Frequency of using internet in last month"
wkworklastyrmn	"Respondent worked recently"
wkcurrjobmn		"Man's occupation"
whoworkformn	"Works for family, others, or self"
wkearntypemn	"Type of earnings from respondent's work"
wkemploywhenmn	"Respondent works all year, seasonally, or occasionally"
inssocsmn		"Health insurance type: government / social security"
insemployermn	"Health insurance type: through employer"
insorgmn		"Health insurance type: mutual / community organization"
insprivatemn	"Health insurance type: private / commercially purchased"
insothermn		"Health insurance type: other"
inscoverynmn	"Covered by health insurance"
tociginddaymn	"Number of manufactured cigarettes usually smoke each day"
tohandrolldaymn	"Number of hand-rolled cigarettes usually smoke each day"
tokretekdaymn	"Number of kreteks usually smoke each day"
tocigindwkmn	"Number of manufactured cigarettes usually smoke each week"
tohandrollwkmn	"Number of hand-rolled cigarettes usually smoke each week"
tokretekwkmn	"Number of kreteks usually smoke each week"
tosmokemn		"Current tobacco use: cigarettes"
topipedaymn		"Number of pipes usually smoke each day"
tocigardaymn	"Number of cigars, cheroots, or cigarellos usually smoke each day"
toshishadaymn	"Number of hookah, shisha, or water pipe sessions usually have each day"
tosmokeothdaymn	"Number of times usually smoke other types of tobacco each day"
topipewkmn		"Number of pipes usually smoke each week"
tocigarwkmn		"Number of cigars, cheroots, or cigarellos usually smoke each week"
toshishawkmn	"Number of hookah, shisha, or water pipe sessions usually have each week"
tosmokeothwkmn	"Number of times usually smoke other types of tobacco each week"
topipemn		"Current tobacco use: pipe"
touseothmn		"Current tobacco use: other"
tosmokefqmn		"Frequently currently smokes tobacco"
tosnuffmdaymn	"Times usually use snuff by mouth each day"
tosnuffmwkmn	"Times usually use snuff by mouth each week"
tosnuffndaymn	"Times usually use snuff by nose each day"
tosnuffnwkmn	"Times usually use snuff by nose each week"
tochewdaymn		"Times usually use chewing tobacco each day"
tochewwkmn		"Times usually use chewing tobacco each week"
tobeteldaymn	"Times usually use betel quid with tobacco each day"
tobetelwkmn		"Times usually use betel quid with tobacco each week"
tosmokelessdaymn"Times usually use other smokeless tobacco each day"
tosmokelesswkmn	"Times usually use other smokeless tobacco each week"
tosmokelessfqmn	"Frequency uses smokeless tobacco"
agemn			"Age"
age5yearmn		"Age in 5-year groups"
urbanmn			"Type of place of residence"
wealthqmn		"Household wealth in quintiles"
marstatmn		"Man's current marital or union status"
----------------------------------------------------------------------------
Variables created in this file:
rc_edu				"Highest level of schooling attended or completed"
rc_edu_median		"Median years of education"
rc_litr_cats		"Level of literacy"
rc_litr				"Literate - higher than secondary or can read part or whole sentence"
rc_media_newsp		"Reads a newspaper at least once a week"
rc_media_tv			"Watches television at least once a week"
rc_media_radio		"Listens to radio at least once a week"
rc_media_allthree	"Accesses to all three media at least once a week"
rc_media_none		"Accesses none of the three media at least once a week"
rc_intr_ever		"Ever used the internet"
rc_intr_use12mo		"Used the internet in the past 12 months"
rc_intr_usefreq		"Internet use frequency in the past month - among users in the past 12 months"
rc_empl				"Employment status"
rc_occup			"Occupation among those employed in the past 12 months"
rc_empl_type		"Type of employer among those employed in the past 12 months"
rc_empl_earn		"Type of earnings among those employed in the past 12 months"
rc_empl_cont		"Continuity of employment among those employed in the past 12 months"
rc_hins_ss			"Health insurance coverage - social security"
rc_hins_empl		"Health insurance coverage - other employer-based insurance"
rc_hins_comm		"Health insurance coverage - mutual health org. or community-based insurance"
rc_hins_priv		"Health insurance coverage - privately purchased commercial insurance"
rc_hins_other		"Health insurance coverage - other type of insurance"
rc_hins_any			"Have any health insurance"
rc_tobc_cig			"Smokes cigarettes"
rc_tobc_other		"Smokes other type of tobacco"
rc_tobc_smk_any		"Smokes any type of tobacco"
rc_smk_freq			"Smoking frequency"
rc_cig_day			"Average number of cigarettes smoked per day"
rc_tobc_snuffm		"Uses snuff smokeless tobacco by mouth"
rc_tobc_snuffn		"Uses snuff smokeless tobacco by nose"
rc_tobc_chew		"Chews tobacco"
rc_tobv_betel		"Uses betel quid with tobacco"
rc_tobc_osmkless	"Uses other type of smokeless tobacco"
rc_tobc_anysmkless	"Uses any type of smokeless tobacco"
rc_tobc_any			"Uses any type of tobacco - smoke or smokeless"
----------------------------------------------------------------------------*/

* indicators from Women's file
if file=="Women" {

label define yesno 0"No" 1"Yes"
*** Education ***

//Highest level of education
gen rc_edu= edachiever
label values rc_edu EDACHIEVER
label var rc_edu "Highest level of schooling attended or completed"

//Median years of education
gen eduyr=edyrtotal 
replace eduyr=20 if edyrtotal>20 & edyrtotal<95
replace eduyr=. if edyrtotal>95 | edachiever>7 

summarize edyrtotal [aweight=perweight], detail

*summarize saves the data in the r()store
*50% percentile
	scalar sp50=r(p50)
*This saves a scalar-sp50- as the 50th percentile in the edyrtotal r store.

	gen dummy=.
	replace dummy=0
	replace dummy=1 if edyrtotal<sp50
	*This makes all edyrtotal over the median (sp50) = the categorical binary 1
	summarize dummy [aweight=perweight]
	scalar sL=r(mean)
	*This saves a scalar-sL- as the mean in the edyrtotal r store.
	drop dummy

	gen dummy=.
	replace dummy=0
	replace dummy=1 if eduyr <=sp50
	summarize dummy [aweight=perweight]
	scalar sU=r(mean)
	drop dummy

	gen rc_edu_median=round(sp50-1+(.5-sL)/(sU-sL),.01)
	label var rc_edu_median	"Median years of education"

//Literacy level
recode lit2 (12=1 ) (11=2) (0=3) (21=4) (22=5), gen(rc_litr_cats)
replace rc_litr_cats=0 if educlvl==3
label define rc_litr_cats 0"Higher than secondary education" 1"Can read a whole sentence"2 "Can read part of a sentence" 3 "Cannot read at all" ///
4 "No card with required language" 5 "Blind/visually impaired"
label values rc_litr_cats rc_litr_cats
label var rc_litr_cats	"Level of literacy"

//Literate
gen rc_litr=0
replace rc_litr=1 if educlvl==3 | lit2==11 | lit2==12
label values rc_litr yesno
label var rc_litr "Literate - higher than secondary or can read part or whole sentence"

*** Media exposure ***

//Media exposure - newspaper
recode newsfq (20/30=1 "Yes") (0/10=0 "No"), gen(rc_media_newsp)
label var rc_media_newsp "Reads a newspaper at least once a week"

//Media exposure - TV
recode tvfq (20/30=1 "Yes") (0/10=0 "No"), gen(rc_media_tv)
label var rc_media_tv "Watches television at least once a week"

//Media exposure - Radio
recode radiofq (20/30=1 "Yes") (0/10=0 "No"), gen(rc_media_radio)
label var rc_media_radio "Listens to radio at least once a week"

//Media exposure - all three
gen rc_media_allthree=0
replace rc_media_allthree=1 if inlist(newsfq,20,30) & inlist(radiofq,20,30) & inlist(tvfq,20,30) 
label values rc_media_allthree yesno
label var rc_media_allthree "Accesses to all three media at least once a week"

//Media exposure - none
gen rc_media_none=0
replace rc_media_none=1 if (newsfq!=20 & newsfq!=30) & (radiofq!=20 & radiofq!=30) & (tvfq!=20 & tvfq!=30) 
label values rc_media_none yesno
label var rc_media_none "Accesses none of the three media at least once a week"

//Ever used internet
* Indicator not available in all surveys so will add cap
cap recode internetevyr (0=0 "No") (11/13=1 "Yes"), gen(rc_intr_ever) 
cap label var rc_intr_ever "Ever used the internet"

//Used interent in the past 12 months
* Indicator not available in all surveys so will add cap
cap recode internetevyr (0 12/13=0 "No") (11=1 "Yes"), gen(rc_intr_use12mo) 
cap label var rc_intr_use12mo "Used the internet in the past 12 months"

//Internet use frequency
* Indicator not available in all surveys so will add cap
cap gen rc_intr_usefreq= internetmo if internetevyr==11
cap label values rc_intr_usefreq INTERNETMO
cap label var rc_intr_usefreq "Internet use frequency in the past month - among users in the past 12 months"

*** Employment ***

//Employment status
recode wkworklastyr (0=0 "Not employed in last 12 months") (11=1 "Not currently working but was employed in last 12 months") (12/13=2 "Currently employed") (98=9 "Don't know/missing"), gen(rc_empl)
label var rc_empl "Employment status"

//Occupation
recode wkcurrjob (10=1 "Professional") (21=2 "Clerical") (22 42=3 "Sales and services") (51=4 "Skilled manual") (52=5 "Unskilled manual") (41=6 "Domestic service") (31/32=7 "Agriculture") (96/99 .=9 "Don't know/missing") if inlist(wkworklastyr,11,12,13), gen(rc_occup)
label var rc_occup "Occupation among those employed in the past 12 months"

//Type of employer
gen rc_empl_type=whoworkfor if inlist(wkworklastyr,11,12,13)
label values rc_empl_type WHOWORKFOR
label var rc_empl_type "Type of employer among those employed in the past 12 months"

//Type of earnings
gen rc_empl_earn=wkearntype if inlist(wkworklastyr,11,12,13)
label values rc_empl_earn WKEARNTYPE
label var rc_empl_earn "Type of earnings among those employed in the past 12 months"

//Continuity of employment
gen rc_empl_cont=wkemploywhen if inlist(wkworklastyr,11,12,13)
label values rc_empl_cont WKEMPLOYWHEN
label var rc_empl_cont "Continuity of employment among those employed in the past 12 months"

*** Health insurance ***
* Note: The different types of health insurance can be country specific. Please check the health insurance variables to see which ones you need.
* In addition, some surveys report this for all women/men and some report it among those that have heard of insurance. Please check what the population of interest is for reporting these indicators.

//Health insurance - Social security
gen rc_hins_ss = inssocs==1
label var rc_hins_ss "Health insurance coverage - social security"

//Health insurance - Other employer-based insurance
gen rc_hins_empl = insemployer==1
label var rc_hins_empl "Health insurance coverage - other employer-based insurance"

//Health insurance - Mutual Health Organization or community-based insurance
gen rc_hins_comm = insorg==1
label var rc_hins_comm "Health insurance coverage - mutual health org. or community-based insurance"

//Health insurance - Privately purchased commercial insurance
gen rc_hins_priv = insprivate==1
label var rc_hins_priv "Health insurance coverage - privately purchased commercial insurance"

//Health insurance - Other
gen rc_hins_other = insother==1
label var rc_hins_other "Health insurance coverage - other type of insurance"

//Health insurance - Any
gen rc_hins_any = inscoveryn==1
label var rc_hins_any "Have any health insurance"

*** Tobacco use ***
* please check availability of variables for types of smoking and tobacco use

//Smokes cigarettes
*for some surveys tosmoke was used instead of tocigfq
*however tosmoke is not a yes/no variable for cigarette smoking, tocigfq is the frequency
cap gen tocigfq=tosmoke 
gen rc_tobc_cig=inlist(tocigfq,1,2) | tosnuff==1
label var rc_tobc_cig "Smokes cigarettes"

//Smokes other type of tobacco
cap gen rc_tobc_other= topipe==1 | tocigar==1 | toshisha==1
label var rc_tobc_other "Smokes other type of tobacco"

//Smokes any type of tobacco
cap gen rc_tobc_smk_any=inlist(tocigfq,1,2) | tosnuff==1 | topipe==1 | tocigar==1 | toshisha==1 
label var rc_tobc_smk_any "Smokes any type of tobacco"

//Snuff by mouth
* Indicator not available in all surveys so will add cap
cap gen rc_tobc_snuffm = tosnuffm==1
cap label values rc_tobc_snuffm yesno
cap label var rc_tobc_snuffm "Uses snuff smokeless tobacco by mouth"

//Snuff by nose
* Indicator not available in all surveys so will add cap
cap gen rc_tobc_snuffn = tosnuffn==1
cap label values rc_tobc_snuffn yesno
cap label var rc_tobc_snuffn "Uses snuff smokeless tobacco by nose"

//Chewing tobacco
* Indicator not available in all surveys so will add cap
cap gen rc_tobc_chew = tochew==1
cap label values rc_tobc_chew yesno
cap label var rc_tobc_chew "Chews tobacco"

//Betel quid with tobacco
* Indicator not available in all surveys so will add cap
cap gen rc_tobv_betel = toghutka==1
cap label values rc_tobv_betel yesno
cap label var rc_tobv_betel "Uses betel quid with tobacco"

//Other type of smokeless tobacco
*Note: there may be other types of smokeless tobacco, please check all v463* variables.
cap gen rc_tobc_osmkless = touseoth==1
cap label values rc_tobc_osmkless yesno
cap label var rc_tobc_osmkless "Uses other type of smokeless tobacco"

//Any smokeless tobacco
gen rc_tobc_anysmkless=0
replace rc_tobc_anysmkless=1 if inlist(tosnuff,1,995) | tosnuffm==1 | tosnuffn==1 | tochew==1 | toghutka==1 | toshisha==1
label values rc_tobc_anysmkless yesno
label var rc_tobc_anysmkless "Uses other type of smokeless tobacco"

//Any tobacco
* Indicator not available in all surveys so will add cap
cap gen rc_tobc_any= inlist(tocigfq,1,2) | inlist(tosmokeothfq,1,2)
cap label values rc_tobc_any yesno
cap label var rc_tobc_any "Uses any type of tobacco - smoke or smokeless"
}

* indicators from Men's file
if file=="Men" {

label define yesno 0"No" 1"Yes"

*** Education ***

//Highest level of education
gen rc_edu= edachievermn
label values rc_edu EDACHIEVERMN
label var rc_edu "Highest level of schooling attended or completed"

//Median years of education
gen eduyr=edyrtotalmn 
replace eduyr=20 if edyrtotalmn>20 & edyrtotalmn<95
replace eduyr=. if edyrtotalmn>95 | edachievermn>7 

summarize eduyr [aweight=perweightmn], detail
* 50% percentile
	scalar sp50=r(p50)
	
	gen dummy=. 
	replace dummy=0 
	replace dummy=1 if eduyr<sp50 
	summarize dummy [aweight=perweightmn]
	scalar sL=r(mean)
	drop dummy
	
	gen dummy=. 
	replace dummy=0 
	replace dummy=1 if eduyr <=sp50 
	summarize dummy [aweight=perweightmn]
	scalar sU=r(mean)
	drop dummy

	gen rc_edu_median=round(sp50-1+(.5-sL)/(sU-sL),.01)
	label var rc_edu_median	"Median years of education"
	
//Literacy level
recode lit2mn (12=1 ) (11=2) (0=3) (21=4) (22=5), gen(rc_litr_cats)
replace rc_litr_cats=0 if educlvlmn==3
label define rc_litr_cats 0"Higher than secondary education" 1"Can read a whole sentence"2 "Can read part of a sentence" 3 "Cannot read at all" ///
4 "No card with required language" 5 "Blind/visually impaired"
label values rc_litr_cats rc_litr_cats
label var rc_litr_cats	"Level of literacy"

//Literate 
gen rc_litr=0
replace rc_litr=1 if educlvlmn==3 | lit2mn==11 | lit2mn==12	
label values rc_litr yesno
label var rc_litr "Literate - higher than secondary or can read part or whole sentence"

*** Media exposure ***

//Media exposure - newspaper
recode newsfqmn (20/30=1 "Yes") (0/10=0 "No"), gen(rc_media_newsp)
label var rc_media_newsp "Reads a newspaper at least once a week"

//Media exposure - TV
recode tvfqmn (120/130=1 "Yes") (0/110=0 "No"), gen(rc_media_tv)
label var rc_media_tv "Watches television at least once a week"

//Media exposure - Radio
recode radiofqmn (20/30=1 "Yes") (0/10=0 "No"), gen(rc_media_radio)
label var rc_media_radio "Listens to radio at least once a week"

//Media exposure - all three
gen rc_media_allthree=0
replace rc_media_allthree=1 if inlist(newsfqmn,20,30) & inlist(radiofqmn,20,30) & inlist(tvfqmn,120,130) 
label values rc_media_allthree yesno
label var rc_media_allthree "Accesses to all three media at least once a week"

//Media exposure - none
gen rc_media_none=0
replace rc_media_none=1 if (newsfqmn!=20 & newsfqmn!=30) & (radiofqmn!=20 & radiofqmn!=30) & (tvfqmn!=120 & tvfqmn!=130) 
label values rc_media_none yesno
label var rc_media_none "Accesses none of the three media at least once a week"

//Ever used internet
* Indicator not available in all surveys so will add cap
cap recode internetevyrmn (0=0 "No") (11/13=1 "Yes"), gen(rc_intr_ever) 
cap label var rc_intr_ever "Ever used the internet"

//Used interent in the past 12 months
* Indicator not available in all surveys so will add cap
cap recode internetevyrmn (0 12/13=0 "No") (11=1 "Yes"), gen(rc_intr_use12mo) 
cap label var rc_intr_use12mo "Used the internet in the past 12 months"

//Internet use frequency
* Indicator not available in all surveys so will add cap
cap gen rc_intr_usefreq= internetmomn if internetevyrmn==11
cap label values rc_intr_usefreq INTERNETMOMN
cap label var rc_intr_usefreq "Internet use frequency in the past month - among users in the past 12 months"

*** Employment ***

//Employment status
recode wkworklastyrmn (0=0 "Not employed in last 12 months") (11=1 "Not currently working but was employed in last 12 months") (12/13=2 "Currently employed") (98=9 "Don't know/missing"), gen(rc_empl)
label var rc_empl "Employment status"

//Occupation
recode wkcurrjobmn (10=1 "Professional") (21=2 "Clerical") (22 42=3 "Sales and services") (51=4 "Skilled manual") (52=5 "Unskilled manual") (41=6 "Domestic service") (31/32=7 "Agriculture") (96/99 .=9 "Don't know/missing") if inlist(wkworklastyrmn,11,12,13), gen(rc_occup)
label var rc_occup "Occupation among those employed in the past 12 months"

* Some survyes do not ask the following employment questions so a capture was added to skip these variables if they are not present. 
//Type of employer
cap gen rc_empl_type=whoworkformn if inlist(wkworklastyrmn,11,12,13)
cap label values rc_empl_type WHOWORKFORMN
cap label var rc_empl_type "Type of employer among those employed in the past 12 months"

//Type of earnings
cap gen rc_empl_earn=wkearntypemn if inlist(wkworklastyrmn,11,12,13)
cap label values rc_empl_earn WKEARNTYPEMN
cap label var rc_empl_earn "Type of earnings among those employed in the past 12 months"

//Continuity of employment
cap gen rc_empl_cont=wkemploywhenmn if inlist(wkworklastyrmn,11,12,13)
cap label values rc_empl_cont WKEMPLOYWHENMN
cap label var rc_empl_cont "Continuity of employment among those employed in the past 12 months"

*** Health insurance ***
* Note: The different types of health insurance can be country specific. Please check the health insurance variables to see which ones you need.
* In addition, some surveys report this for all women/men and some report it among those that have heard of insurance. Please check what the population of interest is for reporting these indicators.

//Health insurance - Social security
gen rc_hins_ss = inssocsmn==1
label var rc_hins_ss "Health insurance coverage - social security"

//Health insurance - Other employer-based insurance
gen rc_hins_empl = insemployermn==1
label var rc_hins_empl "Health insurance coverage - other employer-based insurance"

//Health insurance - Mutual Health Organization or community-based insurance
gen rc_hins_comm = insorgmn==1
label var rc_hins_comm "Health insurance coverage - mutual health org. or community-based insurance"

//Health insurance - Privately purchased commercial insurance
gen rc_hins_priv = insprivatemn==1
label var rc_hins_priv "Health insurance coverage - privately purchased commercial insurance"

//Health insurance - Other
gen rc_hins_other = insothermn==1
label var rc_hins_other "Health insurance coverage - other type of insurance"

//Health insurance - Any
gen rc_hins_any = inscoverynmn==1
label var rc_hins_any "Have any health insurance"

*** Tobacco Use ***
*some surveys used older variables for smoking and tobacco

//Smokes cigarettes
gen rc_tobc_cig=0
cap replace rc_tobc_cig=1 if inlist(tociginddaymn,1,995) | inlist(tohandrollday,1,995) | inlist(tocigindwkmn,1,995) | inlist(tohandrollwkmn,1,995) | inlist(tokretekdaymn,1,995) | inlist(tokretekwkmn,1,995)

*for older surveys use following variable
cap replace rc_tobc_cig= 1 if tosmokemn==1
label var rc_tobc_cig "Smokes cigarettes"

//Smokes other type of tobacco
gen rc_tobc_other= 0
cap replace rc_tobc_other=1 if inlist(topipedaymn,1,995) | inlist(tosmokeothdaymn,1,995) | inlist(topipewkmn,1,995) | inlist(tosmkothwkmn,1,995) | inlist(tocigardaymn,1,995) | inlist(toshishadaymn,1,995) | inlist(tocigarwkmn,1,995) | inlist(toshishawkmn,1,995)

*for older surveys use following variables
cap replace rc_tobc_other=1 if topipemn==1 | touseothmn==1
label var rc_tobc_other "Smokes other type of tobacco"

//Smokes any type of tobacco
gen rc_tobc_smk_any= 0
cap replace rc_tobc_other=1 if inlist(tociginddaymn,1,995) | inlist(tohandrolldaymn,1,995) | inlist(tocigindwkmn,1,995) | inlist(tohandrollwkmn,1,995) | inlist(topipedaymn,1,995) | inlist(tosmokeothdaymn,1,995) | inlist(topipewkmn,1,995) | inlist(tosmokeothwkmn,1,995) | inlist(tokretekdaymn,1,995) | inlist(tokretekwkmn,1,995) | inlist(tocigardaymn,1,995) | inlist(toshishadaymn,1,995) | inlist(tocigarwkmn,1,995) | inlist(toshishawkmn,1,995)

*for older surveys use following variables
cap rc_tobc_smk_any= 1 if tosmokemn==1 | topipemn==1 | touseothmn==1 
label var rc_tobc_smk_any "Smokes any type of tobacoo"

//Smoking frequency
cap gen rc_smk_freq=tosmokefqmn
label define rc_smk_freq 0"Non-smoker" 1"Occasional smoker" 2"Daily smoker"
cap label values rc_smk_freq rc_smk_freq
cap label var rc_smk_freq "Smoking frequency"

//Average number of cigarettes per day
cap recode tociginddaymn (995=.)
cap recode tohandrolldaymn (995=.)
cap recode tokretekdaymn (995=.)
cap gen cigdaily= tociginddaymn + tohandrolldaymn + tokretekdaymn 
recode cigdaily (1/4=1 "<5") (5/9=2 "5-9") (10/14=3 "10-14") (15/24=4 "15-24") (25/95=5 "25+") (else=9 "Don't know/missing") if rc_smk_freq==2 & cigdaily>0, gen (rc_cig_day)
label var rc_cig_day "Average number of cigarettes smoked per day"

//Snuff by mouth
cap gen rc_tobc_snuffm = inlist(tosnuffmdaymn,1,995) | inlist(tosnuffmwkmn,1,995)
cap label values rc_tobc_snuffm yesno
cap label var rc_tobc_snuffm "Uses snuff smokeless tobacco by mouth"

//Snuff by nose
cap gen rc_tobc_snuffn = inlist(tosnuffndaymn,1,995) | inlist(tosnuffnwkmn,1,995)
cap label values rc_tobc_snuffn yesno
cap label var rc_tobc_snuffn "Uses snuff smokeless tobacco by nose"

//Chewing tobacco
cap gen rc_tobc_chew = inlist(tochewdaymn,1,995) | inlist(tochewwkmn,1,995)
cap label values rc_tobc_chew yesno
cap label var rc_tobc_chew "Chews tobacco"

//Betel quid with tobacco
cap gen rc_tobv_betel = inlist(tobeteldaymn,1,995) | inlist(tobetelwkmn,1,995)
cap label values rc_tobv_betel yesno
cap label var rc_tobv_betel "Uses betel quid with tobacco"

//Other type of smokeless tobacco
*Note: there may be other types of smokeless tobacco, please check all smoking variables. 
cap gen rc_tobc_osmkless = inlist(tosmokelessdaymn,1,995) | inlist(tosmokelesswkmn,1,995)
cap label values rc_tobc_osmkless yesno
cap label var rc_tobc_osmkless "Uses other type of smokeless tobacco"

//Any smokeless tobacco
gen rc_tobc_anysmkless=0
cap replace rc_tobc_anysmkless=1 if inlist(tochewdaymn,1,995) | inlist(tosmokelessdaymn,1,995) | inlist(tochewwkmn,1,995) | inlist(tosmokelesswkmn,1,995) | inlist(tosnuffmdaymn,1,995) | inlist(tosnuffndaymn,1,995) | inlist(tobeteldaymn,1,995) | inlist(tosnuffmwkmn,1,995) | inlist(tosnuffnwkmn,1,995) | inlist(tobetelwkmn,1,995)
cap replace rc_tobc_anysmkless=1 if rc_tobc_osmkless==1
cap label values rc_tobc_anysmkless yesno
cap label var rc_tobc_anysmkless "Uses any type of smokeless tobacco"

//Any tobacco 
cap gen rc_tobc_any= inlist(tosmokefqmn,1,2) | inlist(tosmokelessfqmn,1,2)
cap label values rc_tobc_any yesno
cap label var rc_tobc_any "Uses any type of tobacco - smoke or smokeless"
}
