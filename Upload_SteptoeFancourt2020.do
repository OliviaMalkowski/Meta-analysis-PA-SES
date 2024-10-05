* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Banks, J., Batty, G. David, Breedvelt, J., Coughlin, K., Crawford, R., Marmot, M., Nazroo, J., Oldfield, Z., Steel, N., Steptoe, A., Wood, M., Zaninotto, P. (2021). English Longitudinal Study of Ageing: Waves 0-9, 1998-2019. [data collection]. 37th Edition. UK Data Service. SN: 5050, DOI: http://doi.org/10.5255/UKDA-SN-5050-24

* Project ID: 237630

cd ""

* Variables Wave 6
use idauniq w6nssec8 NSSEC w6nssec5 w6nssec3 w6nssec13 samptyp indager DhSex DiSex indsex HeActa HeActb HeActc scovwo finstatw6 w6lwgt w6xwgt w6scwt w6sscwt using wave_6_elsa_data_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Rename variables to ensure consistency across waves
rename w6nssec8 nssec8
rename w6nssec5 nssec5
rename w6nssec3 nssec3
rename w6nssec13 nssec13
rename DhSex dhsex
rename DiSex disex
rename HeActa heacta
rename HeActb heactb
rename HeActc heactc
rename samptyp samptyp6
* Generate a new variable called wave and assign the number 6 to each observation (to designate Wave 6)
gen wave = 6
* Save Wave 6 core dataset
save wave6.dta

* Variables Wave 7
use idauniq NSSEC samptyp indager DhSex DiSex indsex HeActa HeActb HeActc scovwo finstatw7 w7lwgt w7xwgt w7scwt using wave_7_elsa_data.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Rename variables to ensure consistency across waves
rename DhSex dhsex
rename DiSex disex
rename HeActa heacta
rename HeActb heactb
rename HeActc heactc
rename samptyp samptyp7
* Generate a new variable called wave and assign the number 7 to each observation (to designate Wave 7)
gen wave = 7
* Save Wave 7 core dataset
save wave7.dta

* Variables Wave 8
use idauniq w8nssec8 w8nssec5 w8nssec3 samptyp indager indsex heacta heactb heactc finstat w8w1lwgt w8w4lwgt w8xwgt w8scwt w8sscwt using wave_8_elsa_data_eul_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Rename variables to ensure consistency across waves
rename w8nssec8 nssec8
rename w8nssec5 nssec5
rename w8nssec3 nssec3
rename samptyp samptyp8
rename finstat finstatw8
* Generate a new variable called wave and assign the number 8 to each observation (to designate Wave 8)
gen wave = 8
* Save Wave 8 core dataset
save wave8.dta

* Variables Wave 6 Derived
use idauniq edqual using wave_6_ifs_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Save Wave 6 derived dataset
save wave6derived.dta

* Variables Wave 7 Derived
use idauniq edqual using wave_7_ifs_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Save Wave 7 derived dataset
save wave7derived.dta

* Variables Wave 8 Derived
use idauniq edqual using wave_8_elsa_ifs_dvs_eul_v1.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Save Wave 8 derived dataset
save wave8derived.dta

* Wave 6 complete data
* Merge core and derived datasets for Wave 6 using the participant ID
* Use Wave 6 core dataset
use wave6.dta
* One-to-one merge of data in memory with wave6derived.dta on participant ID
merge 1:1 idauniq using wave6derived.dta, generate (merge_derived6)
* Sort from lowest to highest participant ID
sort idauniq
* Overwrite Wave 6 dataset, by replacing the previously saved file
save wave6.dta, replace

* Wave 7 complete data
* Merge core and derived datasets for Wave 7 using the participant ID
* Use Wave 7 core dataset
use wave7.dta
* One-to-one merge of data in memory with wave7derived.dta on participant ID
merge 1:1 idauniq using wave7derived.dta, generate (merge_derived7)
* Sort from lowest to highest participant ID
sort idauniq
* Overwrite Wave 7 dataset, by replacing the previously saved file
save wave7.dta, replace

* Wave 8 complete data
* Merge core and derived datasets for Wave 8 using the participant ID
* Use Wave 8 core dataset
use wave8.dta
* One-to-one merge of data in memory with wave8derived.dta on participant ID
merge 1:1 idauniq using wave8derived.dta, generate (merge_derived8)
* Sort from lowest to highest participant ID
sort idauniq
* Overwrite Wave 8 dataset, by replacing the previously saved file
save wave8.dta, replace

