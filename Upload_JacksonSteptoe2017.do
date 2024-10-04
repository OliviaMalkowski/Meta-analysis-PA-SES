* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Banks, J., Batty, G. David, Breedvelt, J., Coughlin, K., Crawford, R., Marmot, M., Nazroo, J., Oldfield, Z., Steel, N., Steptoe, A., Wood, M., Zaninotto, P. (2021). English Longitudinal Study of Ageing: Waves 0-9, 1998-2019. [data collection]. 37th Edition. UK Data Service. SN: 5050, DOI: http://doi.org/10.5255/UKDA-SN-5050-24

* Project ID: 237630

cd ""

* Variables Wave 5
use idauniq samptyp diagr indager dhsex disex indsex heacta heactb heactc scdtdre scdtdst scdtdcl scdtdha scdtddr scdtd01 scdtd02 scdtd03 scdtd04 scdtd05 scdtd06 scdtd07 scdtd08 scdtd85 finstatw5 w5lwgt w5xwgt w5scwt using wave_5_elsa_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 5 to each observation (to designate Wave 5)
gen wave = 5
* Save Wave 5 core dataset
save wave5.dta

* Variables Wave 4 Nurse
use idauniq resphts height ehtch ehtm ehtft ehtin estht htval htok relhite respwts weight ewtch ewtkg ewtst ewtl estwt wtval wtok relwait bmi bmival bmiok bmiobe w4nurwt using wave_4_nurse_data.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Save Wave 4 nurse dataset
save wave4nurse.dta

* Variables Wave 5 Financial Derived
use idauniq nettotw_bu_s nettotw_bu_f nettotw_bu_t totwq5_bu_s using wave_5_financial_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Save Wave 5 financial derived dataset
save wave5financial.dta

* Wave 5 complete data
* Merge core and financial datasets for Wave 5 using the participant ID
* Use Wave 5 core dataset
use wave5.dta
* One-to-one merge of data in memory with wave5financial.dta on participant ID
merge 1:1 idauniq using wave5financial.dta, generate (merge_financial5)
* Sort from lowest to highest participant ID
sort idauniq
* Overwrite Wave 5 dataset, by replacing the previously saved file
save wave5.dta, replace
* One-to-one merge of data in memory with wave4nurse.dta on participant ID
merge 1:1 idauniq using wave4nurse.dta, generate (merge_nurse4)
* Sort from lowest to highest participant ID
sort idauniq
* Overwrite Wave 5 dataset, by replacing the previously saved file
save wave5.dta, replace

* Age
replace indager = 99 if indager==-7

* Sex
gen Sex = 0 if disex==1
replace Sex = 1 if disex==2

* Perceived discrimination
replace scdtdre = . if scdtdre<0
replace scdtdst = . if scdtdst<0
replace scdtdcl = . if scdtdcl<0
replace scdtdha = . if scdtdha<0
replace scdtddr = . if scdtddr<0

replace scdtdre = 1 if inlist(scdtdre,2,3,4,5)
replace scdtdre = 0 if scdtdre==6

replace scdtdst = 1 if inlist(scdtdst,2,3,4,5)
replace scdtdst = 0 if scdtdst==6

replace scdtdcl = 1 if inlist(scdtdcl,2,3,4,5)
replace scdtdcl = 0 if scdtdcl==6

replace scdtdha = 1 if inlist(scdtdha,2,3,4,5)
replace scdtdha = 0 if scdtdha==6

replace scdtddr = 1 if inlist(scdtddr,2,3,4,5)
replace scdtddr = 0 if scdtddr==6

gen discrimination = 0 if scdtdre==0&scdtdst==0&scdtdcl==0&scdtdha==0&scdtddr==0
replace discrimination = 1 if scdtdre==1|scdtdst==1|scdtdcl==1|scdtdha==1|scdtddr==1

replace scdtd04 = . if scdtd04<0

* Wealth 
* nettotw_bu_s 5982, totwq5_bu_s 5685

