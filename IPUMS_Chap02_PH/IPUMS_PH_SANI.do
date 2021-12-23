/*********************************************************************
Program: 			IPUMS_PH_SANI.do
Purpose: 			Creates variable for binary improved sanitation according to JSTOR standard 
Data inputs: 		IPUMS DHS Household File
Data outputs:		none
Author of do file:	03/15/2018	Courtney Allen, modified by Kassandra Fate for this project

*****************************************************************************************************/

/*------------------------------------------------------------------------------
This do file can be run on any loop of countries indicating the dataset name 
with variable called filename.

VARIABLES USED:
	toilettype		"type of toilet facility"
	toiletplace		"location of toilet facilities"
	toiletshareyn	"household shares toilet facility"

VARIABLES CREATED:
	
	ph_sani_type		"Type of sanitation facility"
	ph_sani_improve		"Access to improved sanitation"
	ph_sani_basic		"Basic or limited sanitation facility"
	ph_sani_location	"Location of sanitation facility"
		
NOTE: 
STANDARD CATEGORIES FOR WATER SOURCE BY IMPROVED/UNIMPROVED
	1-improved
		1210	flush - to piped sewer system
		1250	flush - to septic tank
		1410	flush - to pit latrine
		1420	flush - to somewhere else
		1100	flush - don't know where / unspecified
		3120	pit latrine - improved but shared
		3400	pit latrine - ventilated improved pit (vip)
		3300	pit latrine - with slab
		2100	composting toilet
		5100	other improved
	2-unimproved 
		3200	pit latrine - without slab / open pit
		4100	bucket
		4300	hanging toilet/latrine
		5000	other
	3-open defecation
		0000	no facility/bush/field/river/sea/lake
------------------------------------------------------------------------------*/

