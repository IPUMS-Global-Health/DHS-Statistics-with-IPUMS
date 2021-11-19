/*****************************************************************************************************
Program: 			IPUMS_CH_SIZE.do
Purpose: 			Code child size variables.
Data inputs: 		KR survey list
Data outputs:		coded variables
Author:				Shireen Assaf, modified by Faduma Shaba for this project
Date last modified: June 2020
*****************************************************************************************************/
/* IPUMS Variables used in this file:
Children variables:
birthsz			"Size of child at birth (subjective report)"
birthwt			"Birthweight in kilos"
----------------------------------------------------------------------------
Variables created in this file:
ch_size_birth	"Size of child at birth as reported by mother"
ch_report_bw	"Has a reported birth weight"
ch_below_2p5	"Birth weight less than 2.5 kg"
----------------------------------------------------------------------------*/

//Child's size at birth
recode birthsz (32=1 "Very small") (31=2 "Smaller than average") (10/20 =3 "Average or larger") (97/98=9 "Don't know/missing"), gen(ch_size_birth)

//Child's birth weight was reported
recode birthwt (0/9995=1) (else=0), gen(ch_report_bw)

//Child before 2.5kg
recode birthwt (0/2499=1) (else=0) if ch_report_bw==1, gen(ch_below_2p5)
