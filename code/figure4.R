# --------------------------------------------------------------------------------- #
# Neighborhood-Level Deprivation and Survival in Lung Cancer
# --------------------------------------------------------------------------------- #
#
# Figure 4: High NDI is associated with increased risk of mortality among lung 
# cancer patients
#
# Created by: Ian D. Buller, Ph.D., M.A. (@idblr)
# Created on: 2022-11-07
#
# Most recently modified by: @idblr
# Most recently modified on: 2024-08-06
#
# Notes:
# A) 2022-10-30 (@idblr): Initial script created by Ignacio Jusué-Torres, MD
# B) 2023-04-26 (@idblr): Updated script created by Ignacio Jusué-Torres, MD
# C) 2023-07-09 (@idblr): Relabeled variables used in Cox models for figures
# D) 2024-07-10 (@idblr): Re-formatted code
# E) 2024-08-06 (@idblr): Re-formatted code
# --------------------------------------------------------------------------------- #

# ---------------- #
# DATA IMPORTATION #
# ---------------- #

source(file.path('code', 'preparation.R'))

# -------------------- #
# ADDITIONAL LIBRARIES #
# -------------------- #

loadedPackages <- c('grDevices', 'forestmodel', 'stats', 'survival')
suppressMessages(invisible(lapply(loadedPackages, library, character.only = TRUE)))

# -------- #
# FIGURE 4 #
# -------- #

# FIGURE 4A

## Multivariable Cox Proportional Hazards
## NDI (Messer) as factor (quartiles)
## Age-adjusted

summary(CANCER$SurvTime)
table(CANCER$SurvivalStatus, CANCER$Death)

# Label preparation
CANCER <- CANCER %>% rename(`Age at surgery` = 'Age.at.surgery')
CANCER <- CANCER %>% rename(NDI = 'NDImesser_qt')

# Model
f4a <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ `Age at surgery` + NDI,
  data = CANCER)
summary(f4a)

# Test for PH assumptions
## Scaled Schoenfeld residuals independent of time?
cox.zph(f4a)

# Test for linearity (p-trend)
f4a_ <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ `Age at surgery` + NDImesser_qt.1,
  data = CANCER
)
summary(f4a_) # numeric variable is significant
anova(f4a, f4a_) # not linear

f4a__ <- coxph(
  Surv(SurvTime, SurvivalStatus) ~ `Age at surgery` + NDImesser_tr,
  data = CANCER
)
summary(f4a__) # numeric variable is *not* significant

# Plot
p4a <- forest_model(
  f4a,
  format_options = list(
    colour = 'black',
    shape = 15,
    banded = TRUE,
    point_size = 4
  )
)

png(file.path('figures', 'figure4a.png'), height = 800, width = 1100)
p4a
dev.off()

# FIGURE 4B

## Multivariable Cox Proportional Hazards
## Stage + Race + HOXA7 + NDI (Messer) dichotomized (1-3, 4)
## Age-adjusted

# Label preparation
CANCER <- CANCER %>% rename(NDImesser_qt = 'NDI')
CANCER <- CANCER %>%
  mutate(Race = fct_relevel(Race, c('W', 'B', 'O')))
levels(CANCER$Race) <- c('white', 'Black', 'other')
CANCER$Stage <- droplevels(CANCER$Stage)
CANCER <- CANCER %>% rename(NDI = 'NDImesser_qt_d')
levels(CANCER$NDI) <- c('Low deprivation', 'High deprivation')
CANCER <- CANCER %>% rename(`HOXA7 methylation` = 'HOXA7.Plasma')

# Model
f4b <- coxph(
  Surv(SurvTime, SurvivalStatus) ~
    `Age at surgery` +
    Race +
    Stage +
    `HOXA7 methylation` +
    NDI,
  data = CANCER
)
summary(f4b)

# Test for PH assumptions
## Scaled Schoenfeld residuals independent of time?
cox.zph(f4b)

# Plot
p4b <- forest_model(
  f4b,
  format_options = list(
    colour = 'black',
    shape = 15,
    banded = TRUE,
    point_size = 4
  )
)

png(file.path('figures', 'figure4b.png'), height = 800, width = 1100)
p4b
dev.off()

# ---------------------------------- END OF CODE ---------------------------------- #
