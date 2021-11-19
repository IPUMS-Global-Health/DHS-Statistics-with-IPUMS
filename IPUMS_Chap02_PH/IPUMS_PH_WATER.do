/*********************************************************************
Program: 			IPUMS_PH_WATER.do
Purpose: 			creates variable for binary improved water source according to JSTOR standard 
Data inputs: 		IPUMS DHS Household
Data outputs:		none
Author of do file:	04/08/2018	Courtney Allen, modified by Kassandra Fate for this project
Date last modified: 06/17/2021	Kassandra Fate
*****************************************************************************************************/

/*------------------------------------------------------------------------------
This do file can be run on any loop of countries indicating the dataset name 
with variable called filename.

VARIABLES USED
	trboil			household treats water by boiling
	trbleach		household treats water by adding bleach / chlorine
	trcloth			household treats water by straining through cloth
	trfilter		household treats water by using water filters
	trsolar			household treats water by solar disinfection
	trstand		household treats water by letting it stand
	trother			household treats water by other methods
	treatwtryn		household uses any method to treat drinking water
	drinkwtr		major source of drinking water
	timetowtrhh		time to reach water source and return, in minutes
	wtrshortyn		water shortage or unavailability, last two weeks
	
VARIABLES CREATED
	ph_wtr_trt_boil		"Treated water by boiling before drinking"
	ph_wtr_trt_chlor	"Treated water by adding bleach or chlorine before drinking"
	ph_wtr_trt_cloth	"Treated water by straining through cloth before drinking"
	ph_wtr_trt_filt		"Treated water by ceramic, sand, or other filter before drinking"
	ph_wtr_trt_solar	"Treated water by solar disinfection before drinking"
	ph_wtr_trt_stand	"Treated water by letting stand and settle before drinking"
	ph_wtr_trt_other	"Treated water by other means before drinking"
	ph_wtr_trt_none		"Did not treat water before drinking"
	ph_wtr_trt_appr		"Appropriately treated water before drinking"
	ph_wtr_source 		"Source of drinking water"
	ph_wtr_improve 		"Improved drinking water" 
	ph_wtr_time			"Round trip time to obtain drinking water"
	ph_wtr_basic		"Basic water service"
	ph_wtr_avail		"Availability of water among those using piped water or water from tube well or borehole"
	
NOTE: 
STANDARD CATEGORIES FOR WATER SOURCE BY IMPROVED/UNIMPROVED
	0-unimproved 
		2300	 well - protection unspecified	
		2100	 unprotected well
		3100	 spring - protection unspecified
		3120	 unprotected spring
		3200	 surface water (river/dam/lake/pond/stream/canal/irrigation channel)
		6000	 other	
	1-improved
		1110	 piped into dwelling
		1120	 piped to yard/plot
		1210	 public tap/standpipe
		1220	 piped to neighbor
		1200	 piped outside of yard/lot
		2230	 tube well or borehole
		2200	 protected well
		3110	 protected spring
		4000	 rainwater
		5100	 tanker truck	
		5200	 cart with small tank, cistern, drums/cans
		5300	 purchased water	
		5400	 bottled water
		5500	 purified water, filtration plant
		5410	 satchet water
	
------------------------------------------------------------------------------*/
*keep if hhresident==1

// create yesno label for most basic binary indicators
cap label define yesno 0"No" 1"Yes"

