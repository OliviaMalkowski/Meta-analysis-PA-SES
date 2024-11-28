* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: University College London, Department of Epidemiology and Public Health, National Centre for Social Research. (2024). Health Survey for England, 2006. [data collection]. 4th Edition. UK Data Service. SN: 5809, DOI: http://doi.org/10.5255/UKDA-SN-5809-1

* Date of data access/download (dd/mm/yyyy): 26/05/2023

* Project ID: 237630

cd "X:\Health\ResearchProjects\MJWestern\ED-SP1156\Study 2 - Systematic review\Data\5809stata8_bbb4562a201dd5487aafdfe42061cd97\UKDA-5809-stata8\stata8"

use samptype hserial finoutc pserial indout sex age ag16g10 schrp schrpg4 schrpg7 schrpg6 hrpsoccl hrpseg seg sclass scallx scallxg2 econact seg hpnssec8 hpnssec5 hpnssec3 hrpnssec nssec8 nssec5 nssec3 nssec stnssec sthnssec hrpactiv hrpstwk activb stwork htval wtval height weight htok wtok wstval waist1 waist2 waist3 hipval hip1 hip2 hip3 whval wstokb hipokb whokb bmiok bmi bmival bmivg4 bmivg5 bmicat1 bmicat2 bmicat3 genhelf genhelf2 hhinc totinc mcclem eqvinc eqv5 dnnow dnany dnevr dnoft dnoft2 d7unit d7unitg drevunit drevutg alclimit d7day d7many d7many3 adrinkwq cigwday cigwend cigdyal smkevr cignow cigevr cigreg cigst1 cigst2 cigarnow cigarreg pipenowa ad15spt ad15spt2 longill limitill limitact workact workactg ad15tot ad15tot2 totany a30to06 a30t06c a30t06a a30t06g t59su06 t59s06b hrstot hrstotg actle06 num20 qualact1 qualactg ad15spt ad15spt2 sptany vig20sp hrsspt hrssptg sprtacty a30wk06 wlkacty workd workdc wt_int wt_int_s1 wt_int_s2 wt_hhld gor06 imd2004 cluster hhold using hse06ai.dta
gen wave=1
gen year=06
save year06Chaudhury.dta

use samptype imd2007 age sex kpaguid kpadays kpamins atphysa1 atphysa2 atphysa3 atphysa4 atphysa5 arespa01 arespa02 arespa03 arespa04 arespa05 arespa06 arespa07 arespa08 arespa09 arespa10 arespa11 arespa12 arespa13 arespa14 aownphya aownfit adomorpa apafutr astppa01 astppa02 astppa03 astppa04 astppa05 astppa06 astppa07 astppa08 astppa09 astppa10 astppa11 aprvpa01 aprvpa02 aprvpa03 aprvpa04 aprvpa05 aprvpa06 aprvpa07 aprvpa08 aprvpa09 aprvpa10 aprvpa11 aencpa01 aencpa02 aencpa03 aencpa04 aencpa05 aencpa06 aencpa07 aencpa08 aencpa09 aencpa10 aencpa11 aencpa12 aencpa13 kpadaysc kpaminsc xownphya xdomorpa atphysa1m atphysa1g atphysa2m atphysa2g atphysa3m atphysa3g atphysa4m atphysa4g atphysa5m atphysa5g wt_int wt_hhld hhold area cluster pserial hserial using hse07ai.dta 
gen wave=2
gen year=07
save year07Chaudhury.dta

use year06Chaudhury.dta 
append using year07Chaudhury.dta
sort pserial wave
save rawChaudhury.dta 

unique pserial 
* 34337, 35785

tab age if wave==1
drop if age<60 & wave==1
drop if age>69 & wave==1
drop if age<60 & wave==2
drop if age>64 & wave==2

unique pserial
* 2592, 2608
unique pserial if wave==1
* 2047
unique pserial if wave==2
* 561
drop if a30t06c==-1 & wave==1
unique pserial if wave==1
* 1553

* Physical activity
gen PA = a30to06 
replace PA =. if PA<0
replace PA = 0 if PA<4
replace PA = 1 if PA>=4 & PA<=19
replace PA = 2 if PA>=20 & PA!=.
replace t59s06b = . if t59s06b<0

* Smoking status 
tab cigst1
gen smoking = cigst1 
replace smoking = . if smoking<0
replace smoking = 0 if smoking==1
replace smoking = 1 if inlist(smoking,2,3)
replace smoking = 2 if smoking==4

* Alcohol consumption
tab alclimit 
gen alcohol = alclimit
replace alcohol = . if alcohol<0

* Self-reported health
tab genhelf

* BMI
gen BMI = bmivg4
replace BMI = . if BMI<0
replace BMI = 0 if inlist(BMI,1,2)
replace BMI = 1 if BMI==3
replace BMI = 2 if BMI==4

* Waist circumference
replace wstval = . if wstval<0
gen wc = 0 if wstval<=88 & sex==2
replace wc = 0 if wstval<=102 & sex==1
replace wc = 1 if wstval>88 & wstval!=. & sex==2
replace wc = 1 if wstval>102 & wstval!=. & sex==1

* Waist-to-hip ratio
replace whval = . if whval<0
sum whval,d
gen wh = 0 if whval<=0.9008876
replace wh = 1 if whval>0.9008876 & whval!=.

