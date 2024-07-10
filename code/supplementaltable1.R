# ----------------------------------------------------------------------------------------------- #
# Neighborhood-Level Deprivation and Survival in Lung Cancer
# ----------------------------------------------------------------------------------------------- #
#
# Supplemental Table 1: Comparison of neighborhood deprivation indices and their association with
# cancer survival (N=184) in separate univariate age-adjusted Cox proportional hazard models
#
# Created by: Ian D. Buller, Ph.D., M.A. (@idblr)
# Created on: 2022-11-12
#
# Most recently modified by: @idblr
# Most recently modified on: 2024-07-10
#
# Notes:
# A) 2022-10-30 (@idblr): Initial script created by Ignacio Jusué-Torres, MD
# B) 2023-04-26 (@idblr): Updated script created by Ignacio Jusué-Torres, MD
# C) 2024-07-10 (@idblr): Re-formatted code
# ----------------------------------------------------------------------------------------------- #

####################
# DATA IMPORTATION #
####################

source(file.path('code', 'preparation.R'))

#######################
# ADDITIONAL PACKAGES #
#######################

loadedPackages <- c('survival')
suppressMessages(invisible(lapply(loadedPackages, library, character.only = TRUE)))

########################
# SUPPLEMENTAL TABLE 1 #
########################

# Multivariate Cox Proportional Hazards
# NDI (Messer) as factor (quartiles)
# Age-adjusted
summary(CANCER$SurvTime)
table(CANCER$SurvivalStatus, CANCER$Death)

# Models
## NDI (Messer; MD & IL reference)
fs1a_cat <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDImesser_qt,
  data = CANCER
)
summary(fs1a_cat)

fs1a_dic <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDImesser_qt_d,
  data = CANCER
)
summary(fs1a_dic)

fs1a_cont <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDImesser_tr,
  data = CANCER
)
summary(fs1a_cont)

fs1a_contl <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + log(NDImesser_tr),
  data = CANCER
)
summary(fs1a_contl)

## NDI (Messer; US reference)
fs1b_cat <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDImesser_qt_US,
  data = CANCER
)
summary(fs1b_cat)

fs1b_dic <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDImesser_qt_US_d, 
  data = CANCER
)
summary(fs1b_dic)

fs1b_cont <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDImesser_tr_US,
  data = CANCER
)
summary(fs1b_cont)

fs1b_contl <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + log(NDImesser_tr_US),
  data = CANCER
)
summary(fs1b_contl)

## NDI (Powell-Wiley; MD & IL reference)
fs1c_cat <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDIpw_qt,
  data = CANCER
)
summary(fs1c_cat)

fs1c_dic <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDIpw_qt_d,
  data = CANCER
)
summary(fs1c_dic)

fs1c_cont <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDIpw_tr,
  data = CANCER
)
summary(fs1c_cont)

## NDI (Powell-Wiley; US reference)
fs1d_cat <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDIpw_qt_US,
  data = CANCER
)
summary(fs1d_cat)

fs1d_dic <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDIpw_qt_US_d,
  data = CANCER
)
summary(fs1d_dic)

fs1d_cont <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ Age.at.surgery + NDIpw_tr_US,
  data = CANCER
)
summary(fs1d_cont)

# ----------------------------------------- END OF CODE ----------------------------------------- #
