# ------------------------------------------------------- #
# The Intersection of Neighborhood-Level Deprivation and Survival in Lung Cancer
# ------------------------------------------------------- #
#
# Figure 2: Liquid biopsy epigenetic markers for lung cancer DNA methylation are associated with lung cancer stage and NDI.
#
# Created by: Ian D. Buller, Ph.D., M.A. (@idblr)
# Created on: 2023-06-22
#
# Most recently modified by: @idblr
# Most recently modified on: 2023-07-09
#
# Notes:
# A) 2022-10-30 - Initial script created by Ignacio Jusué-Torres, MD
# B) 2023-04-26 - Updated script created by Ignacio Jusué-Torres, MD
# C) Note: values computed here were then imported into GraphPad Prism to generate the full figure
# ------------------------------------------------------- #

####################
# DATA IMPORTATION #
####################

source("code/preparation.R") 

#######################
# ADDITIONAL PACKAGES #
#######################

loadedPackages <- c("stats")
suppressMessages(invisible(lapply(loadedPackages, library, character.only = TRUE)))

############
# FIGURE 2 #
############

# Figure 2A
stats::cor.test(CANCER$STAGEnum, CANCER$HOXA7.Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$STAGEnum, CANCER$SOX17..Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$STAGEnum, CANCER$ZPF42..Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$STAGEnum, CANCER$TAC1.Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$STAGEnum, CANCER$HOXA9.Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$STAGEnum, CANCER$CDO1.Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)

## Figure 2B
summary(STAGE1$HOXA7.Plasma)
summary(STAGE2$HOXA7.Plasma)
summary(STAGE3$HOXA7.Plasma)
summary(STAGE4$HOXA7.Plasma)
summary(STAGElow$HOXA7.Plasma)
summary(STAGEhigh$HOXA7.Plasma)

