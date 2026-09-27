log using "output\survey_data.log", replace

*==================================================.
*analyse the survey dataset in the data folder.
*==================================================.

use "C:/CLAUDE/Projects/Project4/data/survey_data.dta", clear
*svyset the data using 3 variables: 
*wt_int as the sampling weight.
*psu as the primary sampling unit.
*strata as the stratification variable.
svyset [pw=wt_int],psu(psu) strata(strata)

*income is the outcome variables.
summ income

*treat missing values as missing to exclude from summary statistics.
mvdecode income,mv(-9/-1)

*perform survey estimation. 
*estimate the mean income accounting for complex survey design.
svy:mean income

**Publish the outputs in table form using the etable command. 
etable, cstat(_r_b) cstat(_r_se, nformat(%7.2f)) export("C:/CLAUDE/Projects/Project4/output/income.txt", replace)

*display date and time.
local date `c(current_date)'
local time `c(current_time)'
display _newline "Run `date' at `time'"

*close the log file.
log close








