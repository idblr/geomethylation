# ------------------------------------------------------- #
# The Intersection of Neighborhood-Level Deprivation and Survival in Lung Cancer
# ------------------------------------------------------- #
#
# Data preparation for analyses, tables, and figures
#
# Created by: Ian D. Buller, Ph.D., M.A. (@idblr)
# Created on: 2022-11-01
#
# Most recently modified by: @idblr
# Most recently modified on: 2023-07-09
#
# Notes:
# A) 2022-10-30 - Initial script created by Ignacio Jusué-Torres, MD
# B) 2023-04-26 - Updated script created by Ignacio Jusué-Torres, MD
# ------------------------------------------------------- #

############
# PACKAGES #
############

loadedPackages <- c("dplyr", "forcats", "gmodels", "Hmisc")
suppressMessages(invisible(lapply(loadedPackages, library, character.only = TRUE)))

####################
# DATA IMPORTATION #
####################

# Participant geocodes
GEO_raw <- read.csv("data/Geocoding.csv")
str(GEO_raw)

# 'data.frame':	255 obs. of  51 variables:
# $ hubert ID                   : chr
# $ ignacio new id              : int
# $ cancer..1                   : int
# $ STAGE                       : int
# $ sample type                 : chr
# $ Institution                 : chr
# $ CDO1.Plasma                 : num
# $ TAC1.Plasma                 : num
# $ HOXA7.Plasma                : num
# $ HOXA9.Plasma                : num
# $ SOX17..Plasma               : num
# $ ZPF42..Plasma               : num
# $ CDO1.pb                     : int
# $ TAC1.pb                     : int
# $ HOXA7.pb                    : int
# $ HOXA9.pb                    : int
# $ SOX17.pb                    : int
# $ ZPF42.pb                    : int
# $ Histology                   : chr
# $ Classification              : chr
# $ TNM.T                       : int
# $ TNM.N                       : int
# $ TNM.M                       : int
# $ NODAL.INVOLMENT             : chr
# $ Tumor.Size..cm.             : num
# $ DOB                         : chr
# $ Age.at.surgery              : int
# $ Age.at.the.time.of.Diagnosis: int
# $ Sex                         : chr
# $ Race                        : chr
# $ Date of Diagnosis           : chr
# $ date.of.Surgery             : chr
# $ Date of last Onc F/U        : chr
# $ FU.time                     : int
# $ Date.of.Death               : chr
# $ Death or live               : chr
# $ Death                       : int
# $ Death.time                  : int
# $ Smoker                      : chr
# $ SmokerYN                    : int
# $ Pack.Years                  : int
# $ GEOID_tr                    : integer64
# $ ADI_tr                      : num
# $ NDIpw_tr                    : num
# $ NDIpw_tr_US                 : num
# $ NDIpw_qt                    : chr
# $ NDIpw_qt_US                 : chr
# $ NDImesser_tr                : num
# $ NDImesser_tr_US             : num
# $ NDImesser_qt                : int
# $ NDImesser_qt_US             : int

GEO <- GEO_raw
GEO$NDIpw_qt_US <- GEO[ , 47] # fix names
GEO$NDImesser_qt_US <- GEO[ , 51] # fix names
GEO <- GEO[ , -c(47, 51)]

###################
# DATA MANAGEMENT #
###################

# Age
## Add label for plotting
Hmisc::label(GEO$Age.at.surgery) <- "Age at surgery"

# Sex
## Factorize (female as referent)
GEO$sex <- as.factor(GEO$Sex)
# table(GEO$sex)
# F   M 
# 133 122

# Institution
## Rename "Hopkins " as "Hopkins"
GEO$Institution <- dplyr::recode(GEO$Institution,
                                 "Hopkins " = "Hopkins")
# table(GEO$Institution, useNA = "always")
# Hopkins     UIC 
# 101         154

