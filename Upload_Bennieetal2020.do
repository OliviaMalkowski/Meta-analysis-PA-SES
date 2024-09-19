* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: European Health Interview Survey: United Kingdom Data, Wave 2 and 3, 2013-2020. [data collection]. 2nd Edition. UK Data Service. SN: 7881, DOI: http://doi.org/10.5255/UKDA-SN-7881-2

* Date of data access/download (dd/mm/yyyy): 01/06/2023

* Project ID: 237630

cd ""

use PID HHID WGT PROXY REFYEAR INTMETHOD SEX AGE BIRTHPLACE CITIZEN Region DEG_URB HATLEVEL MAINSTAT FT_PT JOBSTAT HHINCOME HS1 HS2 HS3 BMI PE1 PE2 PE3 PE4 PE5 PE6 PE7 PE8 using ehis_wave_2_uk.dta

save Bennie32575.dta

unique PID 
* 20161
unique HHID 
* 13962, 20161

* Sex 
tab SEX

* Age
tab AGE
replace AGE = 14 if inlist(AGE,15,16)

* Income 
tab HHINCOME 
replace HHINCOME = . if HHINCOME==-1

* Education
tab HATLEVEL
gen education = 3 if inlist(HATLEVEL,0,1)
replace education = 2 if inlist(HATLEVEL,2,3)
replace education = 1 if inlist(HATLEVEL,4,5)
replace education = 0 if inlist(HATLEVEL,6,7,8)

* Degree of urbanization
tab DEG_URB
replace DEG_URB = . if DEG_URB==-1

* Self-rated health
tab HS1
replace HS1 = . if HS1==-1

* BMI 
tab BMI
replace BMI = . if BMI==-1

* Limitations due to health problems
tab HS3
replace HS3 = . if HS3==-1

* Occupational status 
tab MAINSTAT
gen occupation = 0 if MAINSTAT==31
replace occupation = 1 if MAINSTAT==10
replace occupation = 2 if MAINSTAT==35
replace occupation = 3 if MAINSTAT==32
replace occupation = 4 if MAINSTAT==20
replace occupation = 5 if MAINSTAT==33

* Physical effort during working tasks
tab PE1
replace PE1 = . if PE1==-1
replace PE1 = . if PE1==4

* Physical activity guidelines
tab PE8
drop if PE8==-1
unique PID 
* 17869
gen guidelines = 0 if inlist(PE8,0,1)
replace guidelines = 1 if inlist(PE8,2,3,4,5,6,7)

* Weight
sum WGT

gen SES = 0 if inlist(HHINCOME,1,2)
replace SES = 1 if inlist(HHINCOME,3,4,5)

drop if AGE==1
unique PID  
* 17697

save fullBennie.dta

keep if AGE>=11
unique PID
* 8630

gen BMI2 = 0 if BMI==2
replace BMI2 = 1 if BMI==1
replace BMI2 = 2 if BMI==3
replace BMI2 = 3 if BMI==4
save Bennieage60.dta
tab SEX 
* 3,981 male, 4,649 female

log using 20230601Bennie.log

keep if SES==0
unique PID 
* 3660
tab SEX 
* 1483 male, 2177 female
tab guidelines BMI 
tab guidelines HS1
tab guidelines BMI [aw=WGT]
tab guidelines HS1 [aw=WGT]

glm guidelines i.BMI2 [pw=WGT], family(poisson) link(log) vce(robust)
glm guidelines i.HS1 [pw=WGT], family(poisson) link(log) vce(robust)
glm guidelines i.BMI2, family(poisson) link(log) vce(robust)
glm guidelines i.HS1, family(poisson) link(log) vce(robust)
clear 

use Bennieage60.dta 
keep if SES==1
unique PID 
* 4968
tab SEX 
* 2498 male, 2470 female
tab guidelines BMI 
tab guidelines HS1
tab guidelines BMI [aw=WGT]
tab guidelines HS1 [aw=WGT]

glm guidelines i.BMI2 [pw=WGT], family(poisson) link(log) vce(robust)
glm guidelines i.HS1 [pw=WGT], family(poisson) link(log) vce(robust)
glm guidelines i.BMI2, family(poisson) link(log) vce(robust)
glm guidelines i.HS1, family(poisson) link(log) vce(robust)
clear 

log close