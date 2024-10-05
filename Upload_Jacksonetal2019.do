* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Banks, J., Batty, G. David, Breedvelt, J., Coughlin, K., Crawford, R., Marmot, M., Nazroo, J., Oldfield, Z., Steel, N., Steptoe, A., Wood, M., Zaninotto, P. (2021). English Longitudinal Study of Ageing: Waves 0-9, 1998-2019. [data collection]. 37th Edition. UK Data Service. SN: 5050, DOI: http://doi.org/10.5255/UKDA-SN-5050-24

* Project ID: 237630

cd ""

* Variables Wave 6
bus pass holder, age, how often used bus pass, marital status, PA, nonpension household wealth, limiting long-standing illness, sx
use idauniq samptyp indager DhSex DiSex indsex couple DiMar HeActa HeActb HeActc SpBsPs SpBsTm Heill Helim finstatw6 w6lwgt w6xwgt w6scwt w6sscwt scqola scqolb scqolc scqold scqole scqolf scqolg scqolh scqoli scqolj scqolk scqoll scqolm scqoln scqolo scqolp scqolq scqolr scqols sclifea sclifeb sclifec sclifed sclifee PScedA PScedB PScedC PScedD PScedE PScedF PScedG PScedH HHTot scchdg scchdh scchdi scchdt scfamg scfamh scfami scfamt scfrdg scfrdh scfrdi scfrdt scorg01 scorg02 scorg03 scorg04 scorg05 scorg06 scorg07 scorg08 scorg09 using wave_6_elsa_data_v2.dta
* Describe dataset
describe
* Sort from lowest to highest participant ID
sort idauniq
* Generate a new variable called wave and assign the number 6 to each observation (to designate Wave 6)
gen wave = 6
* Save Wave 6 core dataset
save wave6Jackson.dta

use wave6Jackson.dta 
* One-to-one merge of data in memory with wave6financial.dta on participant ID *SEE WEBB for financial*
merge 1:1 idauniq using wave6financial.dta, generate (merge_financial6)
save wave6Jackson.dta, replace

* Age
replace indager = 99 if indager==-7

* Sex
gen Sex = 0 if DiSex==1
replace Sex = 1 if DiSex==2

* Bus pass holder 
replace SpBsPs = . if SpBsPs<0
replace SpBsPs = 0 if SpBsPs==2

* Frequency of bus pass use
replace SpBsTm = . if SpBsTm<0
replace SpBsTm = 2 if inlist(SpBsTm,3,4)

* Limiting long-standing illness
* Generate a new variable and assign the number 0 for participants with no long-standing illness or a long-standing illness that is not limiting 
gen limiting = 0 if Heill == 2 | Helim == 2
* Assign the number 1 for participants with a limiting long-standing illness
replace limiting = 1 if Helim == 1
* Coding of the final limiting long-standing illness variable:
* 0: No long-standing illness or not limiting, 1: Limiting long-standing illness

* Vigorous/Moderate/Mild sports or activities (Wave 9, COVID Wave 2)
* Replace variables as missing for any missing cases (coded as negative numbers in the ELSA dataset)
replace HeActa = . if HeActa<0
replace HeActb = . if HeActb<0
replace HeActc = . if HeActc<0
* Generate a new variable
gen activity2 = .
* Assign the number 3 if the participant partakes in vigorous activity more than once a week or ("|") once a week
replace activity2 = 3 if HeActa==1 | HeActa==2
* Assign the number 2 if the participant partakes in moderate activity more than once a week or once a week, and takes part in vigorous activity less than once a week
replace activity2 = 2 if (HeActb==1 | HeActb==2) & inlist(HeActa,3,4)
* Assign the number 1 if the participant partakes in mild activity more than once a week or once a week, and takes part in moderate and vigorous activities less than once a week
replace activity2 = 1 if (HeActc==1 | HeActc==2) & inlist(HeActa,3,4) & inlist(HeActb,3,4)
* Assign the number 0 if the participant does not take part in activity of any intensity once a week or more
replace activity2 = 0 if inlist(HeActa,3,4) & inlist(HeActb,3,4) & inlist(HeActc,3,4)
* Replace the variable as missing for participants with missing cases on all three variables
replace activity2 = . if inlist(HeActa,.) & inlist(HeActb,.) & inlist(HeActc,.)
* Coding of final physical activity variable:
* 3: Vigorous activity at least once per week
* 2: At least moderate but no vigorous activity at least once per week
* 1: Only mild activity at least once per week
* 0: Inactive (no activity on a weekly basis)

