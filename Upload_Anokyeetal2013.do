* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: University College London, Department of Epidemiology and Public Health, National Centre for Social Research. (2024). Health Survey for England, 2006. [data collection]. 4th Edition. UK Data Service. SN: 5809, DOI: http://doi.org/10.5255/UKDA-SN-5809-1

* Date of data access/download (dd/mm/yyyy): 26/05/2023

* Project ID: 237630

cd ""

use finoutc hhdtypb sex age irndage nrndage ag16g10 ag015g2 indout hohnum schrp schrpg4 schrpg7 schrpg6 hrpsoc2 hrpactiv hrpsoccl soc2000 sclass scallx scallxg2 econact activb hpnssec8 hpnssec5 hpnssec3 nssec8 nssec5 nssec3 hhold samptype smkevr cignow cigarnow pipenowa cigevr cigst1 cigst2 cigsta3 smoke1 smoke2 smoke3 smoke4 dnnow dnany dnevr dnoft dnoft2 d7unit d7unitg d7day d7many drnksame whichday d7typ1 d7typ2 d7typ3 d7typ4 d7typ5 d7typ6 nbrl71 nbrl72 nbrl73 nbrl74 sbrl71 sbrl72 sbrl73 sbrl74 nberqhp7 nberqpt7 nberqsm7 nberqlg7 nberqbt7 orgs13 sptany vig20sp wt_int wt_int_s1 wt_int_s2 child_wt wt_intch wt_hhld wt_nurse wt_nurse_s1 wt_nurse_s2 wt_blood wt_blood_s1 wt_blood_s2 pserial hserial cluster adults children totinc mcclem eqvinc eqv5 hhinc sdqvols lclub vhelp vhtimes orgs08 genhelf genhelf2 bmiok bmi bmival bmivg4 bmivg6 bmivg5 bmicut bmicut2 bmicut3 bmicat1 bmicat2 bmicat3 a30sp06 ch00sptg sprtdays sportdo num20 t59su06 a30t06a a30t06c a30to06 totany daystot ad15tot ad15tot2 using hse06ai.dta

save rawAnokye.dta
unique pserial
* 21399
drop if age<16
unique pserial
* 14142
save fullAnokye.dta

* Drinkers
tab dnnow 
gen drink = dnnow 
replace drink = . if drink<0

* Smokers - can't replicate
tab cigst1 
tab smoke1 
tab smoke4
gen smoking = 0 if smkevr==2
replace smoking = 0 if cignow==2 & cigarnow==2 & pipenowa==2
replace smoking = 1 if cignow==1 | cigarnow==1 | pipenowa==1

* Voluntary activities 
tab orgs08
gen voluntary = orgs08 
replace voluntary = . if voluntary<0

* Health status 
tab genhelf2
gen health = genhelf2 
replace health = . if health<0

* Obese
tab bmivg4
gen BMI = bmivg4 
replace BMI = . if BMI<0
replace BMI = 0 if inlist(BMI,1,2,3)
replace BMI = 1 if BMI==4

* Physical activity
tab sptany
tab vig20sp

gen PArec = vig20sp
replace PArec = . if PArec<0
replace PArec = 0 if PArec<12
replace PArec = 1 if PArec>=12 & PArec!=.

* Weight variable
sum wt_int 
sum wt_hhld

* Equivalized income
sum eqvinc 
sum eqvinc if eqvinc>=0
sum eqvinc if eqvinc<0
gen income = eqv5
replace income = . if income<0

gen SES = 0 if inlist(income,1,2)
replace SES = 1 if inlist(income,3,4,5)
save fullAnokye2.dta

keep if age>=60
unique pserial 
* 4381
save Anokyeage60.dta

gen income2 =  eqvinc 
replace income2 = . if income2<0
xtile quintile = income2 if income2!=., n(5)
gen SES2 = 0 if inlist(quintile,1,2)
replace SES2 = 1 if inlist(quintile,3,4,5)

save Anokyeage60.dta, replace

log using 20230526Anokye.log 
keep if SES2==0
unique pserial
* 1491
tab PArec drink
tab PArec voluntary 
tab PArec health 
tab PArec BMI 
tab PArec drink [aw=wt_int]
tab PArec voluntary [aw=wt_int]
tab PArec health [aw=wt_int]
tab PArec BMI [aw=wt_int]
tab PArec drink [aw=wt_hhld]
tab PArec voluntary [aw=wt_hhld]
tab PArec health [aw=wt_hhld]
tab PArec BMI [aw=wt_hhld]
clear 

use Anokyeage60.dta
keep if SES2==1
unique pserial
* 1792
tab PArec drink
tab PArec voluntary 
tab PArec health 
tab PArec BMI 
tab PArec drink [aw=wt_int]
tab PArec voluntary [aw=wt_int]
tab PArec health [aw=wt_int]
tab PArec BMI [aw=wt_int]
tab PArec drink [aw=wt_hhld]
tab PArec voluntary [aw=wt_hhld]
tab PArec health [aw=wt_hhld]
tab PArec BMI [aw=wt_hhld]
clear 
log close