# Histology
## Rename "SQUAMOUS " as "SQUAMOUS"
GEO$Histology <- dplyr::recode(GEO$Histology,
                               "SQUAMOUS " = "SQUAMOUS")
# table(GEO$Histology, useNA = "always")
# ADENOCARCINOMA        ADENOSQUAMOUS SMALL CELL CARCINOMA    SQUAMOUS  <NA>
# 146                   2             11                      25        71

# Survival Status
## Recode as numeric
GEO$SurvivalStatus  <- as.numeric(GEO$Death)
# summary(GEO$SurvivalStatus)
# Min.    1st Qu.  Median    Mean    3rd Qu.    Max. 
# 0.0000  0.0000   0.0000    0.2667  1.0000     1.0000 

# Smoking Status
## Recode as "Never", "Former", and "Current"
GEO$Smoker <- dplyr::recode(GEO$Smoker,
                            "Former " = "Former",
                            "Never " = "Never",
                            "NEVER" = "Never")
# table(GEO$Smoker, useNA = "always")
# Current  Former   Never 
# 75       137      43

## Factorize (Never as referent)
GEO$smoking <- factor(GEO$Smoker, levels = c("Never", "Former", "Current"))
# table(GEO$smoking, useNA = "always")
# Never    Former   Current 
# 43       137      75

# Race/Ethnicity
## Recode "A" and "H" as "O"
GEO$Race <- dplyr::recode(GEO$Race,
                          "A" = "O",
                          "H" = "O")
# table(GEO$Race, useNA = "always")
# B    O   W 
# 121  25  109

## Factorize (W as referent)
GEO$Race <- forcats::fct_relevel(GEO$Race, "W", "O", "B")
table(GEO$Race)
# table(GEO$Race, useNA = "always")
#  W    O    B    <NA> 
#  109  25   121  0 

# Stage at diagnosis
GEO$STAGEnum <- as.numeric(GEO$STAGE)
## Factorize (0 as referent)
GEO$Stage <- as.factor(GEO$STAGE)
# table(GEO$Stage, useNA = "always")
# 0    1    2    3    4     <NA> 
# 71   90   20   29   45    0 

## Refactorize (1&2 as referent)
GEO$StageDic <- dplyr::recode(GEO$STAGE,
                              "1" = "1&2",
                              "2" = "1&2",
                              "3" = "3&4",
                              "4" = "3&4")
# table(GEO$StageDic, useNA = "always")
# 1&2   3&4  <NA> 
# 110   74   71 

## Refactorize (1-3 as referent)
GEO$Stage4 <- dplyr::recode(GEO$STAGE,
                            "1" = "1-3",
                            "2" = "1-3",
                            "3" = "1-3",
                            "4" = "4")
# table(GEO$Stage4, useNA = "always")
# 1-3    4    <NA> 
# 139    45   71
# gmodels::CrossTable(GEO$STAGE, GEO$Stage4)

# Properly classify disparity metrics
## NDI (Messer)
GEO$NDImesser_tr <- as.numeric(GEO$NDImesser_tr)
Hmisc::label(GEO$NDImesser_tr) <- "NDI (Messer; MD & IL reference)"

GEO$NDImesser_tr_US <- as.numeric(GEO$NDImesser_tr_US)
Hmisc::label(GEO$NDImesser_tr_US) <- "NDI (Messer; US reference)"

GEO$NDImesser_qt <- as.factor(GEO$NDImesser_qt)
Hmisc::label(GEO$NDImesser_qt) <- "NDI (Messer; MD & IL reference)"
levels(GEO$NDImesser_qt) <- c("Quartile 1", "Quartile 2", "Quartile 3", "Quartile 4")

GEO$NDImesser_qt.1 <- as.numeric(GEO$NDImesser_qt)
Hmisc::label(GEO$NDImesser_qt.1) <- "NDI (Messer; MD & IL reference)"