use wave6.dta
* Append Wave 7 dataset
append using wave7.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
* Append Wave 8 dataset
append using wave8.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave

* Assign a number in ascending order to each row of observations
gen ascnr = _n

* Organising dataset
* Generate a variable that assigns the observation number (i.e., 1 for first data collection timepoint, 2 for second data collection timepoint etc.) to each row by participant ID
bysort idauniq (wave): gen obsnr = _n
* Generate a variable that assigns the number of total observations to each row of data for a given participant
bysort idauniq: gen obscount = _N
* Check how many participants have data at 1 to 3 timepoints - the "if obsnr==1" statement is used to prevent participants with data at more than one timepoint from contributing to the counts more than once
tabulate obscount if obsnr==1
* Generate a variable that assigns the number 1 to the row representing participants' first observation
bysort idauniq (wave): gen first = 1 if _n==1
* Generate a variable that assigns the number 1 to the row representing participants' last observation
bysort idauniq (wave): gen last = 1 if _n==_N
* Generate a variable that assigns the number 1 to the row representing participants' first observation if this corresponds to Wave 6 (baseline)
bysort idauniq (wave): gen firstwave = 1 if obsnr==1 & wave==6
* Carry the value of this last variable forwards to the remainder of a participant's observations
bysort idauniq: gen firstwave_cons = firstwave[1]
* Install unique command
ssc install unique
* Count total number of participants and observations
unique idauniq
* 11,468 individuals, 28,712 observations
* Save dataset with a new name
save raw34161.dta

* Worthwhile ratings 
replace scovwo =. if scovwo<0
replace scovwo =. if scovwo==11
bysort idauniq: gen scovwo_cons = scovwo[1]
bysort idauniq: gen samptyp6_cons = samptyp6[1]
keep if scovwo_cons!=. & samptyp6_cons==1
unique idauniq 
* 7427, 19747
tsset idauniq wave 
tsfill, full 
unique idauniq 
* 7427, 22281
mi set mlong
mi reshape wide samptyp6 dhsex disex heacta heactb heactc NSSEC scovwo indsex indager w6lwgt w6xwgt w6scwt w6sscwt nssec8 nssec5 nssec3 nssec13 finstatw6 edqual merge_derived6 samptyp7 finstatw7 w7lwgt w7xwgt w7scwt merge_derived7 samptyp8 finstatw8 w8w1lwgt w8w4lwgt w8xwgt w8scwt w8sscwt merge_derived8 ascnr obsnr obscount first last firstwave firstwave_cons scovwo_cons samptyp6_cons, i(idauniq) j(wave)
keep if scovwo7!=.
unique idauniq
* 5773
mi reshape long samptyp6 dhsex disex heacta heactb heactc NSSEC scovwo indsex indager w6lwgt w6xwgt w6scwt w6sscwt nssec8 nssec5 nssec3 nssec13 finstatw6 edqual merge_derived6 samptyp7 finstatw7 w7lwgt w7xwgt w7scwt merge_derived7 samptyp8 finstatw8 w8w1lwgt w8w4lwgt w8xwgt w8scwt w8sscwt merge_derived8 ascnr obsnr obscount first last firstwave firstwave_cons scovwo_cons samptyp6_cons, i(idauniq) j(wave)
unique idauniq 
* 5773, 17319

* Age
replace indager = 99 if indager==-7

* Education 
replace edqual = . if edqual<0
* Time-constant education - Wave 6
* Generate a new variable duplicating the education variable at Wave 6
gen education_cons = edqual if wave==6
* Declare a panel dataset with participant ID "idauniq" and time variable "wave" 
mi tsset idauniq wave
* Carryforward observations with respect to the time variable "wave" by participant ID
bysort idauniq: carryforward education_cons, replace

* Sex 
replace disex = 0 if disex==1
replace disex = 1 if disex==2

* Social class 
replace nssec3 = . if nssec3==99
replace nssec3 = . if nssec3<0
* Time-constant occupational class - Wave 6
* Generate a new variable duplicating the occupational class variable at Wave 6
gen mynssec3_cons = nssec3 if wave==6
* Declare a panel dataset with participant ID "idauniq" and time variable "wave" 
mi tsset idauniq wave
* Carryforward observations with respect to the time variable "wave" by participant ID
bysort idauniq: carryforward mynssec3_cons, replace

keep if education_cons!=. & mynssec3_cons!=.
unique idauniq 
* 5694, 17082

gen mynssec3 = 0 if nssec3==3
replace mynssec3 = 1 if nssec3==2
replace mynssec3 = 2 if nssec3==1