// generate type of sanitation facility  (MLK - probably not useful)
	/*--------------------------------------------------------------------------
	NOTE: this cycles through ALL country specific coding and ends around 
	line 1491.
	Close bracket around line 59 to hide country specific code.
	--------------------------------------------------------------------------*/

	// check file being used
	foreach x in household {

	//recode country specific responses to standard codes
	if filename=="Afghanistan 2015"  {
	recode toilettype ///
	2300 = 5100 ///
	, gen (ph_sani_type)
	}
	if filename=="Angola 2015"  {
	recode toilettype ///
	1211 = 1210 ///
	1231 = 1420 ///
	1212 = 1210 ///
	1251 = 1250 ///
	1252 = 1250 ///
	1232 = 1420 ///
	1213 = 1210 ///
	1253 = 1250 ///
	1233 = 1420 ///
	3441 = 3400 ///
	3462 = 3400 ///
	3442 = 3400 ///
	3211 = 3200 ///
	3461 = 3400 ///
	3463 = 3400 ///
	3443 = 3400 ///
	3212 = 3200 ///
	4100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Bangladesh 1994"  {
	recode toilettype ///
	1200 = 1250 ///
	3100 = 3200 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Bangladesh 1997"  {
	recode toilettype ///
	1200 = 1250 ///
	3100 = 3200 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Bangladesh 2000"  {
	recode toilettype ///
	1200 = 1250 ///
	3100 = 3200 ///
	3210 = 3200
	, gen (ph_sani_type)
	}
	if filename=="Bangladesh 2004"  {
	recode toilettype ///
	1200 = 1250 ///
	3100 = 3200 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Burkina Faso 1993"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Burkina Faso 1998"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Benin 1996"  {
	recode toilettype ///
	3210 = 3200 ///
	3440 = 3400 ///
	, gen (ph_sani_type)
	}
	if filename=="Congo Democratic Republic 2007"  {
	recode toilettype ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Cote d'Ivoire 1994"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Cameroon 1991"  {
	recode toilettype ///
	3100 = 3200 ///
	4200 = 0000 ///
	0 = 0000 ///
	, gen (ph_sani_type)
	}
	if filename=="Egypt 1992"  {
	recode toilettype ///
	1200 = 1100 ///
	1300 = 1100 ///
	1400 = 1100 ///
	3100 = 3200 ///
	4100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Egypt 1995"  {
	recode toilettype ///
	1200 = 1100 ///
	1300 = 1100 ///
	1400 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Egypt 2000"  {
	recode toilettype ///
	1200 = 1100 ///
	1300 = 1100 ///
	1400 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Egypt 2003"  {
	recode toilettype ///
	1200 = 1100 ///
	1300 = 1100 ///
	1100 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Egypt 2005"  {
	recode toilettype ///
	1200 = 1100 ///
	1300 = 1100 ///
	1400 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Egypt 2008"  {
	recode toilettype ///
	1200 = 1100 ///
	1300 = 1100 ///
	1400 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Egypt 2014"  {
	recode toilettype ///
	1220 = 1210 ///
	1230 = 1210 ///
	1410 = 1250 ///
	1430 = 1100 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Ghana 1993"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Ghana 1998"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Guinea 1999"  {
	recode toilettype ///
	3000 = 3200 ///
	0 = 0000 ///
	, gen (ph_sani_type)
	}
	if filename=="Guinea 2005"  {
	recode toilettype ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="India 1992"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	1130 = 1100 ///
	3110 = 3200 ///
	3120 = 3200 ///
	3121 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="India 1998"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	1130 = 1100 ///
	3110 = 3200 ///
	3120 = 3200 ///
	3121 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="India 2005"  {
	recode toilettype ///
	1430 = 1100 ///
	2200 = 3200 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="India 2015"  {
	recode toilettype ///
	1430 = 1100 ///
	2200 = 3200 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Jordan 1997"  {
	recode toilettype ///
	1110 = 1100 ///
	1130 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Jordan 2002"  {
	recode toilettype ///
	1110 = 1100 ///
	1130 = 1100 ///
	3110 = 3200 ///
	3120 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Kenya 1993"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Kenya 1998"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Lesotho 2009"  {
	recode toilettype ///
	1430 = 1100 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Morocco 1992"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Morocco 2003"  {
	recode toilettype ///
	1111 = 1100 ///
	1112 = 1100 ///
	1130 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Madagascar 1992"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	3100 = 3300 ///
	, gen (ph_sani_type)
	}
	if filename=="Madagascar 1997"  {
	recode toilettype ///
	1110 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Madagascar 2008"  {
	recode toilettype ///
	3210 = 3200 ///
	3310 = 3300 ///
	3320 = 3300 ///
	, gen (ph_sani_type)
	}
	if filename=="Mali 1995"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Malawi 1992"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Mozambique 1997"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Mozambique 2003"  {
	recode toilettype ///
	3100 = 3200 ///
	2000 = 0000 ///
	0 = 0000 ///
	, gen (ph_sani_type)
	}
	if filename=="Mozambique 2011"  {
	recode toilettype ///
	1430 = 1100 ///
	2000 = 1100 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	*if filename=="Nigeria 1990"  {
	*recode toilettype ///
	*11 = 15 ///
	*12 = 15 ///
	*21 = 23 ///
	*22 = 21 ///
	*23 = 42 ///
	*, gen (ph_sani_type)
	}
	if filename=="Nigeria 2003"  {
	recode toilettype ///
	4200 = 0000 ///
	, gen (ph_sani_type)
	}
	if filename=="Niger 1992"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	1130 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Niger 1998"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Namibia 1992"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Namibia 2000"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 3300 ///
	, gen (ph_sani_type)
	}
	if filename=="Nepal 1996"  {
	recode toilettype ///
	3100 = 3200 ///
	0 = 0000 ///
	, gen (ph_sani_type)
	}
	if filename=="Nepal 2006"  {
	recode toilettype ///
	1430 = 1100 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Nepal 2011"  {
	recode toilettype ///
	1430 = 1100 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Pakistan 1991"  {
	recode toilettype ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Pakistan 2006"  {
	recode toilettype ///
	1430 = 1100 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Pakistan 2012"  {
	recode toilettype ///
	1430 = 1100 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Rwanda 1992"  {
	recode toilettype ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Rwanda 2005"  {
	recode toilettype ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Senegal 1992"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Senegal 1997"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Senegal 2005"  {
	recode toilettype ///
	1430 = 1420 ///
	, gen (ph_sani_type)
	}
	if filename=="Senegal 2010"  {
	recode toilettype ///
	3450 = 3300 ///
	, gen (ph_sani_type)
	}
	if filename=="Senegal 2012"  {
	recode toilettype ///
	3450 = 3300 ///
	, gen (ph_sani_type)
	}
	if filename=="Senegal 2014"  {
	recode toilettype ///
	3450 = 3300 ///
	, gen (ph_sani_type)
	}
	if filename=="Senegal 2015"  {
	recode toilettype ///
	3450 = 3300 ///
	, gen (ph_sani_type)
	}
	if filename=="Senegal 2016"  {
	recode toilettype ///
	3450 = 3300 ///
	, gen (ph_sani_type)
	}
	if filename=="Chad 1996"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Chad 2004"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Chad 2014"  {
	recode toilettype ///
	1430 = 1100 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Tanzania 1991"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Tanzania 1996"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Tanzania 2010"  {
	recode toilettype ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Tanzania 2015"  {
	recode toilettype ///
	3310 = 3300 ///
	3320 = 3300 ///
	1430 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Uganda 1995"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Uganda 2006"  {
	recode toilettype ///
	3410 = 3200 ///
	3420 = 3300 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Uganda 2011"  {
	recode toilettype ///
	3410 = 3200 ///
	3420 = 3300 ///
	3210 = 3200 ///
	2300 = 5100 ///
	, gen (ph_sani_type)
	}
	if filename=="Uganda 2016"  {
	recode toilettype ///
	1430 = 1100 ///
	3210 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="Yemen 1991"  {
	recode toilettype ///
	1240 = 1100 ///
	3100 = 1420 ///
	3120 = 3200 ///
	3121 = 1100 ///
	0 = 0000 ///
	, gen (ph_sani_type)
	}
	if filename=="Yemen 2013"  {
	recode toilettype ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="South Africa 1998"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	3100 = 3200 ///
	, gen (ph_sani_type)
	}
	if filename=="South Africa 2016"  {
	recode toilettype ///
	1430 = 1100 ///
	3210 = 3400 ///
	3431 = 3400 ///
	2200 = 5100 ///
	, gen (ph_sani_type)
	}
	if filename=="Zambia 1992"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Zambia 1996"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}
	if filename=="Zimbabwe 1994"  {
	recode toilettype ///
	1110 = 1100 ///
	1120 = 1100 ///
	, gen (ph_sani_type)
	}

} //close bracket for hiding country specific code
	
	// for all other countries
	cap gen ph_sani_type = toilettype

	********************************************************************************
	// label type of sanitation MLK
	recode ph_sani_type . = 9998

	label define ph_sani_type	1210	 "flush - to piped sewer system" ///
								1250	 "flush - to septic tank"		///
								1410	 "flush - to pit latrine"		///
								1420	 "flush - to somewhere else"	///
								1100	 "flush - don't know where/unspecified"			///
								3400	 "pit latrine - ventilated improved pit (vip)"	///
								3300	 "pit latrine - with slab"		///
								3200	 "pit latrine - without slab / open pit" 		///
								0000	 "no facility/bush/field/river/sea/lake" 		///
								2100 	 "composting toilet"			///
								4100	 "bucket toilet"				///
								4300	 "hanging toilet/latrine"		///
								5100	 "other improved"				///
								5000	 "other"						///
								9998	 "missing"
	label values ph_sani_type ph_sani_type
	label var ph_sani_type "Type of sanitation"
	
// create improved sanitation indicator MLK
	recode ph_sani_type (1210/1410 1100 3400 3300 2100 5100 = 1 "improved sanitation") (1420 3200 4100 4300 5000 = 2 "unimproved sanitation") (0000 = 3 "open defecation") (9998=.), gen(ph_sani_improve)
	label var ph_sani_improve "Improved sanitation"
	*cap replace ph_sani_improve = 2 if toiletshareyn==1 //shared toilet is not improved. Note: this is used in the old definition and no longer required. 


// create basic or limited sanitation services indicator MLK
	cap gen ph_sani_basic = .
	cap replace ph_sani_basic = 1 if ph_sani_improve==1 & toiletshareyn==0
	cap replace ph_sani_basic = 2 if ph_sani_improve==1 & toiletshareyn==1
	cap replace ph_sani_basic = 3 if ph_sani_improve==2
	cap replace ph_sani_basic = 4 if ph_sani_improve==3
	cap label define basic_label	1	 "basic sanitation"	2 "limited sanitation" 3 "unimproved sanitation" 4 "open defecation"
	cap label values ph_sani_basic basic_label
	cap label var ph_sani_basic "Basic or limited sanitation"

// create sanitation facility location indicator (this variable may sometimes be country specific)
	clonevar ph_sani_location = toiletplace
	recode ph_sani_location (98/99=.)
	label var ph_sani_location	"Location of sanitation facility"
