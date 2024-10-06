* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Banks, J., Batty, G. David, Breedvelt, J., Coughlin, K., Crawford, R., Marmot, M., Nazroo, J., Oldfield, Z., Steel, N., Steptoe, A., Wood, M., Zaninotto, P. (2021). English Longitudinal Study of Ageing: Waves 0-9, 1998-2019. [data collection]. 37th Edition. UK Data Service. SN: 5050, DOI: http://doi.org/10.5255/UKDA-SN-5050-24

* Project ID: 237630

cd ""

* Variables Wave 6
bus pass holder, age, how often used public transport, how often used bus pass, PA, gait speed, BMI, waist circumference, nonpension household wealth, labor market status, ADL, mobility, car access, gender
use idauniq samptyp indager DhSex DiSex indsex HeActa HeActb HeActc SpBsPs SpBsTm SpTraA SPCar MmSchs MmAlone MmHSS MmWill MmSaf MmAvsp MmWala MmTrya MMWlkA MmWalb MmTryb MMWlkB MmPain MmRecR MmAid WpDes hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi hemob96 headldr headlwa headlba headlea headlbe headlwc finstatw6 w6lwgt w6xwgt w6scwt w6sscwt using wave_6_elsa_data_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 6 to each observation (to designate Wave 6)
gen wave = 6
* Save Wave 6 core dataset
save wave6Webb.dta

* Variables Wave 6 Financial Derived
use idauniq nettotw_bu_s nettotw_bu_f nettotw_bu_t totwq5_bu_s using wave_6_financial_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Save Wave 6 financial derived dataset
save wave6financial.dta

* Variables Wave 6 Nurse
use idauniq resphts height resnhi ehtch ehtm ehtft ehtin estht relhite hinrel respwts weight ewtch ewtkg ewtst ewtl estwt relwait whwill waist1 waist2 waist3 DoneWst respwh wjrel probwj HTOK HTVAL WTOK WTVAL BMI BMIOK BMIVAL BMIOBE WSTOKB WSTVAL w6nurwt using wave_6_elsa_nurse_data_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Save Wave 6 nurse dataset
save wave6nurse.dta

use wave6Webb.dta 
* One-to-one merge of data in memory with wave6financial.dta on participant ID
merge 1:1 idauniq using wave6financial.dta, generate (merge_financial6)
* One-to-one merge of data in memory with wave6nurse.dta on participant ID
merge 1:1 idauniq using wave6nurse.dta, generate (merge_nurse6)
save wave6Webb.dta, replace

unique idauniq 
* 10601
replace indager = 99 if indager==-7
keep if indager>=62
unique idauniq 
* 6870
drop if BMIVAL<0
drop if WSTVAL<0
drop if MMWlkA<0
unique idauniq
* 5535

* Sex 
gen Sex = 0 if DiSex==1
replace Sex = 1 if DiSex==2

* Bus pass holder 
replace SpBsPs = . if SpBsPs<0
replace SpBsPs = 0 if SpBsPs==2

* Frequency of bus pass use
replace SpBsTm = . if SpBsTm<0
replace SpBsTm = 2 if inlist(SpBsTm,3,4)

* Frequency of public transport use
replace SpTraA = 0 if SpTraA == 6
replace SpTraA = 2 if SpTraA == 1
replace SpTraA = 1 if inlist(SpTraA,3,4,5)

* Car access
replace SPCar = 0 if SPCar==1
replace SPCar = 1 if SPCar==2

* Labor market status 
gen labor = 0 if inlist(WpDes,2,3,96)
replace labor = 1 if WpDes==1
replace labor = 2 if inlist(WpDes,4,5,6)

* Age 
gen age = 0 if indager>=62 & indager <70
replace age = 1 if indager>=70 & indager <80 
replace age = 2 if indager>=80 & indager != .

* Physical activity
gen activity = 1 if inlist(HeActa,1,2,3)
replace activity = 1 if inlist(HeActb,1,2)
replace activity = 0 if HeActa==4 & inlist(HeActb,3,4)

* Mobility 
gen mobility = hemobwa + hemobsi + hemobch + hemobcs + hemobcl + hemobst + hemobre + hemobpu + hemobli + hemobpi
gen mobcat = 0 if inlist(mobility,4,5,6,7,8,9,10)
replace mobcat = 1 if inlist(mobility,1,2,3)
replace mobcat = 2 if mobility==0
tab hemob96 

