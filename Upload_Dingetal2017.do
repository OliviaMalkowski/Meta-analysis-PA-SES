* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Banks, J., Batty, G. David, Breedvelt, J., Coughlin, K., Crawford, R., Marmot, M., Nazroo, J., Oldfield, Z., Steel, N., Steptoe, A., Wood, M., Zaninotto, P. (2021). English Longitudinal Study of Ageing: Waves 0-9, 1998-2019. [data collection]. 37th Edition. UK Data Service. SN: 5050, DOI: http://doi.org/10.5255/UKDA-SN-5050-24

* Project ID: 237630

cd ""

* Variables Wave 2
use idauniq sampsta finstat MmSchs MmAlone MmHSS MmWill MmSaf MmAvsp MmWala MmTrya MMWlkA MmTryb MMWlkB MmPain MmAid MMcomZ1 MMcomZ2 MMcomZ3 PScedA PScedB PScedC PScedD PScedE PScedF PScedG PScedH heada01 heada02 heada03 heada04 heada05 heada06 heada07 heada08 heada09 heada10 headb01 headb02 headb03 headb04 headb05 headb06 headb07 headb08 headb09 headb10 headb11 headb12 headb13 CfMetM CfMetMT CfDatD CfDatM CfDatY CfDay CfDScr CfTest CfWrds CfLisEn CfAni CfMem CfMemS CfPAScr CfLisD CfLitSK cflitoc CfLitB CfLitC CfLitD CfLitE nncorre nnmisse nnrow nnclm nrowcl DiPRe outscw2 askpx1 w2indout w2wgt scw2wgt dhager diagr indager DhSex DiSex indsex couple DiMar fqethnr HHTot scako HeSmk HESka HeSkd HeSke HeSkf scptr scptra scptrb scptrc scptrd scptre scptrf scptrg scchd scchda scchdb scchdc scchdd scchde scchdf scfam scfama scfamb scfamc scfamd scfame scfamf scfrd scfrda scfrdb scfrdc scfrdd scfrde scfrdf scchdg scchdh scchdi scchdm scfamg scfamh scfami scfamm scfrdg scfrdh scfrdi scfrdm scorg01 scorg02 scorg03 scorg04 scorg05 scorg06 scorg07 scorg08 scorg09 hediaw1 HeDiaW2 HeDiaW3 HeDiaW4 HeDiaW5 HeDiaW6 HeDiaW7 HeDiaW8 HeDiaW9 hediac1 HeDiaC2 HeDiaC3 HeDiaC4 HeDiaC5 HeDiaC6 HeDiaC7 HeDiaC8 HeDiaC9 hedian1 HeDiaN2 HeDiaN3 HeDiaN4 HeDiaN5 HeDiaN6 HeDiaN7 HeDiaN8 HeDiaN9 hedias1 HeDiaS2 HeDiaS4 HeDiaS5 HeDiaS6 HeDiaS7 HeDiaS9 hedia01 hedia02 hedia03 hedia04 hedia05 hedia06 hedia07 hedia08 hedia09 hedim01 hedim02 hedim03 hedim04 hedim05 hedim06 hedim07 hedim08 hedibw1 HeDibW2 HeDibW3 HeDibW4 HeDibW5 HeDibW6 HeDibW7 HeDibW8 HeDibW9 hediad1 HeDiaD2 HeDiaD3 HeDiaD4 HeDiaD5 HeDiaD6 HeDiaD7 HeDiaD8 HeDiaD9 hediam1 HeDiaM2 HeDiaM3 HeDiaM4 HeDiaM5 HeDiaM6 HeDiaM7 HeDiaM8 HeDiaM9 hedids1 HeDiDS2 HeDiDS3 HeDiDS4 HeDiDS5 HeDiDS6 HeDiDS7 HeDiDS8 HeDiDS9 hedib01 hedib02 hedib03 hedib04 wpjact HeActa HeActb HeActc using wave_2_core_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant identifier (ID)
sort idauniq
* Rename variables to ensure consistency across waves
rename HeActa heacta
rename HeActb heactb
rename HeActc heactc
* Generate a new variable called wave and assign the number 2 to each observation (to designate Wave 2)
gen wave = 2
* Save Wave 2 core dataset
save wave2Ding.dta

