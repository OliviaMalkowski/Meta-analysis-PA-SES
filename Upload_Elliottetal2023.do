* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Elliott, L. R., White, M. P. (2022). BlueHealth International Survey Dataset, 2017-2018. [data collection]. UK Data Service. SN: 8874, DOI: http://doi.org/10.5255/UKDA-SN-8874-2

* Date of data access/download (dd/mm/yyyy): 11/01/2024

* Project ID: 237630

cd ""

use bis_v2_2017-18.dta
keep if flag_straightliner==1
keep if flag_homes_incongruent==1
keep if flag_times==1
keep if flag_homes==1

keep if country==11
sum id
* 1119

* Greenspace 
sum green_space_1000_pct
tab green_space_1000_3cats

gen GS_bi = 0 if inlist(green_space_1000_3cats,1,2)
replace GS_bi = 1 if green_space_1000_3cats==3

* Inland bluespace
sum freshwater_1000_pct
tab freshwater_1000_2cats

* Coastal bluespace
tab coast_prox_cats
gen CBS = 0 if inlist(coast_prox_cats,2,3,4,5)
replace CBS = 1 if coast_prox_cats==1

* Greenspace visits
tab green_weekly
tab green_monthly

tab local_park_4wk
tab large_park_4wk
tab community_garden_4wk
tab playground_4wk
tab cemetery_4wk
tab botanic_zoo_4wk
tab woodland_4wk
tab farmland_4wk
tab meadow_4wk
tab mountain_4wk
tab moorland_4wk
tab country_park_4wk

gen lop = 0 if local_park_4wk==1
replace lop = 1 if local_park_4wk==2
replace lop = 4 if local_park_4wk==3
replace lop = 8 if local_park_4wk==4

gen lap = 0 if large_park_4wk==1
replace lap = 1 if large_park_4wk==2
replace lap = 4 if large_park_4wk==3
replace lap = 8 if large_park_4wk==4

gen com = 0 if community_garden_4wk==1
replace com = 1 if community_garden_4wk==2
replace com = 4 if community_garden_4wk==3
replace com = 8 if community_garden_4wk==4

gen pla = 0 if playground_4wk==1
replace pla = 1 if playground_4wk==2
replace pla = 4 if playground_4wk==3
replace pla = 8 if playground_4wk==4

gen cem = 0 if cemetery_4wk==1
replace cem = 1 if cemetery_4wk==2
replace cem = 4 if cemetery_4wk==3
replace cem = 8 if cemetery_4wk==4

gen zoo = 0 if botanic_zoo_4wk==1
replace zoo = 1 if botanic_zoo_4wk==2
replace zoo = 4 if botanic_zoo_4wk==3
replace zoo = 8 if botanic_zoo_4wk==4

gen woo = 0 if woodland_4wk==1
replace woo = 1 if woodland_4wk==2
replace woo = 4 if woodland_4wk==3
replace woo = 8 if woodland_4wk==4

gen far = 0 if farmland_4wk==1
replace far = 1 if farmland_4wk==2
replace far = 4 if farmland_4wk==3
replace far = 8 if farmland_4wk==4

gen mea = 0 if meadow_4wk==1
replace mea = 1 if meadow_4wk==2
replace mea = 4 if meadow_4wk==3
replace mea = 8 if meadow_4wk==4

gen mou = 0 if mountain_4wk==1
replace mou = 1 if mountain_4wk==2
replace mou = 4 if mountain_4wk==3
replace mou = 8 if mountain_4wk==4

gen moo = 0 if moorland_4wk==1
replace moo = 1 if moorland_4wk==2
replace moo = 4 if moorland_4wk==3
replace moo = 8 if moorland_4wk==4

gen cou = 0 if country_park_4wk==1
replace cou = 1 if country_park_4wk==2
replace cou = 4 if country_park_4wk==3
replace cou = 8 if country_park_4wk==4

gen GSV = lop + lap + com + pla + cem + zoo + woo + far + mea + mou + moo + cou

gen GSV_processed = GSV
replace GSV_processed = 56 if GSV_processed >56 & GSV_processed != .

gen GSV_2 = GSV_processed/2
tab GSV_2 
sum GSV_2
sum GSV_2,d 
gen GSV_2_bi = 0 if GSV_2<=2
replace GSV_2_bi = 1 if GSV_2>2 & GSV_2!=.

* Inland bluespace visits
tab inland_weekly
tab inland_monthly

tab lake_4wk
tab urban_river_4wk
tab rural_river_4wk
tab waterfall_4wk
tab pond_4wk
tab wetland_4wk