* ADL 
gen ADL = headldr + headlwa + headlba + headlea + headlbe + headlwc
gen ADLcat = 0 if inlist(ADL,1,2,3,4,5,6)
replace ADLcat = 1 if ADL==0

* Wealth
* nettotw_bu_s nettotw_bu_f nettotw_bu_t totwq5_bu_s
save fullWebbage62.dta

drop if BMIVAL==.
drop if WSTVAL==.
unique idauniq 
* 4801
drop if activity==.
keep if totwq5_bu_s!=.
unique idauniq 
* 4650
save finalsampleWebb.dta
xtile quintile = nettotw_bu_s if nettotw_bu_s!=., n(5)
replace labor = 2 if WpDes==85
save finalsampleWebb.dta, replace

* Wealth
gen wealth = 1 if nettotw_bu_s <=48000
replace wealth = 2 if nettotw_bu_s>=48001 & nettotw_bu_s <=168000
replace wealth = 3 if nettotw_bu_s>=168001 & nettotw_bu_s <=273000
replace wealth = 4 if nettotw_bu_s>=273001 & nettotw_bu_s <=453000
replace wealth = 5 if nettotw_bu_s>=453001 & nettotw_bu_s <=14000000
save finalsampleWebb.dta, replace

gen wealthnew = 0 if wealth==3
replace wealthnew = 1 if wealth==1
replace wealthnew = 2 if wealth==2
replace wealthnew = 3 if wealth==4 
replace wealthnew = 4 if wealth==5
gen SES = 0 if inlist(wealth,1,2)
replace SES = 1 if inlist(wealth,3,4,5)
save finalsampleWebb.dta, replace

log using Webb20230510.log
logit activity i.SpBsPs i.age i.Sex i.wealthnew i.labor i.ADLcat i.mobcat i.SPCar [pw=w6xwgt], or
logit activity i.SpBsPs i.age i.Sex i.wealthnew i.labor i.ADLcat i.mobcat i.SPCar i.SpTraA [pw=w6xwgt], or

keep if SES==0
unique idauniq 
* 1417
logit activity i.SpBsPs i.age i.Sex i.labor i.ADLcat i.mobcat i.SPCar [pw=w6xwgt], or
logit activity i.SpBsPs [pw=w6xwgt], or
logit activity i.ADLcat [pw=w6xwgt], or
logit activity i.mobcat [pw=w6xwgt], or

tab activity SpBsPs 
tab activity ADLcat 
tab activity mobcat 
tab activity SpBsPs [aw=w6xwgt]
tab activity ADLcat [aw=w6xwgt]
tab activity mobcat [aw=w6xwgt]

logit activity i.SpBsPs i.age i.Sex i.labor i.ADLcat i.mobcat i.SPCar i.SpTraA [pw=w6xwgt], or
logit activity i.SpTraA [pw=w6xwgt], or

tab activity SpTraA 
tab activity SpTraA [aw=w6xwgt]
clear 

use finalsampleWebb.dta
keep if SES==1
unique idauniq 
* 3233
logit activity i.SpBsPs i.age i.Sex i.labor i.ADLcat i.mobcat i.SPCar [pw=w6xwgt], or
logit activity i.SpBsPs [pw=w6xwgt], or
logit activity i.ADLcat [pw=w6xwgt], or
logit activity i.mobcat [pw=w6xwgt], or

tab activity SpBsPs 
tab activity ADLcat 
tab activity mobcat 
tab activity SpBsPs [aw=w6xwgt]
tab activity ADLcat [aw=w6xwgt]
tab activity mobcat [aw=w6xwgt]

logit activity i.SpBsPs i.age i.Sex i.labor i.ADLcat i.mobcat i.SPCar i.SpTraA [pw=w6xwgt], or
logit activity i.SpTraA [pw=w6xwgt], or

tab activity SpTraA 
tab activity SpTraA [aw=w6xwgt]
clear 
log close

log using Webb20230510.log, append 
use finalsampleWebb.dta
tab Sex
* 2091 male, 2559 female
keep if SES==0
unique idauniq 
* 1417
tab Sex 
* 581 male, 836 female
keep if w6xwgt!=.
clear 

use finalsampleWebb.dta
keep if SES==1
unique idauniq 
* 3233
tab Sex 
* 1,510 male, 1,723 female
keep if w6xwgt!=.
clear 
log close