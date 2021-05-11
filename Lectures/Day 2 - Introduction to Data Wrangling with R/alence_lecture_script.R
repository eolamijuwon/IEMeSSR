#######################################################
## ALENCE IEMESSR LECTURES -- SCRIPT FOR HDI EXAMPLE ##
#######################################################

## Required packages  -- install once
## install.packages(c("readxl", "countrycode", "tidyverse", "swirl"))

## Required data -- be sure it is in your project folder
## hdi2020.xlsx
## oil_rents.RData


###################################################
### If you want to try direct download of HDI data
###################################################
## ## Break up the url for convenience, because it is long
## site_url <- "http://hdr.undp.org/"
## path_url <- "sites/default/files/"
## fn_url   <- "2020_statistical_annex_table_1.xlsx"
## 
## ## Paste the parts together
## link_url <- paste0(site_url, path_url, fn_url)
## 
## ## Download using the full url
## download.file(url=link_url,
##               method="curl",
##               destfile="hdi2020.xlsx")
##

library(readxl)
library(countrycode)
## library(tidyverse)  # optional


###################################################
### Read excel data from local file
###################################################
library(readxl)
HDI <- read_excel("hdi2020.xlsx",
                  range = "B8:K200",  # cells to read
                  col_names = FALSE,  # column names not read
                  na = c("", ".."))   # missing value strings
dim(HDI)
head(HDI)


###################################################
### HDI structure
###################################################
str(HDI)


###################################################
### Recheck for problematic columns
###################################################
head(HDI)


###################################################
### Remove unneeded columns
###################################################
## Use negative column indexes to remove columns
HDI <- HDI[ , -c(3, 5, 7, 9)]  # negative column index to remove

## Tidyverse alternative (dplyr package) (NOT RUN)
## HDI <- dplyr::select(HDI, -c(3, 5, 7, 9))


###################################################
### Rename columns
###################################################
## Old column names
colnames(HDI)

## Assign new column names
colnames(HDI) <- c("country", "hdi", "life_exp", 
                   "school_exp", "school_mean", "gni_pc")
head(HDI)


###################################################
### Identify problem rows
###################################################
head(HDI, n=2)
HDI[HDI$country == "MEDIUM HUMAN DEVELOPMENT", ]


###################################################
### Remove problem rows
###################################################
HDI <- HDI[! is.na(HDI$hdi), ]

## Tidyverse alternative (NOT RUN)
## HDI <- dplyr::filter(HDI, ! is.na(HDI$hdi))


###################################################
### Check structure
###################################################
str(HDI)


###################################################
### Check summary
###################################################
summary(HDI)


###################################################
### Histogram: HDI
###################################################
hist(HDI$hdi, 
     main="")


###################################################
### Histogram: GNI per capita
###################################################
hist(HDI$gni_pc, 
     freq=FALSE, 
     main="")
lines(density(HDI$gni_pc), 
      col="blue")


###################################################
### Calculate health index
###################################################
HDI$health_index <- (HDI$life_exp - 20) / (85 - 20)


###################################################
### Check health index
###################################################
summary(HDI$health_index)
summary(HDI$life_exp)


###################################################
### Calculate education index
###################################################
HDI$school_exp_index  <- (HDI$school_exp - 0) / (18 - 0)
HDI$school_mean_index <- (HDI$school_mean - 0) / (15 - 0)
HDI$educ_index <- (HDI$school_exp_index + HDI$school_mean_index) / 2

## Check summary
summary(HDI[, c("school_exp_index", "school_mean_index", "educ_index")])


###################################################
### Fix education index!
###################################################
## Square brackets identify values to "reassign"
HDI[HDI$school_exp_index > 1, "school_exp_index"] <- 1

## Recalculate the dimension index
HDI$educ_index <- (HDI$school_exp_index + HDI$school_mean_index) / 2

## Check summary
summary(HDI[, c("school_exp_index", "school_mean_index", "educ_index")])


###################################################
### Calculate income index
###################################################
HDI$income_index <- (log(HDI$gni_pc) - log(100)) / 
                    (log(75000) - log(100))
summary(HDI[, c("gni_pc", "income_index")])

## Enforce the upper goalpost
HDI[HDI$income_index > 1, "income_index"] <- 1
summary(HDI$income_index)


