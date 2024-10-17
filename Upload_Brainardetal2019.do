* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Sport England. (2023). Active Lives Survey, 2016-2017. [data collection]. UK Data Service. SN: 8391, DOI: http://doi.org/10.5255/UKDA-SN-8391-1

* Date of data access/download (dd/mm/yyyy): 28/02/2023

* Project ID: 237630

cd ""
use serial mode Type age16plus age19plus wt_final wt_final_online wt_time wt_online_time wt_final_B wt_final_C wt_final_AC AGE Age17 Age9 Age5 Age4 Age3 Age2 Age1460 BMIG Disab3 Disab2_POP Impair4 IMD10 IMD4 Gend3 Child4 UrbRur2 UrbRur6_LA UrbRur6 UrbRur10 WorkStat10 WorkStat7 WorkStat5 Quarter happy anxious worthw indev WellB_Happy_GR WellB_Anxious_GR WellB_Worthw_GR InDev_GR lifesat WellB_Lifesat_GR MEMS7_CYC1 DURATION_cyc1_1 MEMS7_cyc1_1 DURATION_walk1_1 MEMS7_walk1_1 DURATION_WALKTRAV_B02 DURATIONGR_WALKTRAV_B02 MEMS7GR_WALKTRAV_B02 DURATION_CYCTRAV_B04 DURATIONGR_CYCTRAV_B04 MEMS7_CYCTRAV_B04 MEMS7GR_CYCTRAV_B04 DURATION_ACTTRAV_C03 DURATIONGR_ACTTRAV_C03 MEMS7_ACTTRAV_C03 MEMS7GR_ACTTRAV_C03 using 20180514_active_lives_survey_year_2_data_shared.dta

unique serial
* 199886
drop if AGE<16
unique serial 
* 194810
drop if Gend3==.
drop if Gend3<0
unique serial 
* 194756
save rawBrainard.dta 

* Age - collapsed 95 and above
tab AGE 
gen age = AGE

* BMIG - can't eliminate <16
gen BMI = BMIG 
replace BMI = . if BMI<0
replace BMI = 0 if inlist(BMI,1,2)
replace BMI = 1 if BMI==3
replace BMI = 2 if inlist(BMI,4,5)

* Impairment - correct
gen limiting = Disab3 
replace limiting = . if limiting<0
replace limiting = 0 if inlist(limiting,2,3)

* Sex 
gen sex = Gend3 
replace sex = 0 if sex==2

* IMD 2015 - correct 
gen IMD = IMD10 
replace IMD = . if IMD<0 

* Child# - correct
gen children = Child4 
replace children = . if children<0
replace children = 0 if children==1
replace children = 1 if children==2
replace children = 2 if children==3
replace children = 3 if children==4

* Rural/urban - correct
gen urbrur = UrbRur6 
replace urbrur = . if urbrur<0

* Working status - correct
gen work = WorkStat10 
replace work = . if work<0
replace work = . if inlist(work,3,4,6,7,8,9,10)
replace work = 0 if work==1
replace work = 1 if work==2 
replace work = 2 if work==5

* Quarter - correct
gen season = Quarter
replace season = 0 if season==5
replace season = 1 if season==6
replace season = 2 if season==7
replace season = 3 if season==8

* Happy - correct 
gen Happiness = happy 
replace Happiness = . if Happiness<0 

* Anxious - correct 
gen Anxious = anxious 
replace Anxious = . if Anxious<0 

* Worthwhile - correct 
gen Worthwhile = worthw 
replace Worthwhile = . if Worthwhile<0 

* Life satisfaction - correct
gen Satisfaction = lifesat 
replace Satisfaction = . if Satisfaction<0 

* Can't achieve goals - correct
gen goals = indev
replace goals = . if goals<0
replace goals = . if inlist(goals,6,7)

