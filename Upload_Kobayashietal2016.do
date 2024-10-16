* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Banks, J., Batty, G. David, Breedvelt, J., Coughlin, K., Crawford, R., Marmot, M., Nazroo, J., Oldfield, Z., Steel, N., Steptoe, A., Wood, M., Zaninotto, P. (2021). English Longitudinal Study of Ageing: Waves 0-9, 1998-2019. [data collection]. 37th Edition. UK Data Service. SN: 5050, DOI: http://doi.org/10.5255/UKDA-SN-5050-24

* Project ID: 237630

cd ""

* Variables Wave 2
use idauniq sampsta finstat dhager diagr indager DhSex DiSex indsex CfLitSK cflitoc CfLitB CfLitC CfLitD CfLitE CfDatD CfDatM CfDatY CfDay CfDScr CfTest CfWrds CfLisEn CfLisD CfAni HeActa HeActb HeActc fqethnr wpdes wpdesc couple DiMar DhWork SPCar Hehelf headb01 headb02 headb03 headb04 headb05 headb06 headb07 headb08 headb09 headb10 headb11 headb12 headb13 Heill Helim PScedA PScedB PScedC PScedD PScedE PScedF PScedG PScedH w2wgt scw2wgt w2indout DhAnyPx DiPRe outscw2 askpx1 w1indout using wave_2_core_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant identifier (ID)
sort idauniq
rename sampsta sampstaw2
rename finstat finstatw2
rename HeActa heacta
rename HeActb heactb 
rename HeActc heactc
rename askpx1 askpx
* Generate a new variable called wave and assign the number 2 to each observation (to designate Wave 2)
gen wave = 2
* Save Wave 2 core dataset
save wave2K.dta

* Variables Wave 2 Financial 
use idauniq nettotw_bu_s nettotw_bu_f nettotw_bu_t totwq5_bu_s using wave_2_financial_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 2 to each observation (to designate Wave 2)
gen wave = 2
* Save Wave 2 financial dataset
save wave2financialK.dta

use idauniq w2edqual using wave_2_derived_variables.dta
describe 
sort idauniq 
gen wave = 2
save wave2derivedK.dta

use wave2K.dta
merge 1:1 idauniq using wave2financialK.dta, generate (merge_financial2)
save wave2K.dta, replace
merge 1:1 idauniq using wave2derivedK.dta, generate (merge_derived2)
save wave2K.dta, replace

* Variables Wave 3
use idauniq sampsta finstat heacta heactb heactc w3indout dipre outscw3 askpx using wave_3_elsa_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename sampsta sampstaw3
rename finstat finstatw3
* Generate a new variable called wave and assign the number 3 to each observation (to designate Wave 3)
gen wave = 3
* Save Wave 3 core dataset
save wave3K.dta

* Variables Wave 4
use idauniq samptyp finstat4 heacta heactb heactc outindw4 dipre outscw4 askpx using wave_4_elsa_data_v3.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename samptyp sampstaw4
rename finstat4 finstatw4
* Generate a new variable called wave and assign the number 4 to each observation (to designate Wave 4)
gen wave = 4
* Save Wave 4 core dataset
save wave4K.dta

* Variables Wave 5
use idauniq samptyp finstatw5 heacta heactb heactc w5indout dipre askpx using wave_5_elsa_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename samptyp sampstaw5
* Generate a new variable called wave and assign the number 5 to each observation (to designate Wave 5)
gen wave = 5
* Save Wave 5 core dataset
save wave5K.dta

* Variables Wave 6
use idauniq samptyp finstatw6 HeActa HeActb HeActc w6indout DiPRe askpx w6lwgt w6xwgt w6scwt using wave_6_elsa_data_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Rename variables to ensure consistency across waves
rename HeActa heacta
rename HeActb heactb
rename HeActc heactc
rename samptyp sampstaw6
* Generate a new variable called wave and assign the number 6 to each observation (to designate Wave 6)
gen wave = 6
* Save Wave 6 core dataset
save wave6K.dta