* Vigorous/Moderate/Mild sports or activities (Wave 9, COVID Wave 2)
* Replace variables as missing for any missing cases (coded as negative numbers in the ELSA dataset)
replace heacta = . if heacta<0
replace heactb = . if heactb<0
replace heactc = . if heactc<0
* Generate a new variable
gen activity2 = .
* Assign the number 3 if the participant partakes in vigorous activity more than once a week or ("|") once a week
replace activity2 = 3 if heacta==1 | heacta==2
* Assign the number 2 if the participant partakes in moderate activity more than once a week or once a week, and takes part in vigorous activity less than once a week
replace activity2 = 2 if (heactb==1 | heactb==2) & inlist(heacta,3,4)
* Assign the number 1 if the participant partakes in mild activity more than once a week or once a week, and takes part in moderate and vigorous activities less than once a week
replace activity2 = 1 if (heactc==1 | heactc==2) & inlist(heacta,3,4) & inlist(heactb,3,4)
* Assign the number 0 if the participant does not take part in activity of any intensity once a week or more
replace activity2 = 0 if inlist(heacta,3,4) & inlist(heactb,3,4) & inlist(heactc,3,4)
* Replace the variable as missing for participants with missing cases on all three variables
replace activity2 = . if inlist(heacta,.) & inlist(heactb,.) & inlist(heactc,.)
* Coding of final physical activity variable:
* 3: Vigorous activity at least once per week
* 2: At least moderate but no vigorous activity at least once per week
* 1: Only mild activity at least once per week
* 0: Inactive (no activity on a weekly basis)
save interim33235.dta 
keep if samptyp=="CM"
unique idauniq 
* 9090
save interim33235.dta, replace
gen total = scdtdre+scdtdst+scdtdcl+scdtdha+scdtddr

save attempt33235.dta

use  attempt33235.dta
gen weightdis5 = 0 if scdtdre==0&scdtdst==0&scdtdcl==0&scdtdha==0&scdtddr==0
replace weightdis5 = 0 if scdtd04==0 & discrimination==1
replace weightdis5 = 1 if scdtd04==1 & discrimination==1
drop if weightdis5==.
keep if bmival>=0
drop if bmival==.
keep if nettotw_bu_s!=.
keep if totwq5_bu_s!=.
unique idauniq 
* 5480
save finalJacksonSteptoe.dta 

bysort weightdis5: sum indager
tab Sex
tab Sex weightdis5
bysort weightdis5: tab totwq5_bu_s
bysort weightdis5: sum bmival

gen activity3 = .
replace activity3 = 3 if heacta==1 | heacta==2
* Assign the number 2 if the participant partakes in moderate activity more than once a week or once a week, and takes part in vigorous activity less than once a week
replace activity3 = 2 if (heactb==1 | heactb==2) & inlist(heacta,3,4,.)
* Assign the number 1 if the participant partakes in mild activity more than once a week or once a week, and takes part in moderate and vigorous activities less than once a week
replace activity3 = 1 if (heactc==1 | heactc==2) & inlist(heacta,3,4,.) & inlist(heactb,3,4,.)
* Assign the number 0 if the participant does not take part in activity of any intensity once a week or more
replace activity3 = 0 if inlist(heacta,3,4) & inlist(heactb,3,4) & inlist(heactc,3,4)

tab activity3 if weightdis5==0
tab activity3 if weightdis5==1

gen bmic = bmiobe
replace bmic = 0 if inlist(bmic,1,2)
replace bmic = 1 if bmic==3
replace bmic = 2 if bmic==4

tab weightdis5 bmic

gen inactive2 = 1 if activity2==0
replace inactive2 = 0 if inlist(activity2,1,2,3)

gen inactive3 = 1 if activity3==0
replace inactive3 = 0 if inlist(activity3,1,2,3)

gen MVPA2 = 1 if inlist(activity2,2,3)
replace MVPA2 = 0 if inlist(activity2,0,1)

gen MVPA3 = 1 if inlist(activity3,2,3)
replace MVPA3 = 0 if inlist(activity3,0,1)

gen SES = 0 if inlist(totwq5_bu_s,1,2)
replace SES = 1 if inlist(totwq5_bu_s,3,4,5)

save finalJacksonSteptoe.dta 