GEO$NDImesser_qt_US <- as.factor(GEO$NDImesser_qt_US)
Hmisc::label(GEO$NDImesser_qt_US) <- "NDI (Messer; US reference)"
levels(GEO$NDImesser_qt_US) <- c("Quartile 1", "Quartile 2", "Quartile 3", "Quartile 4")

GEO$NDImesser_qt_US.1 <- as.numeric(GEO$NDImesser_qt_US)
Hmisc::label(GEO$NDImesser_qt_US.1) <- "NDI (Messer; US reference)"

## NDI (Powell-Wiley)
GEO$NDIpw_tr <- as.numeric(GEO$NDIpw_tr)
Hmisc::label(GEO$NDIpw_tr) <- "NDI (Powell-Wiley; MD & IL reference)"

GEO$NDIpw_tr_US <- as.numeric(GEO$NDIpw_tr_US)
Hmisc::label(GEO$NDIpw_tr_US) <- "NDI (Powell-Wiley; US reference)"

GEO$NDIpw_qt <- as.factor(GEO$NDIpw_qt)
Hmisc::label(GEO$NDIpw_qt) <- "NDI (Powell-Wiley; MD & IL reference)"
levels(GEO$NDIpw_qt) <- c("Quintile 1", "Quintile 2", "Quintile 3", "Quintile 4", "Quintile 5", NA)

GEO$NDIpw_qt.1 <- as.numeric(GEO$NDIpw_qt)
Hmisc::label(GEO$NDIpw_qt.1) <- "NDI (Powell-Wiley; MD & IL reference)"

GEO$NDIpw_qt_US <- as.factor(GEO$NDIpw_qt_US)
Hmisc::label(GEO$NDIpw_qt_US) <- "NDI (Powell-Wiley; US reference)"
levels(GEO$NDIpw_qt_US) <- c("Quintile 1", "Quintile 2", "Quintile 3", "Quintile 4", "Quintile 5", NA)

GEO$NDIpw_qt_US.1 <- as.numeric(GEO$NDIpw_qt_US)
Hmisc::label(GEO$NDIpw_qt_US.1) <- "NDI (Powell-Wiley; US reference)"

# Biomarkers
GEO$CDO1.pb <- as.factor(GEO$CDO1.pb)
Hmisc::label(GEO$CDO1.pb) <- "CDO1"

GEO$TAC1.pb <- as.factor(GEO$TAC1.pb)
Hmisc::label(GEO$TAC1.pb) <- "TAC1"

GEO$HOXA7.pb <- as.factor(GEO$HOXA7.pb)
Hmisc::label(GEO$HOXA7.pb) <- "HOXA7"

GEO$HOXA9.pb <- as.factor(GEO$HOXA9.pb)
Hmisc::label(GEO$HOXA9.pb) <- "HOXA9"

GEO$SOX17.pb <- as.factor(GEO$SOX17.pb)
Hmisc::label(GEO$SOX17.pb) <- "SOX17"

GEO$ZPF42.pb <- as.factor(GEO$ZPF42.pb)
Hmisc::label(GEO$ZPF42.pb) <- "ZPF42"

# Create variable survival time
VARSurvTime <- as.matrix(GEO[, c("FU.time", "Death.time")])
GEO$SurvTime <- apply(VARSurvTime, 1, max, na.rm = T)
GEO$SurvTime[GEO$SurvTime == "-Inf"] <- "NA"
GEO$SurvTime <- as.numeric(GEO$SurvTime)
# summary(GEO$SurvTime)
# Min.    1st Qu.  Median    Mean    3rd Qu.    Max.    NA's 
# 0.00    5.00     26.00     37.04   55.00      193.00  3
rm(VARSurvTime)

# Dichotomize CANCER Yes or NO
CANCER <- subset(GEO, cancer..1 == "1")
CONTROL <- subset(GEO, cancer..1 == "0")

# Stage groupings
CANCER$STAGE  <- as.factor(CANCER$STAGE)
# table(CANCER$STAGE, useNA = "always")
# 1    2    3    4     <NA> 
# 90   20   29   45    0 