use wave2K.dta
append using wave3K.dta 
sort idauniq wave
append using wave4K.dta
sort idauniq wave
append using wave5K.dta
sort idauniq wave
append using wave6K.dta
sort idauniq wave
save dataKobayashi43953.dta

unique idauniq
* 17980, 53903
gen core = sampstaw2 if wave==2
tsset idauniq wave 
bysort idauniq: carryforward core, replace
keep if core==1
unique idauniq
* 8780, 33393
gen age_cons = indager if wave==2
tsset idauniq wave 
bysort idauniq: carryforward age_cons, replace
drop if age_cons>79
unique idauniq 
* 7659, 30147

* Assign a number in ascending order to each row of observations
gen ascnr = _n
* Generate a variable that assigns the observation number (i.e., 1 for first data collection timepoint, 2 for second data collection timepoint etc.) to each row by participant ID
bysort idauniq (wave): gen obsnr = _n
* Generate a variable that assigns the number of total observations to each row of data for a given participant
bysort idauniq: gen obscount = _N
* Check how many participants have data at 1 to 6 timepoints - the "if obsnr==1" statement is used to prevent participants with data at more than one timepoint from contributing to the counts more than once
tabulate obscount if obsnr==1
keep if obscount==5
unique idauniq 
* 4493, 22465
gen proxy2 = askpx if wave==2
tsset idauniq wave 
bysort idauniq: carryforward proxy2, replace
gen proxy3 = askpx if wave==3
tsset idauniq wave 
bysort idauniq: carryforward proxy3, replace
gen proxy4 = askpx if wave==4
tsset idauniq wave 
bysort idauniq: carryforward proxy4, replace
gen proxy5 = askpx if wave==5
tsset idauniq wave 
bysort idauniq: carryforward proxy5, replace
gen proxy6 = askpx if wave==6
drop if proxy2==1
drop if proxy3==1
drop if proxy4==1 
drop if proxy5==1
drop if proxy6==1
bysort idauniq: gen obscount2 = _N
tabulate obscount2 if obsnr==1
keep if obscount2==5
unique idauniq 
* 4357, 21785
save interim43953.dta

gen LITB = CfLitB if wave==2
tsset idauniq wave 
bysort idauniq: carryforward LITB, replace
gen LITC = CfLitC if wave==2
tsset idauniq wave 
bysort idauniq: carryforward LITC, replace
gen LITD = CfLitD if wave==2
tsset idauniq wave 
bysort idauniq: carryforward LITD, replace
gen LITE = CfLitE if wave==2
tsset idauniq wave 
bysort idauniq: carryforward LITE, replace
gen LIT = CfLitSK if wave==2
tsset idauniq wave 
bysort idauniq: carryforward LIT, replace

replace CfLitB = 0 if CfLitB==2
replace CfLitC = 0 if CfLitC==2
replace CfLitD = 0 if CfLitD==2
replace CfLitE = 0 if CfLitE==2

gen score = CfLitB + CfLitC + CfLitD + CfLitE if (CfLitB>=0 & CfLitC>=0 & CfLitD>=0 & CfLitE>=0)
gen literacy = 0 if CfLitB==-1
replace literacy = 0 if inlist(score,0,1,2)
replace literacy = 1 if score==3
replace literacy = 2 if score==4

drop if LIT<0
unique idauniq
* 4350, 21750
bysort idauniq: gen obscount3 = _N
tabulate obscount3 if obsnr==1
keep if obscount3==5
unique idauniq 

save interim43953.dta, replace

* Time orientation
replace CfDatD = . if CfDatD<0
replace CfDatM = . if CfDatM<0
replace CfDatY = . if CfDatY<0
replace CfDay = . if CfDay<0
replace CfDatD = 0 if CfDatD==2
replace CfDatM = 0 if CfDatM==2
replace CfDatY = 0 if CfDatY==2
replace CfDay = 0 if CfDay==2
gen orientation = CfDatD + CfDatM + CfDatY + CfDay 
tab CfDScr 

* Immediate recall
replace CfLisEn = . if CfLisEn<0

* Delayed recall
replace CfLisD = . if CfLisD<0

