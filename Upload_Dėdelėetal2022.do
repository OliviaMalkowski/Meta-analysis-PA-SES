* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: European Commission, Brussels (2022). Eurobarometer 88.4 (2017). GESIS, Cologne. ZA6939 Data file Version 3.0.0, https://doi.org/10.4232/1.14003.

* Date of data access/download (dd/mm/yyyy): 18/05/2023

cd ""
use ZA6939_v3-0-0.dta

keep w3a4a nation w4a cntry_gb p7gb_r p7gb p6gb d60 d63 d25 d15b_r d15b d15a_r2 d15a_r1 d15a d8r2 d8r1 d8 d11r3 d11r2 d11r1 d11 d10 d7r3 d7r2 d7r1 d7 qb9_12 qb9_11 qb9_10 qb9_9 qb9_8 qb9_7 qb9_6 qb9_5 qb9_4 qb9_3 qb9_2 qb9_1 qb8_17 qb8_16 qb8_15 qb8_14 qb8_13 qb8_12 qb8_11 qb8_10 qb8_9 qb8_8 qb8_7 qb8_6 qb8_5 qb8_4 qb8_3 qb8_2 qb8_1 qb4b qb4a_r qb4a qb3b qb3a_r qb3a qb1b2t qb2r qb2 qb1r qb1 qa12b_2 qa12b_1 qa12a_2 qa12a_1 qa11 qa9a qa7a q1_12 w4 gb isocntry country tnscntry serialid uniqid caseid

keep if gb==1
unique uniqid
* 1338
save GBDedele.dta

* Income
tab qa11

* Physical activity
gen minvig = 30 if qb3b==1
replace minvig = 45 if qb3b==2
replace minvig = 75 if qb3b==3
replace minvig = 105 if qb3b==4
replace minvig = 120 if qb3b==5
gen dayvig = qb3a 
replace dayvig = 0 if dayvig==8
gen minmod = 30 if qb4b==1
replace minmod = 45 if qb4b==2
replace minmod = 75 if qb4b==3
replace minmod = 105 if qb4b==4
replace minmod = 120 if qb4b==5
gen daymod = qb4a 
replace daymod = 0 if daymod==8

gen vigorous = dayvig*minvig
tab vigorous if qb3a==8
tab vigorous if qb3b==6
replace vigorous = 0 if qb3b==6
replace vigorous = 0 if qb3a==8
gen moderate = daymod*minmod
tab moderate if qb4a==8
tab moderate if qb4b==6
replace moderate = 0 if qb4b==6
replace moderate = 0 if qb4a==8
gen combination = moderate+vigorous

gen MVPA = 0 if vigorous<75&moderate<120&combination<120
replace MVPA = 1 if (vigorous>=75 & vigorous!=.) | (moderate>=120 & moderate!=.) | (combination>=120 & combination!=.)

* Motivations 
* Health improvement 
tab qb8_1 
* Physical appearance 
tab qb8_2 
* Counteract aging 
tab qb8_3 
* Have fun
tab qb8_4 
* Relax
tab qb8_5
* Be with friends 
tab qb8_6 
* Make acquaintances 
tab qb8_7 
* Meet other cultures
tab qb8_8 
* Physical performance 
tab qb8_9 
* Fitness 
tab qb8_10 
* Control weight 
tab qb8_11 
* Self-esteem
tab qb8_12 
* New skills 
tab qb8_13
* Spirit of competition 
tab qb8_14
* Social integration 
tab qb8_15 
* Other (spont)
tab qb8_16 
* DK
tab qb8_17

* Barriers  
* No time
tab qb9_1
* Too expensive
tab qb9_2
* Competitivity
tab qb9_3
* No infrastructure 
tab qb9_4 
* Disability/Illness 
tab qb9_5 
* No friends 
tab qb9_6 
* Feel discriminated 
tab qb9_7 
* Lack motivation 
tab qb9_8 
* Risk of injuries
tab qb9_9
* Already doing (spont)
tab qb9_10
* Other (spont)
tab qb9_11
* DK 
tab qb9_12

* Marital status 
tab d7r2 

* Gender 
tab d10

* Age
tab d11

* Age of graduation 
tab d8r2

* Occupation 
tab d15a_r2

* Type of community
tab p6gb

* Difficulty paying bills 
tab d60 

* Social class
tab d63 

save Dedelefull.dta

keep if d11>=60
* 520 