* Active travel - walking 
gen Age7 = Age9 
replace Age7 = 0 if Age7==2
replace Age7 = 1 if Age7==3
replace Age7 = 2 if Age7==4
replace Age7 = 3 if Age7==5
replace Age7 = 4 if Age7==6
replace Age7 = 5 if Age7==7
replace Age7 = 6 if inlist(Age7,8,9)

gen MEMS7_walk = MEMS7_walk1_1 
replace MEMS7_walk = . if MEMS7_walk>3360

gen cat_walk = MEMS7_walk 
replace cat_walk = 0 if cat_walk<30
replace cat_walk = 1 if cat_walk >=30 & cat_walk <150
replace cat_walk = 2 if cat_walk >=150 & cat_walk!=.

tab MEMS7GR_WALKTRAV_B02 

* Active travel - cycling 
gen MEMS7_cycling = MEMS7_cyc1_1 
replace MEMS7_cycling = . if MEMS7_cycling>3360

gen cat_cycling = MEMS7_cycling
replace cat_cycling = 0 if cat_cycling<30
replace cat_cycling = 1 if cat_cycling >=30 & cat_cycling <150
replace cat_cycling = 2 if cat_cycling >=150 & cat_cycling!=.

tab MEMS7GR_CYCTRAV_B04 

gen MEMS7_cyctrav = MEMS7_CYCTRAV_B04
replace MEMS7_cyctrav = . if MEMS7_cyctrav>3360

gen cat_cyctrav = MEMS7_cyctrav
replace cat_cyctrav = 0 if cat_cyctrav<30
replace cat_cyctrav = 1 if cat_cyctrav >=30 & cat_cyctrav <150
replace cat_cyctrav = 2 if cat_cyctrav >=150 & cat_cyctrav!=.

* Active travel - general
gen MEMS7_acttrav = MEMS7_ACTTRAV_C03
replace MEMS7_acttrav = . if MEMS7_acttrav>3360

gen cat_acttrav = MEMS7_acttrav
replace cat_acttrav = 0 if cat_acttrav<30
replace cat_acttrav = 1 if cat_acttrav >=30 & cat_acttrav <150
replace cat_acttrav = 2 if cat_acttrav >=150 & cat_acttrav!=.

tab MEMS7GR_ACTTRAV_C03

bysort Age7: sum MEMS7_acttrav 
tab Age7 cat_acttrav 

save fullBrainard.dta 

keep serial age BMI limiting sex IMD children urbrur UrbRur6 work season Happiness Anxious Worthwhile Satisfaction goals Age7 MEMS7_walk cat_walk MEMS7GR_WALKTRAV_B02 MEMS7_cycling cat_cycling MEMS7GR_CYCTRAV_B04 MEMS7_cyctrav cat_cyctrav MEMS7_acttrav cat_acttrav MEMS7GR_ACTTRAV_C03

nbreg MEMS7_walk age i.sex i.limiting IMD children i.work i.urbrur i.season, irr
nbreg MEMS7_walk age i.sex IMD children i.work i.urbrur i.season goals, irr
nbreg MEMS7_cycling age i.sex i.limiting children i.work i.urbrur i.season i.BMI, irr

keep if age>=60
unique serial 
* 75716

gen SES = 0 if inlist(IMD,6,7,8,9,10)
replace SES = 1 if inlist(IMD,1,2,3,4,5)
save Brainardage60.dta 

sum Happiness,d
gen hapbi = 0 if inlist(Happiness,0,1,2,3,4,5,6,7,8)
replace hapbi = 1 if inlist(Happiness,9,10)

sum Anxious,d 
gen anxbi = 0 if inlist(Anxious,0,1,2)
replace anxbi = 1 if inlist(Anxious,3,4,5,6,7,8,9,10)

sum Worthwhile,d
gen worbi = 0 if inlist(Worthwhile,0,1,2,3,4,5,6,7,8)
replace worbi = 1 if inlist(Worthwhile,9,10)

