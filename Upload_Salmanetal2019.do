* STATA version: 18.0, BE-Basic Edition

* STATA citation: StataCorp. 2023. Stata Statistical Software: Release 18. College Station, TX: StataCorp LLC. 

* Data citation: ScotCen Social Research. (2020). Scottish Health Survey, 2014. [data collection]. 4th Edition. UK Data Service. SN: 7851, DOI: http://doi.org/10.5255/UKDA-SN-7851-4

* Date of data access/download (dd/mm/yyyy): 24/05/2023

* Project ID: 237630

cd ""

use CPSerialA SYear Stype12 Main Boost Sample age Sex everbp everangi everhart evermur everireg everoht everstro everdi COPD docangi recangi docheart recheart docireg recireg docoht recoht docstro recstro medheart docnurbp stillbp docinfo1 murdoc murrec COPDDoct COPDSpir COPDTrt ConDr Housewrk HWrkList HevyHWrk HeavyDay HRSHHW MINHHW HWTIM Garden GardList ManWork ManDays HrsDIY MinDIY DIYTim Wlk5Int Wlk10M DayWlk10 Day1Wk10 Day2Wk10 hrswlk10 minwlk10 TotTim WalkPace WalkEff ActPhy WhtAcB0 TotalAct swimocc swimhrs swimmin swimtim swimeff cycleocc cyclehrs cyclemin cycletim cycleeff cyclemus weighocc weighhrs weighmin weightim weigheff weighmus aeroocc aerohrs aeromin aerotim aeroeff aeromus danceocc dancehrs dancemin dancetim danceeff dancemus runocc runhrs runmin runtim runeff runmus ftbllocc ftbllhrs ftbllmin ftblltim ftblleff ftbllmus tennocc tennhrs tennmin tenntim tenneff tennmus squasocc squashrs squasmin squastim squaseff squasmus exocc exhrs exmin extim exeff exmov exmus actaocc actahrs actamin actatim actaeff actamus actbocc actbhrs actbmin actbtim actbeff actbmus bowlocc bowlhrs bowlmin bowltim bowleff bowlmus fishocc fishhrs fishmin fishtim fisheff golfocc golfhrs golfmin golftim golfeff golfmus hillocc hillhrs hillmin hilltim hilleff hillmus snkrocc snkrhrs snkrmin snkrtim snkreff aquaocc aquahrs aquamin aquatim aquaeff aquamus yogaocc yogahrs yogamin yogatim yogaeff yogamus athlocc athlhrs athlmin athltim athleff baskocc baskhrs baskmin basktim baskeff baskmus canoocc canohrs canomin canotim canoeff climocc climhrs climmin climtim climeff cricocc crichrs cricmin crictim criceff cricmus curlocc curlhrs curlmin curltim curleff curlmus hockocc hockhrs hockmin hocktim hockeff hockmus horsocc horshrs horsmin horstim horseff skatocc skathrs skatmin skattim skateff skatmus martocc marthrs martmin marttim marteff martmus netbocc netbhrs netbmin netbtim netbeff netbmus jetsocc jetshrs jetsmin jetstim jetseff rowocc rowhrs rowmin rowtim roweff sailocc sailhrs sailmin sailtim saileff shinocc shinhrs shinmin shintim shineff shinmus sktbocc sktbhrs sktbmin sktbtim sktbeff skiocc skihrs skimin skitim skieff scubocc scubhrs scubmin scubtim scubeff surfocc surfhrs surfmin surftim surfeff surfmus tabtocc tabthrs tabtmin tabttim tabteff tenpocc tenphrs tenpmin tenptim tenpeff tenpmus vollocc vollhrs vollmin volltim volleff vollmus wskiocc wskihrs wskimin wskitim wskieff wskimus SmokEv08 SmokEv11 SmokEver SmokeNow RespHts Height RelHiteB HiNRel ResNHi EHtCh EHtm EHtFt EHtIn EMHeight RespWts Weight WtAdult RelWaitB ResNWt EWtCh EWtkg EWtSt EWtL Smoke1 Smoke4 dsmokev8 DSmokCig DSmokNow OPTIM USE RELAX INTREST ENERGY DEAL THINK GOOD CLOSE CONFID2 MIND LOVE INTRST2 CHEER smkevr cignow cigevr resptyp wemwbs murmur1 murmur2 diabete2 bp1 currbp angidef heartdef iregdef ohtdef strodef copddef recangi2 recheart2 recireg2 recoht2 recstro2 cvddef cvddef1 cvddef2 ihdis cvdis cigdyal cigst1 cigst2 cigst3 rcigst1 rcigst2 htok wtok bmiok bmi bmival htval wtval bmivg5 BMI25 BMI30 BMI40 bmivg4 bmivg6 ad10hwk ad10hwk2 ad10man ad10man2 hwkany10 manany10 hrshwk10 hrhwkg10 hrsman10 hrmang10 WalkNo10 WALKPA65 ad10wlkX ad10wlk2X ad10wlkR ad10wlk2R adwlk10bX adwlk10bR WalkNo10X WalkNo10R hrwalk10X hrwalk10R muscle MusWeek MusRec balance BalWeek BalWeekG acta actb minMspt10 minVspt10 MVPA10wk actwktime minMspt10x minVspt10x MVPA10wkx mintot10T mintot10X mintot10X2 adt10gpTW adt10gpTX adt10gpTX2 adt10gpM actaX actbX adhse10b adman10b Adsp10b adtot10b adtot10c adt10gp phytargAM phytargTM phytargCM phytargTeM phytargYM phytargA phytargT phytargC sprtdays ch00sptg actdays ch00plyg wlkdays ch00wlkg gardays ch00hswg SIMD16_RPa SIMD16_SGa porpul porsal porveg porvdish porjuice porlge porsml poroth porfrt pordry porfroz porfdish vegpor frtpor porfv porftvg porftvg5 porftvg3 frtpor2 frtany vegany porfrt2 porveg2 porjuic2 porpul2 porsal2 porfroz2 porvdis2 porfdis2 pordry2 vegpor2 frtpor3 IllCode1 IllCode2 IllCode3 IllCode4 IllCode5 IllCode6 COPD compm1 compm2a compm3 compm7a compm7b compm7c compm7d compm7e compm8 HBP_UD DIA_UD condcnt15 condct15a condct15b cond15ag cond15ag2 condphy15 limitill longill12 compm17 using shes_14151617i_archive_v2.dta

