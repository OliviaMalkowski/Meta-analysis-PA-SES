* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: Banks, J., Batty, G. David, Breedvelt, J., Coughlin, K., Crawford, R., Marmot, M., Nazroo, J., Oldfield, Z., Steel, N., Steptoe, A., Wood, M., Zaninotto, P. (2021). English Longitudinal Study of Ageing: Waves 0-9, 1998-2019. [data collection]. 37th Edition. UK Data Service. SN: 5050, DOI: http://doi.org/10.5255/UKDA-SN-5050-24

* Project ID: 237630

cd ""

* Variables Wave 1
use idauniq finstat w1wgt heada01 heada02 heada03 heada04 heada05 heada06 heada07 heada08 heada09 heada10 heada11 headb01 headb02 headb03 headb04 headb05 headb06 headb07 headb08 headb09 headb10 headb11 headb12 headb13 headb14 hegenh hehelf psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh hedia01 hedia02 hedia03 hedia04 hedia05 hedia06 hedia07 hedia08 hedia09 hedia10 hedim01 hedim02 hedim03 hedim04 hedim05 hedim06 hedim07 hedib01 hedib02 hedib03 hedib04 hedib05 hedib06 hedib07 hedib08 hedib09 hedib10 heeye hefrnd hepap hehear hehra hefla hefrac heji hepab heanf hecda mmpain cfdatd cfdatm cfdaty cfday cfdscr cftest cfwrds cflisen cflisd heacta heactb heactc scorg7 dhager fqethnr indager anssec enssec dhsex disex indsex edqual scptr couple1 hesmk heska hecig heskb heskc wpdes using wave_1_core_data_v3.dta
* Describe dataset
describe
* Sort from lowest to highest participant identifier (ID)
sort idauniq
* Generate a new variable called wave and assign the number 1 to each observation (to designate Wave 1)
gen wave = 1
* Save Wave 1 core dataset
save wave1Watts.dta

* Variables Wave 2
use idauniq sampsta HeActa HeActb HeActc finstat w2wgt using wave_2_core_data_v4.dta
* Describe dataset
describe
* Sort from lowest to highest participant identifier (ID)
sort idauniq
* Rename variables to shorter or more convenient forms 
rename sampsta samptyp2
rename HeActa heacta
rename HeActb heactb
rename HeActc heactc
rename finstat finstatw2
* Generate a new variable called wave and assign the number 2 to each observation (to designate Wave 2)
gen wave = 2
* Save Wave 2 core dataset
save wave2Watts.dta

use wave1Watts.dta 
append using wave2Watts.dta 
sort idauniq wave
save rawWatts.dta

unique idauniq 
* 12207, 21531
drop if indager<50 & wave==1
unique idauniq 
* 12074, 20954
unique idauniq if wave==1
* 11522

* Mobility, ADL, IADL - Item 1 to 23 
replace heada01 = . if heada01<0
replace heada02 = . if heada02<0
replace heada03 = . if heada03<0
replace heada04 = . if heada04<0
replace heada05 = . if heada05<0
replace heada06 = . if heada06<0
replace heada07 = . if heada07<0
replace heada08 = . if heada08<0
replace heada09 = . if heada09<0
replace heada10 = . if heada10<0
replace heada11 = . if headb11<0
replace headb01 = . if headb01<0
replace headb02 = . if headb02<0
replace headb03 = . if headb03<0
replace headb04 = . if headb04<0
replace headb05 = . if headb05<0
replace headb06 = . if headb06<0
replace headb07 = . if headb07<0
replace headb08 = . if headb08<0
replace headb09 = . if headb09<0
replace headb10 = . if headb10<0
replace headb11 = . if headb11<0
replace headb12 = . if headb12<0
replace headb13 = . if headb13<0
replace headb14 = . if headb14<0