sum Satisfaction,d
gen satbi = 0 if inlist(Satisfaction,0,1,2,3,4,5,6,7,8)
replace satbi = 1 if inlist(Satisfaction,9,10)

gen BMIbi = BMI 
replace BMIbi = 1 if BMIbi==2

gen goalsbi = 0 if inlist(goals,1,2) 
replace goalsbi = 1 if inlist(goals,3,4,5)

save Brainardage60.dta, replace

log using 20230523Brainard.log 
keep if SES==0
unique serial 
* 33445
nbreg MEMS7_walk age i.sex children i.work i.urbrur i.season goals, irr

bysort BMIbi: sum MEMS7_walk 
bysort hapbi: sum MEMS7_walk 
bysort anxbi: sum MEMS7_walk 
bysort worbi: sum MEMS7_walk 
bysort satbi: sum MEMS7_walk 
bysort goalsbi: sum MEMS7_walk 
tab BMIbi cat_walk 
tab hapbi cat_walk 
tab anxbi cat_walk 
tab worbi cat_walk 
tab satbi cat_walk 
tab goalsbi cat_walk 
tab BMI cat_walk 
tab Happiness cat_walk 
tab Anxious cat_walk 
tab Worthwhile cat_walk 
tab Satisfaction cat_walk 
tab goals cat_walk 
clear 

use Brainardage60.dta 
keep if SES==1 
unique serial 
* 42271
nbreg MEMS7_walk age i.sex children i.work i.urbrur i.season goals, irr

bysort BMIbi: sum MEMS7_walk 
bysort hapbi: sum MEMS7_walk 
bysort anxbi: sum MEMS7_walk 
bysort worbi: sum MEMS7_walk 
bysort satbi: sum MEMS7_walk 
bysort goalsbi: sum MEMS7_walk 
tab BMIbi cat_walk 
tab hapbi cat_walk 
tab anxbi cat_walk 
tab worbi cat_walk 
tab satbi cat_walk 
tab goalsbi cat_walk 
tab BMI cat_walk 
tab Happiness cat_walk 
tab Anxious cat_walk 
tab Worthwhile cat_walk 
tab Satisfaction cat_walk 
tab goals cat_walk 
clear 

use Brainardage60.dta
tab sex
* 38,831 female, 36,885 male
keep if SES==0 
unique serial 
* 33445
tab sex
* 17541 female, 15904 male
nbreg MEMS7_walk age i.sex i.limiting children i.work i.urbrur i.season i.BMI Happiness Anxious Worthwhile Satisfaction goals, irr
nbreg MEMS7_walk age i.sex i.limiting children IMD i.work i.urbrur i.season i.BMI Happiness Anxious Worthwhile Satisfaction goals, irr
nbreg MEMS7_cycling age i.sex i.limiting children i.work i.urbrur i.season i.BMI Happiness Anxious Worthwhile Satisfaction goals, irr
nbreg MEMS7_cycling age i.sex i.limiting children IMD i.work i.urbrur i.season i.BMI Happiness Anxious Worthwhile Satisfaction goals, irr
clear 

use Brainardage60.dta 
keep if SES==1 
unique serial 
* 42271
tab sex 
* 21290 female, 20981 male
nbreg MEMS7_walk age i.sex i.limiting children i.work i.urbrur i.season i.BMI Happiness Anxious Worthwhile Satisfaction goals, irr
nbreg MEMS7_walk age i.sex i.limiting children IMD i.work i.urbrur i.season i.BMI Happiness Anxious Worthwhile Satisfaction goals, irr
nbreg MEMS7_cycling age i.sex i.limiting children i.work i.urbrur i.season i.BMI Happiness Anxious Worthwhile Satisfaction goals, irr
nbreg MEMS7_cycling age i.sex i.limiting children IMD i.work i.urbrur i.season i.BMI Happiness Anxious Worthwhile Satisfaction goals, irr
clear 

log close