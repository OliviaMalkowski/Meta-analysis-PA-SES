* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: ISSP Research Group (2015). International Social Survey Programme: Health and Health Care - ISSP 2011. GESIS Data Archive, Cologne. ZA5800 Data file Version 3.0.0, https://doi.org/10.4232/1.12252.

* Date of data access/download (dd/mm/yyyy): 21/05/2023

cd ""
use ZA5800_v3-0-0.dta

keep V3 V4 C_ALPHAN V55 V57 V56 V58 V59 V60 V61 V62 V37 V38 V39 V40 V41 V69 SEX BIRTH AGE EDUCYRS GB_DEGR DEGREE WORK WRKHRS ISCO88 MAINSTAT PARTLIV HHCHILDR HHTODD HOMPOP GB_RINC GB_INC MARITAL URBRURAL GB_REG CASEID SUBSCASE WEIGHT V27 CN_V5 V5
* 55081
* Age 
drop if AGE<65
* 11250
gen age = AGE
replace age = . if AGE==999
drop if age==.
* 11036
* Sex
gen sex = SEX 
replace sex = . if SEX==9
tab sex if active!=.
* Years of education
gen education = EDUCYRS 
replace education = . if  inlist(EDUCYRS,98,99)
* Smoking 
gen smoking = V55
replace smoking = . if inlist(V55,0,98,99)
* Alcohol consumption
gen alcohol = V56
replace alcohol = . if inlist(V56,0,8,9)
* Living alone
gen living = 0 if inlist(HOMPOP,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)
replace living = 1 if HOMPOP==1
replace living = 0 if HOMPOP==99
replace living = 0 if HOMPOP==0
tab living if active!=.
* Steady partner
gen steady=0 if PARTLIV==3
replace steady = 1 if inlist(PARTLIV,1,2)
replace steady=0 if inlist(PARTLIV,0,7,9)
gen revsteady = 0 if steady==1
replace revsteady = 1 if steady==0
tab revsteady if active!=.
* Working status
gen work2 =  MAINSTAT
replace work2 = . if work2==99
replace work2 = 0 if inlist(work2,2,5,6,7,9)
replace work2 = 1 if inlist(work2,3,4,8)
gen revwork = 0 if work2==1
replace revwork = 1 if work2==0
tab revwork if active!=.
* Residence 
gen residence=URBRURAL
replace residence=. if inlist(residence,8,9)
tab residence if active!=.
gen residence2 = residence 
replace residence2 = 0 if inlist(residence2,1,3,4,5)
replace residence2 = 1 if residence2==2
gen residence3 = residence 
replace residence3 = 0 if inlist(residence3,1,2,4,5)
replace residence3 = 1 if residence3==3
gen residence4 = residence 
replace residence4 = 0 if inlist(residence4,1,2,3,5)
replace residence4 = 1 if residence4==4
gen residence5 = residence 
replace residence5 = 0 if inlist(residence5,1,2,3,4)
replace residence5 = 1 if residence5==5
* Active living, 0 inactive living, 1 active living
gen active = V57
replace active = 0 if inlist(active,1,2,3)
replace active = 1 if inlist(active,4,5)
replace active = . if inlist(active,8,9)

logit active age i.sex education smoking alcohol i.living i.revsteady i.revwork i.residence2 i.residence3 i.residence4 i.residence5, or

* Difficulties
gen difficulties = V37
replace difficulties = . if inlist(difficulties,0,8,9)
sum difficulties
* Bodily aches or pains
gen pains = V38
replace pains = . if inlist(pains,8,9)
sum pains
* Long-standing illness
gen illness = V60
replace illness = 0 if illness==2
replace illness = . if inlist(illness,8,9)
revrs illness
tab illness
tab revillness
* BMI 
gen weight = V62 
replace weight = . if inlist(weight,0,998,999)
gen height = V61
replace height = . if inlist(height,0,998,999)
gen heightm = height/100
sum weight, d
sum heightm, d

gen BMI = weight/(heightm*heightm)
sum BMI, d

* 0 normal, 1 underweight, 2 overweight, 3 obese
gen BMI_cat = 1 if BMI<18.50
replace BMI_cat = 0 if BMI>=18.50 & BMI<25.01
replace BMI_cat = 2 if BMI>=25.01 & BMI<30.00
replace BMI_cat = 3 if BMI>=30.00 & BMI!=.

gen BMI1 = BMI_cat
replace BMI1 = 0 if inlist(BMI1,0,2,3)
replace BMI1 = 1 if BMI1==1
gen BMI2 = BMI_cat
replace BMI2 = 0 if inlist(BMI2,0,1,3)
replace BMI2 = 1 if BMI2==2
gen BMI3 = BMI_cat
replace BMI3 = 0 if inlist(BMI3,0,1,2)
replace BMI3 = 1 if BMI3==3

* Unhappy or depressed 
gen depressed =  V39 
replace depressed = . if inlist(depressed,8,9)
sum depressed
* Confidence 
gen confidence = V40
replace confidence = . if inlist(confidence,8,9)
sum confidence
* Overcome problems 
gen overcome = V41
replace overcome = . if inlist(overcome,8,9)
sum overcome

* General health 
gen health = V59
replace health = . if inlist(health,0,8,9)
revrs health
sum health
sum revhealth
save fullYen2010.dta

logit active age i.sex education smoking alcohol i.living i.revsteady i.revwork i.residence2 i.residence3 i.residence4 i.residence5 difficulties pains i.revillness i.BMI1 i.BMI2 i.BMI3 depressed confidence overcome revhealth, or

gen SES = 0 if education<=14
replace SES = 1 if education >14 & education<100

save fullYen2010.dta, replace
keep if C_ALPHAN=="GB-GBN"
* 212
tab sex
* 95 male, 117 female
save YenUK.dta
log using 20241020Yen.log

keep if SES==0
* 196 
tab SEX 
* 86 male, 110 female
tab smoking active 
tab alcohol active
tab difficulties active 
tab pains active 
tab BMI_cat active 
tab depressed active 
tab confidence active 
tab overcome active 
tab health active
clear 

use YenUK.dta 
keep if SES==1
* 15
tab SEX 
* 8 male, 7 female
tab smoking active 
tab alcohol active
tab difficulties active 
tab pains active 
tab BMI_cat active 
tab depressed active 
tab confidence active 
tab overcome active 
tab health active
clear 
log close