STAGE1 <- subset(GEO, STAGE == "1")
STAGE2 <- subset(GEO, STAGE == "2")
STAGE3 <- subset(GEO, STAGE == "3")
STAGE4 <- subset(GEO, STAGE == "4")

STAGElow <- rbind(STAGE1, STAGE2)
STAGEhigh <- rbind(STAGE3, STAGE4)

# Race/Ethnicity groupings
AA <- subset(GEO, Race == "B")
W <- subset(GEO, Race == "W")

# Dichotomize NDI (Messer; Illinois and Maryland referent)
# table(CANCER$NDImesser_qt)
# Quartile 1 Quartile 2 Quartile 3 Quartile 4 
#         39         18         32         95 
CANCER$NDImesser_qt_d <- dplyr::recode(CANCER$NDImesser_qt.1,
                                       "1" = "1-3",
                                       "2" = "1-3",
                                       "3" = "1-3",
                                       "4" = "4")
CANCER$NDImesser_qt_d <- as.factor(CANCER$NDImesser_qt_d)
# table(CANCER$NDImesser_qt_d, useNA = "always")
# 1-3  4    <NA> 
# 89   95    0
# gmodels::CrossTable(CANCER$NDImesser_qt_d, CANCER$Stage4)

# Dichotomize NDI (Messer; US referent)
# table(CANCER$NDImesser_qt_US)
# Quartile 1 Quartile 2 Quartile 3 Quartile 4 
#         44         19         38         83 
CANCER$NDImesser_qt_US_d <- dplyr::recode(CANCER$NDImesser_qt_US.1,
                                          "1" = "1-3",
                                          "2" = "1-3",
                                          "3" = "1-3",
                                          "4" = "4")
CANCER$NDImesser_qt_US_d <- as.factor(CANCER$NDImesser_qt_US_d)
# table(CANCER$NDImesser_qt_US_d, useNA = "always")
# 1-3   4    <NA> 
# 101   83    0

# Dichotomize NDI (Powell-Wiley; Illinois and Maryland referent)
# table(CANCER$NDIpw_qt.1)
# 1  2  3  4  5
# 31 26 25 38 62
CANCER$NDIpw_qt_d <- dplyr::recode(CANCER$NDIpw_qt.1,
                                   "1" = "1-4",
                                   "2" = "1-4",
                                   "3" = "1-4",
                                   "4" = "1-4",
                                   "5" = "5")
CANCER$NDIpw_qt_d <- as.factor(CANCER$NDIpw_qt_d)
# table(CANCER$NDIpw_qt_d, useNA = "always")
# 1-4   5    <NA> 
# 120   62    2

# Dichotomize NDI (Powell-Wiley; US referent)
# table(CANCER$NDIpw_qt_US.1)
# 1  2  3  4  5
# 40 23 19 40 60
CANCER$NDIpw_qt_US_d <- dplyr::recode(CANCER$NDIpw_qt_US.1,
                                   "1" = "1-4",
                                   "2" = "1-4",
                                   "3" = "1-4",
                                   "4" = "1-4",
                                   "5" = "4-5")
CANCER$NDIpw_qt_US_d <- as.factor(CANCER$NDIpw_qt_US_d)
# table(CANCER$NDIpw_qt_US_d, useNA = "always")
# 1-4  5    <NA> 
# 122  60    2

# Split for Table 1 and Figure 2H - 2N
LOWNDI <- subset(CANCER, NDImesser_qt_d == "1-3")
HIGHNDI <- subset(CANCER, NDImesser_qt_d == "4")

# Split for Figures 2H - 2N
NDI1 <- subset(CANCER, NDImesser_qt.1 == "1")
NDI2 <- subset(CANCER, NDImesser_qt.1 == "2")
NDI3 <- subset(CANCER, NDImesser_qt.1 == "3")
NDI4 <- subset(CANCER, NDImesser_qt.1 == "4")

# --------------------- END OF CODE --------------------- #