save Salman34013.dta 

keep CPSerialA SYear Stype12 Main Boost Sample age Sex everbp everangi everhart evermur everireg everoht everstro everdi COPD docangi recangi docheart recheart docireg recireg docoht recoht docstro recstro medheart docnurbp stillbp docinfo1 murdoc murrec COPDDoct COPDSpir COPDTrt ConDr Housewrk HWrkList HevyHWrk HeavyDay HRSHHW MINHHW HWTIM Garden GardList ManWork ManDays HrsDIY MinDIY DIYTim Wlk5Int Wlk10M DayWlk10 Day1Wk10 Day2Wk10 hrswlk10 minwlk10 TotTim WalkPace WalkEff ActPhy WhtAcB0 TotalAct SmokEv08 SmokEv11 SmokEver SmokeNow RespHts Height RelHiteB HiNRel ResNHi EHtCh EHtm EHtFt EHtIn EMHeight RespWts Weight WtAdult RelWaitB ResNWt EWtCh EWtkg EWtSt EWtL Smoke1 Smoke4 dsmokev8 DSmokCig DSmokNow OPTIM USE RELAX INTREST ENERGY DEAL THINK GOOD CLOSE CONFID2 MIND LOVE INTRST2 CHEER smkevr cignow cigevr resptyp wemwbs murmur1 murmur2 diabete2 bp1 currbp angidef heartdef iregdef ohtdef strodef copddef recangi2 recheart2 recireg2 recoht2 recstro2 cvddef cvddef1 cvddef2 ihdis cvdis cigdyal cigst1 cigst2 cigst3 rcigst1 rcigst2 htok wtok bmiok bmi bmival htval wtval bmivg5 BMI25 BMI30 BMI40 bmivg4 bmivg6 ad10hwk ad10hwk2 ad10man ad10man2 hwkany10 manany10 hrshwk10 hrhwkg10 hrsman10 hrmang10 WalkNo10 WALKPA65 ad10wlkX ad10wlk2X ad10wlkR ad10wlk2R adwlk10bX adwlk10bR WalkNo10X WalkNo10R hrwalk10X hrwalk10R muscle MusWeek MusRec balance BalWeek BalWeekG acta actb minMspt10 minVspt10 MVPA10wk actwktime minMspt10x minVspt10x MVPA10wkx mintot10T mintot10X mintot10X2 adt10gpTW adt10gpTX adt10gpTX2 adt10gpM actaX actbX adhse10b adman10b Adsp10b adtot10b adtot10c adt10gp phytargAM phytargTM phytargCM phytargTeM phytargYM phytargA phytargT phytargC sprtdays ch00sptg actdays ch00plyg wlkdays ch00wlkg gardays ch00hswg SIMD16_RPa SIMD16_SGa porpul porsal porveg porvdish porjuice porlge porsml poroth porfrt pordry porfroz porfdish vegpor frtpor porfv porftvg porftvg5 porftvg3 frtpor2 frtany vegany porfrt2 porveg2 porjuic2 porpul2 porsal2 porfroz2 porvdis2 porfdis2 pordry2 vegpor2 frtpor3 IllCode1 IllCode2 IllCode3 IllCode4 IllCode5 IllCode6 COPD compm1 compm2a compm3 compm7a compm7b compm7c compm7d compm7e compm8 HBP_UD DIA_UD condcnt15 condct15a condct15b cond15ag cond15ag2 condphy15 limitill longill12 compm17

save Salman34013short.dta 

unique CPSerialA
* 23929
gen diabetes = 1 if IllCode1==2 | IllCode2==2 | IllCode3==2 | IllCode4==2 | IllCode5==2 | IllCode6==2
replace diabetes = 0 if diabetes!=1
tab compm2a 
tab DIA_UD 
gen diabetes2 = 1 if compm2a==1 | DIA_UD==1
tab diabete2
keep if diabete2==1
unique CPSerialA
* 1259
save fullSalman34013.dta 

