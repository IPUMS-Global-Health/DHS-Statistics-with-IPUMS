/*****************************************************************************************************
Program: 			PH_tables.do
Purpose: 			produce tables for indicators
Author:				Shireen Assaf
Date last modified: July 2021 by Kassandra Fate
*Note this do file will produce the following tables in excel:
	1. Tables_hh_wash:			Contains the table for WASH (water and santitation) indicators
	2. Tables_hh_charac:			Contains the table for household characteristics
	3. Tables_hh_poss:			Contains the table for household possessions
	4. Tables_handwsh:			Contains the table for handwashing indicators
Notes: 					 						
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

* indicators from Household file
if file=="household" {

cap gen wt=hhweight

**************************************************************************************************
* Indicators for WASH indicators: excel file Tables_hh_WASH will be produced
**************************************************************************************************
* all WASH characteristics are crosstabulated by place of residence

*type of water source
	tab ph_wtr_source urbanhh [iw=wt] , col

*improved drinking water source
	tab ph_wtr_improve urbanhh [iw=wt] , col

*round trip time to obtaining water
	tab ph_wtr_time urbanhh [iw=wt] , col

*basic or limited water service
	tab ph_wtr_basic urbanhh [iw=wt] , col

*availability of water among those using piped water 
	tab ph_wtr_avail urbanhh [iw=wt] , col

*treatment of water: boil
	tab ph_wtr_trt_boil urbanhh [iw=wt] , col
	
*treatment of water: bleach or chlorine
	tab ph_wtr_trt_chlor urbanhh [iw=wt] , col
	
*treatment of water: straining through cloth
	tab ph_wtr_trt_cloth	urbanhh [iw=wt] , col
	
*treatment of water: ceramic, sand or other filter
	tab ph_wtr_trt_filt urbanhh [iw=wt] , col
	
*treatment of water: solar disinfection
	tab ph_wtr_trt_solar urbanhh [iw=wt] , col
	
*treatment of water: letting stand and settle	
	tab ph_wtr_trt_stand urbanhh [iw=wt] , col	

*treatment of water: other
	tab ph_wtr_trt_other urbanhh [iw=wt] , col
	
*treatment of water: no treatment	
	tab ph_wtr_trt_none urbanhh [iw=wt] , col	
	
*treatment of water: appropriate treatment	
	tab ph_wtr_trt_appr urbanhh [iw=wt] , col	
	
*type of sanitation 
	tab ph_sani_type urbanhh [iw=wt] , col

*improved sanitation
	tab ph_sani_improve urbanhh [iw=wt] , col

*basic or limited sanitation
	tab ph_sani_basic urbanhh [iw=wt] , col

*location of sanitation facility
	tab ph_sani_location urbanhh [iw=wt] , col


* output to excel
tabout 	ph_wtr_source ph_wtr_improve ph_wtr_time ph_wtr_basic ph_wtr_avail ///
		ph_wtr_trt_boil ph_wtr_trt_chlor ph_wtr_trt_cloth ph_wtr_trt_filt   ///
		ph_wtr_trt_solar ph_wtr_trt_stand ph_wtr_trt_other ph_wtr_trt_none ///
		ph_wtr_trt_appr ph_sani_type ph_sani_improve ph_sani_location ph_sani_basic ///
		urbanhh using Tables_hh_wash.xls [iw=wt] , c(col) f(1) replace 
*/


**************************************************************************************************
* Indicators for household characteristics: excel file Tables_hh_charac will be produced
**************************************************************************************************
* all household characteristics are crosstabulated by place of residence

*electricity
tab ph_electric urbanhh [iw=wt] , col

*floor marital
tab ph_floor urbanhh [iw=wt] , col

*rooms for sleeping
tab ph_rooms_sleep urbanhh [iw=wt] , col

*place for cooking
tab ph_cook_place urbanhh [iw=wt] , col

*cooking fuel
tab ph_cook_fuel urbanhh [iw=wt] , col

*solid fuel for cooking
tab ph_cook_solid urbanhh [iw=wt] , col

*clean fuel for cooking
tab ph_cook_clean urbanhh [iw=wt] , col

*frequency of smoking in the home
tab ph_smoke urbanhh [iw=wt] , col

* output to excel
tabout 	ph_electric ph_floor ph_rooms_sleep ph_cook_place ph_cook_fuel 	///
		ph_cook_solid ph_cook_clean ph_smoke urbanhh using Tables_hh_charac.xls [iw=wt] , c(col) f(1) replace 
*/
**************************************************************************************************
* Indicators for household possessions: excel file Tables_hh_poss will be produced
**************************************************************************************************
* all household possessions are crosstabulated by place of residence

*radio
tab ph_radio urbanhh [iw=wt] , col

*TV
tab ph_tv urbanhh [iw=wt] , col

*mobile
tab ph_mobile urbanhh [iw=wt] , col

*telephone
tab ph_tel urbanhh [iw=wt] , col