save Dedelefullage60.dta
tab d10
* 275 male, 245 female
* Weights: w3a4a w4a w4
gen SES = 0 if inlist(qa11,1,2)
replace SES = 1 if inlist(qa11,3,4,5)
gen socialclass = d63 
replace socialclass  = . if socialclass==7
save Dedelefullage60.dta, replace
log using 20230518Dedele.log 
keep if SES==0
unique serialid 
* 229

tab MVPA qb8_1 [aw=w4]
tab MVPA qb8_2 [aw=w4]
tab MVPA qb8_3 [aw=w4]
tab MVPA qb8_4 [aw=w4]
tab MVPA qb8_5 [aw=w4]
tab MVPA qb8_6 [aw=w4]
tab MVPA qb8_7 [aw=w4]
tab MVPA qb8_8 [aw=w4]
tab MVPA qb8_9 [aw=w4]
tab MVPA qb8_10 [aw=w4]
tab MVPA qb8_11 [aw=w4]
tab MVPA qb8_12 [aw=w4]
tab MVPA qb8_13 [aw=w4]
tab MVPA qb8_14 [aw=w4]
tab MVPA qb8_15 [aw=w4]
tab MVPA qb9_1 [aw=w4]
tab MVPA qb9_2 [aw=w4]
tab MVPA qb9_3 [aw=w4]
tab MVPA qb9_4 [aw=w4]
tab MVPA qb9_5 [aw=w4]
tab MVPA qb9_6 [aw=w4]
tab MVPA qb9_7 [aw=w4]
tab MVPA qb9_8 [aw=w4]
tab MVPA qb9_9 [aw=w4]
tab MVPA qb9_10 [aw=w4]

tab MVPA qb8_1
tab MVPA qb8_2
tab MVPA qb8_3
tab MVPA qb8_4
tab MVPA qb8_5
tab MVPA qb8_6
tab MVPA qb8_7
tab MVPA qb8_8
tab MVPA qb8_9
tab MVPA qb8_10
tab MVPA qb8_11
tab MVPA qb8_12
tab MVPA qb8_13
tab MVPA qb8_14
tab MVPA qb8_15
tab MVPA qb9_1
tab MVPA qb9_2
tab MVPA qb9_3
tab MVPA qb9_4
tab MVPA qb9_5
tab MVPA qb9_6
tab MVPA qb9_7
tab MVPA qb9_8
tab MVPA qb9_9
tab MVPA qb9_10
clear 

use Dedelefullage60.dta
keep if SES==1
unique serialid 
* 88

tab MVPA qb8_1 [aw=w4]
tab MVPA qb8_2 [aw=w4]
tab MVPA qb8_3 [aw=w4]
tab MVPA qb8_4 [aw=w4]
tab MVPA qb8_5 [aw=w4]
tab MVPA qb8_6 [aw=w4]
tab MVPA qb8_7 [aw=w4]
tab MVPA qb8_8 [aw=w4]
tab MVPA qb8_9 [aw=w4]
tab MVPA qb8_10 [aw=w4]
tab MVPA qb8_11 [aw=w4]
tab MVPA qb8_12 [aw=w4]
tab MVPA qb8_13 [aw=w4]
tab MVPA qb8_14 [aw=w4]
tab MVPA qb8_15 [aw=w4]
tab MVPA qb9_1 [aw=w4]
tab MVPA qb9_2 [aw=w4]
tab MVPA qb9_3 [aw=w4]
tab MVPA qb9_4 [aw=w4]
tab MVPA qb9_5 [aw=w4]
tab MVPA qb9_6 [aw=w4]
tab MVPA qb9_7 [aw=w4]
tab MVPA qb9_8 [aw=w4]
tab MVPA qb9_9 [aw=w4]
tab MVPA qb9_10 [aw=w4]

tab MVPA qb8_1
tab MVPA qb8_2
tab MVPA qb8_3
tab MVPA qb8_4
tab MVPA qb8_5
tab MVPA qb8_6
tab MVPA qb8_7
tab MVPA qb8_8
tab MVPA qb8_9
tab MVPA qb8_10
tab MVPA qb8_11
tab MVPA qb8_12
tab MVPA qb8_13
tab MVPA qb8_14
tab MVPA qb8_15
tab MVPA qb9_1
tab MVPA qb9_2
tab MVPA qb9_3
tab MVPA qb9_4
tab MVPA qb9_5
tab MVPA qb9_6
tab MVPA qb9_7
tab MVPA qb9_8
tab MVPA qb9_9
tab MVPA qb9_10
clear 

log close