stats::wilcox.test(STAGE1$HOXA7.Plasma, STAGE2$HOXA7.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$HOXA7.Plasma, STAGE3$HOXA7.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$HOXA7.Plasma, STAGE4$HOXA7.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGElow$HOXA7.Plasma, STAGEhigh$HOXA7.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

## Figure 2C
summary(STAGE1$SOX17..Plasma)
summary(STAGE2$SOX17..Plasma)
summary(STAGE3$SOX17..Plasma)
summary(STAGE4$SOX17..Plasma)
summary(STAGElow$SOX17..Plasma)
summary(STAGEhigh$SOX17..Plasma)

stats::wilcox.test(STAGE1$SOX17..Plasma, STAGE2$SOX17..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$SOX17..Plasma, STAGE3$SOX17..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$SOX17..Plasma, STAGE4$SOX17..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGElow$SOX17..Plasma, STAGEhigh$SOX17..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

## Figure 2D
summary(STAGE1$ZPF42..Plasma)
summary(STAGE2$ZPF42..Plasma)
summary(STAGE3$ZPF42..Plasma)
summary(STAGE4$ZPF42..Plasma)
summary(STAGElow$ZPF42..Plasma)
summary(STAGEhigh$ZPF42..Plasma)

stats::wilcox.test(STAGE1$ZPF42..Plasma, STAGE2$ZPF42..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$ZPF42..Plasma, STAGE3$ZPF42..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$ZPF42..Plasma, STAGE4$ZPF42..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGElow$ZPF42..Plasma, STAGEhigh$ZPF42..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

## Figure 2E
summary(STAGE1$TAC1.Plasma)
summary(STAGE2$TAC1.Plasma)
summary(STAGE3$TAC1.Plasma)
summary(STAGE4$TAC1.Plasma)
summary(STAGElow$TAC1.Plasma)
summary(STAGEhigh$TAC1.Plasma)

stats::wilcox.test(STAGE1$TAC1.Plasma, STAGE1$TAC1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$TAC1.Plasma, STAGE2$TAC1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$TAC1.Plasma, STAGE4$TAC1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGElow$TAC1.Plasma, STAGEhigh$TAC1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

## Figure 2F
summary(STAGE1$HOXA9.Plasma)
summary(STAGE2$HOXA9.Plasma)
summary(STAGE3$HOXA9.Plasma)
summary(STAGE4$HOXA9.Plasma)
summary(STAGElow$HOXA9.Plasma)
summary(STAGEhigh$HOXA9.Plasma)

stats::wilcox.test(STAGE1$HOXA9.Plasma, STAGE2$HOXA9.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$HOXA9.Plasma, STAGE3$HOXA9.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$HOXA9.Plasma, STAGE4$HOXA9.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGElow$HOXA9.Plasma, STAGEhigh$HOXA9.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

## Figure 2G
summary(STAGE1$CDO1.Plasma)
summary(STAGE2$CDO1.Plasma)
summary(STAGE3$CDO1.Plasma)
summary(STAGE4$CDO1.Plasma)
summary(STAGElow$CDO1.Plasma)
summary(STAGEhigh$CDO1.Plasma)

stats::wilcox.test(STAGE1$CDO1.Plasma, STAGE1$CDO1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$CDO1.Plasma, STAGE2$CDO1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGE1$CDO1.Plasma, STAGE3$CDO1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(STAGElow$CDO1.Plasma, STAGEhigh$CDO1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

# Figure 2H
stats::cor.test(CANCER$NDImesser_tr, CANCER$HOXA7.Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$NDImesser_tr, CANCER$TAC1.Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$NDImesser_tr, CANCER$CDO1.Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$NDImesser_tr, CANCER$SOX17..Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$NDImesser_tr, CANCER$ZPF42..Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::cor.test(CANCER$NDImesser_tr, CANCER$HOXA9.Plasma,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)

# Figure 2I
summary(NDI1$HOXA7.Plasma)
summary(NDI2$HOXA7.Plasma)
summary(NDI3$HOXA7.Plasma)
summary(NDI4$HOXA7.Plasma)
summary(LOWNDI$HOXA7.Plasma)
summary(HIGHNDI$HOXA7.Plasma)

stats::wilcox.test(NDI1$HOXA7.Plasma, NDI2$HOXA7.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$HOXA7.Plasma, NDI2=3$HOXA7.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$HOXA7.Plasma, NDI4$HOXA7.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(LOWNDI$HOXA7.Plasma, HIGHNDI$HOXA7.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

# Figure 2J
summary(NDI1$TAC1.Plasma)
summary(NDI2$TAC1.Plasma)
summary(NDI3$TAC1.Plasma)
summary(NDI4$TAC1.Plasma)
summary(LOWNDI$TAC1.Plasma)
summary(HIGHNDI$TAC1.Plasma)

stats::wilcox.test(NDI1$TAC1.Plasma, NDI2$TAC1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$TAC1.Plasma, NDI2=3$TAC1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$TAC1.Plasma, NDI4$TAC1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(LOWNDI$TAC1.Plasma, HIGHNDI$TAC1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

# Figure 2K
summary(NDI1$CDO1.Plasma)
summary(NDI2$CDO1.Plasma)
summary(NDI3$CDO1.Plasma)
summary(NDI4$CDO1.Plasma)
summary(LOWNDI$CDO1.Plasma)
summary(HIGHNDI$CDO1.Plasma)

stats::wilcox.test(NDI1$CDO1.Plasma, NDI2$CDO1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$CDO1.Plasma, NDI2=3$CDO1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$CDO1.Plasma, NDI4$CDO1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(LOWNDI$CDO1.Plasma, HIGHNDI$CDO1.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

# Figure 2L
summary(NDI1$SOX17..Plasma)
summary(NDI2$SOX17..Plasma)
summary(NDI3$SOX17..Plasma)
summary(NDI4$SOX17..Plasma)
summary(LOWNDI$SOX17..Plasma)
summary(HIGHNDI$SOX17..Plasma)

stats::wilcox.test(NDI1$SOX17..Plasma, NDI2$SOX17..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$SOX17..Plasma, NDI2=3$SOX17..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$SOX17..Plasma, NDI4$SOX17..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(LOWNDI$SOX17..Plasma, HIGHNDI$SOX17..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

# Figure 2M
summary(NDI1$ZPF42..Plasma)
summary(NDI2$ZPF42..Plasma)
summary(NDI3$ZPF42..Plasma)
summary(NDI4$ZPF42..Plasma)
summary(LOWNDI$ZPF42..Plasma)
summary(HIGHNDI$ZPF42..Plasma)

stats::wilcox.test(NDI1$ZPF42..Plasma, NDI2$ZPF42..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$ZPF42..Plasma, NDI2=3$ZPF42..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$ZPF42..Plasma, NDI4$ZPF42..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(LOWNDI$ZPF42..Plasma, HIGHNDI$ZPF42..Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

# Figure 2N
summary(NDI1$HOXA9.Plasma)
summary(NDI2$HOXA9.Plasma)
summary(NDI3$HOXA9.Plasma)
summary(NDI4$HOXA9.Plasma)
summary(LOWNDI$HOXA9.Plasma)
summary(HIGHNDI$HOXA9.Plasma)

stats::wilcox.test(NDI1$HOXA9.Plasma, NDI2$HOXA9.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$HOXA9.Plasma, NDI2=3$HOXA9.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(NDI1$HOXA9.Plasma, NDI4$HOXA9.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)
stats::wilcox.test(LOWNDI$HOXA9.Plasma, HIGHNDI$HOXA9.Plasma,
                   mu = 0, alt = "two.sided", paired = FALSE,
                   conf.int = TRUE, conf.level = 0.95, exact = FALSE)

# --------------------- END OF CODE --------------------- #
