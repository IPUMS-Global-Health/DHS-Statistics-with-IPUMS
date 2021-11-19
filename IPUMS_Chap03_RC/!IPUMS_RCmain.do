/*******************************************************************************************************************************
Program: 				IPUMS_RCmain.do
Purpose: 				Main file for the Respondents' Characteristics Chapter. 
						The main file will call other do files that will produce the RC indicators and produce tables.
Data outputs:			Coded variables and table output on screen and in excel tables.  
Author: 				Shireen Assaf, modified by Kassandra Fate
Date last modified:		August 27 2021 by Kassandra Fate
*******************************************************************************************************************************/
/* DIRECTIONS
Submitting a Data Extract with IPUMS DHS
1.	Navigate to https://www.idhsdata.org/idhs/
2.	Under “DATA” in the left-hand toolbar, select “BROWSE AND SELECT DATA”
3.	Choose your Unit of Analysis for data browsing: women, children, births, household members, or men
4.	Select the appropriate data sample(s) for your project in terms of countries and years
5.	Select the appropriate variables for your project using the drop-down menu “Select Variables”
IPUMS DHS Variables used in this file:
Women: edachiever edyrtotal lit2 educlvl newsfq tvfq radiofq internetevyr internetmo wkworklastyr wkcurrjob whoworkfor wkearntype wkemploywhen inssocs insemployer insorg insprivate insother inscoveryn tocigfq tosmoke tosnuff topipe tocigar toshisha tosnuffm tosnuffn tochew toghutka touseoth tosmokeothfq currmarr
Men: edachievermn edyrtotalmn lit2mn educlvlmn newsfqmn tvfqmn radiofqmn internetevyrmn internetmomn wkworklastyrmn wkcurrjobmn whoworkformn wkearntypemn wkemploywhenmn inssocsmn insemployermn insorgmn insprivatemn insothermn inscoverynmn tociginddaymn tohandrolldaymn tokretekdaymn tocigindwkmn tohandrollwkmn tokretekwkmn tosmokemn topipedaymn tocigardaymn toshishadaymn tosmokeothdaymn topipewkmn tocigarwkmn toshishawkmn tosmokeothwkmn topipemn touseothmn tosmokefqmn tosnuffmdaymn tosnuffmwkmn tosnuffndaymn tosnuffnwkmn tochewdaymn tochewwkmn tobeteldaymn tobetelwkmn tosmokelessdaymn tosmokelesswkmn tosmokelessfqmn agemn age5yearmn urbanmn wealthqmn marstatmn
Note: In IPUMS DHS, each survey's region variable has a unique name to facilitate
	pooling data. These variables can be found in the IPUMS drop down menu under:
		GEOGRAPHY -> SINGLE SAMPLE GEOGRAPHY
6.	Add the above variables to your cart
7.	View your cart using the data cart
a.	Note: the associated weights will also appear in your cart
8.	Once you are satisfied with your variable collection, select “CREATE DATA EXTRACT”
9.	Choose your desired data format and click submit
a.	Note: For use with Stata: choose “Stata (.dta)”
10.	Optional: Describe your extract for easy organization between your multiple data extracts
11.	Select “Submit Extract”
12.	Check the email you used for your IPUMS account for notification of when your data extract is ready
13.	Download and save the data files to open the data set in your desired data software
14. Open dataset
----------------------------------------------------------------------------*/
set more off

global datapath "$datapath//$rcdata.dta"

* select your survey

* Women's Files
global womensdata "$datapath//$womensdata.dta"

* Men's Files
global mensdata "$datapath//$mensdata.dta"
****************************

* Women's file variables

* open dataset
use "$datapath//$womensdata.dta", clear

gen file=substr("$womensdata", 3, 2)

do IPUMS_RC_CHAR.do
*Purpose: 	Code respondent characteristic indicators for women

do IPUMS_RC_tables.do
*Purpose: 	Produce tables for indicators computed from IPUMS_RC_CHAR.do file. 
* Note:		This will drop any women and men not in 15-49 age range. You can change this selection. Please check the notes in the do file.

*/
*******************************************************************************************************************************
*******************************************************************************************************************************

* Men's file variables

* open dataset
use "$datapath//$mensdata.dta", clear

gen file=substr("$mensdata", 3, 2)

do IPUMS_RC_CHAR.do
*Purpose: 	Code respondent characteristic indicators for men

do IPUMS_RC_tables.do
*Purpose: 	Produce tables for indicators computed from IPUMS_RC_CHAR.do file. 
* Note:		This will drop any women and men not in 15-49 age range. You can change this selection. Please check the notes in the do file.

*/
*******************************************************************************************************************************
*******************************************************************************************************************************