sum scovwo if wave==6 
sum scovwo if wave==7

gen education = 2 if inlist(edqual,1,2)
replace education = 1 if inlist(edqual,3,4)
replace education = 0 if inlist(edqual,5,6,7)

* Physical activity
gen MVPA = 1 if heacta==1 | heactb==1
replace MVPA = 0 if heacta!=1 & heactb!=1 & heacta!=. & heactb!=.
replace MVPA = . if MVPA==0 & heactb<0 & wave==6
replace MVPA = . if MVPA==0 & heacta<0
replace MVPA = . if MVPA==0 & heactb<0

gen change = scovwo - scovwo_cons if wave==7
gen change_cons = change if wave==7
mi tsset idauniq wave 
bysort idauniq: carryforward change_cons, replace
save full34161.dta

mi tsset, clear
mi set, clear
gen age_cons = indager if wave==6
tsset idauniq wave
bysort idauniq: carryforward age_cons, replace

gen ed_cons = education if wave==6
tsset idauniq wave 
bysort idauniq: carryforward ed_cons, replace

gen occ_cons = mynssec3 if wave==6
tsset idauniq wave 
bysort idauniq: carryforward occ_cons, replace

gen sex_cons = disex if wave==6
tsset idauniq wave 
bysort idauniq: carryforward sex_cons, replace

gen MVPA_cons = MVPA if wave==6
tsset idauniq wave 
bysort idauniq: carryforward MVPA_cons, replace

gen worthwhile = scovwo if wave==6
tsset idauniq wave 
bysort idauniq: carryforward worthwhile, replace

gen worthwhile7 = scovwo if wave==7
tsset idauniq wave 
bysort idauniq: carryforward worthwhile7, replace

save full34161.dta, replace 

keep if wave==8
gen worthchange = worthwhile7-worthwhile
save full34161w8.dta
log using 34161SteptoeFancourt20230510.log
logit MVPA worthchange worthwhile i.MVPA_cons age_cons i.ed_cons i.occ_cons i.sex_cons [pw=w8xwgt], or
keep if age_cons>=60
unique idauniq 
* 4409
gen SES = 0 if inlist(ed_cons,0,1)
replace SES = 1 if ed_cons==2
save full34161w8age60.dta
keep if SES==0
unique idauniq 
* 2937
logit MVPA worthchange worthwhile i.MVPA_cons age_cons i.occ_cons i.sex_cons [pw=w8xwgt], or
logit MVPA worthchange worthwhile i.MVPA_cons [pw=w8xwgt], or
logit MVPA worthchange [pw=w8xwgt], or
logit MVPA worthwhile [pw=w8xwgt], or
tab worthchange MVPA [aw=w8xwgt]
tab worthwhile MVPA [aw=w8xwgt]
clear 

use full34161w8age60.dta
keep if SES==1
unique idauniq 
* 1472
logit MVPA worthchange worthwhile i.MVPA_cons age_cons i.occ_cons i.sex_cons [pw=w8xwgt], or
logit MVPA worthchange worthwhile i.MVPA_cons [pw=w8xwgt], or
logit MVPA worthchange [pw=w8xwgt], or
logit MVPA worthwhile [pw=w8xwgt], or
tab worthchange MVPA [aw=w8xwgt]
tab worthwhile MVPA [aw=w8xwgt]
clear 
log close

log using 34161SteptoeFancourt20230510.log, append 
use full34161w8age60.dta
keep if SES==0
unique idauniq
* 2937
tab sex_cons 
* 1144 male, 1793 female
keep if w8xwgt!=0
unique idauniq 
* 2915
tab sex_cons 
* 1136 male, 1779 female
logit MVPA worthchange [pw=w8xwgt], or
logit MVPA worthwhile [pw=w8xwgt], or
tab worthchange MVPA [aw=w8xwgt]
tab worthwhile MVPA [aw=w8xwgt]
clear 

use full34161w8age60.dta
keep if SES==1
unique idauniq
* 1472
tab sex_cons 
* 841 male, 631 female
keep if w8xwgt!=0
unique idauniq 
* 1460
tab sex_cons 
* 836 male, 624 female
logit MVPA worthchange [pw=w8xwgt], or
logit MVPA worthwhile [pw=w8xwgt], or
tab worthchange MVPA [aw=w8xwgt]
tab worthwhile MVPA [aw=w8xwgt]
clear 
log close

use full34161w8age60.dta
keep if w8xwgt!=0
unique idauniq 
* 4375
tab sex_cons
* 1972 male, 2403 female