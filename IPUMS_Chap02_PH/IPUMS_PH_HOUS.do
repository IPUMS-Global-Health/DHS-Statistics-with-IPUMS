/*****************************************************************************************************
Program: 			  IPUMS_PH_HOUS.do
Purpose: 			  Code to compute household characteristics, possessions, and smoking in the home
Data inputs: 		IPUMS DHS Housing Variables
Data outputs:		coded variables
Author:				  Shireen Assaf, modified by Faduma Shaba and Kassandra Fate for this project
Date last modified: May 2021
*****************************************************************************************************/

/*----------------------------------------------------------------------------
Variables used in this file:
electrchh		"Have electricity"
floor			"Flooring material"
sleeprooms		"Number of Rooms for sleeping"
cookwhere		"Usual place for cooking"
cookfuel		"Type of cooking fuel"
tosmkhhfreq		"Frequency of smoking at home"
radiohh			"Owns a radio"
tvhh			"Owns a tv"
mobphone		"Owns a mobile phone"
hhphonehh		"Owns a non-mobile telephone"
pc				"Owns a computer"
fridgehh		"Owns a refrigerator"
bikehh			"Owns a bicycle"
drawncart		"Owns an animal drawn cart"
motorcyclhh		"Owns a motorcycle/scooter"
carhh			"Owns a car or truck"
boatwmotor		"Owns a boat with a motor"
aglandyn		"Owns agricultural land"
livestockyn		"Owns livestock or farm animals"

Variables created in this file:
ph_electric		"Have electricity"
ph_floor		"Flooring material"
ph_rooms_sleep	"Rooms for sleeping"
ph_cook_place	"Place for cooking"
ph_cook_fuel	"Type of cooking fuel"
ph_cook_solid	"Using solid fuel for cooking"
ph_cook_clean	"Using clean fuel for cooking"
ph_smoke		"Frequency of smoking at home"	
ph_radio		"Owns a radio"
ph_tv			"Owns a tv"
ph_mobile		"Owns a mobile phone"
ph_tel			"Owns a non-mobile telephone"
ph_comp			"Owns a computer"
ph_frig			"Owns a refrigerator"
ph_bike			"Owns a bicycle"
ph_cart			"Owns a animal drawn cart"
ph_moto			"Owns a motorcycle/scooter"
ph_car			"Owns a car or truck"
ph_boat			"Owns a boat with a motor"
ph_agriland		"Owns agricultural land"
ph_animals		"Owns livestock or farm animals"
----------------------------------------------------------------------------*/

keep if hhlineno==1

cap label define yesno 0"No" 1"Yes"

*** Household characteristics ***

//Have electricity
gen ph_electric= electrchh
replace ph_electric=. if electrchh > 7
label values ph_electric yesno
label var ph_electric "Have electricity"

//Flooring material
gen ph_floor= floor
replace ph_floor=. if floor > 997
label values ph_floor FLOOR
label var ph_floor "Flooring material"

//Number of rooms for sleeping
recode sleeprooms (1=1 "One") (2=2 "Two") (3/max=3 "Three or more") , gen(ph_rooms_sleep)
replace ph_rooms_sleep=. if sleeprooms > 97
label var ph_rooms_sleep "Rooms for sleeping"

//Place for cooking
gen ph_cook_place = cookwhere 
replace ph_cook_place =. if cookwhere > 520
replace ph_cook_place =4 if cookfuel==995 
label define cookwhere 4 "No food cooked in household", modify
label values ph_cook_place COOKWHERE
label var ph_cook_place "Place for cooking"

//Type of cooking fuel
gen ph_cook_fuel= cookfuel
replace ph_cook_fuel=. if cookfuel > 997
label values ph_cook_fuel COOKFUEL
label var ph_cook_fuel "Type of cooking fuel"

//Solid fuel for cooking
gen ph_cook_solid= inrange(cookfuel,500,600)
label values ph_cook_solid yesno
label var ph_cook_solid "Using solid fuel for cooking"

//Clean fuel for cooking
gen ph_cook_clean= inrange(cookfuel,100,200)
label values ph_cook_clean yesno
label var ph_cook_clean "Using clean fuel for cooking"

//Frequency of smoking in the home
gen ph_smoke= tosmkhhfreq
replace ph_smoke=. if tosmkhhfreq > 7
label values ph_smoke TOSMKHHFREQ
label var ph_smoke "Frequency of smoking at home"

*** Household possessions ***

//Radio
gen ph_radio= radiohh==1
label values ph_radio yesno
label var ph_radio "Owns a radio"

//TV
gen ph_tv= tvhh==1
label values ph_tv yesno
label var ph_tv "Owns a tv"

//Mobile phone
gen ph_mobile= mobphone==1
label values ph_mobile yesno
label var ph_mobile "Owns a mobile phone"

//Non-mobile phone
gen ph_tel= hhphonehh==1
label values ph_tel yesno
label var ph_tel "Owns a non-mobile telephone"

//Computer
gen ph_comp= pc==1
label values ph_comp yesno
label var ph_comp "Owns a computer"

//Refrigerator
gen ph_frig= fridgehh==1
label values ph_frig yesno
label var ph_frig "Owns a refrigerator"

//Bicycle
gen ph_bike= bikehh==1
label values ph_bike yesno
label var ph_bike "Owns a bicycle"

//Animal drawn cart
gen ph_cart= drawncart==1
label values ph_cart yesno
label var ph_cart "Owns a animal drawn cart"

//Motorcycle or scooter
gen ph_moto= motorcyclhh==1
label values ph_moto yesno
label var ph_moto "Owns a motorcycle/scooter"

//Car or truck
gen ph_car= carhh==1
label values ph_car yesno
label var ph_car "Owns a car or truck"

//Boat with a motor
gen ph_boat= boatwmotor==1
label values ph_boat yesno
label var ph_boat "Owns a boat with a motor"

//Agricultural land
gen ph_agriland= aglandyn==1
label values ph_agriland yesno
label var ph_agriland "Owns agricultural land"

//Livestook
gen ph_animals= livestockyn==1
label values ph_animals yesno
label var ph_animals "Owns livestock or farm animals"