* Variables Wave 2 Financial 
use idauniq nettotw_bu_s nettotw_bu_f nettotw_bu_t totwq5_bu_s totwq10_bu_s totwq10_bu_f using wave_2_financial_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 2 to each observation (to designate Wave 2)
gen wave = 2
* Save Wave 2 financial dataset
save wave2financialDing.dta

* Variables Wave 2 Derived
use idauniq w2edqual using wave_2_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 2 to each observation (to designate Wave 2)
gen wave = 2
* Save Wave 2 derived dataset
save wave2derivedDing.dta

* Variables Wave 2 Nurse 
use idauniq w2wtnur mmgswil mmgsdom mmgssta mmgsd1 mmgsn1 mmgsd2 mmgsn2 mmgsd3 mmgsn3 mmgstp mmgsres mmgspr1 mmgspr2 bpconst consub1 consub2 consub3 cufsize airtemp sys1 dias1 sys2 dias2 sys3 dias3 ynobp bprespc sysval diaval respbps clotb fit bswill samptak bsoutc cfib chol hdl hscrp hba1c bloodr resphts height ehtch ehtm ehtft ehtin estht htval htok relhite hinrel respwts weight ewtch ewtkg ewtst ewtl estwt wtval wtok relwait bmi bmival bmiok bmiobe whintro waist1 hip1 waist2 hip2 waist3 hip3 wstval hipval whval wstokb hipokb whokb ynowh respwh wjrel probwj hjrel probhj using wave_2_nurse_data_v2.dta 
describe 
sort idauniq 
gen wave = 2
save wave2nurseDing.dta

* Wave 2 complete data
use wave2Ding.dta
merge 1:1 idauniq using wave2financialDing.dta, generate (merge_financial2)
save wave2Ding.dta, replace
use wave2Ding.dta
merge 1:1 idauniq using wave2derivedDing.dta, generate (merge_derived2)
save wave2Ding.dta, replace
use wave2Ding.dta
merge 1:1 idauniq using wave2nurseDing.dta, generate (merge_nurse2)
save wave2Ding.dta, replace

* Variables Wave 3
use idauniq sampsta finstat cfprom cfmetm cfmetmt cfdatd cfdatm cfdaty cfday cfdscr cftest cfwrds cflisen cfani cfmem cfleten cfmems cfpascr cflisd nrow nclm ncorrect nmissed nrowclm using wave_3_elsa_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename sampsta sampstaw3 
rename finstat finstatw3
* Generate a new variable called wave and assign the number 3 to each observation (to designate Wave 3)
gen wave = 3
* Save Wave 3 core dataset
save wave3Ding.dta

* Variables Wave 4
use idauniq samptyp finstat4 mmschs mmalone mmhss mmwill mmsaf mmavsp mmwala mmtrya mmwlka mmtryb mmwlkb mmpain mmaid psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh headldr headlwa headlba headlea headlbe headlwc headlma headlda headlpr headlsh headlte headlco headlme headlho headlmo headl96 cfmetm cfmetmt cfdatd cfdatm cfdaty cfday cfdscr cfprom cftest cfwrds cflisen cfani cfmem cfleten nrow nclm ncorrect nmissed nrowclm cfmems cfpascr cflisd cfsumb cfsumc cfsumd cfsuma cfsume cfsumf cfmscr dipre outscw4 askpx w4xwgt w4lwgt w4scwt diagr indager dhsex disex indsex couple dimar fqethnr hhtot scako hesmk heska heskd heske heskf scptr scptra scptrb scptrc scptrd scptre scptrf scptrg scchd scchda scchdb scchdc scchdd scchde scchdf scfam scfama scfamb scfamc scfamd scfame scfamf scfrd scfrda scfrdb scfrdc scfrdd scfrde scfrdf scchdg scchdh scchdi scchdm scfamg scfmh scfami scfamm scfrdg scfrdh scfrdi scfrdm scorg01 scorg02 scorg03 scorg04 scorg05 scorg06 scorg07 scorg08 scorg09 hedawbp hedacbp hedanbp hedasbp hedawan hedacan hedanan hedasan hedawmi hedacmi hedanmi hedawhf hedachf hedanhf hedashf hedawhm hedachm hedanhm hedashm hedawar hedacar hedanar hedasar hedawdi hedacdi hedandi hedawst hedacst hedanst hedawch hedacch hedanch hedasch hedawot hedacot hedanot hedasot hediabp hediaan hediami hediahf hediahm hediaar hediadi hediast hediach hedia95 hedia96 hedimbp hediman hedimmi hedimhf hedimhm hedimar hedimdi hedimst hedimch hedizm51 hedizm52 hedim85 hedim86 hedim96 hedbwlu hedbdlu hedbmlu hedbslu hedbwas hedbdas hedbmas hedbsas hedbwar hedbdar hedbmar hedbsar hedbwos hedbdos hedbmos hedbsos hedbwca hedbdca hedbmca hedbsca hedbwpd hedbdpd hedbmpd hedbspd hedbwps hedbdps hedbmps hedbwad hedbdad hedbmad hedbwde hedbdde hedbmde hedbsde hediblu hedibas hedibar hedibos hedibca hedibpd hedibps hedibad hedibde hedibbl hedib96 wpjact heacta heactb heactc w4edqual using wave_4_elsa_data_v3.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
rename scfmh scfamh
* Generate a new variable called wave and assign the number 4 to each observation (to designate Wave 4)
gen wave = 4
* Save Wave 4 core dataset
save wave4Ding.dta