replace PScedA = . if PScedA<0
replace sclifea = . if sclifea<0
replace scqola = . if scqola<0
replace PScedB = . if PScedB<0
replace sclifeb = . if sclifeb<0
replace scqolb = . if scqolb<0
replace PScedC = . if PScedC<0
replace sclifec = . if sclifec<0
replace scqolc = . if scqolc<0
replace PScedD = . if PScedD<0
replace sclifed = . if sclifed<0
replace scqold = . if scqold<0
replace PScedE = . if PScedE<0
replace sclifee = . if sclifee<0
replace scqole = . if scqole<0
replace PScedF = . if PScedF<0
replace PScedG = . if PScedG<0
replace PScedH = . if PScedH<0
replace scqolf = . if scqolf<0
replace scqolg = . if scqolg<0
replace scqolh = . if scqolh<0
replace scqoli = . if scqoli<0
replace scqolj = . if scqolj<0
replace scqolk = . if scqolk<0
replace scqoll = . if scqoll<0
replace scqolm = . if scqolm<0
replace scqoln = . if scqoln<0
replace scqolo = . if scqolo<0
replace scqolp = . if scqolp<0
replace scqolq = . if scqolq<0
replace scqolr = . if scqolr<0
replace scqols = . if scqols<0

* Recode to the number 0 if participant answered "Yes"
replace PScedA = 0 if PScedA == 1
* Recode to the number 1 if participant answered "No"
replace PScedA = 1 if PScedA == 2

* Recode to the number 0 if participant answered "Yes"
replace PScedB = 0 if PScedB == 1
* Recode to the number 1 if participant answered "No"
replace PScedB = 1 if PScedB == 2

* Recode to the number 0 if participant answered "Yes"
replace PScedC = 0 if PScedC == 1
* Recode to the number 1 if participant answered "No"
replace PScedC = 1 if PScedC == 2

* Recode to the number 0 if participant answered "Yes"
replace PScedE = 0 if PScedE == 1
* Recode to the number 1 if participant answered "No"
replace PScedE = 1 if PScedE == 2

* Recode to the number 0 if participant answered "Yes"
replace PScedG = 0 if PScedG == 1
* Recode to the number 1 if participant answered "No"
replace PScedG = 1 if PScedG == 2

* Recode to the number 0 if participant answered "Yes"
replace PScedH = 0 if PScedH == 1
* Recode to the number 1 if participant answered "No"
replace PScedH = 1 if PScedH == 2

* Recode to the number 0 if participant answered "No"
replace PScedD = 0 if PScedD == 2
* Recode to the number 0 if participant answered "No"
replace PScedF = 0 if PScedF == 2

gen depression = PScedA + PScedB + PScedC + PScedD + PScedE + PScedF + PScedG + PScedH

* Recode each item into a 0-3 scale (13 of the 19 items were reversed)
replace scqola = 0 if scqola == 1
replace scqola = 1 if scqola == 2
replace scqola = 2 if scqola == 3
replace scqola = 3 if scqola == 4
replace scqolb = 0 if scqolb == 1
replace scqolb = 1 if scqolb == 2
replace scqolb = 2 if scqolb == 3
replace scqolb = 3 if scqolb == 4
revrs scqolc
replace revscqolc = 0 if revscqolc == 1
replace revscqolc = 1 if revscqolc == 2
replace revscqolc = 2 if revscqolc == 3
replace revscqolc = 3 if revscqolc == 4
replace scqold = 0 if scqold == 1
replace scqold = 1 if scqold == 2
replace scqold = 2 if scqold == 3
replace scqold = 3 if scqold == 4
revrs scqole
replace revscqole = 0 if revscqole == 1
replace revscqole = 1 if revscqole == 2
replace revscqole = 2 if revscqole == 3
replace revscqole = 3 if revscqole == 4
replace scqolf = 0 if scqolf == 1
replace scqolf = 1 if scqolf == 2
replace scqolf = 2 if scqolf == 3
replace scqolf = 3 if scqolf == 4
revrs scqolg
replace revscqolg = 0 if revscqolg == 1
replace revscqolg = 1 if revscqolg == 2
replace revscqolg = 2 if revscqolg == 3
replace revscqolg = 3 if revscqolg == 4
replace scqolh = 0 if scqolh == 1
replace scqolh = 1 if scqolh == 2
replace scqolh = 2 if scqolh == 3
replace scqolh = 3 if scqolh == 4
replace scqoli = 0 if scqoli == 1
replace scqoli = 1 if scqoli == 2
replace scqoli = 2 if scqoli == 3
replace scqoli = 3 if scqoli == 4
revrs scqolj
replace revscqolj = 0 if revscqolj == 1
replace revscqolj = 1 if revscqolj == 2
replace revscqolj = 2 if revscqolj == 3
replace revscqolj = 3 if revscqolj == 4
revrs scqolk
replace revscqolk = 0 if revscqolk == 1
replace revscqolk = 1 if revscqolk == 2
replace revscqolk = 2 if revscqolk == 3
replace revscqolk = 3 if revscqolk == 4
revrs scqoll
replace revscqoll = 0 if revscqoll == 1
replace revscqoll = 1 if revscqoll == 2
replace revscqoll = 2 if revscqoll == 3
replace revscqoll = 3 if revscqoll == 4
revrs scqolm
replace revscqolm = 0 if revscqolm == 1
replace revscqolm = 1 if revscqolm == 2
replace revscqolm = 2 if revscqolm == 3
replace revscqolm = 3 if revscqolm == 4
revrs scqoln
replace revscqoln = 0 if revscqoln == 1
replace revscqoln = 1 if revscqoln == 2
replace revscqoln = 2 if revscqoln == 3
replace revscqoln = 3 if revscqoln == 4
revrs scqolo
replace revscqolo = 0 if revscqolo == 1
replace revscqolo = 1 if revscqolo == 2
replace revscqolo = 2 if revscqolo == 3
replace revscqolo = 3 if revscqolo == 4
revrs scqolp
replace revscqolp = 0 if revscqolp == 1
replace revscqolp = 1 if revscqolp == 2
replace revscqolp = 2 if revscqolp == 3
replace revscqolp = 3 if revscqolp == 4
revrs scqolq
replace revscqolq = 0 if revscqolq == 1
replace revscqolq = 1 if revscqolq == 2
replace revscqolq = 2 if revscqolq == 3
replace revscqolq = 3 if revscqolq == 4
revrs scqolr
replace revscqolr = 0 if revscqolr == 1
replace revscqolr = 1 if revscqolr == 2
replace revscqolr = 2 if revscqolr == 3
replace revscqolr = 3 if revscqolr == 4
revrs scqols
replace revscqols = 0 if revscqols == 1
replace revscqols = 1 if revscqols == 2
replace revscqols = 2 if revscqols == 3
replace revscqols = 3 if revscqols == 4

