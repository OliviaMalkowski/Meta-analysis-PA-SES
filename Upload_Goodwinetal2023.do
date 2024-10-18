* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Banks, J., Batty, G. David, Breedvelt, J., Coughlin, K., Crawford, R., Marmot, M., Nazroo, J., Oldfield, Z., Steel, N., Steptoe, A., Wood, M., Zaninotto, P. (2021). English Longitudinal Study of Ageing: Waves 0-9, 1998-2019. [data collection]. 37th Edition. UK Data Service. SN: 5050, DOI: http://doi.org/10.5255/UKDA-SN-5050-24

* Project ID: 237630

cd ""

* Variables Wave 1
use idauniq finstat w1wgt psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh hehear heacta heactb heactc dhager fqethnr indager dhsex disex indsex edqual hedia01 hedia02 hedia03 hedia04 hedia05 hedia06 hedia07 hedia08 hedia09 hedia10 hesmk heska hecig heskb heskc hedib01 hedib02 hedib03 hedib04 hedib05 hedib06 hedib07 hedib08 hedib09 hedib10 hepsy1 hepsy2 hepsy3 hepsy4 hepsy5 hepsy6 hepsy7 hepsy8 hepsy9 using wave_1_core_data_v3.dta
* Describe dataset
describe
* Sort from lowest to highest participant identifier (ID)
sort idauniq
* Generate a new variable called wave and assign the number 1 to each observation (to designate Wave 1)
gen wave = 1
* Save Wave 1 core dataset
save wave1Goodwin.dta

* Variables Wave 1 Financial Derived
use idauniq tnhwq5_bu_s nfwq5_bu_s totwq5_bu_s using wave_1_financial_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Save Wave 1 financial derived dataset 
save wave1financialGoodwin.dta

* Wave 1 complete data
* Use Wave 1 core dataset
use wave1Goodwin.dta
* One-to-one merge of data in memory with wave1financialGoodwin.dta on participant ID
merge 1:1 idauniq using wave1financialGoodwin.dta, generate (merge_financial1)
* Overwrite Wave 1 dataset, by replacing the previously saved file
save wave1Goodwin.dta, replace

* Variables Wave 2
use idauniq sampsta finstat HeActa HeActb HeActc scfeela scfeelb scfeelc scfeeld Hehear w2wgt scw2wgt using wave_2_core_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant identifier (ID)
sort idauniq
rename HeActa heacta
rename HeActb heactb 
rename HeActc heactc
rename Hehear hehear
* Generate a new variable called wave and assign the number 2 to each observation (to designate Wave 2)
gen wave = 2
* Save Wave 2 core dataset
save wave2Goodwin.dta

* Variables Wave 2 Nurse
use idauniq height ehtm estht htval htok relhite hinrel weight ewtkg estwt wtval wtok relwait bmi bmival bmiok bmiobe using wave_2_nurse_data_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Save Wave 2 nurse dataset
save wave2nurseGoodwin.dta

* Wave 2 complete data
* Use Wave 2 core dataset
use wave2Goodwin.dta
* One-to-one merge of data in memory with wave2nurseGoodwin.dta on participant ID
merge 1:1 idauniq using wave2nurseGoodwin.dta, generate (merge_nurse2)
* Sort from lowest to highest participant ID
sort idauniq
* Overwrite Wave 2 dataset, by replacing the previously saved file
save wave2Goodwin.dta, replace

* Variables Wave 3
use idauniq sampsta finstat heacta heactb heactc hehear w3lwgt w3xwgt using wave_3_elsa_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 3 to each observation (to designate Wave 3)
gen wave = 3
* Save Wave 3 core dataset
save wave3Goodwin.dta

* Variables Wave 4
use idauniq samptyp finstat4 hehear heacta heactb heactc w4xwgt w4lwgt w4scwt using wave_4_elsa_data_v3.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 4 to each observation (to designate Wave 4)
gen wave = 4
* Save Wave 4 core dataset
save wave4Goodwin.dta

* Variables Wave 5
use idauniq samptyp finstatw5 hehear heacta heactb heactc w5lwgt w5xwgt w5scwt using wave_5_elsa_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 5 to each observation (to designate Wave 5)
gen wave = 5
* Save Wave 5 core dataset
save wave5Goodwin.dta