* Variables Wave 4 Financial 
use idauniq nettotw_bu_s nettotw_bu_f nettotw_bu_t totwq5_bu_s totwq10_bu_s totwq10_bu_f using wave_4_financial_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 4 to each observation (to designate Wave 4)
gen wave = 4
* Save Wave 4 financial dataset
save wave4financialDing.dta

* Variables Wave 4 Nurse 
use idauniq mmgswil mmgsdom mmgssta mmgsd1 mmgsn1 mmgsd2 mmgsn2 mmgsd3 mmgsn3 mmgstp mmgsres mmgsprre mmgsprpa mmgspreq mmgsprot bpconst cuffsize airtemp sys1 dias1 sys2 dias2 sys3 dias3 whynobp bprespc sysval diaval respbps clotb fit bswill samptak bsoutc cfib chol hdl dheas hscrp hba1c bloodr resphts height ehtch ehtm ehtft ehtin estht htval htok relhite hinrel respwts weight ewtch ewtkg ewtst ewtl estwt wtval wtok relwait bmi bmival bmiok bmiobe whwill waist1 hip1 waist2 hip2 waist3 hip3 wstval hipval whval wstokb hipokb whokb ynowh respwh wjrel probwj hjrel probhj using wave_4_nurse_data.dta 
describe 
sort idauniq 
gen wave = 4
save wave4nurseDing.dta

* Wave 4 complete data
use wave4Ding.dta
merge 1:1 idauniq using wave4financialDing.dta, generate (merge_financial4)
save wave4Ding.dta, replace
use wave4Ding.dta
merge 1:1 idauniq using wave4nurseDing.dta, generate (merge_nurse4)
save wave4Ding.dta, replace