*computer
tab ph_comp urbanhh [iw=wt] , col

*refrigerator
tab ph_frig urbanhh [iw=wt] , col

*bicycle
tab ph_bike urbanhh [iw=wt] , col

*animal drawn cart
tab ph_cart urbanhh [iw=wt] , col

*motorcycle/scooter
tab ph_moto urbanhh [iw=wt] , col

*car or truck
tab ph_car urbanhh [iw=wt] , col

*boat with a motor
tab ph_boat urbanhh [iw=wt] , col

*agricultural land
tab ph_agriland urbanhh [iw=wt] , col

*livestock or farm animals
tab ph_animals urbanhh [iw=wt] , col


* output to excel
tabout 	ph_radio ph_tv ph_mobile ph_tel ph_comp ph_frig ph_bike ph_cart	///
		ph_moto ph_car ph_boat ph_agriland ph_animals urbanhh using Tables_hh_poss.xls [iw=wt] , c(col) f(1) replace 
*/

**************************************************************************************************
* Indicators for handwashing: excel file Tables_handwsh will be produced
**************************************************************************************************

//fixed place for handwashing
*residence
tab urbanhh ph_hndwsh_place_fxd [iw=wt] , row

*region
tab GEO-REGION ph_hndwsh_place_fxd [iw=wt] , row

*wealth quintiles
tab wealthqhh ph_hndwsh_place_fxd [iw=wt] , row

* output to excel
tabout urbanhh GEO-REGION wealthqhh ph_hndwsh_place_fxd using Tables_handwsh.xls [iw=wt] , c(row) f(1) replace 
********************

//mobile place for handwashing
*residence
tab urbanhh ph_hndwsh_place_mob [iw=wt] , row

*region
tab GEO-REGION ph_hndwsh_place_mob [iw=wt] , row

*wealth quintiles
tab wealthqhh ph_hndwsh_place_mob [iw=wt] , row

* output to excel
tabout urbanhh GEO-REGION wealthqhh ph_hndwsh_place_mob using Tables_handwsh.xls [iw=wt] , c(row) f(1) append 
********************

//fixed and mobile place for handwashing
*residence
tab urbanhh ph_hndwsh_place_any [iw=wt] , row

*region
tab GEO-REGION ph_hndwsh_place_any [iw=wt] , row

*wealth quintiles
tab wealthqhh ph_hndwsh_place_any [iw=wt] , row

* output to excel
tabout urbanhh GEO-REGION wealthqhh ph_hndwsh_place_any using Tables_handwsh.xls [iw=wt] , c(row) f(1) append 
********************

//water for handwashing
*residence
tab urbanhh ph_hndwsh_water [iw=wt] , row

*region
tab GEO-REGION ph_hndwsh_water [iw=wt] , row

*wealth quintiles
tab wealthqhh ph_hndwsh_water [iw=wt] , row

* output to excel
tabout urbanhh GEO-REGION wealthqhh ph_hndwsh_water using Tables_handwsh.xls [iw=wt] , c(row) f(1) append 
********************

//soap for handwashing
*residence
tab urbanhh ph_hndwsh_soap [iw=wt] , row

*region
tab GEO-REGION ph_hndwsh_soap [iw=wt] , row

*wealth quintiles
tab wealthqhh ph_hndwsh_soap [iw=wt] , row

* output to excel
tabout urbanhh GEO-REGION wealthqhh ph_hndwsh_soap using Tables_handwsh.xls [iw=wt] , c(row) f(1) append 
********************

//cleansing agent for handwashing
*residence
tab urbanhh ph_hndwsh_clnsagnt [iw=wt] , row

*region
tab GEO-REGION ph_hndwsh_clnsagnt [iw=wt] , row

*wealth quintiles
tab wealthqhh ph_hndwsh_clnsagnt [iw=wt] , row

* output to excel
tabout urbanhh GEO-REGION wealthqhh ph_hndwsh_clnsagnt using Tables_handwsh.xls [iw=wt] , c(row) f(1) append 
********************

//basic handwashing facility
*residence
tab urbanhh ph_hndwsh_basic [iw=wt] , row

*region
tab GEO-REGION ph_hndwsh_basic [iw=wt] , row

*wealth quintiles
tab wealthqhh ph_hndwsh_basic [iw=wt] , row

* output to excel
tabout urbanhh GEO-REGION wealthqhh ph_hndwsh_basic using Tables_handwsh.xls [iw=wt] , c(row) f(1) append 
********************

//limited handwashing facility
*residence
tab urbanhh ph_hndwsh_limited [iw=wt] , row

*region
tab GEO-REGION ph_hndwsh_limited [iw=wt] , row

*wealth quintiles
tab wealthqhh ph_hndwsh_limited [iw=wt] , row

* output to excel
tabout urbanhh GEO-REGION wealthqhh ph_hndwsh_limited using Tables_handwsh.xls [iw=wt] , c(row) f(1) append 

*/
**************************************************************************************************
}
