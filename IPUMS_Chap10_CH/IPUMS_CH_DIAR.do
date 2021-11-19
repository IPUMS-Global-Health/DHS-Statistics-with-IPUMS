/*****************************************************************************************************
Program: 			      IPUMS_CH_DIAR.do
Purpose: 			      Code diarrhea variables.
Data inputs: 		    IPUMS Children's variables
Data outputs:		    coded variables
Author:				      Shireen Assaf, modified by Faduma Shaba for this project
Date last modified: June 2020
Notes:
*****************************************************************************************************/
/*
IPUMS Variables used in this file:

kidalive		"Child is alive"
diarrecent		"Child had diarrhea recently"
** following variables are country specific, check which variables country has **
diatrprivdr		"Source of diarrhea treatment: Private doctor"
diatrpubhp		"Source of diarrhea treatment: Health post (public)"
diatrprivmob	"Source of diarrhea treatment: Mobile clinic (private)"
diatrpubmob		"Source of diarrhea treatment: Mobile clinic (public)"
diatrenone		"Whether no treatment or advice sought for child's diarrhea"
diatrpubfw		"Source of diarrhea treatment: Fieldworker (public)"
diatrprivhl		"Source of diarrhea treatment: Traditional Practitioner/Healer"
diatrpuboth		"Source of diarrhea treatment: Other public source"
diatroth		"Source of diarrhea treatment: Other"
diatrpubhos		"Source of diarrhea treatment: Public hospital"
diatrprivhos	"Source of diarrhea treatment: Private hospital/clinic"
diatrpubhc		"Source of diarrhea treatment: Public health center"
diatrprivoth	"Source of diarrhea treatment: Other private source"
diatrprivdrug	"Source of diarrhea treatment: Private pharmacy"
diafluidupdn 	"Child fed the same, more, or less fluid with diarrhea"
diafoodupdn		"Child got same, increased, or decreased food with diarrhea"
diagivors		"Child given oral rehydration for diarrhea"
diagivpplors	"Child given pre-packaged ORS liquid for diarrhea"
diagivsolut		"Child given recommended home solution with salt and sugar for diarrhea"
diagivzinc		"Child given zinc for diarrhea"
diagivinjantib	"Child given antibiotic injection for diarrhea"
diagivpilsyr	"Child given pills or syrups (unspecified) for diarrhea"
diagivantim		"Child given antimotility for diarrhea"
diagiviv		"Child given an IV for diarrhea"
diagivherb		"Child given home remedy or herbal medicine for diarrhea"
diagivothtyppil "Child given other type of pill (not antibiotic, antimotility, or zinc) for diarrhea"
diagivpilunk	"Child given unknown pill/syrup for diarrhea"
diagivinjnonantib	"Child given non-antibiotic injection for diarrhea"
diagivinjunk	"Child given unknown injection for diarrhea"
diagivother		"Child given other treatment for diarrhea"
diagivnone		"Child given nothing as treatment for diarrhea"

*/
/*----------------------------------------------------------------------------
Variables created in this file:
ch_diar				      "Diarrhea in the 2 weeks before the survey"
ch_diar_care		    "Advice or treatment sought for diarrhea"
ch_diar_liq			    "Amount of liquids given for child with diarrhea"
ch_diar_food		    "Amount of food given for child with diarrhea"
ch_diar_ors			    "Given oral rehydration salts for diarrhea"
ch_diar_rhf			    "Given recommended homemade fluids for diarrhea"
ch_diar_ors_rhf		  "Given either ORS or RHF for diarrhea"
ch_diar_zinc		    "Given zinc for diarrhea"
ch_diar_zinc_ors	  "Given zinc and ORS for diarrhea"
ch_diar_ors_fluid	  "Given ORS or increased fluids for diarrhea"
ch_diar_ort			    "Given oral rehydration treatment and increased liquids for diarrhea"
ch_diar_ort_feed	  "Given ORT and continued feeding for diarrhea"
ch_diar_antib		    "Given antibiotic drugs for diarrhea"
ch_diar_antim		    "Given antimotility drugs for diarrhea"
ch_diar_intra		    "Given Intravenous solution for diarrhea"
ch_diar_other		    "Given home remedy or other treatment  for diarrhea"
ch_diar_notrt		    "No treatment for diarrhea"
ch_diar_govh 		    "Diarrhea treatment sought from government hospital among children with diarrhea"
ch_diar_govh_trt 	  "Diarrhea treatment sought from government hospital among children with diarrhea that sought treatment"
ch_diar_govh_ors 	  "Diarrhea treatment sought from government hospital among children with diarrhea that received ORS"
ch_diar_govcent 	  "Diarrhea treatment sought from government health center among children with diarrhea"
ch_diar_govcent_trt "Diarrhea treatment sought from government health center among children with diarrhea that sought treatment"
ch_diar_govcent_ors "Diarrhea treatment sought from government health center among children with diarrhea that received ORS"
ch_diar_pclinc 		  "Diarrhea treatment sought from private hospital/clinic among children with diarrhea"
ch_diar_pclinc_trt 	"Diarrhea treatment sought from private hospital/clinic among children with diarrhea that sought treatment"
ch_diar_pclinc_ors 	"Diarrhea treatment sought from private hospital/clinic among children with diarrhea that received ORS"
ch_diar_pdoc 		    "Diarrhea treatment sought from private doctor among children with diarrhea"
ch_diar_pdoc_trt  	"Diarrhea treatment sought from private doctor among children with diarrhea that sought treatment"
ch_diar_pdoc_ors 	  "Diarrhea treatment sought from private doctor among children with diarrhea that received ORS"
ch_diar_pharm 		  "Diarrhea treatment sought from a pharmacy among children with diarrhea"
ch_diar_pharm_trt 	"Diarrhea treatment sought from a pharmacy among children with diarrhea that sought treatment"
ch_diar_pharm_ors 	"Diarrhea treatment sought from a pharmacy among children with diarrhea that received ORS"
----------------------------------------------------------------------------*/

