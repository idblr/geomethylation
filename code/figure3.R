# ------------------------------------------------------- #
# The Intersection of Neighborhood-Level Deprivation and Survival in Lung Cancer
# ------------------------------------------------------- #
#
# Figure 3: High NDI is associated with shorter survival
#
# Created by: Ian D. Buller, Ph.D., M.A. (@idblr)
# Created on: 2022-11-07
#
# Most recently modified by: @idblr
# Most recently modified on: 2023-06-23
#
# Notes:
# A) 2022-10-30 - Initial script created by Ignacio Jusué-Torres, MD
# B) 2023-04-26 - Updated script created by Ignacio Jusué-Torres, MD
# ------------------------------------------------------- #

####################
# DATA IMPORTATION #
####################

source("code/preparation.R") 

#######################
# ADDITIONAL PACKAGES #
#######################

loadedPackages <- c("graphics", "grDevices", "survival", "survminer")
suppressMessages(invisible(lapply(loadedPackages, library, character.only = TRUE)))

############
# FIGURE 3 #
############

summary(CANCER$SurvTime)
CANCER$SurvivalStatus  <- as.numeric(CANCER$Death)
table(CANCER$SurvivalStatus, CANCER$Death)
# CANCER$NDImesser_qt_d  <- as.factor(CANCER$NDImesser_qt_d)
table(CANCER$NDImesser_qt_d)

time <- CANCER$SurvTime
status <- CANCER$SurvivalStatus
group <- CANCER$NDImesser_qt_d

# Model
f3 <- survival::survfit(survival::Surv(time, status) ~ group, data = CANCER)

summary(f3)
f3
#VALUES MEDIAN
#VALUES PROB  at 1 year and 5 years
summary(f3, time = 12)$surv
summary(f3, time = 24)$surv
summary(f3, time = 60)$surv

# Plot
p3 <- survminer::ggsurvplot(f3,
                            data = CANCER,
                            risk.table = TRUE,
                            conf.int = TRUE,
                            break.time.by = 6,
                            size = 1.5,
                            xlim = c(0, 110),
                            xlab = "Time (months)",
                            legend.labs = c("Low NDI", "High NDI"),
                            palette = c("#2E9FDF", "#E7B800"),
                            pval.method = TRUE, 
                            pval = TRUE) 

grDevices::png("figures/figure3.png", height = 800, width = 1100)
p3
grDevices::dev.off()

# --------------------- END OF CODE --------------------- #