* Variables Wave 6
use idauniq w6indout samptyp finstatw6 MmSchs MmAlone MmHSS MmWill MmSaf MmAvsp MmWala MmTrya MMWlkA MmTryb MMWlkB MmPain MmAid PScedA PScedB PScedC PScedD PScedE PScedF PScedG PScedH headldr headlwa headlba headlea headlbe headlwc headlma HeADLda headlpr headlsh headlph headlco headlme headlho headlmo headl96 CfDatD CfDatM CfDatY CfDay CfDScr CfTest CfWrds CfLisEn CfTimB CfLisTim CF200pre CF240 CF241 CF242 CFFIRnd CF201g1 CF202h1 CF203i1 CF216c CF204a1 CF205b1 CF206c1 CF207d1 CF208e1 CF209f1 CF210j1 CF211k1 CF212l1 CF213m1 CF214n1 CF215o1 CF221g2 CF222h2 CF223i2 CF226c CF224a2 CF225b2 CF226c2 CF227d2 CF228e2 CF229f2 CF230j2 CF231k2 CF232l2 CF233m2 CF234n2 CF235o2 CfTimF CfLisD CfLitSK CfLitB CfLitC CfLitD CfLitE CfLitF CfSumB CfSumC CfSumD CfSumE CfSumA CfSumF CfMScr DiPRe askpx w6lwgt w6xwgt w6scwt indager DhSex DiSex indsex couple DiMar Fqethnr HHTot scako HeSmk HESka HeSkd HeSke HeSkf scprtr scptra scptrb scptrc scptrd scptre scptrf q18g q21g q25g q29g scptrg scchd scchda scchdb scchdc scchdd scchde scchdf scfam scfama scfamb scfamc scfamd scfame scfamf scfrd scfrda scfrdb scfrdc scfrdd scfrde scfrdf scchdg scchdh scchdi scchdt scchdm scfamg scfamh scfami scfamt scfamm scfrdg scfrdh scfrdi scfrdt scfrdm scorg01 scorg02 scorg03 scorg04 scorg05 scorg06 scorg07 scorg08 scorg09 hedawbp hedacbp hedanbp hedasbp hedawan hedacan hedanan hedasan hedawmi hedacmi hedanmi hedawhf hedachf hedanhf hedashf hedawhm hedachm hedanhm hedashm hedawar hedacar hedanar hedasar hedawdi hedacdi hedandi hedawst hedacst hedanst hedawch hedacch hedanch hedasch hedawot hedacot hedanot hedasot hediabp hediaan hediami hediahf hediahm hediaar hediadi hediast hediach hedia95 hedia96 hedimbp hediman hedimmi hedimhf hedimhm hedimar hedimdi hedimst hedimch hedim85 hedim86 hedim96 hedbwlu hedbdlu hedbmlu hedblu hedbwas hedbdas hedbmas hedbsas hedbwar hedbdar hedbmar hedbsar hedbwos hedbdos hedbmos hedbsos hedbwca hedbdca hedbmca hedbsca hedbwpd hedbdpd hedbmpd hedbspd hedbwps hedbdps hedbmps hedbwad hedbdad hedbmad hedbwde hedbdde hedbmde hedbsde hedbwbl hedbdbl hedbmbl hedbsbl hediblu hedibas hedibar hedibos hedibca hedibpd hedibps hedibad hedibde hedibbl hedib96 WpJAct HeActa HeActb HeActc using wave_6_elsa_data_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Rename variables to ensure consistency across waves
rename HeActa heacta
rename HeActb heactb
rename HeActc heactc
rename samptyp sampstaw6
rename WpJAct wpjact
* Generate a new variable called wave and assign the number 6 to each observation (to designate Wave 6)
gen wave = 6
* Save Wave 6 core dataset
save wave6Ding.dta

* Variables Wave 6 Financial 
use idauniq nettotw_bu_s nettotw_bu_f nettotw_bu_t totwq5_bu_s totwq10_bu_s totwq10_bu_f using wave_6_financial_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 6 to each observation (to designate Wave 6)
gen wave = 6
* Save Wave 6 financial dataset
save wave6financialDing.dta

* Variables Wave 6 Derived
use idauniq edqual using wave_6_ifs_derived_variables.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 6 to each observation (to designate Wave 6)
gen wave = 6
* Save Wave 6 derived dataset
save wave6derivedDing.dta

* Variables Wave 6 Nurse 
use idauniq mmgswil mmgsdom mmgssta MMGSStp mmgsd1 mmgsn1 mmgsd2 mmgsn2 mmgsd3 mmgsn3 mmgstp mmgsres mmgsprre mmgsprpa mmgspreq mmgsprot cuffsize airtemp sys1 dias1 sys2 dias2 sys3 dias3 whynobp SYSVAL DIAVAL BSOUTC respbps clotb fit bswill samptak cfib chol hdl hscrp hba1c resphts height ehtch ehtm ehtft ehtin estht HTVAL HTOK relhite hinrel respwts weight ewtch ewtkg ewtst ewtl estwt WTVAL WTOK relwait BMI BMIOK BMIVAL BMIOBE whwill waist1 waist2 waist3 WSTVAL WSTOKB bswill bpconst using wave_6_elsa_nurse_data_v2.dta 
describe 
sort idauniq 
gen wave = 6
save wave6nurseDing.dta

* Wave 6 complete data
use wave6Ding.dta
merge 1:1 idauniq using wave6financialDing.dta, generate (merge_financial6)
save wave6Ding.dta, replace
use wave6Ding.dta
merge 1:1 idauniq using wave6derivedDing.dta, generate (merge_derived6)
save wave6Ding.dta, replace
use wave6Ding.dta
merge 1:1 idauniq using wave6nurseDing.dta, generate (merge_nurse6)
save wave6Ding.dta, replace