* Difficulty walking 100 yards
gen hemobwa = 1 if (heada01 == 1 | heada02 == 1 | heada03 == 1 | heada04 == 1 | heada05 == 1 | heada06 == 1 | heada07 == 1 | heada08 == 1 | heada09 == 1 | heada10 == 1 | heada11 == 1) & wave==1
replace hemobwa = 0 if inlist(heada01,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada02,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada03,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada04,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada05,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada06,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada07,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada08,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada09,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada10,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1
replace hemobwa = 0 if inlist(heada11,2,3,4,5,6,7,8,9,10,96) & hemobwa!=1

* Difficulty sitting for about two hours
gen hemobsi = 1 if (heada01 == 2 | heada02 == 2 | heada03 == 2 | heada04 == 2 | heada05 == 2 | heada06 == 2 | heada07 == 2 | heada08 == 2 | heada09 == 2 | heada10 == 2 | heada11 == 2) & wave==1
replace hemobsi = 0 if inlist(heada01,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada02,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada03,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada04,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada05,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada06,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada07,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada08,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada09,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada10,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1
replace hemobsi = 0 if inlist(heada11,1,3,4,5,6,7,8,9,10,96) & hemobsi!=1

* Difficulty getting up from a chair after sitting for long periods
gen hemobch = 1 if (heada01 == 3 | heada02 == 3 | heada03 == 3 | heada04 == 3 | heada05 == 3 | heada06 == 3 | heada07 == 3 | heada08 == 3 | heada09 == 3 | heada10 == 3 | heada11 == 3) & wave==1
replace hemobch = 0 if inlist(heada01,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada02,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada03,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada04,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada05,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada06,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada07,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada08,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada09,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada10,1,2,4,5,6,7,8,9,10,96) & hemobch!=1
replace hemobch = 0 if inlist(heada11,1,2,4,5,6,7,8,9,10,96) & hemobch!=1

* Difficulty climbing several flights of stairs without resting
gen hemobcs = 1 if (heada01 == 4 | heada02 == 4 | heada03 == 4 | heada04 == 4 | heada05 == 4 | heada06 == 4 | heada07 == 4 | heada08 == 4 | heada09 == 4 | heada10 == 4 | heada11 == 4) & wave==1
replace hemobcs = 0 if inlist(heada01,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada02,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada03,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada04,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada05,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada06,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada07,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada08,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada09,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada10,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1
replace hemobcs = 0 if inlist(heada11,1,2,3,5,6,7,8,9,10,96) & hemobcs!=1

* Difficulty climbing one flight of stairs without resting
gen hemobcl = 1 if (heada01 == 5 | heada02 == 5 | heada03 == 5 | heada04 == 5 | heada05 == 5 | heada06 == 5 | heada07 == 5 | heada08 == 5 | heada09 == 5 | heada10 == 5 | heada11 == 5) & wave==1
replace hemobcl = 0 if inlist(heada01,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada02,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada03,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada04,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada05,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada06,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada07,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada08,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada09,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada10,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1
replace hemobcl = 0 if inlist(heada11,1,2,3,4,6,7,8,9,10,96) & hemobcl!=1

* Difficulty stooping, kneeling, or crouching
gen hemobst = 1 if (heada01 == 6 | heada02 == 6 | heada03 == 6 | heada04 == 6 | heada05 == 6 | heada06 == 6 | heada07 == 6 | heada08 == 6 | heada09 == 6 | heada10 == 6 | heada11 == 6) & wave==1
replace hemobst = 0 if inlist(heada01,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada02,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada03,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada04,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada05,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada06,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada07,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada08,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada09,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada10,1,2,3,4,5,7,8,9,10,96) & hemobst!=1
replace hemobst = 0 if inlist(heada11,1,2,3,4,5,7,8,9,10,96) & hemobst!=1

* Difficulty reaching or extending arms above shoulder level 
gen hemobre = 1 if (heada01 == 7 | heada02 == 7 | heada03 == 7 | heada04 == 7 | heada05 == 7 | heada06 == 7 | heada07 == 7 | heada08 == 7 | heada09 == 7 | heada10 == 7 | heada11 == 7) & wave==1
replace hemobre = 0 if inlist(heada01,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada02,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada03,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada04,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada05,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada06,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada07,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada08,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada09,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada10,1,2,3,4,5,6,8,9,10,96) & hemobre!=1
replace hemobre = 0 if inlist(heada11,1,2,3,4,5,6,8,9,10,96) & hemobre!=1

* Difficulty pulling or pushing large objects, like a living room chair
gen hemobpu = 1 if (heada01 == 8 | heada02 == 8 | heada03 == 8 | heada04 == 8 | heada05 == 8 | heada06 == 8 | heada07 == 8 | heada08 == 8 | heada09 == 8 | heada10 == 8 | heada11 == 8) & wave==1
replace hemobpu = 0 if inlist(heada01,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada02,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada03,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada04,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada05,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada06,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada07,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada08,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada09,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada10,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1
replace hemobpu = 0 if inlist(heada11,1,2,3,4,5,6,7,9,10,96) & hemobpu!=1

* Difficulty lifting or carrying weights over 10 pounds, like a heavy bag of groceries
gen hemobli = 1 if (heada01 == 9 | heada02 == 9 | heada03 == 9 | heada04 == 9 | heada05 == 9 | heada06 == 9 | heada07 == 9 | heada08 == 9 | heada09 == 9 | heada10 == 9 | heada11 == 9) & wave==1
replace hemobli = 0 if inlist(heada01,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada02,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada03,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada04,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada05,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada06,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada07,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada08,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada09,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada10,1,2,3,4,5,6,7,8,10,96) & hemobli!=1
replace hemobli = 0 if inlist(heada11,1,2,3,4,5,6,7,8,10,96) & hemobli!=1

* Difficulty picking up a 5p coin from a table
gen hemobpi = 1 if (heada01 == 10 | heada02 == 10 | heada03 == 10 | heada04 == 10 | heada05 == 10 | heada06 == 10 | heada07 == 10 | heada08 == 10 | heada09 == 10 | heada10 == 10 | heada11 == 10) & wave==1
replace hemobpi = 0 if inlist(heada01,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada02,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada03,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada04,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada05,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada06,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada07,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada08,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada09,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada10,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1
replace hemobpi = 0 if inlist(heada11,1,2,3,4,5,6,7,8,9,96) & hemobpi!=1

* Difficulty dressing
gen headldr = 1 if (headb01 == 1 | headb02 == 1 | headb03 == 1 | headb04 == 1 | headb05 == 1 | headb06 == 1 | headb07 == 1 | headb08 == 1 | headb09 == 1 | headb10 == 1 | headb11 == 1 | headb12 == 1 | headb13 == 1 | headb14 == 1) & wave==1
replace headldr = 0 if inlist(headb01,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb02,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb03,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb04,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb05,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb06,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb07,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb08,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb09,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb10,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb11,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb12,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb13,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1
replace headldr = 0 if inlist(headb14,2,3,4,5,6,7,8,9,10,11,12,13,96) & headldr!=1

* Difficulty walking across a room
gen headlwa = 1 if (headb01 == 2 | headb02 == 2 | headb03 == 2 | headb04 == 2 | headb05 == 2 | headb06 == 2 | headb07 == 2 | headb08 == 2 | headb09 == 2 | headb10 == 2 | headb11 == 2 | headb12 == 2 | headb13 == 2 | headb14 == 2) & wave==1
replace headlwa = 0 if inlist(headb01,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb02,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb03,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb04,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb05,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb06,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb07,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb08,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb09,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb10,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb11,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb12,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb13,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1
replace headlwa = 0 if inlist(headb14,1,3,4,5,6,7,8,9,10,11,12,13,96) & headlwa!=1

* Difficulty bathing or showering
gen headlba = 1 if (headb01 == 3 | headb02 == 3 | headb03 == 3 | headb04 == 3 | headb05 == 3 | headb06 == 3 | headb07 == 3 | headb08 == 3 | headb09 == 3 | headb10 == 3 | headb11 == 3 | headb12 == 3 | headb13 == 3 | headb14 == 3) & wave==1
replace headlba = 0 if inlist(headb01,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb02,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb03,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb04,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb05,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb06,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb07,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb08,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb09,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb10,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb11,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb12,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb13,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1
replace headlba = 0 if inlist(headb14,1,2,4,5,6,7,8,9,10,11,12,13,96) & headlba!=1

* Difficulty eating, such as cutting up your food
gen headlea = 1 if (headb01 == 4 | headb02 == 4 | headb03 == 4 | headb04 == 4 | headb05 == 4 | headb06 == 4 | headb07 == 4 | headb08 == 4 | headb09 == 4 | headb10 == 4 | headb11 == 4 | headb12 == 4 | headb13 == 4 | headb14 == 4) & wave==1
replace headlea = 0 if inlist(headb01,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb02,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb03,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb04,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb05,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb06,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb07,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb08,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb09,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb10,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb11,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb12,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb13,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1
replace headlea = 0 if inlist(headb14,1,2,3,5,6,7,8,9,10,11,12,13,96) & headlea!=1

* Difficulty getting in or out of bed
gen headlbe = 1 if (headb01 == 5 | headb02 == 5 | headb03 == 5 | headb04 == 5 | headb05 == 5 | headb06 == 5 | headb07 == 5 | headb08 == 5 | headb09 == 5 | headb10 == 5 | headb11 == 5 | headb12 == 5 | headb13 == 5 | headb14 == 5) & wave==1
replace headlbe = 0 if inlist(headb01,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb02,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb03,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb04,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb05,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb06,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb07,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb08,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb09,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb10,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb11,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb12,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb13,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1
replace headlbe = 0 if inlist(headb14,1,2,3,4,6,7,8,9,10,11,12,13,96) & headlbe!=1

* Difficulty using the toilet, including getting up or down
gen headlwc = 1 if (headb01 == 6 | headb02 == 6 | headb03 == 6 | headb04 == 6 | headb05 == 6 | headb06 == 6 | headb07 == 6 | headb08 == 6 | headb09 == 6 | headb10 == 6 | headb11 == 6 | headb12 == 6 | headb13 == 6 | headb14 == 6) & wave==1
replace headlwc = 0 if inlist(headb01,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb02,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb03,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb04,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb05,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb06,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb07,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb08,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb09,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb10,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb11,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb12,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb13,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1
replace headlwc = 0 if inlist(headb14,1,2,3,4,5,7,8,9,10,11,12,13,96) & headlwc!=1

* Difficulty using a map to figure out how to get around in a strange place
gen headlma = 1 if (headb01 == 7 | headb02 == 7 | headb03 == 7 | headb04 == 7 | headb05 == 7 | headb06 == 7 | headb07 == 7 | headb08 == 7 | headb09 == 7 | headb10 == 7 | headb11 == 7 | headb12 == 7 | headb13 == 7 | headb14 == 7) & wave==1
replace headlma = 0 if inlist(headb01,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb02,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb03,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb04,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb05,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb06,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb07,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb08,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb09,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb10,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb11,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb12,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb13,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1
replace headlma = 0 if inlist(headb14,1,2,3,4,5,6,8,9,10,11,12,13,96) & headlma!=1

* Difficulty preparing a hot meal 
gen headlpr = 1 if (headb01 == 8 | headb02 == 8 | headb03 == 8 | headb04 == 8 | headb05 == 8 | headb06 == 8 | headb07 == 8 | headb08 == 8 | headb09 == 8 | headb10 == 8 | headb11 == 8 | headb12 == 8 | headb13 == 8 | headb14 == 8) & wave==1
replace headlpr = 0 if inlist(headb01,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb02,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb03,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb04,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb05,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb06,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb07,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb08,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb09,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb10,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb11,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb12,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb13,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1
replace headlpr = 0 if inlist(headb14,1,2,3,4,5,6,7,9,10,11,12,13,96) & headlpr!=1

* Difficulty shopping for groceries
gen headlsh = 1 if (headb01 == 9 | headb02 == 9 | headb03 == 9 | headb04 == 9 | headb05 == 9 | headb06 == 9 | headb07 == 9 | headb08 == 9 | headb09 == 9 | headb10 == 9 | headb11 == 9 | headb12 == 9 | headb13 == 9 | headb14 == 9) & wave==1
replace headlsh = 0 if inlist(headb01,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb02,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb03,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb04,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb05,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb06,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb07,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb08,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb09,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb10,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb11,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb12,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb13,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1
replace headlsh = 0 if inlist(headb14,1,2,3,4,5,6,7,8,10,11,12,13,96) & headlsh!=1

* Difficulty making telephone calls
gen headlph = 1 if (headb01 == 10 | headb02 == 10 | headb03 == 10 | headb04 == 10 | headb05 == 10 | headb06 == 10 | headb07 == 10 | headb08 == 10 | headb09 == 10 | headb10 == 10 | headb11 == 10 | headb12 == 10 | headb13 == 10 | headb14 == 10) & wave==1
replace headlph = 0 if inlist(headb01,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb02,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb03,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb04,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb05,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb06,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb07,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb08,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb09,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb10,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb11,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb12,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb13,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1
replace headlph = 0 if inlist(headb14,1,2,3,4,5,6,7,8,9,11,12,13,96) & headlph!=1

* Difficulty taking medications
gen headlme = 1 if (headb01 == 11 | headb02 == 11 | headb03 == 11 | headb04 == 11 | headb05 == 11 | headb06 == 11 | headb07 == 11 | headb08 == 11 | headb09 == 11 | headb10 == 11 | headb11 == 11 | headb12 == 11 | headb13 == 11 | headb14 == 11) & wave==1
replace headlme = 0 if inlist(headb01,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb02,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb03,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb04,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb05,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb06,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb07,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb08,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb09,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb10,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb11,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb12,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb13,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1
replace headlme = 0 if inlist(headb14,1,2,3,4,5,6,7,8,9,10,12,13,96) & headlme!=1

* Difficulty doing work around the house or garden
gen headlho = 1 if (headb01 == 12 | headb02 == 12 | headb03 == 12 | headb04 == 12 | headb05 == 12 | headb06 == 12 | headb07 == 12 | headb08 == 12 | headb09 == 12 | headb10 == 12 | headb11 == 12 | headb12 == 12 | headb13 == 12 | headb14 == 12) & wave==1
replace headlho = 0 if inlist(headb01,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb02,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb03,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb04,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb05,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb06,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb07,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb08,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb09,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb10,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb11,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb12,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb13,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1
replace headlho = 0 if inlist(headb14,1,2,3,4,5,6,7,8,9,10,11,13,96) & headlho!=1

* Difficulty managing money, such as paying bills and keeping track of expenses
gen headlmo = 1 if (headb01 == 13 | headb02 == 13 | headb03 == 13 | headb04 == 13 | headb05 == 13 | headb06 == 13 | headb07 == 13 | headb08 == 13 | headb09 == 13 | headb10 == 13 | headb11 == 13 | headb12 == 13 | headb13 == 13 | headb14 == 13) & wave==1
replace headlmo = 0 if inlist(headb01,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb02,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb03,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb04,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb05,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb06,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb07,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb08,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb09,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb10,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb11,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb12,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb13,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1
replace headlmo = 0 if inlist(headb14,1,2,3,4,5,6,7,8,9,10,11,12,96) & headlmo!=1

* General health
replace hehelf = . if hehelf<0 
gen health = 0 if hehelf==1
replace health = 0.25 if hehelf==2
replace health = 0.5 if hehelf==3
replace health = 0.75 if hehelf==4
replace health = 1 if hehelf==5

* Depressive symptoms 
replace psceda = . if psceda<0
replace pscedb = . if pscedb<0
replace pscedc = . if pscedc<0
replace pscedd = . if pscedd<0
replace pscede = . if pscede<0
replace pscedf = . if pscedf<0
replace pscedg = . if pscedg<0
replace pscedh = . if pscedh<0

replace psceda = 0 if psceda == 1
replace psceda = 1 if psceda == 2

replace pscedb = 0 if pscedb == 1
replace pscedb = 1 if pscedb == 2

replace pscedc = 0 if pscedc == 1
replace pscedc = 1 if pscedc == 2

replace pscede = 0 if pscede == 1
replace pscede = 1 if pscede == 2

replace pscedg = 0 if pscedg == 1
replace pscedg = 1 if pscedg == 2

replace pscedh = 0 if pscedh == 1
replace pscedh = 1 if pscedh == 2

replace pscedd = 0 if pscedd == 2
replace pscedf = 0 if pscedf == 2

* High blood pressure or hypertension 
replace hedia01 = . if hedia01<0
replace hedia02 = . if hedia02<0
replace hedia03 = . if hedia03<0
replace hedia04 = . if hedia04<0
replace hedia05 = . if hedia05<0
replace hedia06 = . if hedia06<0
replace hedia07 = . if hedia07<0
replace hedia08 = . if hedia08<0
replace hedia09 = . if hedia09<0
replace hedia10 = . if hedia10<0
replace hedim01 = . if hedim01<0
replace hedim02 = . if hedim02<0
replace hedim03 = . if hedim03<0
replace hedim04 = . if hedim04<0
replace hedim05 = . if hedim05<0
replace hedim06 = . if hedim06<0
replace hedim07 = . if hedim07<0
replace hedib01 = . if hedib01<0
replace hedib02 = . if hedib02<0
replace hedib03 = . if hedib03<0
replace hedib04 = . if hedib04<0
replace hedib05 = . if hedib05<0
replace hedib06 = . if hedib06<0
replace hedib07 = . if hedib07<0
replace hedib08 = . if hedib08<0
replace hedib09 = . if hedib09<0
replace hedib10 = . if hedib10<0
save interimWatts.dta

gen hediabp = 1 if (hedia01 == 1 | hedia02 == 1 | hedia03 == 1 | hedia04 == 1 | hedia05 == 1 | hedia06 == 1 | hedia07 == 1 | hedia08 == 1 | hedia09 == 1 | hedia10 == 1) & wave==1
replace hediabp = 0 if inlist(hedia01,2,3,4,5,6,7,8,95,96) & hediabp!=1
replace hediabp = 0 if inlist(hedia02,2,3,4,5,6,7,8,95,96) & hediabp!=1
replace hediabp = 0 if inlist(hedia03,2,3,4,5,6,7,8,95,96) & hediabp!=1
replace hediabp = 0 if inlist(hedia04,2,3,4,5,6,7,8,95,96) & hediabp!=1
replace hediabp = 0 if inlist(hedia05,2,3,4,5,6,7,8,95,96) & hediabp!=1
replace hediabp = 0 if inlist(hedia06,2,3,4,5,6,7,8,95,96) & hediabp!=1
replace hediabp = 0 if inlist(hedia07,2,3,4,5,6,7,8,95,96) & hediabp!=1
replace hediabp = 0 if inlist(hedia08,2,3,4,5,6,7,8,95,96) & hediabp!=1
replace hediabp = 0 if inlist(hedia09,2,3,4,5,6,7,8,95,96) & hediabp!=1
replace hediabp = 0 if inlist(hedia10,2,3,4,5,6,7,8,95,96) & hediabp!=1

* Angina 
gen hediaan = 1 if (hedia01 == 2 | hedia02 == 2 | hedia03 == 2 | hedia04 == 2 | hedia05 == 2 | hedia06 == 2 | hedia07 == 2 | hedia08 == 2 | hedia09 == 2 | hedia10 == 2) & wave==1
replace hediaan = 0 if inlist(hedia01,1,3,4,5,6,7,8,95,96) & hediaan!=1
replace hediaan = 0 if inlist(hedia02,1,3,4,5,6,7,8,95,96) & hediaan!=1
replace hediaan = 0 if inlist(hedia03,1,3,4,5,6,7,8,95,96) & hediaan!=1
replace hediaan = 0 if inlist(hedia04,1,3,4,5,6,7,8,95,96) & hediaan!=1
replace hediaan = 0 if inlist(hedia05,1,3,4,5,6,7,8,95,96) & hediaan!=1
replace hediaan = 0 if inlist(hedia06,1,3,4,5,6,7,8,95,96) & hediaan!=1
replace hediaan = 0 if inlist(hedia07,1,3,4,5,6,7,8,95,96) & hediaan!=1
replace hediaan = 0 if inlist(hedia08,1,3,4,5,6,7,8,95,96) & hediaan!=1
replace hediaan = 0 if inlist(hedia09,1,3,4,5,6,7,8,95,96) & hediaan!=1
replace hediaan = 0 if inlist(hedia10,1,3,4,5,6,7,8,95,96) & hediaan!=1

* Heart attack
gen hediaha = 1 if (hedia01 == 3 | hedia02 == 3 | hedia03 == 3 | hedia04 == 3 | hedia05 == 3 | hedia06 == 3 | hedia07 == 3 | hedia08 == 3 | hedia09 == 3 | hedia10 == 3) & wave==1
replace hediaha = 0 if inlist(hedia01,1,2,4,5,6,7,8,95,96) & hediaha!=1
replace hediaha = 0 if inlist(hedia02,1,2,4,5,6,7,8,95,96) & hediaha!=1
replace hediaha = 0 if inlist(hedia03,1,2,4,5,6,7,8,95,96) & hediaha!=1
replace hediaha = 0 if inlist(hedia04,1,2,4,5,6,7,8,95,96) & hediaha!=1
replace hediaha = 0 if inlist(hedia05,1,2,4,5,6,7,8,95,96) & hediaha!=1
replace hediaha = 0 if inlist(hedia06,1,2,4,5,6,7,8,95,96) & hediaha!=1
replace hediaha = 0 if inlist(hedia07,1,2,4,5,6,7,8,95,96) & hediaha!=1
replace hediaha = 0 if inlist(hedia08,1,2,4,5,6,7,8,95,96) & hediaha!=1
replace hediaha = 0 if inlist(hedia09,1,2,4,5,6,7,8,95,96) & hediaha!=1
replace hediaha = 0 if inlist(hedia10,1,2,4,5,6,7,8,95,96) & hediaha!=1
save interim2Watts.dta

* Congestive heart failure
gen hediahf = 1 if (hedia01 == 4 | hedia02 == 4 | hedia03 == 4 | hedia04 == 4 | hedia05 == 4 | hedia06 == 4 | hedia07 == 4 | hedia08 == 4 | hedia09 == 4 | hedia10 == 4) & wave==1
replace hediahf = 0 if inlist(hedia01,1,2,3,5,6,7,8,95,96) & hediahf!=1
replace hediahf = 0 if inlist(hedia02,1,2,3,5,6,7,8,95,96) & hediahf!=1
replace hediahf = 0 if inlist(hedia03,1,2,3,5,6,7,8,95,96) & hediahf!=1
replace hediahf = 0 if inlist(hedia04,1,2,3,5,6,7,8,95,96) & hediahf!=1
replace hediahf = 0 if inlist(hedia05,1,2,3,5,6,7,8,95,96) & hediahf!=1
replace hediahf = 0 if inlist(hedia06,1,2,3,5,6,7,8,95,96) & hediahf!=1
replace hediahf = 0 if inlist(hedia07,1,2,3,5,6,7,8,95,96) & hediahf!=1
replace hediahf = 0 if inlist(hedia08,1,2,3,5,6,7,8,95,96) & hediahf!=1
replace hediahf = 0 if inlist(hedia09,1,2,3,5,6,7,8,95,96) & hediahf!=1
replace hediahf = 0 if inlist(hedia10,1,2,3,5,6,7,8,95,96) & hediahf!=1

* Abnormal heart rhythm
gen hediahr = 1 if (hedia01 == 6 | hedia02 == 6 | hedia03 == 6 | hedia04 == 6 | hedia05 == 6 | hedia06 == 6 | hedia07 == 6 | hedia08 == 6 | hedia09 == 6 | hedia10 == 6) & wave==1
replace hediahr = 0 if inlist(hedia01,1,2,3,4,5,7,8,95,96) & hediahr!=1
replace hediahr = 0 if inlist(hedia02,1,2,3,4,5,7,8,95,96) & hediahr!=1
replace hediahr = 0 if inlist(hedia03,1,2,3,4,5,7,8,95,96) & hediahr!=1
replace hediahr = 0 if inlist(hedia04,1,2,3,4,5,7,8,95,96) & hediahr!=1
replace hediahr = 0 if inlist(hedia05,1,2,3,4,5,7,8,95,96) & hediahr!=1
replace hediahr = 0 if inlist(hedia06,1,2,3,4,5,7,8,95,96) & hediahr!=1
replace hediahr = 0 if inlist(hedia07,1,2,3,4,5,7,8,95,96) & hediahr!=1
replace hediahr = 0 if inlist(hedia08,1,2,3,4,5,7,8,95,96) & hediahr!=1
replace hediahr = 0 if inlist(hedia09,1,2,3,4,5,7,8,95,96) & hediahr!=1
replace hediahr = 0 if inlist(hedia10,1,2,3,4,5,7,8,95,96) & hediahr!=1

* Diabetes
gen hediadi = 1 if (hedia01 == 7 | hedia02 == 7 | hedia03 == 7 | hedia04 == 7 | hedia05 == 7 | hedia06 == 7 | hedia07 == 7 | hedia08 == 7 | hedia09 == 7 | hedia10 == 7) & wave==1
replace hediadi = 0 if inlist(hedia01,1,2,3,4,5,6,8,95,96) & hediadi!=1
replace hediadi = 0 if inlist(hedia02,1,2,3,4,5,6,8,95,96) & hediadi!=1
replace hediadi = 0 if inlist(hedia03,1,2,3,4,5,6,8,95,96) & hediadi!=1
replace hediadi = 0 if inlist(hedia04,1,2,3,4,5,6,8,95,96) & hediadi!=1
replace hediadi = 0 if inlist(hedia05,1,2,3,4,5,6,8,95,96) & hediadi!=1
replace hediadi = 0 if inlist(hedia06,1,2,3,4,5,6,8,95,96) & hediadi!=1
replace hediadi = 0 if inlist(hedia07,1,2,3,4,5,6,8,95,96) & hediadi!=1
replace hediadi = 0 if inlist(hedia08,1,2,3,4,5,6,8,95,96) & hediadi!=1
replace hediadi = 0 if inlist(hedia09,1,2,3,4,5,6,8,95,96) & hediadi!=1
replace hediadi = 0 if inlist(hedia10,1,2,3,4,5,6,8,95,96) & hediadi!=1

* Stroke
gen hediast = 1 if (hedia01 == 8 | hedia02 == 8 | hedia03 == 8 | hedia04 == 8 | hedia05 == 8 | hedia06 == 8 | hedia07 == 8 | hedia08 == 8 | hedia09 == 8 | hedia10 == 8) & wave==1
replace hediast = 0 if inlist(hedia01,1,2,3,4,5,6,7,95,96) & hediast!=1
replace hediast = 0 if inlist(hedia02,1,2,3,4,5,6,7,95,96) & hediast!=1
replace hediast = 0 if inlist(hedia03,1,2,3,4,5,6,7,95,96) & hediast!=1
replace hediast = 0 if inlist(hedia04,1,2,3,4,5,6,7,95,96) & hediast!=1
replace hediast = 0 if inlist(hedia05,1,2,3,4,5,6,7,95,96) & hediast!=1
replace hediast = 0 if inlist(hedia06,1,2,3,4,5,6,7,95,96) & hediast!=1
replace hediast = 0 if inlist(hedia07,1,2,3,4,5,6,7,95,96) & hediast!=1
replace hediast = 0 if inlist(hedia08,1,2,3,4,5,6,7,95,96) & hediast!=1
replace hediast = 0 if inlist(hedia09,1,2,3,4,5,6,7,95,96) & hediast!=1
replace hediast = 0 if inlist(hedia10,1,2,3,4,5,6,7,95,96) & hediast!=1

* Chronic lung disease 
gen hediald = 1 if (hedib01 == 1 | hedib02 == 1 | hedib03 == 1 | hedib04 == 1 | hedib05 == 1 | hedib06 == 1 | hedib07 == 1 | hedib08 == 1 | hedib09 == 1 | hedib10 == 1) & wave==1
replace hediald = 0 if inlist(hedib01,2,3,4,5,6,7,8,9,96) & hediald!=1
replace hediald = 0 if inlist(hedib02,2,3,4,5,6,7,8,9,96) & hediald!=1
replace hediald = 0 if inlist(hedib03,2,3,4,5,6,7,8,9,96) & hediald!=1
replace hediald = 0 if inlist(hedib04,2,3,4,5,6,7,8,9,96) & hediald!=1
replace hediald = 0 if inlist(hedib05,2,3,4,5,6,7,8,9,96) & hediald!=1
replace hediald = 0 if inlist(hedib06,2,3,4,5,6,7,8,9,96) & hediald!=1
replace hediald = 0 if inlist(hedib07,2,3,4,5,6,7,8,9,96) & hediald!=1
replace hediald = 0 if inlist(hedib08,2,3,4,5,6,7,8,9,96) & hediald!=1
replace hediald = 0 if inlist(hedib09,2,3,4,5,6,7,8,9,96) & hediald!=1
replace hediald = 0 if inlist(hedib10,2,3,4,5,6,7,8,9,96) & hediald!=1

* Asthma
gen hediaas = 1 if (hedib01 == 2 | hedib02 == 2 | hedib03 == 2 | hedib04 == 2 | hedib05 == 2 | hedib06 == 2 | hedib07 == 2 | hedib08 == 2 | hedib09 == 2 | hedib10 == 2) & wave==1
replace hediaas = 0 if inlist(hedib01,1,3,4,5,6,7,8,9,96) & hediaas!=1
replace hediaas = 0 if inlist(hedib02,1,3,4,5,6,7,8,9,96) & hediaas!=1
replace hediaas = 0 if inlist(hedib03,1,3,4,5,6,7,8,9,96) & hediaas!=1
replace hediaas = 0 if inlist(hedib04,1,3,4,5,6,7,8,9,96) & hediaas!=1
replace hediaas = 0 if inlist(hedib05,1,3,4,5,6,7,8,9,96) & hediaas!=1
replace hediaas = 0 if inlist(hedib06,1,3,4,5,6,7,8,9,96) & hediaas!=1
replace hediaas = 0 if inlist(hedib07,1,3,4,5,6,7,8,9,96) & hediaas!=1
replace hediaas = 0 if inlist(hedib08,1,3,4,5,6,7,8,9,96) & hediaas!=1
replace hediaas = 0 if inlist(hedib09,1,3,4,5,6,7,8,9,96) & hediaas!=1
replace hediaas = 0 if inlist(hedib10,1,3,4,5,6,7,8,9,96) & hediaas!=1

* Arthritis
gen hediaat = 1 if (hedib01 == 3 | hedib02 == 3 | hedib03 == 3 | hedib04 == 3 | hedib05 == 3 | hedib06 == 3 | hedib07 == 3 | hedib08 == 3 | hedib09 == 3 | hedib10 == 3) & wave==1
replace hediaat = 0 if inlist(hedib01,1,2,4,5,6,7,8,9,96) & hediaat!=1
replace hediaat = 0 if inlist(hedib02,1,2,4,5,6,7,8,9,96) & hediaat!=1
replace hediaat = 0 if inlist(hedib03,1,2,4,5,6,7,8,9,96) & hediaat!=1
replace hediaat = 0 if inlist(hedib04,1,2,4,5,6,7,8,9,96) & hediaat!=1
replace hediaat = 0 if inlist(hedib05,1,2,4,5,6,7,8,9,96) & hediaat!=1
replace hediaat = 0 if inlist(hedib06,1,2,4,5,6,7,8,9,96) & hediaat!=1
replace hediaat = 0 if inlist(hedib07,1,2,4,5,6,7,8,9,96) & hediaat!=1
replace hediaat = 0 if inlist(hedib08,1,2,4,5,6,7,8,9,96) & hediaat!=1
replace hediaat = 0 if inlist(hedib09,1,2,4,5,6,7,8,9,96) & hediaat!=1
replace hediaat = 0 if inlist(hedib10,1,2,4,5,6,7,8,9,96) & hediaat!=1

* Osteoporosis
gen hediaos = 1 if (hedib01 == 4 | hedib02 == 4 | hedib03 == 4 | hedib04 == 4 | hedib05 == 4 | hedib06 == 4 | hedib07 == 4 | hedib08 == 4 | hedib09 == 4 | hedib10 == 4) & wave==1
replace hediaos = 0 if inlist(hedib01,1,2,3,5,6,7,8,9,96) & hediaos!=1
replace hediaos = 0 if inlist(hedib02,1,2,3,5,6,7,8,9,96) & hediaos!=1
replace hediaos = 0 if inlist(hedib03,1,2,3,5,6,7,8,9,96) & hediaos!=1
replace hediaos = 0 if inlist(hedib04,1,2,3,5,6,7,8,9,96) & hediaos!=1
replace hediaos = 0 if inlist(hedib05,1,2,3,5,6,7,8,9,96) & hediaos!=1
replace hediaos = 0 if inlist(hedib06,1,2,3,5,6,7,8,9,96) & hediaos!=1
replace hediaos = 0 if inlist(hedib07,1,2,3,5,6,7,8,9,96) & hediaos!=1
replace hediaos = 0 if inlist(hedib08,1,2,3,5,6,7,8,9,96) & hediaos!=1
replace hediaos = 0 if inlist(hedib09,1,2,3,5,6,7,8,9,96) & hediaos!=1
replace hediaos = 0 if inlist(hedib10,1,2,3,5,6,7,8,9,96) & hediaos!=1

* Cancer
gen hediaca = 1 if (hedib01 == 5 | hedib02 == 5 | hedib03 == 5 | hedib04 == 5 | hedib05 == 5 | hedib06 == 5 | hedib07 == 5 | hedib08 == 5 | hedib09 == 5 | hedib10 == 5) & wave==1
replace hediaca = 0 if inlist(hedib01,1,2,3,4,6,7,8,9,96) & hediaca!=1
replace hediaca = 0 if inlist(hedib02,1,2,3,4,6,7,8,9,96) & hediaca!=1
replace hediaca = 0 if inlist(hedib03,1,2,3,4,6,7,8,9,96) & hediaca!=1
replace hediaca = 0 if inlist(hedib04,1,2,3,4,6,7,8,9,96) & hediaca!=1
replace hediaca = 0 if inlist(hedib05,1,2,3,4,6,7,8,9,96) & hediaca!=1
replace hediaca = 0 if inlist(hedib06,1,2,3,4,6,7,8,9,96) & hediaca!=1
replace hediaca = 0 if inlist(hedib07,1,2,3,4,6,7,8,9,96) & hediaca!=1
replace hediaca = 0 if inlist(hedib08,1,2,3,4,6,7,8,9,96) & hediaca!=1
replace hediaca = 0 if inlist(hedib09,1,2,3,4,6,7,8,9,96) & hediaca!=1
replace hediaca = 0 if inlist(hedib10,1,2,3,4,6,7,8,9,96) & hediaca!=1

* Parkinson's
gen hediapk = 1 if (hedib01 == 6 | hedib02 == 6 | hedib03 == 6 | hedib04 == 6 | hedib05 == 6 | hedib06 == 6 | hedib07 == 6 | hedib08 == 6 | hedib09 == 6 | hedib10 == 6) & wave==1
replace hediapk = 0 if inlist(hedib01,1,2,3,4,5,7,8,9,96) & hediapk!=1
replace hediapk = 0 if inlist(hedib02,1,2,3,4,5,7,8,9,96) & hediapk!=1
replace hediapk = 0 if inlist(hedib03,1,2,3,4,5,7,8,9,96) & hediapk!=1
replace hediapk = 0 if inlist(hedib04,1,2,3,4,5,7,8,9,96) & hediapk!=1
replace hediapk = 0 if inlist(hedib05,1,2,3,4,5,7,8,9,96) & hediapk!=1
replace hediapk = 0 if inlist(hedib06,1,2,3,4,5,7,8,9,96) & hediapk!=1
replace hediapk = 0 if inlist(hedib07,1,2,3,4,5,7,8,9,96) & hediapk!=1
replace hediapk = 0 if inlist(hedib08,1,2,3,4,5,7,8,9,96) & hediapk!=1
replace hediapk = 0 if inlist(hedib09,1,2,3,4,5,7,8,9,96) & hediapk!=1
replace hediapk = 0 if inlist(hedib10,1,2,3,4,5,7,8,9,96) & hediapk!=1

* Emotional
gen hediaem = 1 if (hedib01 == 7 | hedib02 == 7 | hedib03 == 7 | hedib04 == 7 | hedib05 == 7 | hedib06 == 7 | hedib07 == 7 | hedib08 == 7 | hedib09 == 7 | hedib10 == 7) & wave==1
replace hediaem = 0 if inlist(hedib01,1,2,3,4,5,6,8,9,96) & hediaem!=1
replace hediaem = 0 if inlist(hedib02,1,2,3,4,5,6,8,9,96) & hediaem!=1
replace hediaem = 0 if inlist(hedib03,1,2,3,4,5,6,8,9,96) & hediaem!=1
replace hediaem = 0 if inlist(hedib04,1,2,3,4,5,6,8,9,96) & hediaem!=1
replace hediaem = 0 if inlist(hedib05,1,2,3,4,5,6,8,9,96) & hediaem!=1
replace hediaem = 0 if inlist(hedib06,1,2,3,4,5,6,8,9,96) & hediaem!=1
replace hediaem = 0 if inlist(hedib07,1,2,3,4,5,6,8,9,96) & hediaem!=1
replace hediaem = 0 if inlist(hedib08,1,2,3,4,5,6,8,9,96) & hediaem!=1
replace hediaem = 0 if inlist(hedib09,1,2,3,4,5,6,8,9,96) & hediaem!=1
replace hediaem = 0 if inlist(hedib10,1,2,3,4,5,6,8,9,96) & hediaem!=1

* Alzheimer's
gen hediaaz = 1 if (hedib01 == 8 | hedib02 == 8 | hedib03 == 8 | hedib04 == 8 | hedib05 == 8 | hedib06 == 8 | hedib07 == 8 | hedib08 == 8 | hedib09 == 8 | hedib10 == 8) & wave==1
replace hediaaz = 0 if inlist(hedib01,1,2,3,4,5,6,7,9,96) & hediaaz!=1
replace hediaaz = 0 if inlist(hedib02,1,2,3,4,5,6,7,9,96) & hediaaz!=1
replace hediaaz = 0 if inlist(hedib03,1,2,3,4,5,6,7,9,96) & hediaaz!=1
replace hediaaz = 0 if inlist(hedib04,1,2,3,4,5,6,7,9,96) & hediaaz!=1
replace hediaaz = 0 if inlist(hedib05,1,2,3,4,5,6,7,9,96) & hediaaz!=1
replace hediaaz = 0 if inlist(hedib06,1,2,3,4,5,6,7,9,96) & hediaaz!=1
replace hediaaz = 0 if inlist(hedib07,1,2,3,4,5,6,7,9,96) & hediaaz!=1
replace hediaaz = 0 if inlist(hedib08,1,2,3,4,5,6,7,9,96) & hediaaz!=1
replace hediaaz = 0 if inlist(hedib09,1,2,3,4,5,6,7,9,96) & hediaaz!=1
replace hediaaz = 0 if inlist(hedib10,1,2,3,4,5,6,7,9,96) & hediaaz!=1

* Dementia
gen hediade = 1 if (hedib01 == 9 | hedib02 == 9 | hedib03 == 9 | hedib04 == 9 | hedib05 == 9 | hedib06 == 9 | hedib07 == 9 | hedib08 == 9 | hedib09 == 9 | hedib10 == 9) & wave==1
replace hediade = 0 if inlist(hedib01,1,2,3,4,5,6,7,8,96) & hediade!=1
replace hediade = 0 if inlist(hedib02,1,2,3,4,5,6,7,8,96) & hediade!=1
replace hediade = 0 if inlist(hedib03,1,2,3,4,5,6,7,8,96) & hediade!=1
replace hediade = 0 if inlist(hedib04,1,2,3,4,5,6,7,8,96) & hediade!=1
replace hediade = 0 if inlist(hedib05,1,2,3,4,5,6,7,8,96) & hediade!=1
replace hediade = 0 if inlist(hedib06,1,2,3,4,5,6,7,8,96) & hediade!=1
replace hediade = 0 if inlist(hedib07,1,2,3,4,5,6,7,8,96) & hediade!=1
replace hediade = 0 if inlist(hedib08,1,2,3,4,5,6,7,8,96) & hediade!=1
replace hediade = 0 if inlist(hedib09,1,2,3,4,5,6,7,8,96) & hediade!=1
replace hediade = 0 if inlist(hedib10,1,2,3,4,5,6,7,8,96) & hediade!=1
save interim3Watts.dta

* Eyesight 
replace heeye = . if heeye<0

* Hearing
replace hehear = . if hehear<0

* Fallen down
replace hefla = . if hefla<0

* Fractured hip
replace hefrac = . if hefrac<0

* Joint replacement
replace heji = . if heji<0

* Pain when walking 
replace mmpain = . if mmpain<0

* Day of month 
replace cfdatd = . if cfdatd<0

* Month
replace cfdatm = . if cfdatm<0

* Year 
replace cfdaty = . if cfdaty<0

* Day 
replace cfday = . if cfday<0

* Word recall - immediate
replace cflisen = . if cflisen<0

* Word recall - delayed
replace cflisd = . if cflisd<0
save interim4Watts.dta

keep if wave==1
keep idauniq hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi headldr headlwa headlba headlea headlbe headlwc headlma headlpr headlsh headlph headlme headlho headlmo health psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh hediabp hediaan hediaha hediahf hediahr hediadi hediast hediald hediaas hediaat hediaos hediaca hediapk hediaem hediaaz hediade heeye hehear hefla hefrac heji mmpain cfdatd cfdatm cfdaty cfday cflisen cflisd
unique idauniq 
* 11522

egen nmcount = rowmiss(_all)
tab nmcount
keep if nmcount<30
unique idauniq 
* 11345
save wave1Wattsfinal.dta

* Variables Wave 1
use idauniq finstat w1wgt scorg7 dhager fqethnr indager anssec enssec dhsex disex indsex edqual scptr couple1 hesmk heska hecig heskb heskc wpdes heacta heactb heactc using wave_1_core_data_v3.dta
* Describe dataset
describe
* Sort from lowest to highest participant identifier (ID)
sort idauniq
* Generate a new variable called wave and assign the number 1 to each observation (to designate Wave 1)
gen wave = 1
* Save Wave 1 core dataset
save wave1Wattsshort.dta

use wave1Wattsfinal.dta
* One-to-one merge of data in memory with data.dta on participant ID and wave
merge 1:1 idauniq using wave1Wattsshort.dta, generate (merge_short)
keep if merge_short==3
unique idauniq 
* 11345
save wave1Wattsnew.dta
append using wave2Watts.dta 
sort idauniq wave
save rawWattsfinal.dta

* Sportsclub membership 
replace scorg7 = . if scorg7<0

* Physical activity - wave 2
gen MVPA = 0 if inlist(heacta,3,4) & inlist(heactb,3,4)
replace MVPA = 1 if inlist(heacta,1,2) | inlist(heactb,1,2)

* Assign a number in ascending order to each row of observations
gen ascnr = _n
* Organising dataset
* Generate a variable that assigns the observation number (i.e., 1 for first data collection timepoint, 2 for second data collection timepoint etc.) to each row by participant ID
bysort idauniq (wave): gen obsnr = _n
* Generate a variable that assigns the number of total observations to each row of data for a given participant
bysort idauniq: gen obscount = _N
* Check how many participants have data at 1 to 8 timepoints - the "if obsnr==1" statement is used to prevent participants with data at more than one timepoint from contributing to the counts more than once
tabulate obscount if obsnr==1
keep if obscount ==2
unique idauniq 
* 8808, 17616
save wave2Wattsfinal.dta

keep idauniq wave indager edqual scorg7 MVPA
save lWatts.dta

reshape wide indager edqual scorg7 MVPA, i(idauniq) j(wave)
save wWatts.dta

keep if indager1>=60
unique idauniq 
* 5402
save wWattsage60.dta

* Education
replace edqual1 = . if edqual1<0

gen education3 = 0 if inlist(edqual1,5,7)
replace education3 = 1 if edqual1==4
replace education3 = 2 if inlist(edqual1,1,2,3)
save wWattsage60.dta, replace

gen ed2 = education3 
replace ed2 = 0 if education3==1
replace ed2 = 1 if education3==2
save wWattsage60.dta, replace

log using 20230517Watts.log
use wWattsage60.dta
keep if ed2 == 0
unique idauniq
* 3572
tab scorg71 MVPA2
clear

use wWattsage60.dta
keep if ed2 == 1
unique idauniq
* 1317
tab scorg71 MVPA2
clear

log close

use wave1Wattsnew.dta
gen smoking = 0 if hesmk==2
replace smoking = 0 if hesmk==1&heska==2
replace smoking = 1 if heska==1

* Physical activity - wave 1
gen MVPA = 0 if inlist(heacta,3,4) & inlist(heactb,3,4)
replace MVPA = 1 if inlist(heacta,1,2) | inlist(heactb,1,2)

keep if indager>=60
unique idauniq 
* 7109
save wave1Wattsnewage60.dta
tab disex
* 3,222 male, 3,887 female

* Education
replace edqual = . if edqual<0

gen education3 = 0 if inlist(edqual,5,7)
replace education3 = 1 if edqual==4
replace education3 = 2 if inlist(edqual,1,2,3)
save wave1Wattsnewage60.dta, replace

gen ed2 = education3 
replace ed2 = 0 if education3==1
replace ed2 = 1 if education3==2
save wave1Wattsnewage60.dta, replace

log using 20230517Watts.log, append
use wave1Wattsnewage60.dta
keep if ed2 == 0
unique idauniq
* 4877
tab smoking MVPA
tab disex 
* 2130 male, 2747 female
clear

use wave1Wattsnewage60.dta
keep if ed2 == 1
unique idauniq
* 1573
tab smoking MVPA
tab disex 
* 901 male, 672 female
clear
log close

use wWattsage60.dta
merge 1:1 idauniq using wave1Watts.dta, gen(merge_disex)
keep if merge_disex==3
save bysexWatts.dta
unique idauniq
* 5402
tab disex
* 2400 male, 3002 female
keep if ed2 == 0
tab disex 
* 1514 male, 2058 female
clear 
use bysexWatts.dta 
keep if ed2 == 1 
tab disex 
* 748 male, 569 female
clear