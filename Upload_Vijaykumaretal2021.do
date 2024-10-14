* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: McNeill, A., & Vijaykumar, S. (2020, November 19). Conflicting Nutrition Information. Retrieved from osf.io/zpa5b

* Date of data access/download (dd/mm/yyyy): 08/05/2023

cd ""
import delimited "Food and Nutrition Dataset.csv"
save rawVijaykumar.dta

keep participant age_group household_income exercise_frequency healthstatusr healthcon1  healthcon2 healthcon3 healthcon4 healthcon5 healthcon6 confusion1 confusion2 confusion3 backlash1 backlash2 backlash3 backlash4r backlash5r healthconsciousness confusion backlash
save Vijaykumar.dta
log using Vijaykumar20230508.log
sum
pwcorr healthstatusr exercise_frequency, sig
pwcorr healthconsciousness exercise_frequency, sig
pwcorr confusion exercise_frequency, sig
pwcorr backlash exercise_frequency, sig
tab healthstatusr
tab healthconsciousness 
tab confusion 
tab backlash 
tab exercise_frequency
sum healthstatusr
sum healthconsciousness 
sum confusion 
sum backlash 
sum exercise_frequency

tab age_group
keep if inlist(age_group,5,6)
unique participant 
* 206
tab household_income
gen income = 0 if inlist(household_income,1,2,3,4)
replace income = 1 if inlist(household_income,5,6)
save Vijaykumarage60.dta 

use Vijaykumarage60.dta
keep if age_group==6
unique participant 
* 109
save Vijaykumarage65.dta

keep if  income==0
unique participant 
* 61
pwcorr healthstatusr exercise_frequency, sig
pwcorr healthconsciousness exercise_frequency, sig
pwcorr confusion exercise_frequency, sig
pwcorr backlash exercise_frequency, sig
tab healthstatusr exercise_frequency
tab healthconsciousness exercise_frequency
tab confusion exercise_frequency
tab backlash exercise_frequency
clear 

use Vijaykumarage65.dta
keep if  income==1
unique participant 
* 48
pwcorr healthstatusr exercise_frequency, sig
pwcorr healthconsciousness exercise_frequency, sig
pwcorr confusion exercise_frequency, sig
pwcorr backlash exercise_frequency, sig
tab healthstatusr exercise_frequency
tab healthconsciousness exercise_frequency
tab confusion exercise_frequency
tab backlash exercise_frequency
clear 

import delimited "Food and Nutrition Dataset.csv"
keep participant age_group household_income exercise_frequency healthstatusr healthcon1  healthcon2 healthcon3 healthcon4 healthcon5 healthcon6 confusion1 confusion2 confusion3 backlash1 backlash2 backlash3 backlash4r backlash5r healthconsciousness confusion backlash internet tv newspapers_or_magazines family_friends_coworkers doctors_healthcare_professionals
save Vijaykumarfull.dta
sum
pwcorr internet exercise_frequency, sig
pwcorr tv exercise_frequency, sig
pwcorr newspapers_or_magazines exercise_frequency, sig
pwcorr family_friends_coworkers exercise_frequency, sig
pwcorr doctors_healthcare_professionals exercise_frequency, sig

tab age_group
keep if inlist(age_group,5,6)
unique participant 
* 206
tab household_income
gen income = 0 if inlist(household_income,1,2,3,4)
replace income = 1 if inlist(household_income,5,6)
save Vijaykumarfullage60.dta

use Vijaykumarfullage60.dta
keep if age_group==6
unique participant 
* 109
save Vijaykumarfullage65.dta

keep if  income==0
unique participant 
* 61
pwcorr internet exercise_frequency, sig
pwcorr tv exercise_frequency, sig
pwcorr newspapers_or_magazines exercise_frequency, sig
pwcorr family_friends_coworkers exercise_frequency, sig
pwcorr doctors_healthcare_professionals exercise_frequency, sig
tab internet exercise_frequency
tab tv exercise_frequency
tab newspapers_or_magazines exercise_frequency
tab family_friends_coworkers exercise_frequency
tab doctors_healthcare_professionals exercise_frequency
clear 

use Vijaykumarfullage65.dta
keep if  income==1
unique participant 
* 48
pwcorr internet exercise_frequency, sig
pwcorr tv exercise_frequency, sig
pwcorr newspapers_or_magazines exercise_frequency, sig
pwcorr family_friends_coworkers exercise_frequency, sig
pwcorr doctors_healthcare_professionals exercise_frequency, sig
tab internet exercise_frequency
tab tv exercise_frequency
tab newspapers_or_magazines exercise_frequency
tab family_friends_coworkers exercise_frequency
tab doctors_healthcare_professionals exercise_frequency
clear 
log close

import delimited "Food and Nutrition Dataset.csv"
log using Vijaykumar20230508.log, append
keep participant age_group household_income exercise_frequency serving_fruit_veg
save Vijaykumarfrandveg.dta
sum
pwcorr serving_fruit_veg exercise_frequency, sig
keep if inlist(age_group,5,6)
gen income = 0 if inlist(household_income,1,2,3,4)
replace income = 1 if inlist(household_income,5,6)
save Vijaykumarfrandvegage60.dta

use Vijaykumarfrandvegage60.dta
keep if age_group==6
unique participant
* 109
save Vijaykumarfrandvegage65.dta
keep if income==0
unique participant 
* 61
pwcorr serving_fruit_veg exercise_frequency, sig
tab serving_fruit_veg exercise_frequency
clear 
use Vijaykumarfrandvegage65.dta
keep if income==1
unique participant 
* 48
pwcorr serving_fruit_veg exercise_frequency, sig
tab serving_fruit_veg exercise_frequency
clear 
log close

use Vijaykumarage60.dta
merge 1:1 participant using rawVijaykumar.dta, gen(merge1)
keep if merge1==3
keep if age_group==6
tab income gender
* Low: 46 male, 15 female
* High: 43 male, 5 female
tab gender
* 89 male, 20 female