use wave2Ding.dta 
append using wave3Ding.dta 
sort idauniq wave
append using wave4Ding.dta 
sort idauniq wave
append using wave6Ding.dta 
sort idauniq wave
save rawDing.dta

unique idauniq
* 17940, 43629
gen age_cons = indager if wave==2
tsset idauniq wave 
bysort idauniq: carryforward age_cons, replace
keep if age_cons>=65 & age_cons<90
unique idauniq 
* 4638, 13865
save fullDing.dta

* Age 
sum indager if wave==2 

* Sex 
tab DiSex if wave==2

* Walking speed 
* Wave 2
replace MMWlkA = . if MMWlkA<0
replace MMWlkB = . if MMWlkB<0
egen slowness = rowmean(MMWlkA MMWlkB) if wave==2
gen speed = 2.44/slowness
gen revspeed = speed*-1
gen speedb = 2.4/slowness
gen revspeedb = speedb*-1

* Wave 4
replace mmwlka = . if mmwlka<0
replace mmwlkb = . if mmwlkb<0
egen slowness4 = rowmean(mmwlka mmwlkb)
gen speed4 = 2.44/slowness4
gen revspeed4 = speed4*-1
gen speed4b = 2.4/slowness4
gen revspeed4b = speed4b*-1

* Hand grip strength 
* Wave 2 + 4
replace mmgsd1 = . if mmgsd1<0
replace mmgsd2 = . if mmgsd2<0
replace mmgsd3 = . if mmgsd3<0

gen weak = mmgsd1
gen weaksex = weak
replace weaksex = weak*1.5 if DiSex==2 & wave==2
replace weaksex = weak*1.5 if disex==2 & wave==4
gen revweaksex = weaksex*-1

* Exhaustion 
* Wave 2
replace PScedB = . if PScedB<0
replace PScedH = . if PScedH<0
gen exhaustion = 1 if (PScedB==1 | PScedH==1) & PScedB!=. & PScedH!=.
replace exhaustion = 0 if PScedB==2 & PScedH==2 & PScedB!=. & PScedH!=.
* Wave 4
replace pscedb = . if pscedb<0
replace pscedh = . if pscedh<0
gen exhaustion4 = 1 if (pscedb==1 | pscedh==1) & pscedb!=. & pscedh!=.
replace exhaustion4 = 0 if pscedb==2 & pscedh==2 & pscedb!=. & pscedh!=.
save interimDing.dta

* Physical frailty 

* BMI 

* Chronic disease 

* Allostatic load 

* Physical activity  
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
gen revactivity = 0 if activity2==3
replace revactivity = 1 if activity2==2
replace revactivity = 2 if activity2==1
replace revactivity = 3 if activity2==0
replace wpjact = . if wpjact<0
gen revPA = revactivity 
replace revPA = 0 if wpjact==4
replace revPA = 3 if wpjact==1
* 1 missing - wpjact doesn't change total
sum revactivity if wave==2

* Smoking history 

* Alcohol intake 

* Depressive symptoms 

* Cognitive impairment 

* Education 

* Wealth 
gen wealth = 0 if inlist(totwq10_bu_s,1,2)
replace wealth = 1 if inlist(totwq10_bu_s,3,4,5,6,7,8,9,10)

* Social support 

* Social integration 

* Activity limitation

save interim2Ding.dta
replace indager = 99 if indager==-7
save finalDing.dta

sum speed if wave==2
sum speed if wave==2 & DiSex==1
sum speed if wave==2 & DiSex==2
sum revspeed if wave==2
sum speedb if wave==2
sum speedb if wave==2 & DiSex==1
sum speedb if wave==2 & DiSex==2
sum revspeedb if wave==2
sum speed4 if wave==4
sum revspeed4 if wave==4
sum speed4b if wave==4
sum revspeed4b if wave==4

sum weak if wave==2
sum weak if wave==2 & DiSex==1
sum weak if wave==2 & DiSex==2
sum weak if wave==4
sum weaksex if wave==2
sum weaksex if wave==4
sum revweaksex if wave==2
sum revweaksex if wave==4

