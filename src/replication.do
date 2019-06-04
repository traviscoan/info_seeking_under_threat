* Script to replicate the main findings in Coan et al. (2019)

* cd "[set working directory]"
use stdata.dta, clear

* Unpack emocond...
gen anger = 0
replace anger = 1 if emocond == 1
gen fear = 0
replace fear = 1 if emocond == 2
gen threat = 0
replace threat = 1 if emocond == 3
gen control = 0
replace control = 1 if emocond == 4
gen good_times = 0
replace good_times = 1 if emocond == 5

*******************
* Intent-to-Treat *
*******************

* Intent-to-treat effects
pwmean overall_military, over(emocond) pv
pwmean MilInt, over(emocond) pv
pwmean TerPol, over(emocond) pv
pwmean DefBud, over(emocond) pv
pwmean MilExp, over(emocond) pv

* Placebo estimates
pwmean Abort, over(emocond) pv
pwmean AffAct, over(emocond) pv
pwmean EcPhil, over(emocond) pv
pwmean EdComm, over(emocond) pv
pwmean EdPol, over(emocond) pv
pwmean EnPol, over(emocond) pv
pwmean HlthPo, over(emocond) pv
pwmean JobsPo, over(emocond) pv
pwmean JobPrf, over(emocond) pv
pwmean Welfar, over(emocond) pv

********
* CATE *
********

* Scale rating measure 0-1
replace rating = rating/10

* Generate compliance treatment -- continous
gen anger_treat = 0
replace anger_treat = rating if anger == 1
gen fear_treat = 0
replace fear_treat = rating if fear == 1

* Anger...
ivregress 2sls overall_military (anger_treat = anger) if anger == 1 | control == 1
ivregress 2sls overall_military (anger_treat = anger) if anger == 1 | good_times == 1
ivregress 2sls overall_military (anger_treat = anger) if anger == 1 | threat == 1
ivregress 2sls overall_military (anger_treat = anger) if anger == 1 | fear == 1

ivregress 2sls MilInt (anger_treat = anger) if anger == 1 | control == 1
ivregress 2sls MilInt (anger_treat = anger) if anger == 1 | good_times == 1
ivregress 2sls MilInt (anger_treat = anger) if anger == 1 | threat == 1
ivregress 2sls MilInt (anger_treat = anger) if anger == 1 | fear == 1

ivregress 2sls TerPol (anger_treat = anger) if anger == 1 | control == 1
ivregress 2sls TerPol (anger_treat = anger) if anger == 1 | good_times == 1
ivregress 2sls TerPol (anger_treat = anger) if anger == 1 | threat == 1
ivregress 2sls TerPol (anger_treat = anger) if anger == 1 | fear == 1

ivregress 2sls DefBud (anger_treat = anger) if anger == 1 | control == 1
ivregress 2sls DefBud (anger_treat = anger) if anger == 1 | good_times == 1
ivregress 2sls DefBud (anger_treat = anger) if anger == 1 | threat == 1
ivregress 2sls DefBud (anger_treat = anger) if anger == 1 | fear == 1

ivregress 2sls MilExp (anger_treat = anger) if anger == 1 | control == 1
ivregress 2sls MilExp (anger_treat = anger) if anger == 1 | good_times == 1
ivregress 2sls MilExp (anger_treat = anger) if anger == 1 | threat == 1
ivregress 2sls MilExp (anger_treat = anger) if anger == 1 | fear == 1

* Fear...
ivregress 2sls overall_military (fear_treat = fear) if fear == 1 | control == 1
ivregress 2sls overall_military (fear_treat = fear) if fear == 1 | good_times == 1
ivregress 2sls overall_military (fear_treat = fear) if fear == 1 | threat == 1
ivregress 2sls overall_military (fear_treat = fear) if fear == 1 | anger == 1

ivregress 2sls MilInt (fear_treat = fear) if fear == 1 | control == 1
ivregress 2sls MilInt (fear_treat = fear) if fear == 1 | good_times == 1
ivregress 2sls MilInt (fear_treat = fear) if fear == 1 | threat == 1
ivregress 2sls MilInt (fear_treat = fear) if fear == 1 | anger == 1

ivregress 2sls TerPol (fear_treat = fear) if fear == 1 | control == 1
ivregress 2sls TerPol (fear_treat = fear) if fear == 1 | good_times == 1
ivregress 2sls TerPol (fear_treat = fear) if fear == 1 | threat == 1
ivregress 2sls TerPol (fear_treat = fear) if fear == 1 | anger == 1

ivregress 2sls DefBud (fear_treat = fear) if fear == 1 | control == 1
ivregress 2sls DefBud (fear_treat = fear) if fear == 1 | good_times == 1
ivregress 2sls DefBud (fear_treat = fear) if fear == 1 | threat == 1
ivregress 2sls DefBud (fear_treat = fear) if fear == 1 | anger == 1

ivregress 2sls MilExp (fear_treat = fear) if fear == 1 | control == 1
ivregress 2sls MilExp (fear_treat = fear) if fear == 1 | good_times == 1
ivregress 2sls MilExp (fear_treat = fear) if fear == 1 | threat == 1
ivregress 2sls MilExp (fear_treat = fear) if fear == 1 | anger == 1