//Diarrhea symptoms
gen ch_diar=0
replace ch_diar=1 if diarrecent==20 | diarrecent==21 | diarrecent==22 | diarrecent==23
replace ch_diar =. if kidalive==0
label var ch_diar "Diarrhea in the 2 weeks before the survey"

//Diarrhea treatment
*** this is country specific and the footnote for the final table needs to be checked to see what sources are included.
*** The code below only excludes traditional practitioner (usually diatrprivhl). The variable for traditional healer may be different for different surveys 
*** Some surveys also exclude pharmacies, shop, or other sources.
gen ch_diar_care=0 if ch_diar==1
replace ch_diar_care=1 if ch_diar==1 & (diatrprivdr==1 | diatrpubhp==1 | diatrprivmob==1 | diatrpubmob==1 |diatrenone==1 | diatrpubfw==1 | diatrprivhl==1 | diatrpuboth==1 | diatroth==1 | diatrpubhos==1 | diatrprivhos==1 | diatrpubhc==1)
// (ch_diar==1 & diatrprivoth==1) // (ch_diar==1 & diatrprivdrug==1)

/* If you want to also remove pharmacy for example as a source of treatment (country specific condition) you can remove
* the 'k in the list on line 57 or do the following.
replace ch_diar_care=0 if ch_diar==1 & diatrprivdrug==1
replace ch_diar_care =. if kidalive==0
*/
label var ch_diar_care "Advice or treatment sought for diarrhea"

//Liquid intake
recode diafluidupdn (20=1 "More") (10=2 "Same as usual") (31=3 "Somewhat less") (32=4 "Much less") (33=5 "None") ///
(97=9 "Don't know/missing") if ch_diar==1, gen(ch_diar_liq)
label var ch_diar_liq "Amount of liquids given for child with diarrhea"

//Food intake
recode diafoodupdn (20=1 "More") (10=2 "Same as usual") (31=3 "Somewhat less") (32=4 "Much less") (33=5 "None") ///
(40=6 "Never gave food") (97/98=9 "Don't know/missing") if ch_diar==1, gen(ch_diar_food)
label var ch_diar_food "Amount of food given for child with diarrhea"

//ORS
gen ch_diar_ors=0 if ch_diar==1
replace ch_diar_ors=1 if (diagivors==20 | diagivors==21 | diagivors==22) // | diagivpplors==1)
label var ch_diar_ors "Given oral rehydration salts for diarrhea"

//RHF
gen ch_diar_rhf=0 if ch_diar==1
replace ch_diar_rhf=1 if (diagivsolut==10 | diagivsolut==11 | diagivsolut==12)
label var ch_diar_rhf "Given recommended homemade fluids for diarrhea"

//ORS or RHF
gen ch_diar_ors_rhf=0 if ch_diar==1
replace ch_diar_ors_rhf=1 if  (diagivors==20 | diagivors==21 | diagivors==22 | diagivsolut==10 | diagivsolut==11 | diagivsolut==12) //| diagivpplors==1
label var ch_diar_ors_rhf "Given either ORS or RHF for diarrhea"

