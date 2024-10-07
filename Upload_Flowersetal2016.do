* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Gladwell, Valerie (2016). Green exercise: The combined effect of the environment and exercise on physical activity and health. [Data Collection]. Colchester, Essex: UK Data Archive. 10.5255/UKDA-SN-852253

* Date of data access/download (dd/mm/yyyy): 08/05/2023

cd ""

import spss using PhysicalActivity_Greenspace.sav

keep ID Age Health Gender ActTrW ActTrGS MEDIxR Access Quality RoadPer NRelate LocalGS GSVisits PA_Guidelines Income
log using Flowers20230508.log
sum
logit PA_Guidelines Age Health Gender ActTrW ActTrGS MEDIxR Access Quality RoadPer NRelate LocalGS, or
logit PA_Guidelines Age Health Gender i.GSVisits, or

keep if Age>=60
unique ID
* 194
logit PA_Guidelines Age Health Gender ActTrW ActTrGS MEDIxR Access Quality RoadPer NRelate LocalGS, or
logit PA_Guidelines Age Health Gender i.GSVisits, or

tab Income
gen SES = 0 if inlist(Income,1,2,3,4)
replace SES = 1 if inlist(Income,5,6,7,8,9,10,11)
sum RoadPer,d
sum NRelate,d 
sum LocalGS,d
gen RoadMed = 0 if RoadPer<7.305
replace RoadMed = 1 if RoadPer>=7.305 & RoadPer!=.
gen NRelateMed = 0 if NRelate<3.642857
replace NRelateMed = 1 if NRelate>=3.642857 & NRelate!=.
gen LocalGSMed = 0 if LocalGS<60.93146 
replace LocalGSMed = 1 if LocalGS>=60.93146 & LocalGS!=.
save Flowersage60.dta

keep if SES==0
unique ID
* 55
tab Gender 
* 25 male, 30 female
logit PA_Guidelines Age Health Gender ActTrW ActTrGS MEDIxR Access Quality RoadPer NRelate LocalGS, or
logit PA_Guidelines Age Health Gender i.GSVisits, or
tab PA_Guidelines Health
tab PA_Guidelines MEDIxR
tab PA_Guidelines Access
tab PA_Guidelines Quality
tab PA_Guidelines GSVisits

tab PA_Guidelines RoadMed
tab PA_Guidelines NRelateMed 
tab PA_Guidelines LocalGSMed
clear 

use Flowersage60.dta
keep if SES==1
unique ID
* 107
tab Gender 
* 68 male, 39 female
logit PA_Guidelines Age Health Gender ActTrW ActTrGS MEDIxR Access Quality RoadPer NRelate LocalGS, or
logit PA_Guidelines Age Health Gender i.GSVisits, or
tab PA_Guidelines Health
tab PA_Guidelines MEDIxR
tab PA_Guidelines Access
tab PA_Guidelines Quality
tab PA_Guidelines GSVisits

tab PA_Guidelines RoadMed
tab PA_Guidelines NRelateMed 
tab PA_Guidelines LocalGSMed
clear

import spss using PhysicalActivity_Greenspace.sav
keep ID Age Health Gender ActTrW ActTrGS MEDIxR Access Quality RoadPer NRelate LocalGS GSVisits PA_Guidelines Income
save Flowers.dta

keep if Quality !=. & Access !=. & LocalGS!=. & MEDIxR !=. & ActTrW !=. & ActTrGS !=. &  RoadPer!=.
unique ID
sum
save Flowersmissing.dta