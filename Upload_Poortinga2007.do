* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: National Centre for Social Research, University College London, Department of Epidemiology and Public Health. (2024). Health Survey for England, 2003. [data collection]. 2nd Edition. UK Data Service. SN: 5098, DOI: http://doi.org/10.5255/UKDA-SN-5098-1

* Date of data access/download (dd/mm/yyyy): 26/05/2023

* Project ID: 237630

cd ""

use finoutc hhdtypb sex age irndage nrndage ag16g10 ag015g2 indout hohnum schrp schrpg4 schrpg7 schrpg6 hrpsoc2 hrpactiv hrpsoccl soc2000 soc90 sclass scallx scallxg2 econact activb hpnssec8 hpnssec5 hpnssec3 nssec8 nssec5 nssec3 hhold samptype smkevr cignow cigevr cigst1 cigst2 cigsta3 smoke1 dnnow dnany dnevr dnoft dnoft2 d7unit d7unitg d7day d7many d7many2 drnksame whichday d7typ1 d7typ2 d7typ3 d7typ4 d7typ5 d7typ6 nbrl71 nbrl72 nbrl73 nbrl74 sbrl71 sbrl72 sbrl73 sbrl74 nberqhp7 nberqpt7 nberqsm7 nberqlg7 nberqbt7 orgs13 adtot30 adtot30c adt30any adt30gp actlevel adhse30b adhs30bg anyhse adman30b admn30bg anyman homeacty workd workdc workact workactg active adwlk30b adwk30bg anywlk wlkactyb adsp30 adsp30g anyspt vig20sp sprtacty int_wt hhld_wt pserial hserial cluster area using hse03ai.dta
save Poortinga.dta

unique pserial
* 18553
unique hserial
* 8867
sum age if age>=65
* 3219
drop if age>=65
unique pserial
* 15334
drop if age<16
unique pserial 
* 11617
unique hserial
* 6848
save fullPoortinga.dta

* Sex
replace sex = 0 if sex==2

* Age
tab ag16g10

* Social class
tab schrpg4
gen class = schrpg4
replace class=. if class<0

* Economic status 
tab econact
gen economic = econact
replace economic = . if economic<0
replace economic = 0 if economic==1
replace economic = 1 if economic==2
replace economic = . if economic==3
replace economic = 2 if economic==4
gen economic2 = econact
replace economic2 = . if economic2<0
replace economic2 = 0 if economic2==1
replace economic2 = 1 if economic2==2
replace economic2 = 2 if economic2==3
replace economic2 = 2 if economic2==4

* Sportsclub membership
tab orgs13
gen member = orgs13 
replace member = 2 if member<0

* Sports activity 
tab adsp30
tab adsp30g 
tab vig20sp
replace vig20sp=. if vig20sp<0
gen sports = 0 if adsp30g==0
replace sports = 0 if adsp30g==1
replace sports = 1 if inlist(adsp30g,2,3,4)

* Occupational activity
tab workactg
replace workactg = . if workactg<0
replace workactg = 0 if workactg==1
replace workactg = 1 if workactg==2
 
melogit sports i.sex i.ag16g10 i.class i.economic i.member || cluster: || hserial:,or
melogit workactg i.sex i.ag16g10 i.class i.economic i.member || cluster: || hserial:,or
melogit sports i.sex i.ag16g10 i.class i.economic i.member || area: || hserial:,or
melogit workactg i.sex i.ag16g10 i.class i.economic i.member || area: || hserial:,or

gen member2 = member 
replace member2 = . if member2==2

save Poortinga2.dta

keep if age>=60
unique pserial 
* 1050
unique hserial 
* 904
unique cluster
* 326

tab class
gen SES = 0 if inlist(class,3,4)
replace SES = 1 if inlist(class,1,2)
save Poortinga2age60.dta 
tab sex
* 561 female, 489 male

log using 20230526Poortinga.log
keep if SES==0
tab sex
* 261 female, 247 male
unique pserial
* 508
unique hserial
* 429
unique cluster
* 238
unique area 
* 316
melogit sports i.sex i.economic i.member || cluster: || hserial:,or
melogit workactg i.sex i.economic i.member || cluster: || hserial:,or
melogit sports i.sex i.economic i.member || area: || hserial:,or
melogit workactg i.sex i.economic i.member || area: || hserial:,or
tab sports member 
tab workactg member 
tab sports member2 
tab workactg member2
clear 

use Poortinga2age60.dta 
keep if SES==1
tab sex
* 294 female, 233 male
unique pserial
* 527
unique hserial
* 461
unique cluster
* 244
unique area 
* 321
melogit sports i.sex i.economic i.member || cluster: || hserial:,or
melogit workactg i.sex i.economic i.member || cluster: || hserial:,or
melogit sports i.sex i.economic i.member || area: || hserial:,or
melogit workactg i.sex i.economic i.member || area: || hserial:,or
tab sports member 
tab workactg member 
tab sports member2 
tab workactg member2
clear 

log close