//Zinc
gen ch_diar_zinc=0 if ch_diar==1
replace ch_diar_zinc=1 if ch_diar==1 & (diagivzinc==10 | diagivzinc==11 | diagivzinc==12)
label  var ch_diar_zinc "Given zinc for diarrhea"

//Zinc and ORS
gen ch_diar_zinc_ors=0 if ch_diar==1
replace ch_diar_zinc_ors=1 if ((diagivors==20 | diagivors==21 | diagivors==22)  & (diagivzinc==10 | diagivzinc==11 | diagivzinc==12)) // | diagivpplors==1
label var ch_diar_zinc_ors "Given zinc and ORS for diarrhea"

//ORS or increased liquids
gen ch_diar_ors_fluid=0 if ch_diar==1
replace ch_diar_ors_fluid=1 if (diagivors==20 | diagivors==21 | diagivors==22 | diafluidupdn==20) // | diagivpplors==1
label var ch_diar_ors_fluid "Given ORS or increased fluids for diarrhea"

//ORT or increased liquids
gen ch_diar_ort=0 if ch_diar==1
replace ch_diar_ort=1 if (diagivors==20 | diagivors==21 | diagivors==22 | diagivsolut==10 | diagivsolut==11 | diagivsolut==12 | diafluidupdn==20)
cap replace ch_diar_ort=1 if diagivpplors==1 // older surveys do not have diagivpplors
label var ch_diar_ort "Given oral rehydration treatment or increased liquids for diarrhea"

//ORT and continued feeding
gen ch_diar_ort_feed=0 if ch_diar==1
replace ch_diar_ort_feed=1 if ((diagivors==20 | diagivors==21 | diagivors==22 | diagivsolut==10 | diagivsolut==11 | diagivsolut==12 | diafluidupdn==20)&(diafoodupdn>=10 & diafoodupdn<=31)) // | diagivpplors==1 
label var ch_diar_ort_feed "Given ORT and continued feeding for diarrhea"

//Antiobiotics
gen ch_diar_antib=0 if ch_diar==1
replace ch_diar_antib=1 if (diagivinjantib==1) //diagivpilsyr==1 | 
label var ch_diar_antib "Given antibiotic drugs for diarrhea"

//Antimotility drugs
gen ch_diar_antim=0 if ch_diar==1
replace ch_diar_antim=1 if diagivantim==1
label var ch_diar_antim "Given antimotility drugs for diarrhea"

//Intravenous solution
gen ch_diar_intra=0 if ch_diar==1
replace ch_diar_intra=1 if diagiviv==1
label var ch_diar_intra "Given Intravenous solution for diarrhea"

//Home remedy or other treatment
gen ch_diar_other=0 if ch_diar==1
replace ch_diar_other=1 if diagivherb==1 | diagivothtyppil==1 | diagivpilunk==1 | diagivinjnonantib==1 |  diagivinjunk==1 | diagivother==1 
// h15j==1 | h15k==1 | h15l==1 | h15m==1 | (dhs vars that have no ipums equiv)
label var ch_diar_other "Given home remedy or other treatment for diarrhea"