// create water treatment indicators

	// treated water by boiling
	gen ph_wtr_trt_boil = trboil
	replace ph_wtr_trt_boil = 0 if trboil>=97
	label val ph_wtr_trt_boil yesno
	label var ph_wtr_trt_boil	"Treated water by boiling before drinking"

	// treated water by adding bleach or chlorine
	gen ph_wtr_trt_chlor = trbleach
	replace ph_wtr_trt_chlor = 0 if trbleach>=7
	label val ph_wtr_trt_chlor yesno
	label var ph_wtr_trt_chlor	"Treated water by adding bleach or chlorine before drinking"

	// treated water by straining through cloth
	gen ph_wtr_trt_cloth = trcloth
	replace ph_wtr_trt_cloth = 0 if trcloth>=7
	label val ph_wtr_trt_cloth yesno
	label var ph_wtr_trt_cloth	"Treated water by straining through cloth before drinking"

	// treated water by ceramic, sand, or other filter
	gen ph_wtr_trt_filt = trfilter
	replace ph_wtr_trt_filt = 0 if trfilter>=7
	label val ph_wtr_trt_filt yesno
	label var ph_wtr_trt_filt	"Treated water by ceramic, sand, or other filter before drinking"

	// treated water by solar disinfection
	gen ph_wtr_trt_solar = trsolar
	replace ph_wtr_trt_solar = 0 if trsolar>=7
	label val ph_wtr_trt_solar yesno
	label var ph_wtr_trt_solar	"Treated water by solar disinfection"

	// treated water by letting stand and settle
	gen ph_wtr_trt_stand = trstand
	replace ph_wtr_trt_stand = 0 if trstand>=7
	label val ph_wtr_trt_stand yesno
	label var ph_wtr_trt_stand	"Treated water by letting stand and settle before drinking"

	// treated water by other means
	gen ph_wtr_trt_other = 0
	replace ph_wtr_trt_other = 1 if trother==1
	replace ph_wtr_trt_other = . if trother>=7
	label val ph_wtr_trt_other yesno
	label var ph_wtr_trt_other	"Treated water by other means before drinking"

	// any treatment or none
	gen ph_wtr_trt_none = 0
	replace ph_wtr_trt_none = 1 if treatwtryn==1
	replace ph_wtr_trt_none = . if treatwtryn>=7
	label define trt_none 0 "No treatment" 1 "Some treatment" 
	label val ph_wtr_trt_none trt_none
	label var ph_wtr_trt_none	"Did not treat water before drinking"
	
	// using appropriate treatment MLK
	/*--------------------------------------------------------------------------
	NOTE: Appropriate water treatment includes: boil, add bleach or chlorine, 
	ceramic, sand or other filter, and solar disinfection.
	--------------------------------------------------------------------------*/
	gen ph_wtr_trt_appr = 0
	replace ph_wtr_trt_appr = 1 if trboil==10 | trbleach==1 | trfilter==1 | trsolar==1 
	label val ph_wtr_trt_appr yesno
	label var ph_wtr_trt_appr	"Appropriately treated water before drinking"


	
