* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Banks, J., Batty, G. David, Breedvelt, J., Coughlin, K., Crawford, R., Marmot, M., Nazroo, J., Oldfield, Z., Steel, N., Steptoe, A., Wood, M., Zaninotto, P. (2021). English Longitudinal Study of Ageing: Waves 0-9, 1998-2019. [data collection]. 37th Edition. UK Data Service. SN: 5050, DOI: http://doi.org/10.5255/UKDA-SN-5050-24

* Project ID: 237630

cd ""

* Variables Wave 5
use idauniq samptyp diagr indager dhsex disex indsex scdeou scdehe scdemo scdeor scdefr scdewa scdewo scdere scdeli scdeca scdene scdecr scdeha scdeim scdesof scdecal scdein scdecu scdeac scdecar scdebr scdesy scdeta scdeso scdead scdeth wpjact heacta heactb heactc sctvwkd sctvwke scako scveg scfru cftest cfwrds cflisen cflisd dhdobc fqethnr fffqend fqend finstatw5 w5lwgt w5xwgt w5scwt using wave_5_elsa_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 5 to each observation (to designate Wave 5)
gen wave = 5
* Save Wave 5 core dataset
save wave5Allen.dta

* Variables Wave 6
use idauniq samptyp indager DhSex DiSex indsex CfTest CfWrds CfLisEn CfLisD DhDoBC Fqethnr FqEnd fffqend finstatw6 w6lwgt w6xwgt w6scwt w6sscwt using wave_6_elsa_data_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename samptyp samptypw6
rename DhSex dhsex 
rename DiSex disex
rename CfTest cftest 
rename CfWrds cfwrds 
rename CfLisEn cflisen 
rename CfLisD cflisd
rename DhDoBC dhdobc
rename Fqethnr fqethnr
rename FqEnd fqend
* Generate a new variable called wave and assign the number 6 to each observation (to designate Wave 6)
gen wave = 6
* Save Wave 6 core dataset
save wave6Allen.dta

use wave5Allen.dta
append using wave6Allen.dta
* Sort by participant ID and wave (lowest to highest)
sort idauniq wave
save rawAllen.dta

replace indager = 99 if indager==-7

gen indager_cons = indager if wave==5
tsset idauniq wave 
bysort idauniq: carryforward indager_cons, replace
drop if indager_cons<55
gen ascnr = _n
bysort idauniq (wave): gen obsnr = _n
bysort idauniq: gen obscount = _N
tabulate obscount if obsnr==1
keep if obscount==2
unique idauniq 
* 8376, 16752
save fullAllen.dta

* Physical activity 
replace heacta = . if heacta<0
replace heactb = . if heactb<0
replace heactc = . if heactc<0 

gen activity = 0 if wpjact==1 & inlist(heactc,3,4) & heactb==4 & heacta==4
replace activity = 0 if wpjact==-1 & heactc==4 & heactb==4 & heacta==4
replace activity = 1 if wpjact==2 & inlist(heactb,2,3,4) & heacta==4 
replace activity = 1 if wpjact==2 & inlist(heactc,1,2,3) & inlist(heactb,2,3,4) & heacta==4
replace activity = 1 if (wpjact==-1|wpjact==1) & inlist(heactb,2,3) & heacta==4
replace activity = 2 if wpjact==3 | heactb==1 | inlist(heacta,2,3)
replace activity = 3 if wpjact==4 | heacta==1

* Television viewing 
replace sctvwkd =. if sctvwkd<0
replace sctvwke =. if sctvwke<0

gen television = (sctvwkd*5) + sctvwke 

* Diet 
replace scveg = . if scveg<0
replace scfru = . if scfru<0
gen diet = scveg + scfru 

* Alcohol 
replace scako = . if scako<0 
revrs scako

* Memory
replace cflisen = . if cflisen<0
replace cflisd = . if cflisd<0 
egen memory = rowmean(cflisen cflisd)
gen memory2 = (cflisen+cflisd)/2

* Ethnicity 
replace fqethnr = . if fqethnr<0

* Education 
replace fqend = . if fqend<0
replace fffqend = . if fffqend<0
gen education = fffqend 
replace education = fqend if education==. & fqend!=.

save interimAllen.dta
replace fqethnr = 0 if fqethnr==2

gen activity2 = 0 if wpjact==1 & inlist(heactc,3,4) & heactb==4 & heacta==4
replace activity2 = 0 if wpjact==-1 & heactc==4 & heactb==4 & heacta==4
replace activity2 = 1 if wpjact==2 & inlist(heactb,2,3,4) & heacta==4 
replace activity2 = 1 if inlist(heactc,1,2,3) & inlist(heactb,2,3,4) & heacta==4
replace activity2 = 1 if (wpjact==-1|wpjact==1) & inlist(heactb,2,3) & heacta==4
replace activity2 = 2 if wpjact==3 | heactb==1 | inlist(heacta,2,3)
replace activity2 = 3 if wpjact==4 | heacta==1