* Variables Wave 6
use idauniq samptyp finstatw6 HeHear HeActa HeActb HeActc w6lwgt w6xwgt w6scwt w6sscwt using wave_6_elsa_data_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename samptyp samptyp6
rename HeActa heacta 
rename HeActb heactb 
rename HeActc heactc
rename HeHear hehear
* Generate a new variable called wave and assign the number 6 to each observation (to designate Wave 6)
gen wave = 6
* Save Wave 6 core dataset
save wave6Goodwin.dta

* Variables Wave 7
use idauniq samptyp finstatw7 HeHear HeActa HeActb HeActc w7lwgt w7xwgt w7scwt using wave_7_elsa_data.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename samptyp samptyp7
rename HeActa heacta 
rename HeActb heactb 
rename HeActc heactc
rename HeHear hehear
* Generate a new variable called wave and assign the number 7 to each observation (to designate Wave 7)
gen wave = 7
* Save Wave 7 core dataset
save wave7Goodwin.dta

* Variables Wave 8
use idauniq samptyp finstat hehear heacta heactb heactc w8w1lwgt w8w4lwgt w8xwgt w8scwt w8sscwt using wave_8_elsa_data_eul_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename samptyp samptyp8
rename finstat finstat9
* Generate a new variable called wave and assign the number 8 to each observation (to designate Wave 8)
gen wave = 8
* Save Wave 8 core dataset
save wave8Goodwin.dta

* Variables Wave 9
use idauniq samptyp finstat hehear heacta heactb heactc W9W1LWGT W9W4LWGT w9xwgt w9scwt using wave_9_elsa_data_eul_v1.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename samptyp samptyp9
rename finstat finstat9
* Generate a new variable called wave and assign the number 9 to each observation (to designate Wave 9)
gen wave = 9
* Save Wave 9 core dataset
save wave9Goodwin.dta

* Append Wave 2 dataset to Wave 1 dataset
use wave1Goodwin.dta
append using wave2Goodwin.dta 
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
* Append Wave 3 dataset
append using wave3Goodwin.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
* Append Wave 4 dataset
append using wave4Goodwin.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
* Append Wave 5 dataset
append using wave5Goodwin.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
* Append Wave 6 dataset
append using wave6Goodwin.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
* Append Wave 7 dataset
append using wave7Goodwin.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
* Append Wave 8 dataset
append using wave8Goodwin.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
* Append Wave 9 dataset
append using wave9Goodwin.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
* Assign a number in ascending order to each row of observations
gen ascnr = _n
save rawGoodwin.dta

* Organising dataset
* Generate a variable that assigns the observation number (i.e., 1 for first data collection timepoint, 2 for second data collection timepoint etc.) to each row by participant ID
bysort idauniq (wave): gen obsnr = _n
* Generate a variable that assigns the number of total observations to each row of data for a given participant
bysort idauniq: gen obscount = _N
* Check how many participants have data at 1 to 8 timepoints - the "if obsnr==1" statement is used to prevent participants with data at more than one timepoint from contributing to the counts more than once
tabulate obscount if obsnr==1
* Generate a variable that assigns the number 1 to the row representing participants' first observation
bysort idauniq (wave): gen first = 1 if _n==1
* Generate a variable that assigns the number 1 to the row representing participants' last observation
bysort idauniq (wave): gen last = 1 if _n==_N
* Generate a variable that assigns the number 1 to the row representing participants' first observation if this corresponds to Wave 1 (baseline)
bysort idauniq (wave): gen firstwave = 1 if obsnr==1 & wave==1
* Carry the value of this last variable forwards to the remainder of a participant's observations 
bysort idauniq: gen firstwave_cons = firstwave[1]
* Install unique command
ssc install unique
* Count total number of participants and observations
unique idauniq
* 19807 individuals, 90074 observations 
save rawGoodwin.dta, replace