// generate water source indicator (MLK - probably not useful)
	/*--------------------------------------------------------------------------
	NOTE: this cycles through ALL country specific coding and ends around 
	line 2252. 
	Close bracket around line 130 to hide country specific code.
	--------------------------------------------------------------------------*/
	
	// check if "hr" or "pr" file is being used
	foreach x in hr pr {
	
	// recode country specific responses to standard codes
	if filename=="Angola 2015"  {
	recode drinkwtr ///
	5201 = 5200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Bangladesh 1994"  {
	recode drinkwtr ///
	1100 = 1110 ///
	3220 = 3200 ///
	3210 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Bangladesh 1997"  {
	recode drinkwtr ///
	1100 = 1110 ///
	3220 = 3200 ///
	3210 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Bangladesh 2000"  {
	recode drinkwtr ///
	1100 = 1110
	3220 = 3200 ///
	3210 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Bangladesh 2004"  {
	recode drinkwtr ///
	2300 = 2100 ///
	3220 = 3200 ///
	3210 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Burkina Faso 1993"  {
	recode drinkwtr ///
	1100 = 1110
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Burkina Faso 1998"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Burkina Faso 2003"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Benin 1996"  {
	recode drinkwtr ///
	2341 = 2300 ///
	4100 = 4000 ///
	, gen (ph_wtr_source)
	}
	if filename=="Congo (Democratic Republic) 2007"  {
	recode drinkwtr ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Cote d'Ivoire 1994"  {
	recode drinkwtr ///
	2110 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Cote d'Ivoire 1998'"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2110 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Cameroon 1991"  {
	recode drinkwtr ///
	2341 = 2100 ///
	2342 = 2100 ///
	, gen (ph_wtr_source)
	}
	if filename=="Cameroon 1998"  {
	recode drinkwtr ///
	2341 = 2100 ///
	2342 = 2100 ///
	3210 = 3200 ///
	5000 = 5300 ///
	, gen (ph_wtr_source)
	}
	if filename=="Cameroon 2004"  {
	recode drinkwtr ///
	1210 = 1200 ///
	2200 = 2100 ///
	2341 = 2100 ///
	3120 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Egypt 1992"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3240 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Egypt 1995"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3240 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Egypt 2000"  {
	recode drinkwtr ///
	2111 = 2300 ///
	2112 = 2300 ///
	2120 = 2300 ///
	2211 = 2300 ///
	2212 = 2300 ///
	2220 = 2300 ///
	3240 = 3200 ///
	5200 = 5300 ///
	, gen (ph_wtr_source)
	}
	if filename=="Egypt 2003"  {
	recode drinkwtr ///
	2111 = 2300 ///
	2112 = 2300 ///
	2120 = 2300 ///
	2211 = 2300 ///
	2212 = 2300 ///
	2220 = 2300 ///
	, gen (ph_wtr_source)
	}
	if filename=="Ethiopia 2000"  {
	recode drinkwtr ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Ghana 1993"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	2231 = 2230 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	3260 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Ghana 1998"  {
	recode drinkwtr ///
	1000 = 2300 ///
	1100 = 2300 ///
	2320 = 2300 ///
	2231 = 2230 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	3260 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Ghana 2003"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Guinea 1999"  {
	recode drinkwtr ///
	2310 = 2300 ///
	2320 = 2300 ///
	3120 = 3200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Guinea 2005"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="India 1992"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	2313 = 2230 ///
	2323 = 2230 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="India 1998"  {
	recode drinkwtr ///
	1100 = 1120 ///
	2323 = 2230 ///
	2310 = 2300 ///
	2313 = 2230 ///
	2220 = 2200 ///
	2120 = 2100 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Jordan 1997"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	, gen (ph_wtr_source)
	}
	if filename=="Kenya 1993"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2341 = 2100 ///
	2342 = 2100 ///
	3220 = 3200 ///
	3210 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Kenya 1998"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Kenya 2003"  {
	recode drinkwtr ///
	2110 = 2100 ///
	2120 = 2100 ///
	2210 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Lesotho 2004"  {
	recode drinkwtr ///
	1200 = 1220 ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2213 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Lesotho 2009"  {
	recode drinkwtr ///
	3210 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Morocco 1992"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Morocco 2003"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Madagascar 1992"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Madagascar 1997"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2110 = 2100 ///
	2231 = 2230 ///
	2232 = 2230 ///
	2320 = 2300 ///
	2120 = 2100 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Madagascar 2003"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Mali 1995"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	2231 = 2230 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Mali 2001"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3240 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Malawi 1992"  {
	recode drinkwtr ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Malawi 2000"  {
	recode drinkwtr ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Malawi 2004"  {
	recode drinkwtr ///
	2110 = 2100 ///
	2120 = 2100 ///
	2210 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Mozambique 1997"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2330 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Mozambique 2003"  {
	recode drinkwtr ///
	1100 = 1120 ///
	2110 = 1120 ///
	2130 = 1220 ///
	2120 = 2100 ///
	, gen (ph_wtr_source)
	}
	if filename=="Nigeria 2003"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Niger 1992"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Niger 1998"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2220 = 2200 ///
	2120 = 2100 ///
	2320 = 2100 ///
	3210 = 3200 ///
	3220 = 3200 ///
	5300 = 5200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Namibia 1992"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Nepal 1996"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	2313 = 2230 ///
	2323 = 2230 ///
	3210 = 3200 ///
	1212 = 3110 ///
	, gen (ph_wtr_source)
	}
	if filename=="Nepal 2001"  {
	recode drinkwtr ///
	1100 = 1120 ///
	2310 = 2300 ///
	2330 = 2300 ///
	2231 = 2230 ///
	2232 = 2230 ///
	3210 = 3200 ///
	1212 = 3110 ///
	, gen (ph_wtr_source)
	}
	if filename=="Nepal 2006"  {
	recode drinkwtr ///
	1212 = 3110 ///
	, gen (ph_wtr_source)
	}
	if filename=="Nepal 2011"  {
	recode drinkwtr ///
	1212 = 3110 ///
	, gen (ph_wtr_source)
	}
	if filename=="Pakistan 1991"  {
	recode drinkwtr ///
	2341 = 2230 ///
	2342 = 2100 ///
	3210 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Pakistan 2006"  {
	recode drinkwtr ///
	2341 = 2230 ///
	, gen (ph_wtr_source)
	}
	if filename=="Pakistan 2012"  {
	recode drinkwtr ///
	2341 = 2230 ///
	1211 = 5500 ///
	, gen (ph_wtr_source)
	}
	if filename=="Rwanda 1992"  {
	recode drinkwtr ///
	2341 = 2230 ///
	2342 = 2230 ///
	3210 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Rwanda 2000"  {
	recode drinkwtr ///
	2112 = 2100 ///
	2120 = 2100 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Rwanda 2005"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Senegal 1992"  {
	recode drinkwtr ///
	1100 = 1120 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Senegal 1997"  {
	recode drinkwtr ///
	1100 = 1120 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Senegal 2005"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Chad 1996"  {
	recode drinkwtr ///
	1100 = 1120 ///
	2110 = 2100 ///
	2210 = 2200 ///
	2120 = 2100 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Chad 2004"  {
	recode drinkwtr ///
	1100 = 1120 ///
	2110 = 2100 ///
	2120 = 2100 ///
	2210 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	5320 = 5300 ///
	5330 = 5300 ///
	5340 = 5300 ///
	5310 = 5300 ///
	, gen (ph_wtr_source)
	}
	if filename=="Tanzania 1991"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	3250 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Tanzania 1996"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Tanzania 1999"  {
	recode drinkwtr ///
	2220 = 2230 ///
	, gen (ph_wtr_source)
	}
	if filename=="Tanzania 2004"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2212 = 2200 ///
	2220 = 2200 ///
	2200 = 2230 ///
	2211 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Tanzania 2010"  {
	recode drinkwtr ///
	2111 = 2100 ///
	2112 = 2100 ///
	2120 = 2100 ///
	2211 = 2200 ///
	2212 = 2200 ///
	2220 = 2200 ///
	2200 = 2230 ///
	, gen (ph_wtr_source)
	}
	if filename=="Uganda 1995"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3300 = 3110 ///
	, gen (ph_wtr_source)
	}
	if filename=="Uganda 2001"  {
	recode drinkwtr ///
	2110 = 2100 ///
	2120 = 2100 ///
	2210 = 2200 ///
	2220 = 2200 ///
	2231 = 2230 ///
	2232 = 2230 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	3300 = 3110 ///
	, gen (ph_wtr_source)
	}
	if filename=="Uganda 2006"  {
	recode drinkwtr ///
	2231 = 2230 ///
	2232 = 2230 ///
	2210 = 2200 ///
	2220 = 2200 ///
	2110 = 2100 ///
	2120 = 2100 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	3300 = 3110 ///
	, gen (ph_wtr_source)
	}
	if filename=="Uganda 2011"  {
	recode drinkwtr ///
	2231 = 2230 ///
	2232 = 2230 ///
	2210 = 2200 ///
	2220 = 2200 ///
	2110 = 2100 ///
	2120 = 2100 ///
	3210 = 3200 ///
	3220 = 3200 ///
	3230 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Uganda 2016"  {
	recode drinkwtr ///
	5310 = 5200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Yemen 1991"  {
	recode drinkwtr ///
	1100 = 1110 ///
	1200 = 1120 ///
	2341 = 2230 ///
	2342 = 2100 ///
	3110 = 4000 ///
	3120 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Yemen 2013"  {
	recode drinkwtr ///
	1000 = 5500 ///
	3120 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="South Africa 1998"  {
	recode drinkwtr ///
	4100 = 4000 ///
	, gen (ph_wtr_source)
	}
	if filename=="Zambia 1992"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2320 = 2300 ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Zambia 1996"  {
	recode drinkwtr ///
	1100 = 1110 ///
	2310 = 2300 ///
	2321 = 2100 ///
	2322 = 2100 ///
	2232 = 2230 ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Zambia 2001"  {
	recode drinkwtr ///
	2120 = 2100 ///
	2130 = 2100 ///
	2210 = 2200 ///
	2220 = 2200 ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Zimbabwe 1994"  {
	recode drinkwtr ///
	1100 = 1110 ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	if filename=="Zimbabwe 1999"  {
	recode drinkwtr ///
	3210 = 3200 ///
	3220 = 3200 ///
	, gen (ph_wtr_source)
	}
	} //bracket closes country specific section
	
	// for all other countries
	cap gen ph_wtr_source = drinkwtr

	// create water source labels - MLK
	recode ph_wtr_source . = 9998

	cap label define ph_wtr_source 	1110	"piped into dwelling"			///
									1120	"piped to yard/plot" 			///
									1210	"public tap/standpipe" 			///
									1220	"piped to neighbor"				///
									1200	"piped outside of yard/lot" 	///
									2230	"tube well or borehole" 		///
									2300	"well - protection unspecified" ///
									2200	"protected well" 				///
									2100	"unprotected well"				///
									3100	"spring - protection unspecified" ///
									3110	"protected spring" 				///
									3120	"unprotected spring"			///
									3200 	"surface water (river/dam/lake/pond/stream/canal/irrigation channel)" ///
									4000	"rainwater"						///
									5100	"tanker truck"					///
									5200	"cart with small tank, cistern, drums/cans" ///
									5300 	"purchased water"				///
									5400 	"bottled water"					///
									5500	"purified water, filtration plant" ///
									5410 	"satchet water"					///
									6000	"other"							///			
									9998	"missing"			
	cap label values ph_wtr_source ph_wtr_source
	cap label var ph_wtr_source "Source of drinking water"
	*/

// improved water source MLK
recode ph_wtr_source (1110/1220 2230 2200 3110 4000 5100/5500 = 1 "improved water") (2300 2100 3100 3120 3200 6000 = 0 "unimproved/surface water") (9998=99 "missing"), gen(ph_wtr_improve)
label var ph_wtr_improve "Improved Water Source"

// time to obtain drinking water (round trip)
recode timetowtrhh (995 = 0 "water on premises") ( 1/30 = 1 "30 minutes or less") (31/900 = 2 "More than 30 minutes") (998/max = 3 "don't know"), gen(ph_wtr_time)
label var ph_wtr_time "Round trip time to obtain water"
	
// basic or limited water source MLK
gen ph_wtr_basic = .
replace ph_wtr_basic = 1 if ph_wtr_improve==1 & ph_wtr_time<=1
replace ph_wtr_basic = 2 if ph_wtr_improve==1 & ph_wtr_time>1
replace ph_wtr_basic = 3 if ph_wtr_improve==0
label define wtr_basic_label	1	 "basic water services"	2 "limited water services" 3 "unimproved water source"
label values ph_wtr_basic wtr_basic_label
label var ph_wtr_basic "Basic or limited water services"

// availability of piped water or water from tubewell
clonevar ph_wtr_avail = wtrshortyn
recode ph_wtr_avail (8/9=.)
label var ph_wtr_avail		"Availability of water among those using piped water or water from tube well or borehole"