* Memory score 
gen memory = orientation + CfLisEn + CfLisD 

* Verbal fluency 
replace CfAni = . if CfAni<0
gen verbal = 0 if CfAni==0
replace verbal = 1 if inlist(CfAni,1,2,3,4,5,6,7)
replace verbal = 2 if inlist(CfAni,8,9,10,11,12)
replace verbal = 3 if inlist(CfAni,13,14,15)
replace verbal = 4 if inlist(CfAni,16,17)
replace verbal = 5 if inlist(CfAni,18,19)
replace verbal = 6 if inlist(CfAni,20,21)
replace verbal = 7 if inlist(CfAni,22,23,24)
replace verbal = 8 if inlist(CfAni,25,26,27,28,29)
replace verbal = 9 if CfAni>=30 & CfAni!=.

* Depressive symptoms
rename PScedA psceda 
rename PScedB pscedb 
rename PScedC pscedc 
rename PScedD pscedd 
rename PScedE pscede 
rename PScedF pscedf 
rename PScedG pscedg
rename PScedH pscedh
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

* Generate a new variable equal to the sum of depressive symptoms (eight items) to create a total depression score
gen depression = ceda + cedb + cedc + cedd + cede + cedf + cedg + cedh
gen depbi = 0 if inlist(depression,0,1,2,3,4)
replace depbi = 1 if inlist(depression,5,6,7,8)

* IADL limitations 
gen IADL = 0 if inlist(headb01,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb02,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb03,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb04,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb05,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb06,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb07,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb08,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb09,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb10,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb11,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb12,1,2,3,4,5,6,7,8,9,10,11,12,13) | inlist(headb13,1,2,3,4,5,6,7,8,9,10,11,12,13) 
replace IADL = 1 if headb01==96 & IADL!=0

* Limiting long-standing illness
gen limiting = 1 if Heill == 2 | Helim == 2
replace limiting = 0 if Helim == 1

* Self-rated health
replace Hehelf = . if Hehelf<0
gen health = 0 if inlist(Hehelf,4,5)
replace health = 1 if inlist(Hehelf,1,2,3)

* Access to a car when needed
replace SPCar = 0 if SPCar==2

* Marital status
gen marital = 0 if couple==3
replace marital = 1 if inlist(couple,1,2)

* Working status 
gen working = DhWork 
replace working = 0 if working==2

* Net non-pension wealth quintile
sum nettotw_bu_s 
tab totwq5_bu_s

* Educational attainment
gen education = 0 if w2edqual==7
replace education = 1 if inlist(w2edqual,3,4,5,6)
replace education = 2 if inlist(w2edqual,1,2)

* Ethnicity
replace fqethnr = . if fqethnr<0
replace fqethnr = 0 if fqethnr==2

* Sex 
tab DiSex

* Age 
tab indager 

* Physical activity
replace heacta = . if heacta<0 
replace heactb = . if heactb<0 
replace heactc = . if heactc<0

gen MVPA = 1 if inlist(heacta,1,2) | inlist(heactb,1,2)
replace MVPA = 0 if inlist(heacta,3,4) & inlist(heactb,3,4)

* Time-constant variables 
literacy memory verbal depbi IADL limiting health SPCar marital working nettotw_bu_s totwq5_bu_s education w2edqual fqethnr DiSex indager