* Neuroticism 
replace scdemo = . if scdemo<0
replace scdewo = . if scdewo<0
replace scdene = . if scdene<0
replace scdecal = . if scdecal<0
revrs scdemo scdewo scdene
gen neuroticism = (revscdemo+revscdewo+revscdene+scdecal)/4

* Extraversion
replace scdeou = . if scdeou<0 
replace scdefr = . if scdefr<0
replace scdeli = . if scdeli<0
replace scdeac = . if scdeac<0
replace scdeta = . if scdeta<0
revrs scdeou scdefr scdeli scdeac scdeta
gen extraversion = (revscdeou+revscdefr+revscdeli+revscdeac+revscdeta)/5

* Agreeableness 
replace scdehe = . if scdehe<0
replace scdewa = . if scdewa<0
replace scdeca = . if scdeca<0
replace scdesof = . if scdesof<0
replace scdesy = . if scdesy<0
revrs scdehe scdewa scdeca scdesof scdesy
gen agreeableness = (revscdehe+revscdewa+revscdeca+revscdesof+revscdesy)/5

* Conscientiousness 
replace scdeor = . if scdeor<0
replace scdere = . if scdere<0
replace scdeha = . if scdeha<0
replace scdecar = . if scdecar<0
replace scdeth = . if scdeth<0
revrs scdeor scdere scdeha scdeth
gen conscientiousness = (revscdeor+revscdere+revscdeha+scdecar+revscdeth)/5

* Openness 
replace scdecr = . if scdecr<0 
replace scdeim = . if scdeim<0
replace scdein = . if scdein<0
replace scdecu = . if scdecu<0
replace scdebr = . if scdebr<0
replace scdeso = . if scdeso<0
replace scdead = . if scdead<0
revrs scdecr scdeim scdein scdecu scdebr scdeso scdead
gen openness = (revscdecr+revscdeim+revscdein+revscdecu+revscdebr+revscdeso+revscdead)/7

pwcorr activity television, sig
pwcorr activity memory2, sig
pwcorr activity revscako, sig 
pwcorr activity diet, sig
pwcorr activity neuroticism, sig 
pwcorr activity extraversion, sig 
pwcorr activity openness, sig 
pwcorr activity agreeableness, sig 
pwcorr activity conscientiousness, sig 

save fullAllen2.dta
keep if wave==5
save fullAllen2w5.dta

pwcorr activity television, sig
pwcorr activity memory2, sig
pwcorr activity revscako, sig 
pwcorr activity diet, sig
pwcorr activity memory, sig

sum activity2 
sum television 
sum memory2
sum revscako 
sum diet 
sum memory 

keep if indager>=60
* 6563
gen edu = 0 if education==2
replace edu = 0 if inlist(education,3,4,5,6)
replace edu = 1 if inlist(education,1,7,8)
save Allenage60.dta 

sum television,d 
gen tel = 0 if television<=30
replace tel = 1 if television>30 & television!=.
sum memory2,d
gen mem2 = 0 if memory2<=5
replace mem2 = 1 if memory2>5 & memory2!=.
sum revscako,d 
gen reva = 0 if revscako<=5
replace reva = 1 if revscako>5 & revscako!=.
sum diet,d 
gen frvg = 0 if diet<=5
replace frvg = 1 if diet>5 & diet!=.
sum memory,d
gen mem = 0 if memory<=5
replace mem = 1 if memory>5 & memory!=.

save Allenage60.dta, replace

use Allenage60.dta
drop if w5xwgt==0
unique idauniq 
* 6183
tab disex 
* 2,745 male, 3,438 female
save AllenCW.dta
log using 20240116Allen.log

use AllenCW.dta
keep if edu==0
unique idauniq 
* 4743
tab disex 
* 2,025 male, 2,718 female
pwcorr activity2 television, sig obs
pwcorr activity2 memory2, sig obs
pwcorr activity2 revscako, sig obs
pwcorr activity2 diet, sig obs
pwcorr activity2 memory, sig obs
tab activity2 tel 
tab activity2 mem2 
tab activity2 reva 
tab activity2 frvg 
tab activity2 mem 
bysort tel: sum activity2,d
bysort mem2: sum activity2,d
bysort reva: sum activity2,d
bysort frvg: sum activity2,d
bysort mem: sum activity2,d
clear 

use AllenCW.dta
keep if edu==1
unique idauniq 
* 1436
tab disex
* 717 male, 719 female
pwcorr activity2 television, sig obs
pwcorr activity2 memory2, sig obs
pwcorr activity2 revscako, sig obs
pwcorr activity2 diet, sig obs
pwcorr activity2 memory, sig obs
tab activity2 tel 
tab activity2 mem2 
tab activity2 reva 
tab activity2 frvg 
tab activity2 mem 
bysort tel: sum activity2,d
bysort mem2: sum activity2,d
bysort reva: sum activity2,d
bysort frvg: sum activity2,d
bysort mem: sum activity2,d
clear 

log close