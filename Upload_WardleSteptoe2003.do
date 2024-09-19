* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Office for National Statistics, Social Survey Division. (2002). ONS Omnibus Survey, September 2000. [data collection]. UK Data Service. SN: 4531, DOI: http://doi.org/10.5255/UKDA-SN-4531-1

* Date of data access/download (dd/mm/yyyy): 26/05/2023

* Project ID: 237630

cd ""

use serial respsex respage hhtypb hhtypa hhtype wrking yinact dvilo3a dvilo4a everwk sc1 seggrp agex ageh wta m267_1 m267_2 m267_3 m267_4 m267_5 m267_6a m267_6b m267_6c m267_6d m267_6e m267_6f m267_6g m267_6h m267_6i m267_7 m267_8 m267_9a m267_9b m267_9c m267_9d m267_9e m267_9f m267_9g m267_10 m267_10r m267_11 m267_11r using a0009267.dta 
save ONSWarSt.dta 

unique serial 
* 1691

* Social class
gen class = sc1
replace class = 0 if inlist(class,1,2)
replace class = 2 if inlist(class,4,5)
replace class = . if inlist(class,6,7)
replace class = 1 if ! inlist(class,0,2) & class!=.

gen SES = 0 if class==2
replace SES = 1 if inlist(class,0,1)

* Age 
gen age = 0 if respage<35
replace age = 1 if respage>=35 & respage<50
replace age = 2 if respage>=50 & respage<65
replace age = 3 if respage>=65
tab age if respsex==1
tab age if respsex==2

* Sex 
tab respsex

* Self-rated health
tab m267_5
gen health = m267_5
replace health = 0 if inlist(health,1,2,3)
replace health = 1 if inlist(health,4,5)
replace health = . if health==8

* Physical activity
tab m267_2
gen PA = m267_2
replace PA = . if PA==8
replace PA = 0 if PA==1
replace PA = 1 if PA==2

gen PAr = PA 
replace PAr = 2 if PAr==0
replace PAr = 0 if PAr==1
replace PAr = 1 if PAr==2

* Internal locus of control
tab m267_6a
replace m267_6a = . if inlist(m267_6a,8,9)
tab m267_6d
replace m267_6d = . if inlist(m267_6d,8,9)
tab m267_6g
replace m267_6g = . if inlist(m267_6g,8,9)
gen internal = (m267_6a+m267_6d+m267_6g)/3

* Chance locus of control
tab m267_6b
replace m267_6b = . if inlist(m267_6b,8,9)
tab m267_6f
replace m267_6f = . if inlist(m267_6f,8,9)
tab m267_6i 
replace m267_6i = . if inlist(m267_6i,8,9)
gen chance = (m267_6b+m267_6f+m267_6i)/3
gen chabi = 0 if chance<3
replace chabi = 1 if chance>=3 & chance!=.

* Future salience
tab m267_9a 
replace m267_9a = . if inlist(m267_9a,8,9)
tab m267_9b 
replace m267_9b = . if inlist(m267_9b,8,9)
tab m267_9c 
replace m267_9c = . if inlist(m267_9c,8,9)
tab m267_9d 
replace m267_9d = . if inlist(m267_9d,8,9)
tab m267_9e 
replace m267_9e = . if inlist(m267_9e,8,9)
tab m267_9f 
replace m267_9f = . if inlist(m267_9f,8,9)
tab m267_9g
replace m267_9g = . if inlist(m267_9g,8,9)
gen salience = 1 if inlist(m267_9a,1,2) & inlist(m267_9b,1,2) & inlist(m267_9c,1,2) & inlist(m267_9d,1,2) & inlist(m267_9e,1,2) & inlist(m267_9f,1,2) & inlist(m267_9g,1,2)
replace salience = 0 if salience!=1 & m267_9a!=. & m267_9b!=. & m267_9c!=. & m267_9d!=. & m267_9e!=. & m267_9f!=. & m267_9g!=.

* Longevity 
tab m267_10 
tab m267_10r 
tab m267_11 
tab m267_11r

gen longevity = m267_10r
replace longevity = . if inlist(longevity,998,999)
gen lonbi = 0 if inlist(longevity,3,4,5)
replace lonbi = 1 if inlist(longevity,1,2)
replace lonbi = . if respage>75
gen lonbi2 = 0 if inlist(longevity,3,4,5)
replace lonbi2 = 1 if inlist(longevity,1,2)

* Health consciousness
tab m267_7
gen consc = m267_7
replace consc = 0 if inlist(consc,1,2,3,4)
replace consc = 1 if inlist(consc,5,6,7,8)
replace consc = . if inlist(consc,98,99)
tab m267_8

bysort respsex: tab class health
bysort respsex: tab class chabi
bysort respsex: tab class salience
bysort respsex: tab class lonbi
bysort respsex: tab class lonbi2
bysort respsex: tab class consc

save interimWarSte.dta

logit PA i.age i.respsex i.health i.chabi i.salience i.lonbi i.consc, or

keep if respage>=60
unique serial 
* 550
save WarSteage60.dta 
tab respsex
* 242 male, 308 female

log using 20230601WarSte.log

keep if SES==0
unique serial 
* 132
tab respsex
* 43 male, 89 female
logit PA respage i.respsex i.health i.chabi i.salience i.lonbi i.consc, or
logit PA respage i.respsex i.health i.chabi i.salience i.lonbi2 i.consc, or
logit PA i.health, or
logit PA i.chabi, or
logit PA i.salience, or
logit PA i.lonbi, or
logit PA i.lonbi2, or
logit PA i.consc, or
tab PA health
tab PA chabi 
tab PA salience 
tab PA lonbi 
tab PA lonbi2
tab PA consc
tab PAr health
tab PAr chabi 
tab PAr salience 
tab PAr lonbi 
tab PAr lonbi2
tab PAr consc
clear

use WarSteage60.dta
keep if SES==1
unique serial 
* 384
tab respsex
* 187 male, 197 female
logit PA respage i.respsex i.health i.chabi i.salience i.lonbi i.consc, or
logit PA respage i.respsex i.health i.chabi i.salience i.lonbi2 i.consc, or
logit PA i.health, or
logit PA i.chabi, or
logit PA i.salience, or
logit PA i.lonbi, or
logit PA i.lonbi2, or
logit PA i.consc, or
tab PA health
tab PA chabi 
tab PA salience 
tab PA lonbi 
tab PA lonbi2
tab PA consc
tab PAr health
tab PAr chabi 
tab PAr salience 
tab PAr lonbi 
tab PAr lonbi2
tab PAr consc
clear

log close