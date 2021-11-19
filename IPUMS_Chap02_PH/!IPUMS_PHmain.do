/*******************************************************************************************************************************
Program: 				IPUMS_PHmain.do
Purpose: 				Main file for the Population and Housing Chapter. 
						The main file will call other do files that will produce the PH indicators.
Data outputs:			Coded variables  
Author: 				Shireen Assaf, modified by Kassandra Fate for this project
Date last modified:		July 29, 2021 by Kassandra Fate
*******************************************************************************************************************************/

/* DIRECTIONS
Submitting a Data Extract with IPUMS DHS
1.	Navigate to https://www.idhsdata.org/idhs/
2.	Under “DATA” in the left-hand toolbar, select “BROWSE AND SELECT DATA”
3.	Choose your Unit of Analysis for data browsing: women, children, births, household members, or men
4.	Select the appropriate data sample(s) for your project in terms of countries and years
5.	Select the appropriate variables for your project using the drop-down menu “Select Variables”
IPUMS DHS Variables used in this file:
HNDWSH variables: handwashwtr hwsoap handwashsand handwashplobs
HOUS variables: electrchh floor sleeprooms cookwhere cookfuel tosmkhhfreq radiohh tvhh mobphone hhphonehh pc fridgehh bikehh motorcyclhh carhh boatwmotor drawncart aglandyn livestockyn
POP variables: hhage hhbirthcert motheralive fatheralive sex hhresident hhrelate edsumm wealthqhh hhnumall clusternoall hhlineno hhsize urbanhh
SCHOL variables: hhlineno hhweight wealthqhh urbanhh hhnum clusternoall hhnumall hhage hhslept hhintcmc edlevelnow sex
GINI variables:hhlineno hhrelate wealthqhh dejureno
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
14. 	Open dataset
----------------------------------------------------------------------------*/

set more off

* Household file variables (use for indicators where households are the unit of analysis)

*******************************************************************************************************************************

* open dataset
use "$datapath//$hhdata.dta", clear

gen file=substr("$hhdata", 3, 2)
gen filename=strlower(substr("$hhdata", 1, 6))

do IPUMS_PH_SANI.do
* Purpose: 	Code Sanitation indicators

do IPUMS_PH_WATER.do
* Purpose: 	Code Water Source indicators

do IPUMS_PH_HOUS.do
* Purpose:	Code housing indicators such as house material, assets, cooking fuel and place, and smoking in the home

do IPUMS_PH_tables.do
* Purpose: 	Produce tables for indicators computed from the above do files
*/

*******************************************************************************************************************************

* open dataset
use "$datapath//$hhdata.dta", clear

gen file=substr("$hhdata", 3, 2)

do IPUMS_PH_HNDWSH.do
* Purpose:	Code handwashing indicators

do IPUMS_PH_tables.do
* Purpose: 	Produce tables for indicators computed from the above do files

do IPUMS_PH_SCHOL.do
* Purpose:	Code education and schooling indicators. 
* Note: This code will merge birth and household files and drop some cases. It will also produce the excel file Tables_schol 

* open dataset again since cases were dropped in IPUMS_PH_EDU.do
use "$datapath//$hhdata.dta", clear

do IPUMS_PH_POP.do
* Purpose: 	Code to compute population characteristics, birth registration, education levels, household composition, orphanhood, and living arrangments
* Warning: This do file will collapse the data and therefore some indicators produced will be lost. However, they are saved in the file PR_temp_children.dta and this data file will be used to produce the tables for these indicators in the IPUMS_PH_table code. This do file will produce the Tables_hh_comps for household composition (usually Table 2.8 or 2.9 in the Final Report). 

do IPUMS_PH_tables2.do
* Purpose: 	Produce tables for indicators computed from the IPUMS_PH_POP.do file
*/
*
do IPUMS_PH_GINI.do
* Purpose:	Code to produce Gini index table. 
* Note: 	This code will collapse the data and produce the table Table_gini.xls

*/

*******************************************************************************************************************************