gen literacy_cons = literacy if wave==2
tsset idauniq wave 
bysort idauniq: carryforward literacy_cons, replace
gen memory_cons = memory if wave==2
tsset idauniq wave 
bysort idauniq: carryforward memory_cons, replace
gen verbal_cons = verbal if wave==2
tsset idauniq wave 
bysort idauniq: carryforward verbal_cons, replace
gen depbi_cons = depbi if wave==2
tsset idauniq wave 
bysort idauniq: carryforward depbi_cons, replace
gen IADL_cons = IADL if wave==2
tsset idauniq wave 
bysort idauniq: carryforward IADL_cons, replace
gen limiting_cons = limiting if wave==2
tsset idauniq wave 
bysort idauniq: carryforward limiting_cons, replace
gen health_cons = limiting if wave==2
tsset idauniq wave 
bysort idauniq: carryforward health_cons, replace
gen SPCar_cons = SPCar if wave==2
tsset idauniq wave 
bysort idauniq: carryforward SPCar_cons, replace
gen marital_cons = marital if wave==2
tsset idauniq wave 
bysort idauniq: carryforward marital_cons, replace
gen working_cons = working if wave==2
tsset idauniq wave 
bysort idauniq: carryforward working_cons, replace
gen netto_cons = nettotw_bu_s if wave==2
tsset idauniq wave 
bysort idauniq: carryforward netto_cons, replace
gen wealth_cons = totwq5_bu_s if wave==2
tsset idauniq wave 
bysort idauniq: carryforward wealth_cons, replace
gen education_cons = education if wave==2
tsset idauniq wave 
bysort idauniq: carryforward education_cons, replace
gen w2edqual_cons = w2edqual if wave==2
tsset idauniq wave 
bysort idauniq: carryforward w2edqual_cons, replace
gen eth_cons = fqethnr if wave==2
tsset idauniq wave 
bysort idauniq: carryforward eth_cons, replace
gen sex_cons = DiSex if wave==2
tsset idauniq wave 
bysort idauniq: carryforward sex_cons, replace
gen w2wgt_cons = w2wgt if wave==2
tsset idauniq wave 
bysort idauniq: carryforward w2wgt_cons, replace
gen scw2wgt_cons = scw2wgt if wave==2
tsset idauniq wave 
bysort idauniq: carryforward scw2wgt_cons, replace
gen w6lwgt_cons = w6lwgt if wave==2
tsset idauniq wave 
bysort idauniq: carryforward w6lwgt_cons, replace

save Kobayashiprocessed.dta

keep idauniq wave w6lwgt w6xwgt w6scwt age_cons literacy_cons memory_cons verbal_cons depbi_cons IADL_cons limiting_cons health_cons SPCar_cons marital_cons working_cons netto_cons wealth_cons education_cons w2edqual_cons eth_cons sex_cons w2wgt_cons scw2wgt_cons MVPA
save longKob.dta
reshape wide MVPA w6lwgt w6xwgt w6scwt, i(idauniq) j(wave)
gen persistent = 1 if MVPA2==1 & MVPA3==1 & MVPA4==1 & MVPA5==1 & MVPA6==1
replace persistent = 0 if MVPA2==0 | MVPA3==0 | MVPA4==0 | MVPA5==0 | MVPA6==0
replace persistent = . if MVPA2==. | MVPA3==. | MVPA4==. | MVPA5==. | MVPA6==.
save wideKob.dta
xtile quintile = netto_cons if netto_cons!=. & age_cons<65, n(5)
xtile quintile2 = netto_cons if netto_cons!=. & age_cons>=65, n(5)
gen wealth = quintile
replace wealth = quintile2 if wealth==.
gen SES = 0 if inlist(wealth,1,2)
replace SES = 1 if inlist(wealth,3,4,5)
save wideKob.dta, replace
unique idauniq 
* 4350
keep if age_cons>=60
unique idauniq 
* 2697
save wideKobage60.dta
tab sex_cons 
* 1,168 male, 1,529 female

log using 20230522Kobayashi.log
keep if SES==0
unique idauniq 
* 1057

tab literacy_cons persistent 
tab memory_cons persistent 
tab verbal_cons persistent 
tab depbi_cons persistent 
tab IADL_cons persistent
tab health_cons persistent 
tab literacy_cons persistent [aw=w2wgt_cons]
tab memory_cons persistent [aw=w2wgt_cons]
tab verbal_cons persistent [aw=w2wgt_cons]
tab depbi_cons persistent [aw=w2wgt_cons]
tab IADL_cons persistent [aw=w2wgt_cons]
tab health_cons persistent [aw=w2wgt_cons]
tab literacy_cons persistent [aw=w6lwgt6]
tab memory_cons persistent [aw=w6lwgt6]
tab verbal_cons persistent [aw=w6lwgt6]
tab depbi_cons persistent [aw=w6lwgt6]
tab IADL_cons persistent [aw=w6lwgt6]
tab health_cons persistent [aw=w6lwgt6]
tab literacy_cons persistent [aw=w6xwgt6]
tab memory_cons persistent [aw=w6xwgt6]
tab verbal_cons persistent [aw=w6xwgt6]
tab depbi_cons persistent [aw=w6xwgt6]
tab IADL_cons persistent [aw=w6xwgt6]
tab health_cons persistent [aw=w6xwgt6]
clear