###################################################
### Calculate HDI (geometric mean of indexes)
###################################################
HDI$our_hdi <- (HDI$health_index * HDI$educ_index * 
                HDI$income_index) ^ (1/3)
summary(HDI$our_hdi)


###################################################
### Compare UNDP's HDI with ours
###################################################
summary(HDI[, c("hdi", "our_hdi")])

## Differences between HDI values
HDI$hdi_diff <- HDI$hdi - HDI$our_hdi
summary(HDI$hdi_diff)


###################################################
### Round off our HDI
###################################################
HDI$our_hdi <- round(HDI$our_hdi, digits=3)

## Recompare
HDI$hdi_diff <- HDI$hdi - HDI$our_hdi
summary(HDI$hdi_diff)


###################################################
### Plot the comparison
###################################################
plot(x=HDI$our_hdi, y=HDI$hdi,
     xlab="Our HDI",
     ylab="The UNDP's HDI",
     pch=16, cex=0.5)
abline(a=0, b=1, col="blue")  # x=y line



###################################################
### Calculate "non-income HDI"
###################################################
HDI$hdi_noninc <- sqrt(HDI$health_index * HDI$educ_index)
summary(HDI$hdi_noninc)

plot(x=HDI$income_index, y=HDI$hdi_noninc, cex=0.5)
abline(a=0, b=1, col="red", lwd=2)  # x=y line


###################################################
### Load and summarize oil-rent data
###################################################
load("oil_rents.RData")
summary(oil_rents)


###################################################
### Inspect country codes
###################################################
head(oil_rents$isocode)


###################################################
### Create country codes in HDI data
###################################################
HDI$isocode <- countrycode(HDI$country,
                           origin="country.name",
                           destination="iso3c")


###################################################
### Display some country codes
###################################################
HDI[1:15, c("country", "isocode", "hdi")]


###################################################
### Merge HDI and oil-rent data
###################################################
dim(HDI)  # dimensions before merging
HDI <- merge(x=HDI, y=oil_rents,
             by="isocode",
             all.x=TRUE)  # do not drop any "x" (HDI) data


###################################################
### A quick check of the merge
###################################################
dim(HDI)  # dimensions after merging (added one column)
table(is.na(HDI$oil_rents_pct))  # "missing" oil-rent data
rownames(HDI) <- HDI$isocode  # this will be useful later


###################################################
### Calculate non-oil vs. oil GNI
###################################################
HDI$gni_oil_pc    <- HDI$gni_pc * (HDI$oil_rents_pct / 100)
HDI$gni_nonoil_pc <- HDI$gni_pc - HDI$gni_oil_pc
summary(HDI[ , c("gni_oil_pc", "gni_nonoil_pc")])


###################################################
### code chunk number 46: take_logs
###################################################
HDI$gni_oil_pc_log    <- log(HDI$gni_oil_pc + 1)
HDI$gni_nonoil_pc_log <- log(HDI$gni_nonoil_pc)


###################################################
### Very basic linear-model output!
###################################################
lm(hdi_noninc ~ gni_oil_pc_log + gni_nonoil_pc_log, data=HDI)


###################################################
### Linear model estimate: thorough summary
###################################################
lm_out1 <- lm(hdi_noninc ~ gni_oil_pc_log + gni_nonoil_pc_log, data=HDI)
summary(lm_out1)


###################################################
### Parts of model output, and extractor functions
###################################################
names(lm_out1)
coef(lm_out1)  # extract coefficients
resid(lm_out1)[1:5]  # extract and view the first five residuals
fitted.values(lm_out1)[1:5]  # same for the fitted values


###################################################
### Diagnostic plots
###################################################
par(mfrow=c(2, 2))  # set graphics to print "2 x 2"
plot(lm_out1)


#######################################
## That completes the HDI example -- ##
## swirl instructions follow         ##
#######################################

###################################################
### Installing swirl package and R programming course
###################################################
## ## Install the swirl package -- the "infrastructure"
## install.packages("swirl")
## 
## ## Install the R programming course -- the content
## swirl::install_course("R Programming")  


###################################################
### Running swirl
###################################################
## ## "Load" (attach) the swirl package      
## library(swirl)
## 
## ## Run swirl
## swirl()  # follow the prompts to choose a course, lessons     


