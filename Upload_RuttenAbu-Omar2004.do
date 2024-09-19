* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Europäische Kommission (2012). Eurobarometer 58.2 (Oct-Dec 2002). GESIS Data Archive, Cologne. ZA3886 Data file Version 1.0.1, https://doi.org/10.4232/1.10954.

* Date of data access/download (dd/mm/yyyy): 14/03/2023

cd ""
use ZA3886_v1-0-1.dta

keep v4 v5 v6 v7 v34 v224 v225 v226 v227 v228 v229 v230 v231 v232 v233 v234 v235 v236 v237 v238 v239 v240 v241 v355 v356 v357 v358 v364 v365 v373 v382 v383 v397 isocntry

gen hdayvig = v226/60
gen hdaymod = v229/60 
gen hdaywalk = v232/60 
gen hdaysit = v234/60

gen hwkvig = hdayvig * v224 
replace hwkvig = 0 if v224==0
replace hwkvig = 0 if v226==.i
gen hwkmod = hdaymod * v227 
replace hwkmod = 0 if v227==0
replace hwkmod = 0 if v229==.i
gen hwkwalk = hdaywalk * v230
replace hwkwalk = 0 if v230==0
replace hwkwalk = 0 if v232==.i
gen missing = hwkvig + hwkmod + hwkwalk

gen METvig = hwkvig * 8
gen METmod = hwkmod * 4
gen METwalk = hwkwalk * 3.3

replace METvig = -1 if v226==.n | v224==.n
replace METmod = -1 if v229==.n | v227==.n
replace METwalk = -1 if v232==.n | v230==.n
gen MET = METvig + METmod + METwalk

replace METvig = 0 if METvig==-1
replace METmod = 0 if METmod==-1
replace METwalk = 0 if METwalk==-1
gen METhrwk = METvig + METmod + METwalk

gen quartiles = 1 if METhrwk>=0 & METhrwk<=8
replace quartiles = 2 if METhrwk>8 & METhrwk<=24
replace quartiles = 3 if METhrwk>24 & METhrwk<=51.1
replace quartiles = 4 if METhrwk>51.1 & METhrwk!=.

replace v239 = 5 if v239==.d
replace v240 = 5 if v240==.d
replace v241 = 5 if v241==.d

gen area = 1 if inlist(v239,1,2)
replace area = 0 if inlist(v239,3,4,5)
gen clubs = 1 if inlist(v240,1,2)
replace clubs = 0 if inlist(v240,3,4,5)
gen authority = 1 if inlist(v241,1,2)
replace authority = 0 if inlist(v241,3,4,5)

keep if isocntry=="GB-GBN"
log using Abu-Omar.log
tab area quartiles
tab clubs quartiles 
tab authority quartiles
tab v239 quartiles
tab v240 quartiles 
tab v241 quartiles

keep if v356>=60
unique v5
tab area quartiles if inlist(v383,1,2)
tab clubs quartiles if inlist(v383,1,2)
tab authority quartiles if inlist(v383,1,2)
tab v239 quartiles if inlist(v383,1,2)
tab v240 quartiles if inlist(v383,1,2)
tab v241 quartiles if inlist(v383,1,2)

tab area quartiles if inlist(v383,3,4)
tab clubs quartiles if inlist(v383,3,4)
tab authority quartiles if inlist(v383,3,4)
tab v239 quartiles if inlist(v383,3,4)
tab v240 quartiles if inlist(v383,3,4)
tab v241 quartiles if inlist(v383,3,4)
log close
save 34876.dta
tab v355 
* 74 male, 114 female

tab v355 if inlist(v383,1,2)
* 31 male, 46 female
tab v355 if inlist(v383,3,4)
* 18 male, 11 female