* Age 
sum age

* Sex
tab Sex
replace Sex = 0 if Sex==2

* Long-standing illness
tab longill12
replace longill12 = 0 if longill12==2

* CVD 
replace angidef = . if angidef<0
replace angidef = 0 if angidef==2
replace heartdef = . if heartdef<0
replace heartdef = 0 if heartdef==2
replace strodef = . if strodef<0
replace strodef = 0 if strodef==2
replace murmur1 = . if murmur1<0
replace murmur1 = 0 if murmur1==2
replace iregdef = . if iregdef<0
replace iregdef = 0 if iregdef==2
replace ohtdef = . if ohtdef<0
replace ohtdef = 0 if ohtdef==2 
gen CVD = angidef+heartdef+strodef+murmur1+iregdef+ohtdef
replace CVD=1 if CVD>1 & CVD!=.

* SIMD 
tab SIMD16_RPa 
tab SIMD16_SGa

* Smoking status
tab cigst1 
tab cigst3
replace cigst3=. if cigst3<0
gen smoking = 2 if cigst1==4
replace smoking = 1 if cigst1==3
replace smoking = 0 if inlist(cigst1,1,2)

* BMI 
tab bmivg6 
gen BMI =  bmivg6
replace BMI = . if inlist(BMI,1,-1)
replace bmi = . if bmi<0
replace bmival = . if bmival<0

* Portion of fruit and vegetables 
tab porftvg3
gen fruveg = porftvg3
replace fruveg = . if fruveg<0
replace fruveg = 0 if fruveg==1
replace fruveg = 1 if fruveg==2
replace porfv =. if porfv<0

* WEMWBS score 
replace OPTIM=. if OPTIM<0
replace USE=. if USE<0
replace RELAX=. if RELAX<0
replace INTREST=. if INTREST<0
replace ENERGY=. if ENERGY<0
replace DEAL=. if DEAL<0
replace THINK=. if THINK<0
replace GOOD=. if GOOD<0
replace CLOSE=. if CLOSE<0
replace CONFID2=. if CONFID2<0
replace MIND=. if MIND<0
replace LOVE=. if LOVE<0
replace INTRST2=. if INTRST2<0
replace CHEER=. if CHEER<0
gen WEMWBS = OPTIM+USE+RELAX+INTREST+ENERGY+DEAL+THINK+GOOD+CLOSE+CONFID2+MIND+LOVE+INTRST2+CHEER
replace wemwbs = . if wemwbs<0

* Physical activity
tab MusRec 
tab BalWeekG
tab adt10gpTW 
replace adt10gpTW=. if adt10gpTW<0
gen PArec = adt10gpTW
replace PArec = 0 if inlist(PArec,2,3,4)
tab adt10gpTX 
replace adt10gpTX=. if adt10gpTX<0
tab adt10gpTX2 
replace adt10gpTX2=. if adt10gpTX2<0
tab adt10gpM 
replace adt10gpM=. if adt10gpM<0
tab adt10gp 
replace adt10gp=. if adt10gp<0

logit PArec age i.Sex i.longill12 i.CVD i.SIMD16_SGa i.cigst3 bmival porfv wemwbs, or

bysort PArec: sum wemwbs
bysort PArec: sum porfv

save fullSalman34013_2.dta 
keep if age>=60
unique CPSerialA
* 883

gen SES = 0 if inlist(SIMD16_SGa,1,2)
replace SES = 1 if inlist(SIMD16_SGa,3,4,5)

save Salman34013age60.dta 

log using 20230505Salman34013.log

keep if SES==0
unique CPSerialA
* 373
logit PArec age i.Sex i.longill12 i.CVD i.cigst3 bmival porfv wemwbs, or
logit PArec i.cigst3, or
logit PArec bmival, or
logit PArec porfv, or
logit PArec wemwbs, or

tab PArec cigst3 
tab PArec BMI 
tab PArec porftvg3
tab PArec fruveg
clear 

use Salman34013age60.dta 
keep if SES==1
unique CPSerialA
* 510
logit PArec age i.Sex i.longill12 i.CVD i.cigst3 bmival porfv wemwbs, or
logit PArec i.cigst3, or
logit PArec bmival, or
logit PArec porfv, or
logit PArec wemwbs, or

tab PArec cigst3 
tab PArec BMI 
tab PArec porftvg3
tab PArec fruveg
clear

use Salman34013age60.dta 
sum wemwbs,d
gen wemwbs_bi=0 if wemwbs<=50
replace wemwbs_bi=1 if wemwbs>50 & wemwbs!=.
save Salman34013age60.dta, replace
tab Sex 
* 414 female, 469 male

keep if SES==0
unique CPSerialA
* 373
tab Sex 
* 184 female, 189 male
tab PArec wemwbs_bi
clear

use Salman34013age60.dta
keep if SES==1
unique CPSerialA
* 510
tab Sex 
* 230 female, 280 male
tab PArec wemwbs_bi
clear

log close