* Equivalized household income quintiles
tab eqv5
gen income = eqv5
replace income = . if income<0

* Five category NS-SEC
gen occupation = nssec5 
replace occupation = . if inlist(occupation,-1,99)

* Economic activity status 
tab econact
gen economic = econact
replace economic = . if economic<0
replace economic = 2 if inlist(economic,2,3,4)

* Limiting long-term illness
tab limitill
gen limiting = 0 if limitill==3
replace limiting = 1 if limitill==2
replace limiting = 2 if limitill==1

* Age
tab age

* 2004 IMD quintiles
tab imd2004

gen SES = 0 if inlist(imd2004,4,5)
replace SES = 1 if inlist(imd2004,1,2,3)

gen PAdi = 0 if inlist(PA,0,1)
replace PAdi = 1 if PA==2
save interimChaudhury.dta

log using 20241128Chaudhury.log 
keep if SES==0
unique pserial 
* 473
tab sex 
* 220 men, 253 women
tab PA smoking
tab PA alcohol 
tab PA genhelf 
tab PA BMI
tab PA wc 
tab PA wh 
tab t59s06b smoking
tab t59s06b alcohol 
tab t59s06b genhelf 
tab t59s06b BMI
tab t59s06b wc 
tab t59s06b wh 
clear 

use interimChaudhury.dta 
keep if SES==1
unique pserial 
* 1080
tab sex 
* 499 men, 581 women
tab PA smoking
tab PA alcohol 
tab PA genhelf 
tab PA BMI
tab PA wc 
tab PA wh 
tab t59s06b smoking
tab t59s06b alcohol 
tab t59s06b genhelf 
tab t59s06b BMI
tab t59s06b wc 
tab t59s06b wh 
clear 

log close

use interimChaudhury.dta 
keep if wave==2
unique pserial 
* 561

replace astppa01=. if astppa01<0
replace astppa02=. if astppa02<0
replace astppa03=. if astppa03<0
replace astppa04=. if astppa04<0
replace astppa05=. if astppa05<0
replace astppa06=. if astppa06<0
replace astppa07=. if astppa07<0
replace astppa08=. if astppa08<0
replace astppa09=. if astppa09<0
replace astppa10=. if astppa10<0
replace astppa11=. if astppa11<0

* Don't need to do more
tab astppa01 
* Work commitments
tab astppa02 
* Don't have enough leisure time
tab astppa03 
* Caring for children or older people
tab astppa04 
* Have no one to exercise with
tab astppa05 
* Don't have enough money
tab astppa06 
* No suitable places to do it in area
tab astppa07 
* Haven't got the right clothes or equipment
tab astppa08 
* Poor health or physical limitations
tab astppa09 
* Injuries which prevent
tab astppa10 
* None of these
tab astppa11 

replace aprvpa01=. if aprvpa01<0
replace aprvpa02=. if aprvpa02<0
replace aprvpa03=. if aprvpa03<0
replace aprvpa04=. if aprvpa04<0
replace aprvpa05=. if aprvpa05<0
replace aprvpa06=. if aprvpa06<0
replace aprvpa07=. if aprvpa07<0
replace aprvpa08=. if aprvpa08<0
replace aprvpa09=. if aprvpa09<0
replace aprvpa10=. if aprvpa10<0
replace aprvpa11=. if aprvpa11<0

* Not the sporty type
tab aprvpa01 
* Too shy or embarassed
tab aprvpa02 
* Worried about injury
tab aprvpa03 
* Too old
tab aprvpa04 
* Prefer to do other things
tab aprvpa05 
* Think exercise is a waste of time
tab aprvpa06 
* Too overweight
tab aprvpa07
* Not motivated to do more
tab aprvpa08
* Don't enjoy physical activity
tab aprvpa09 
* Something else
tab aprvpa10 
* None of these
tab aprvpa11

tab imd2007
drop SES
gen SES = 0 if inlist(imd2007,4,5)
replace SES = 1 if inlist(imd2007,1,2,3)

save interimChaudhury2.dta

log using 20241128Chaudhury.log, append
* Don't need to do more
tab astppa01 SES
* Work commitments
tab astppa02 SES
* Don't have enough leisure time
tab astppa03 SES
* Caring for children or older people
tab astppa04 SES
* Have no one to exercise with
tab astppa05 SES
* Don't have enough money
tab astppa06 SES
* No suitable places to do it in area
tab astppa07 SES
* Haven't got the right clothes or equipment
tab astppa08 SES
* Poor health or physical limitations
tab astppa09 SES
* Injuries which prevent
tab astppa10 SES
* None of these
tab astppa11 SES

* Not the sporty type
tab aprvpa01 SES
* Too shy or embarassed
tab aprvpa02 SES
* Worried about injury
tab aprvpa03 SES
* Too old
tab aprvpa04 SES
* Prefer to do other things
tab aprvpa05 SES
* Think exercise is a waste of time
tab aprvpa06 SES
* Too overweight
tab aprvpa07 SES
* Not motivated to do more
tab aprvpa08 SES
* Don't enjoy physical activity
tab aprvpa09 SES
* Something else
tab aprvpa10 SES
* None of these
tab aprvpa11 SES

log close