tab exhaustion if wave==2
tab exhaustion if wave==2 & DiSex==1
tab exhaustion if wave==2 & DiSex==2
tab exhaustion4 if wave==4

sum activity2 if wave==2
sum activity2 if wave==4
sum activity2 if wave==6
sum revactivity if wave==2
sum revactivity if wave==4
sum revactivity if wave==6
sum revPA if wave==2
sum revPA if wave==4
sum revPA if wave==6

tab wealth if wave==2

log using 20241018Ding.log
use finalDing.dta
unique idauniq 
* 4638, 13865
tab DiSex if wave==2
* 2,070 male, 2,568 female
tab wealth DiSex if wave==2
* Low SES: 361 male, 615 female; High SES: 1,661 male, 1,920 female
drop if w2wgt==0
unique idauniq 
* 4628, 13824
unique idauniq if wave==2
* 4597
unique idauniq if w2wgt!=.
* 4597
tab DiSex if wave==2 & w2wgt!=.
* 2,047 male, 2,550 female

keep idauniq wave wealth revactivity activity2 exhaustion exhaustion4 revweaksex weaksex weak revspeed4b speed4b revspeed4 speed4 revspeedb speedb revspeed speed
save shortformDing1810.dta 
rename activity2 activity 
rename exhaustion4 w4exhaustion
rename revspeed4 w4revspeed 
rename speed4 w4speed
save shortformDing21810.dta 

reshape wide wealth revactivity activity exhaustion w4exhaustion revweaksex weaksex weak revspeed4b speed4b w4revspeed w4speed revspeedb speedb revspeed speed, i(idauniq) j(wave)
save wideDing1810.dta 
drop wealth4 wealth6 revactivity2 activity2 exhaustion4 exhaustion6 w4exhaustion2 w4exhaustion6 revweaksex6 weaksex6 weak6 revspeed4b2 revspeed4b6 speed4b2 speed4b6 w4revspeed2 w4revspeed6 w4speed2 w4speed6 revspeedb4 revspeedb6 speedb4 speedb6 revspeed4 revspeed6 speed4 speed6 
drop speed3 w4speed3 revspeed3 w4revspeed3 speedb3 revspeedb3 weak3 weaksex3 revweaksex3 exhaustion3 w4exhaustion3 wealth3 activity3 revactivity3 speed4b3 revspeed4b3
save wideDingfinal1810.dta

sum speed2,d 
gen speed2bi = 0 if speed2<=0.81198
replace speed2bi = 1 if speed2>0.81198&speed2!=.

sum weak2,d
gen weak2bi = 0 if weak2<=25
replace weak2bi = 1 if weak2>25 & weak2!=.

sum weaksex2,d 
gen weaksex2bi = 0 if weaksex2<=31.5
replace weaksex2bi = 1 if weaksex2>31.5 & weaksex2!=.

tab wealth2

tab speed2bi revactivity4 if wealth==0
sum activity4 if speed2bi==0 & wealth==0
sum activity4 if speed2bi==1 & wealth==0
tab weak2bi revactivity4 if wealth==0 
tab weaksex2bi revactivity4 if wealth==0 
sum activity4 if weak2bi==0 & wealth==0
sum activity4 if weaksex2bi==0 & wealth==0 
sum activity4 if weak2bi==1 & wealth==0
sum activity4 if weaksex2bi==1 & wealth==0 
tab exhaustion2 revactivity4 if wealth==0
sum activity4 if exhaustion2==0 & wealth==0
sum activity4 if exhaustion2==1 & wealth==0

tab speed2bi revactivity4 if wealth==1
sum activity4 if speed2bi==0 & wealth==1
sum activity4 if speed2bi==1 & wealth==1
tab weak2bi revactivity4 if wealth==1
tab weaksex2bi revactivity4 if wealth==1
sum activity4 if weak2bi==0 & wealth==1
sum activity4 if weaksex2bi==0 & wealth==1
sum activity4 if weak2bi==1 & wealth==1
sum activity4 if weaksex2bi==1 & wealth==1 
tab exhaustion2 revactivity4 if wealth==1
sum activity4 if exhaustion2==0 & wealth==1
sum activity4 if exhaustion2==1 & wealth==1
save wideDingbinary1810.dta
log close