* Generate a new variable equal to the sum of the 19 items (range 0-57)
gen QoL = scqola + scqolb + revscqolc + scqold + revscqole + scqolf + revscqolg + scqolh + scqoli + revscqolj + revscqolk + revscqoll + revscqolm + revscqoln + revscqolo + revscqolp + revscqolq + revscqolr + revscqols

gen satisfaction = sclifea+sclifeb+sclifec+sclifed+sclifee

save wave6Jackson.dta, replace

keep if indager>=62
unique idauniq 
* 6870
drop if SpBsPs==.
drop if limiting==.
drop if totwq5_bu_s==.
unique idauniq 
* 6274
drop if satisfaction==. & depression==. & QoL==.
unique idauniq 
* 6016
save interim6Jackson.dta, replace
drop if indager==99
drop if DiMar==.
unique idauniq 
* 5861
sum indager if SpBsPs==0
sum indager if SpBsPs==1
tab Sex if SpBsPs==0
tab Sex if SpBsPs==1
tab totwq5_bu_s if SpBsPs==0
tab totwq5_bu_s if SpBsPs==1
tab limiting if SpBsPs==0
tab limiting if SpBsPs==1

replace activity2=0 if activity2==1
replace activity2=1 if activity2==2
replace activity2=2 if activity2==3
tab activity2 if SpBsPs==0
tab activity2 if SpBsPs==1

gen marital = 0 if inlist(DiMar,1,5,6,7)
replace marital = 1 if inlist(DiMar,2,3,4)
replace marital = 1 if DiMar==8
tab marital if SpBsPs==0
tab marital if SpBsPs==1

save finalJackson62.dta
log using Jackson20230511.log

set showbaselevels on 
ologit activity2 i.SpBsPs indager i.Sex i.marital i.totwq5_bu_s i.limiting, or
ologit activity2 i.SpBsTm indager i.Sex i.marital i.totwq5_bu_s i.limiting, or

gen SES = 0 if inlist(totwq5_bu_s,1,2)
replace SES = 1 if inlist(totwq5_bu_s,3,4,5)

save finalJackson62.dta, replace
sum w6xwgt

keep if SES==0
unique idauniq 
* 1979
ologit activity2 i.SpBsPs indager i.Sex i.marital i.limiting, or
ologit activity2 i.SpBsTm indager i.Sex i.marital i.limiting, or
ologit activity2 i.SpBsPs, or
ologit activity2 i.SpBsTm, or
clear 

use finalJackson62.dta
keep if SES==1
unique idauniq 
* 3882
ologit activity2 i.SpBsPs indager i.Sex i.marital i.limiting, or
ologit activity2 i.SpBsTm indager i.Sex i.marital i.limiting, or
ologit activity2 i.SpBsPs, or
ologit activity2 i.SpBsTm, or
clear 
log close

log using Jackson20230511.log, append
use finalJackson62.dta
keep if SES==0
unique idauniq 
* 1979
tab activity2 SpBsPs
tab activity2 SpBsTm
clear

use finalJackson62.dta
keep if SES==1
unique idauniq 
* 3882
tab activity2 SpBsPs
tab activity2 SpBsTm
clear 
log close

log using 20231029Jackson.log 
use finalJackson62.dta
keep if SES==0
unique idauniq 
* 1979
tab Sex 
* 798 male, 1181 female
gen frequencyb = SpBsTm
replace frequencyb = 1 if SpBsTm == 2
ologit activity2 i.frequencyb indager i.Sex i.marital i.limiting, or
ologit activity2 i.frequencyb, or
clear 

use finalJackson62.dta
keep if SES==1
unique idauniq 
* 3882
tab Sex 
* 1814 male, 2068 female
gen frequencyb = SpBsTm
replace frequencyb = 1 if SpBsTm == 2
ologit activity2 i.frequencyb indager i.Sex i.marital i.limiting, or
ologit activity2 i.frequencyb, or
clear
log close