keep if indager>=60
unique idauniq 
*4343
save JacksonSteptoeage60.dta 
tab Sex 
* 1,928 male, 2,415 female

log using 20230604JackStep.log

keep if SES==0
tab disex 
* 584 male, 897 female
unique idauniq 
*1481
logit inactive2 indager i.Sex i.bmic i.weightdis5, or 
logit inactive2 indager i.Sex i.bmic i.weightdis5 [pweight=w5xwgt], or 
logit inactive3 indager i.Sex i.bmic i.weightdis5, or 
logit inactive3 indager i.Sex i.bmic i.weightdis5 [pweight=w5xwgt], or 
logit MVPA2 indager i.Sex i.bmic i.weightdis5, or 
logit MVPA2 indager i.Sex i.bmic i.weightdis5 [pweight=w5xwgt], or 
logit MVPA3 indager i.Sex i.bmic i.weightdis5, or 
logit MVPA3 indager i.Sex i.bmic i.weightdis5 [pweight=w5xwgt], or 
tab inactive2 bmic 
tab inactive3 bmic
tab MVPA2 bmic 
tab MVPA3 bmic 
tab inactive2 bmic [aw=w5xwgt]
tab inactive3 bmic [aw=w5xwgt]
tab MVPA2 bmic [aw=w5xwgt]
tab MVPA3 bmic [aw=w5xwgt]
tab inactive2 weightdis5 
tab inactive3 weightdis5 
tab MVPA2 weightdis5  
tab MVPA3 weightdis5  
tab inactive2 weightdis5 [aw=w5xwgt]
tab inactive3 weightdis5 [aw=w5xwgt]
tab MVPA2 weightdis5 [aw=w5xwgt]
tab MVPA3 weightdis5 [aw=w5xwgt]
tab activity2 bmic 
tab activity3 bmic 
tab activity2 bmic [aw=w5xwgt]
tab activity3 bmic [aw=w5xwgt]
tab activity2 weightdis5 
tab activity3 weightdis5
tab activity2 weightdis5 [aw=w5xwgt]
tab activity3 weightdis5 [aw=w5xwgt]
clear 

use JacksonSteptoeage60.dta 
keep if SES==1
tab disex 
* 1,344 male, 1,518 female
unique idauniq 
*2862
logit inactive2 indager i.Sex i.bmic i.weightdis5, or 
logit inactive2 indager i.Sex i.bmic i.weightdis5 [pweight=w5xwgt], or 
logit inactive3 indager i.Sex i.bmic i.weightdis5, or 
logit inactive3 indager i.Sex i.bmic i.weightdis5 [pweight=w5xwgt], or 
logit MVPA2 indager i.Sex i.bmic i.weightdis5, or 
logit MVPA2 indager i.Sex i.bmic i.weightdis5 [pweight=w5xwgt], or 
logit MVPA3 indager i.Sex i.bmic i.weightdis5, or 
logit MVPA3 indager i.Sex i.bmic i.weightdis5 [pweight=w5xwgt], or 
tab inactive2 bmic 
tab inactive3 bmic
tab MVPA2 bmic 
tab MVPA3 bmic 
tab inactive2 bmic [aw=w5xwgt]
tab inactive3 bmic [aw=w5xwgt]
tab MVPA2 bmic [aw=w5xwgt]
tab MVPA3 bmic [aw=w5xwgt]
tab inactive2 weightdis5 
tab inactive3 weightdis5 
tab MVPA2 weightdis5  
tab MVPA3 weightdis5  
tab inactive2 weightdis5 [aw=w5xwgt]
tab inactive3 weightdis5 [aw=w5xwgt]
tab MVPA2 weightdis5 [aw=w5xwgt]
tab MVPA3 weightdis5 [aw=w5xwgt]
tab activity2 bmic 
tab activity3 bmic 
tab activity2 bmic [aw=w5xwgt]
tab activity3 bmic [aw=w5xwgt]
tab activity2 weightdis5 
tab activity3 weightdis5
tab activity2 weightdis5 [aw=w5xwgt]
tab activity3 weightdis5 [aw=w5xwgt]
clear 

log close