gen lak = 0 if lake_4wk==1
replace lak = 1 if lake_4wk==2
replace lak = 4 if lake_4wk==3
replace lak = 8 if lake_4wk==4

gen urb = 0 if urban_river_4wk==1
replace urb = 1 if urban_river_4wk==2
replace urb = 4 if urban_river_4wk==3
replace urb = 8 if urban_river_4wk==4

gen rur = 0 if rural_river_4wk==1
replace rur = 1 if rural_river_4wk==2
replace rur = 4 if rural_river_4wk==3
replace rur = 8 if rural_river_4wk==4

gen wat = 0 if waterfall_4wk==1
replace wat = 1 if waterfall_4wk==2
replace wat = 4 if waterfall_4wk==3
replace wat = 8 if waterfall_4wk==4

gen pon = 0 if pond_4wk==1
replace pon = 1 if pond_4wk==2
replace pon = 4 if pond_4wk==3
replace pon = 8 if pond_4wk==4

gen wet = 0 if wetland_4wk==1
replace wet = 1 if wetland_4wk==2
replace wet = 4 if wetland_4wk==3
replace wet = 8 if wetland_4wk==4

gen IBSV = lak + urb + rur + wat + pon + wet

gen IBSV_processed = IBSV
replace IBSV_processed = 56 if IBSV_processed >56 & IBSV_processed != .

gen IBSV_2 = IBSV_processed/2
tab IBSV_2 
sum IBSV_2
sum IBSV_2,d 
gen IBSV_2_bi = 0 if IBSV_2<=0.5
replace IBSV_2_bi = 1 if IBSV_2>0.5 & IBSV_2!=.

* Coastal bluespace visits
tab coast_weekly
tab coast_monthly

tab esplanade_4wk
tab pier_4wk
tab harbour_4wk
tab beach_4wk
tab rocky_shore_4wk
tab cliff_4wk
tab lagoon_4wk
tab sea_4wk

gen esp = 0 if esplanade_4wk==1
replace esp = 1 if esplanade_4wk==2
replace esp = 4 if esplanade_4wk==3
replace esp = 8 if esplanade_4wk==4

gen pie = 0 if pier_4wk==1
replace pie = 1 if pier_4wk==2
replace pie = 4 if pier_4wk==3
replace pie = 8 if pier_4wk==4

gen har = 0 if harbour_4wk==1
replace har = 1 if harbour_4wk==2
replace har = 4 if harbour_4wk==3
replace har = 8 if harbour_4wk==4

gen bea = 0 if beach_4wk==1
replace bea = 1 if beach_4wk==2
replace bea = 4 if beach_4wk==3
replace bea = 8 if beach_4wk==4

gen roc = 0 if rocky_shore_4wk==1
replace roc = 1 if rocky_shore_4wk==2
replace roc = 4 if rocky_shore_4wk==3
replace roc = 8 if rocky_shore_4wk==4

gen cli = 0 if cliff_4wk==1
replace cli = 1 if cliff_4wk==2
replace cli = 4 if cliff_4wk==3
replace cli = 8 if cliff_4wk==4

gen lag = 0 if lagoon_4wk==1
replace lag = 1 if lagoon_4wk==2
replace lag = 4 if lagoon_4wk==3
replace lag = 8 if lagoon_4wk==4

gen sea = 0 if sea_4wk==1
replace sea = 1 if sea_4wk==2
replace sea = 4 if sea_4wk==3
replace sea = 8 if sea_4wk==4

gen CBSV = esp + pie + har + bea + roc + cli + lag + sea

gen CBSV_processed = CBSV
replace CBSV_processed = 56 if CBSV_processed >56 & CBSV_processed != .

gen CBSV_2 = CBSV_processed/2
tab CBSV_2 
sum CBSV_2
sum CBSV_2,d 
gen CBSV_2_bi = 0 if CBSV_2<=0
replace CBSV_2_bi = 1 if CBSV_2>0 & CBSV_2!=.

* Physical activity
tab physical_activity
sum physical_activity
gen PA = physical_activity*2
tab PA 
sum PA
gen PA_bi = 0 if PA<10
replace PA_bi = 1 if PA>=10 & PA!=.

* Sex 
tab sex
* 622 female, 497 male

* Age 
tab age
tab age_sex

* Highest educational attainment 
tab education
gen SES_ed = 0 if inlist(education,1,2,3)
replace SES_ed = 1 if education==4

* Reported comfort with current household income
tab income_perceived
tab household_income
gen SES_inc = 0 if inlist(income_perceived,1,2)
replace SES_inc = 1 if inlist(income_perceived,3,4)

save Elliottfull.dta

keep if age==5
unique id 
* 419
save Elliott60.dta 