//No treatment
gen ch_diar_notrt=0 if ch_diar==1
replace ch_diar_notrt=1 if diagivnone==1
* to double check if received any treatment then the indicator should be replaced to 0
foreach c in ch_diar_ors ch_diar_rhf ch_diar_ors_rhf ch_diar_zinc ch_diar_zinc_ors ch_diar_ors_fluid ch_diar_ort ch_diar_ort_feed ch_diar_antib ch_diar_antim ch_diar_intra ch_diar_other {
replace ch_diar_notrt=0 if `c'==1
}
label var ch_diar_notrt "No treatment for diarrhea"


***Diarrhea treatment by source (among children with diarrhea symptoms)
* This is country specific and needs to be checked to produce the specific source of interest.

//Diarrhea treamtment in government hospital
gen ch_diar_govh=0 if ch_diar==1
replace ch_diar_govh=1 if ch_diar==1 & diatrpubhos==1
replace ch_diar_govh =. if kidalive==0
label var ch_diar_govh "Diarrhea treatment sought from government hospital among children with diarrhea"

gen ch_diar_govh_trt=0 if ch_diar_care==1
replace ch_diar_govh_trt=1 if ch_diar_care==1 & diatrpubhos==1
replace ch_diar_govh_trt =. if kidalive==0
label var ch_diar_govh_trt "Diarrhea treatment sought from government hospital among children with diarrhea that sought treatment"

gen ch_diar_govh_ors=0 if ch_diar_ors==1
replace ch_diar_govh_ors=1 if ch_diar_ors==1 & diatrpubhos==1
replace ch_diar_govh_ors =. if kidalive==0
label var ch_diar_govh_ors "Diarrhea treatment sought from government hospital among children with diarrhea that received ORS"

//Diarrhea treamtment in government health center
gen ch_diar_govcent=0 if ch_diar==1
replace ch_diar_govcent=1 if ch_diar==1 & diatrpubhc==1
replace ch_diar_govcent =. if kidalive==0
label var ch_diar_govcent "Diarrhea treatment sought from government health center among children with diarrhea"

gen ch_diar_govcent_trt=0 if ch_diar_care==1
replace ch_diar_govcent_trt=1 if ch_diar_care==1 & diatrpubhc==1
replace ch_diar_govcent_trt =. if kidalive==0
label var ch_diar_govcent_trt "Diarrhea treatment sought from government health center among children with diarrhea that sought treatment"

gen ch_diar_govcent_ors=0 if ch_diar_ors==1
replace ch_diar_govcent_ors=1 if ch_diar_ors==1 & diatrpubhc==1
replace ch_diar_govcent_ors =. if kidalive==0
label var ch_diar_govcent_ors "Diarrhea treatment sought from government health center among children with diarrhea that received ORS"

//Diarrhea treatment from a private hospital/clinic
gen ch_diar_pclinc=0 if ch_diar==1
replace ch_diar_pclinc=1 if ch_diar==1 & diatrprivhos==1
replace ch_diar_pclinc =. if kidalive==0
label var ch_diar_pclinc "Diarrhea treatment sought from private hospital/clinic among children with diarrhea"

gen ch_diar_pclinc_trt=0 if ch_diar_care==1
replace ch_diar_pclinc_trt=1 if ch_diar_care==1 & diatrprivhos==1
replace ch_diar_pclinc_trt =. if kidalive==0
label var ch_diar_pclinc_trt "Diarrhea treatment sought from private hospital/clinic among children with diarrhea that sought treatment"

gen ch_diar_pclinc_ors=0 if ch_diar_ors==1
replace ch_diar_pclinc_ors=1 if ch_diar_ors==1 & diatrprivhos==1
replace ch_diar_pclinc_ors =. if kidalive==0
label var ch_diar_pclinc_ors "Diarrhea treatment sought from private hospital/clinic among children with diarrhea that received ORS"

//Diarrhea treatment from a private doctor
gen ch_diar_pdoc=0 if ch_diar==1
replace ch_diar_pdoc=1 if ch_diar==1 & diatrprivdr==1
replace ch_diar_pdoc =. if kidalive==0
label var ch_diar_pdoc "Diarrhea treatment sought from private doctor among children with diarrhea"

gen ch_diar_pdoc_trt=0 if ch_diar_care==1
replace ch_diar_pdoc_trt=1 if  ch_diar_care==1 & diatrprivdr==1
replace ch_diar_pdoc_trt =. if kidalive==0
label var ch_diar_pdoc_trt "Diarrhea treatment sought from private doctor among children with diarrhea that sought treatment"

gen ch_diar_pdoc_ors=0 if ch_diar_ors==1
replace ch_diar_pdoc_ors=1 if ch_diar_ors==1 &  diatrpubhos==1
replace ch_diar_pdoc_ors =. if kidalive==0
label var ch_diar_pdoc_ors "Diarrhea treatment sought from private doctor among children with diarrhea that received ORS"

//Diarrhea treatment from a pharmacy
gen ch_diar_pharm=0 if ch_diar==1
replace ch_diar_pharm=1 if ch_diar==1 & diatrprivdrug==1
replace ch_diar_pharm =. if kidalive==0
label var ch_diar_pharm "Diarrhea treatment sought from a pharmacy among children with diarrhea"

gen ch_diar_pharm_trt=0 if ch_diar_care==1
replace ch_diar_pharm_trt=1 if  ch_diar_care==1 & diatrprivdrug==1
replace ch_diar_pharm_trt =. if kidalive==0
label var ch_diar_pharm_trt "Diarrhea treatment sought from a pharmacy among children with diarrhea that sought treatment"

gen ch_diar_pharm_ors=0 if ch_diar_ors==1
replace ch_diar_pharm_ors=1 if ch_diar_ors==1 & diatrprivdrug==1
replace ch_diar_pharm_ors =. if kidalive==0
label var ch_diar_pharm_ors "Diarrhea treatment sought from a pharmacy among children with diarrhea that received ORS"