bysort idauniq: gen finstat_cons = finstat[1]
keep if finstat_cons=="C1CM"
unique idauniq 
* 11391 individuals, 59003 observations
bysort idauniq: gen hedib01_cons = hedib01[1]
bysort idauniq: gen hedib02_cons = hedib02[1]
bysort idauniq: gen hedib03_cons = hedib03[1]
bysort idauniq: gen hedib04_cons = hedib04[1]
bysort idauniq: gen hedib05_cons = hedib05[1]
bysort idauniq: gen hedib06_cons = hedib06[1]
bysort idauniq: gen hedib07_cons = hedib07[1]
bysort idauniq: gen hedib08_cons = hedib08[1]
bysort idauniq: gen hedib09_cons = hedib09[1]
bysort idauniq: gen hedib10_cons = hedib10[1]
bysort idauniq: gen hepsy1_cons = hepsy1[1]
bysort idauniq: gen hepsy2_cons = hepsy2[1]
bysort idauniq: gen hepsy3_cons = hepsy3[1]
bysort idauniq: gen hepsy4_cons = hepsy4[1]
bysort idauniq: gen hepsy5_cons = hepsy5[1]
bysort idauniq: gen hepsy6_cons = hepsy6[1]
bysort idauniq: gen hepsy7_cons = hepsy7[1]
bysort idauniq: gen hepsy8_cons = hepsy8[1]
bysort idauniq: gen hepsy9_cons = hepsy9[1]
drop if hedib01_cons==6 | hedib02_cons==6 | hedib03_cons==6 | hedib04_cons==6 | hedib05_cons==6 | hedib06_cons==6 | hedib07_cons==7 | hedib08_cons==8 | hedib09_cons==6 | hedib10_cons==6
drop if inlist(hepsy1_cons,1,5,6) | inlist(hepsy2_cons,1,5,6) | inlist(hepsy3_cons,1,5,6) | inlist(hepsy4_cons,1,5,6) | inlist(hepsy5_cons,1,5,6) | inlist(hepsy6_cons,1,5,6) | inlist(hepsy7_cons,1,5,6) | inlist(hepsy8_cons,1,5,6) | inlist(hepsy9_cons,1,5,6)
unique idauniq
* 11298 individuals, 58622 observations
save interimGoodwin.dta
keep hehear idauniq wave
reshape wide hehear, i(idauniq) j(wave)
gen hearing = 0 if ! inlist(hehear1,4,5) & ! inlist(hehear2,4,5) & ! inlist(hehear3,4,5) & ! inlist(hehear4,4,5) & ! inlist(hehear5,4,5) & ! inlist(hehear6,4,5) & ! inlist(hehear7,4,5) & ! inlist(hehear8,4,5) & ! inlist(hehear9,4,5)
replace hearing = 1 if inlist(hehear1,4,5) | inlist(hehear2,4,5) | inlist(hehear3,4,5) | inlist(hehear4,4,5) | inlist(hehear5,4,5) | inlist(hehear6,4,5) | inlist(hehear7,4,5) | inlist(hehear8,4,5) | inlist(hehear9,4,5)
reshape long
drop hehear
save longinterimGoodwin.dta

use interimGoodwin.dta
merge 1:1 idauniq wave using longinterimGoodwin.dta, generate (merge_long)
keep if merge_long==3
save interimGoodwin.dta, replace

* Wealth
tab totwq5_bu_s
gen wealth = 0 if inlist(totwq5_bu_s,1,2,3)
replace wealth = 1 if inlist(totwq5_bu_s,4,5)

* Loneliness (reversed)
* Replace variables as missing for any missing cases (coded as negative numbers in the ELSA dataset)
* How often respondent feels they lack companionship
replace scfeela = . if scfeela<0
* How often respondent feels left out
replace scfeelb = . if scfeelb<0
* How often respondent feels isolated from others 
replace scfeelc = . if scfeelc<0
* How often respondent feels in tune with the people around them
replace scfeeld = . if scfeeld<0
revrs scfeeld 

gen loneliness = scfeela+scfeelb+scfeelc+revscfeeld

* Physical activity
* Generate a new variable
gen activity2 = .
replace activity2 = 1 if heacta==1
replace activity2 = 0 if inlist(heacta,2,3,4)
replace activity2 = 1 if heactb==1
replace activity2 = 0 if inlist(heactb,2,3,4) & activity2!=1
replace activity2 = 0 if inlist(heactc,1,2,3,4) & activity2!=1
replace activity2 = . if inlist(heacta,.) & inlist(heactb,.) & inlist(heactc,.)