use wideKobage60.dta
keep if SES==1
unique idauniq 
* 1606

tab literacy_cons persistent 
tab memory_cons persistent 
tab verbal_cons persistent 
tab depbi_cons persistent 
tab IADL_cons persistent
tab health_cons persistent 
tab literacy_cons persistent [aw=w2wgt_cons]
tab memory_cons persistent [aw=w2wgt_cons]
tab verbal_cons persistent [aw=w2wgt_cons]
tab depbi_cons persistent [aw=w2wgt_cons]
tab IADL_cons persistent [aw=w2wgt_cons]
tab health_cons persistent [aw=w2wgt_cons]
tab literacy_cons persistent [aw=w6lwgt6]
tab memory_cons persistent [aw=w6lwgt6]
tab verbal_cons persistent [aw=w6lwgt6]
tab depbi_cons persistent [aw=w6lwgt6]
tab IADL_cons persistent [aw=w6lwgt6]
tab health_cons persistent [aw=w6lwgt6]
tab literacy_cons persistent [aw=w6xwgt6]
tab memory_cons persistent [aw=w6xwgt6]
tab verbal_cons persistent [aw=w6xwgt6]
tab depbi_cons persistent [aw=w6xwgt6]
tab IADL_cons persistent [aw=w6xwgt6]
tab health_cons persistent [aw=w6xwgt6]
clear

log close

log using 20230522Kobayashi.log, append
use wideKobage60.dta
keep if SES==0
unique idauniq 
* 1057
keep if w6xwgt6!=0
unique idauniq 
* 1056
tab sex_cons
* 405 male, 651 female
tab literacy_cons persistent [aw=w6xwgt6]
tab memory_cons persistent [aw=w6xwgt6]
tab verbal_cons persistent [aw=w6xwgt6]
tab depbi_cons persistent [aw=w6xwgt6]
tab IADL_cons persistent [aw=w6xwgt6]
tab health_cons persistent [aw=w6xwgt6]
clear 

use wideKobage60.dta
keep if SES==1
unique idauniq 
* 1606
keep if w6xwgt6!=0
unique idauniq 
* 1603 
tab sex_cons
* 746 male, 857 female
tab literacy_cons persistent [aw=w6xwgt6]
tab memory_cons persistent [aw=w6xwgt6]
tab verbal_cons persistent [aw=w6xwgt6]
tab depbi_cons persistent [aw=w6xwgt6]
tab IADL_cons persistent [aw=w6xwgt6]
tab health_cons persistent [aw=w6xwgt6]
clear 
log close

log using 20230522Kobayashi.log, append
use wideKobage60.dta
sum w6lwgt6 
sum w2wgt_cons
log close

use wideKobage60.dta
sum memory_cons, d
sum verbal_cons, d 
gen mem_bi = 0 if memory_cons <= 14
replace mem_bi = 1 if memory_cons > 14 & memory_cons!=.
gen ver_bi = 0 if verbal_cons <= 6
replace ver_bi = 1 if verbal_cons > 6 & verbal_cons!=.
save wideKobage60b.dta

log using 20231215Kobayashi.log
keep if SES==0
unique idauniq 
* 1057
tab sex_cons
* 406 male, 651 female
tab mem_bi persistent [aw=w6lwgt6]
tab ver_bi persistent [aw=w6lwgt6]
clear 

use wideKobage60b.dta
keep if SES==1
unique idauniq 
* 1606
tab sex_cons
* 746 male, 860 female
tab mem_bi persistent [aw=w6lwgt6]
tab ver_bi persistent [aw=w6lwgt6]
clear 

log close