# ----------------------------------------------------------------------------------------------- #
# Neighborhood-Level Deprivation and Survival in Lung Cancer
# ----------------------------------------------------------------------------------------------- #
#
# Table 1: Baseline characteristics of the 184 lung cancer patients
#
# Created by: Ian D. Buller, Ph.D., M.A. (@idblr)
# Created on: 2022-11-01
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

loadedPackages <- c('stats')
suppressMessages(invisible(lapply(loadedPackages, library, character.only = TRUE)))

###########
# TABLE 1 #
###########

# Age at surgery
summary(CANCER$Age.at.surgery)
summary(LOWNDI$Age.at.surgery)
summary(HIGHNDI$Age.at.surgery)
wilcox.test(
  LOWNDI$Age.at.surgery,
  HIGHNDI$Age.at.surgery,
  mu = 0,
  alt = 'two.sided',
  paired = FALSE,
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE
)

# Sex
table(CANCER$Sex)
CrossTable(CANCER$Sex, CANCER$NDImesser_qt_d)
fisher.test(table(CANCER$Sex, CANCER$NDImesser_qt_d))
chisq.test(table(CANCER$Sex, CANCER$NDImesser_qt_d))

# Race
table(CANCER$Race)
CrossTable(CANCER$Race, CANCER$NDImesser_qt_d)
fisher.test(table(CANCER$Race, CANCER$NDImesser_qt_d))
chisq.test(table(CANCER$Race, CANCER$NDImesser_qt_d))

# Smoking Pack Years
summary(CANCER$Pack.Years)
summary(LOWNDI$Pack.Years)
summary(HIGHNDI$Pack.Years)
wilcox.test(
  LOWNDI$Pack.Years,
  HIGHNDI$Pack.Years,
  mu = 0,
  alt = 'two.sided',
  paired = FALSE,
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE
)

# Smoking Status
table(CANCER$Smoker)
CrossTable(CANCER$Smoker, CANCER$NDImesser_qt_d)
fisher.test(table(CANCER$Smoker, CANCER$NDImesser_qt_d))
chisq.test(table(CANCER$Smoker, CANCER$NDImesser_qt_d))

# Tumor Size
summary(CANCER$Tumor.Size..cm.)
summary(LOWNDI$Tumor.Size..cm.)
summary(HIGHNDI$Tumor.Size..cm.)
wilcox.test(
  LOWNDI$Tumor.Size..cm.,
  HIGHNDI$Tumor.Size..cm.,
  mu = 0,
  alt = 'two.sided',
  paired = FALSE,
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE
)

# # Classification
# # 2024-07-10 omit Small Cell Lung Carcinoma
# CrossTable(GEO$Classification)
# CrossTable(CANCER$Classification, CANCER$NDImesser_qt_d)
# fisher.test(table(CANCER$Classification, CANCER$NDImesser_qt_d))
# chisq.test(table(CANCER$Classification, CANCER$NDImesser_qt_d)) # WARNING

# Stage
CrossTable(CANCER$STAGE)
CrossTable(CANCER$STAGE, CANCER$NDImesser_qt_d)
fisher.test(table(CANCER$STAGE, CANCER$NDImesser_qt_d))
chisq.test(table(CANCER$STAGE, CANCER$NDImesser_qt_d))

#################
# MISCELLANEOUS #
#################

#  Information (Not Included in Table 1)

# Institution
CrossTable(CANCER$Institution, CANCER$NDImesser_qt_d)

# Histology
table(CANCER$Histology, useNA = 'always')
CrossTable(CANCER$Histology, CANCER$NDImesser_qt_d)
fisher.test(table(CANCER$Histology, CANCER$NDImesser_qt_d))
chisq.test(table(CANCER$Histology, CANCER$NDImesser_qt_d)) # WARNING

# NDI (Messer; All US census tracts referent)
# NOTE: Highly correlated with NDI (Messer; Illinois and Maryland referent)...
## ... used to create LOWNDI and HIGHNDI
summary(CANCER$NDImesser_qt_US.1)
summary(LOWNDI$NDImesser_qt_US.1)
summary(HIGHNDI$NDImesser_qt_US.1)
wilcox.test(
  LOWNDI$NDImesser_qt_US.1,
  HIGHNDI$NDImesser_qt_US.1,
  mu = 0,
  alt = 'two.sided',
  paired = FALSE,
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE
)

# NDI (Powell-Wiley; Illinois and Maryland referent)
# NOTE: Highly correlated with NDI (Messer; Illinois and Maryland referent)...
## ... used to create LOWNDI and HIGHNDI
summary(CANCER$NDIpw_qt.1)
summary(LOWNDI$NDIpw_qt.1)
summary(HIGHNDI$NDIpw_qt.1)
wilcox.test(
  LOWNDI$NDIpw_qt.1,
  HIGHNDI$NDIpw_qt.1,
  mu = 0,
  alt = 'two.sided',
  paired = FALSE,
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE
)

# NDI (Powell-Wiley; All US census tracts referent)
# NOTE: Highly correlated with NDI (Messer; Illinois and Maryland referent)...
## ... used to create LOWNDI and HIGHNDI
summary(CANCER$NDIpw_qt_US.1)
summary(LOWNDI$NDIpw_qt_US.1)
summary(HIGHNDI$NDIpw_qt_US.1)
wilcox.test(
  LOWNDI$NDIpw_qt_US.1,
  HIGHNDI$NDIpw_qt_US.1,
  mu = 0,
  alt = 'two.sided',
  paired = FALSE,
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE
)

# ----------------------------------------- END OF CODE ----------------------------------------- #