log using 20240111Elliott.log 

use Elliott60.dta 
tab sex
* 228 female, 191 male
keep if SES_inc==0
unique id 
* 52
tab sex 
* 30 female, 22 male
tab GS_bi PA_bi
tab freshwater_1000_2cats PA_bi
tab CBS PA_bi
tab GSV_2_bi PA_bi 
tab IBSV_2_bi PA_bi 
tab CBSV_2_bi PA_bi 
bysort GS_bi: sum PA 
bysort freshwater_1000_2cats: sum PA 
bysort CBS: sum PA 
bysort GSV_2_bi: sum PA 
bysort IBSV_2_bi: sum PA 
bysort CBSV_2_bi: sum PA 
pwcorr PA green_space_1000_pct, sig obs
pwcorr PA freshwater_1000_2cats, sig obs
pwcorr PA CBS, sig obs
pwcorr PA GSV_2, sig obs
pwcorr PA IBSV_2, sig obs
pwcorr PA CBSV_2, sig obs
clear 

use Elliott60.dta 
keep if SES_inc==1
unique id 
* 366
tab sex 
* 197 female, 169 male
tab GS_bi PA_bi
tab freshwater_1000_2cats PA_bi
tab CBS PA_bi
tab GSV_2_bi PA_bi 
tab IBSV_2_bi PA_bi 
tab CBSV_2_bi PA_bi 
bysort GS_bi: sum PA 
bysort freshwater_1000_2cats: sum PA 
bysort CBS: sum PA 
bysort GSV_2_bi: sum PA 
bysort IBSV_2_bi: sum PA 
bysort CBSV_2_bi: sum PA 
pwcorr PA green_space_1000_pct, sig obs
pwcorr PA freshwater_1000_2cats, sig obs
pwcorr PA CBS, sig obs
pwcorr PA GSV_2, sig obs
pwcorr PA IBSV_2, sig obs
pwcorr PA CBSV_2, sig obs
clear 

log close

log using 20240115Elliott.log 

use Elliott60.dta
keep if SES_inc==0
unique id 
* 52
tab sex 
* 30 female, 22 male
tab GS_bi PA_bi [aw=weight_var]
tab freshwater_1000_2cats PA_bi [aw=weight_var]
tab CBS PA_bi [aw=weight_var]
tab GSV_2_bi PA_bi [aw=weight_var]
tab IBSV_2_bi PA_bi [aw=weight_var]
tab CBSV_2_bi PA_bi [aw=weight_var]
bysort GS_bi: sum PA [aw=weight_var]
bysort freshwater_1000_2cats: sum PA [aw=weight_var]
bysort CBS: sum PA [aw=weight_var]
bysort GSV_2_bi: sum PA [aw=weight_var]
bysort IBSV_2_bi: sum PA [aw=weight_var]
bysort CBSV_2_bi: sum PA [aw=weight_var]
pwcorr PA green_space_1000_pct [aw=weight_var], sig obs
pwcorr PA freshwater_1000_2cats [aw=weight_var], sig obs
pwcorr PA CBS [aw=weight_var], sig obs
pwcorr PA GSV_2 [aw=weight_var], sig obs
pwcorr PA IBSV_2 [aw=weight_var], sig obs
pwcorr PA CBSV_2 [aw=weight_var], sig obs
clear 

use Elliott60.dta 
keep if SES_inc==1
unique id 
* 366
tab sex 
* 197 female, 169 male
tab GS_bi PA_bi [aw=weight_var]
tab freshwater_1000_2cats PA_bi [aw=weight_var]
tab CBS PA_bi [aw=weight_var]
tab GSV_2_bi PA_bi [aw=weight_var]
tab IBSV_2_bi PA_bi [aw=weight_var]
tab CBSV_2_bi PA_bi [aw=weight_var]
bysort GS_bi: sum PA [aw=weight_var]
bysort freshwater_1000_2cats: sum PA [aw=weight_var]
bysort CBS: sum PA [aw=weight_var]
bysort GSV_2_bi: sum PA [aw=weight_var]
bysort IBSV_2_bi: sum PA [aw=weight_var]
bysort CBSV_2_bi: sum PA [aw=weight_var]
pwcorr PA green_space_1000_pct [aw=weight_var], sig obs
pwcorr PA freshwater_1000_2cats [aw=weight_var], sig obs
pwcorr PA CBS [aw=weight_var], sig obs
pwcorr PA GSV_2 [aw=weight_var], sig obs
pwcorr PA IBSV_2 [aw=weight_var], sig obs
pwcorr PA CBSV_2 [aw=weight_var], sig obs
clear 

log close