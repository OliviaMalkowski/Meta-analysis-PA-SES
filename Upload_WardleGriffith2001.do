* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Office for National Statistics, Social Survey Division. (2001). ONS Omnibus Survey, March 1999. [data collection]. UK Data Service. SN: 4223, DOI: http://doi.org/10.5255/UKDA-SN-4223-1

* Date of data access/download (dd/mm/yyyy): 01/06/2023

* Project ID: 237630

cd ""

use serial respsex respage respmar ethnic hhtypb hhtypa ten1 hhtype cars numcar fulled wrking yinact dvilo3 dvilo4 everwk sc1 seggrp agex ageh wta wtc wtcind defact1 defacto lefted car tengrp m227_6m1 m227_6m2 m227_6m3 m227_6m4 m227_6m5 m227_6m6 m227_6m7 m227_6m8 m227_6m9 m227_6ma m227_6mb m227_6mc m227_6md m227_7 m227_8a mlbs_8a mst_8a mstlb_8a mkgs_8a m227_8b mlbs_8b mst_8b mstlb_8b mkgs_8b m227_9 m227_10 m22711m1 m22711m2 m22711m3 m22711m4 m22711m5 m22711m6 m227_12 mst_12 mstlb_12 mkgs_12 mlbs_12 m227_13 m227_14 mst_14 mstlb_14 mkgs_14 mlbs_14 m227_15 mst_15 mstlb_15 mkgs_15 mlbs_15 m227_16 mst_16 mstlb_16 mkgs_16 mlbs_16 m227_17 mft_17 min_17 mcms_17 mmet_17 mmcm_17 m227_18 m227_19 using f9903227.dta
save rawWarGri.dta 

unique serial
* 1894

* Social class
gen class = sc1
replace class = 0 if inlist(class,1,2)
replace class = 3 if inlist(class,4,5)
replace class = . if inlist(class,6,7)

* Sex 
tab respsex
tab respsex class

* Age 
tab respage

* BMI
tab m227_12
sum mst_12
sum mstlb_12
sum mkgs_12
sum mlbs_12
gen mlbskg_12 = mlbs_12/2.205
gen mstlbkg_12 = mstlb_12/2.205
gen mstkg_12 = mst_12*6.35
gen stlbskg = mstlbkg_12+mstkg_12
replace stlbskg = mstkg_12 if stlbskg==. & mstkg_12!=.

sum mkgs_12 
sum mlbskg_12 
sum stlbskg
replace stlbskg = . if stlbskg>200

gen weight = mkgs_12
replace weight = mlbskg_12 if weight==.
replace weight = stlbskg if weight==.

tab m227_17 
sum mft_17 
sum min_17 
sum mcms_17
sum mmet_17 
sum mmcm_17
gen mftm_17 = mft_17/3.281
gen minm_17 = min_17/39.37
gen mcmsm_17 = mcms_17/100
gen mmcmm_17 = mmcm_17/100
gen ftinm = mftm_17+minm_17 
gen mcmm = mmet_17+mmcmm_17

sum ftinm 
sum mcmm 
sum mcmsm_17 

gen height = ftinm 
replace height = mcmm if height==. 
replace height = mcmsm_17 if height==.

gen BMI = (weight/(height*height)) if weight!=. & height!=.

gen BMIc = 0 if BMI<25
replace BMIc = 1 if BMI>=25 & BMI<30
replace BMIc = 2 if BMI>=30 & BMI!=.

* Physical activity
tab m227_6m1 
tab m227_6m2
tab m227_6m3 
tab m227_6m4 
tab m227_6m5 
tab m227_6m6 
tab m227_6m7 
tab m227_6m8 
tab m227_6m9 
tab m227_6ma 
tab m227_6mb 
tab m227_6mc 
tab m227_6md

gen PA = 1 if m227_6m1 == 13 | m227_6m2 == 13 | m227_6m3  == 13 | m227_6m4  == 13 | m227_6m5  == 13 | m227_6m6  == 13 | m227_6m7  == 13 | m227_6m8  == 13 | m227_6m9  == 13 | m227_6ma  == 13 | m227_6mb  == 13 | m227_6mc  == 13 | m227_6md  == 13
replace PA = 0 if PA!=1
replace PA = . if m227_6m1==98

* Education
tab fulled 
tab lefted

* Socio-economic status
gen SES2 = 0 if class==3
replace SES2 = 1 if class==0
replace SES2 = 0 if sc1==3.2
replace SES2 = 1 if sc1==3.1

save fullWarGri.dta

keep if respage>=60
unique serial
* 555
save WarGriage60v2.dta 
tab respsex
* 235 male, 320 female

log using 20230824WarGri.log

keep if SES2==0
unique serial 
* 247
tab PA BMIc 
logit PA BMI, or 
logit PA i.BMIc, or
tab respsex 
* 121 male, 126 female
clear 

use WarGriage60v2.dta 
keep if SES2==1
unique serial 
* 281
tab PA BMIc 
logit PA BMI, or 
logit PA i.BMIc, or
tab respsex
* 112 male, 169 female
clear

log close