* Smoking
gen smoking = 2 if hesmk==2
replace smoking = 1 if heska==2 & hesmk==1
replace smoking = 0 if heska==1

* Depression
* Recode to the number 0 if participant answered "No" (items psceda-pscedc are reverse-coded)
replace psceda = 0 if psceda==2
replace pscedb = 0 if pscedb==2
replace pscedc = 0 if pscedc==2

* Recode to the number 0 if participant answered "Yes"
replace pscedd = 0 if pscedd==1
* Recode to the number 1 if participant answered "No"
replace pscedd = 1 if pscedd==2

* Recode to the number 0 if participant answered "No" (item pscede is reverse-coded)
replace pscede = 0 if pscede==2

* Recode to the number 0 if participant answered "Yes"
replace pscedf = 0 if pscedf==1
* Recode to the number 1 if participant answered "No"
replace pscedf = 1 if pscedf==2

* Recode to the number 0 if participant answered "No" (items pscedg-pscedh are reverse-coded)
replace pscedg = 0 if pscedg==2
replace pscedh = 0 if pscedh==2

* Generate new variables duplicating psceda-pscedh, but excluding missing cases (coded as negative numbers in the ELSA dataset)
gen ceda = psceda if psceda>=0
gen cedb = pscedb if pscedb>=0
gen cedc = pscedc if pscedc>=0
gen cedd = pscedd if pscedd>=0
gen cede = pscede if pscede>=0
gen cedf = pscedf if pscedf>=0
gen cedg = pscedg if pscedg>=0
gen cedh = pscedh if pscedh>=0

* Generate a new variable equal to the sum of depressive symptoms (eight items) to create a total depression score (range 0-8)
gen depression = ceda + cedb + cedc + cedd + cede + cedf + cedg + cedh

* BMI
 height ehtm estht htval htok relhite hinrel weight ewtkg estwt wtval wtok relwait bmi bmival bmiok bmiobe
gen bmic = bmival if bmival>=0 & bmival!=.
gen bmicdi = 0 if bmic<25
replace bmicdi = 1 if bmic>=25 & bmic!=.
save int2Goodwin.dta

bysort idauniq: gen age_cons = indager[1]
keep if age_cons>=60
unique idauniq 
* 7167, 33816
save Goodwin60.dta
sum w1wgt
tab dhsex 
tab disex
tab indsex 
* 3,241 male, 3,926 female

keep loneliness depression bmicdi smoking activity2 wealth idauniq wave
rename activity2 activity 
reshape wide loneliness depression bmicdi smoking activity wealth, i(idauniq) j(wave)
save wideGoodwin60.dta 

log using 20231229Goodwin.log
keep if wealth1==0
unique idauniq 
* 4370
tab loneliness2 activity1
tab depression1 activity1
tab bmicdi2 activity1
tab smoking1 activity1
tab loneliness2 activity2
tab depression1 activity2
tab bmicdi2 activity2
tab smoking1 activity2
tab loneliness2 activity3
tab depression1 activity3
tab bmicdi2 activity3
tab smoking1 activity3
clear 

use wideGoodwin60.dta
keep if wealth1==1
unique idauniq 
* 2699
tab loneliness2 activity1
tab depression1 activity1
tab bmicdi2 activity1
tab smoking1 activity1
tab loneliness2 activity2
tab depression1 activity2
tab bmicdi2 activity2
tab smoking1 activity2
tab loneliness2 activity3
tab depression1 activity3
tab bmicdi2 activity3
tab smoking1 activity3
clear 

use Goodwin60.dta
tab dhsex 
tab disex
tab indsex 
tab wealth dhsex 
tab wealth disex
tab wealth indsex

* Low SES: 1899 male, 2471 female
* High SES: 1298 male, 1400 (disex)/1401 (dhsex/indsex) female

clear
log close

log using 20231229Goodwin.log, append
use Goodwin60.dta
sum loneliness,d
sum depression,d
log close 