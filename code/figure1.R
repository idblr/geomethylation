# ------------------------------------------------------- #
# The Intersection of Neighborhood-Level Deprivation and Survival in Lung Cancer
# ------------------------------------------------------- #
#
# Figure 1: Higher neighborhood deprivation index (NDI) values among Black patients and among patients with late lung cancer stages
#
# Created by: Ian D. Buller, Ph.D., M.A. (@idblr)
# Created on: 2022-11-07
#
# Most recently modified by: @idblr
# Most recently modified on: 2023-07-09
#
# Notes:
# A) 2022-10-30 - Initial script created by Ignacio Jusué-Torres, MD
# B) 2023-04-26 - Updated script created by Ignacio Jusué-Torres, MD
# C) 2023-07-09 - Relabeled factor levels of "Race" variable
# ------------------------------------------------------- #

####################
# DATA IMPORTATION #
####################

source("code/preparation.R") 

#######################
# ADDITIONAL PACKAGES #
#######################

loadedPackages <- c("cowplot", "ggplot2", "stats")
suppressMessages(invisible(lapply(loadedPackages, library, character.only = TRUE)))

############
# FIGURE 1 #
############

# Label preparation
CANCER <- CANCER %>%
  mutate(Race = fct_relevel(Race, c("W","B","O")))
levels(CANCER$Race) <- c("white", "Black", "other")

# Figure 1A
dt <- CANCER %>%
  dplyr::count(NDImesser_qt, Race) %>% 
  dplyr::group_by(NDImesser_qt) %>% 
  dplyr::mutate(Sum = sum(n)) %>% 
  dplyr::mutate(percentage = n/Sum*100)

p1a <- ggplot2::ggplot(data = dt) +
  ggplot2::geom_col(ggplot2::aes(x = NDImesser_qt, 
                                 y = percentage,
                                 fill = Race),
                    position = ggplot2::position_dodge2(preserve = "single")) +
  ggplot2::scale_fill_manual(values = c("#E69F00", "#56B4E9", "#009E73")) +
  ggplot2::lims(y = c(0, 100)) +
  ggplot2::xlab("NDI (Messer; MD & IL reference)") +
  ggplot2::ylab("Percentage (%)") +
  ggplot2::labs(fill = "Race/Ethnicity", title = "A") + 
  ggplot2::theme_classic()

# Figure 1B
p1b <- ggplot2::ggplot(data = CANCER) +
  ggplot2::geom_boxplot(ggplot2::aes(y = NDImesser_tr,
                                     fill = Race)) +
  ggplot2::scale_fill_manual(values = c("#E69F00", "#56B4E9", "#009E73")) +
  ggplot2::ylab("NDI (Messer; MD & IL reference)") +
  ggplot2::labs(fill = "Race/Ethnicity", title = "B") +
  ggplot2::theme_classic() +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

# Figure 1C
dt <- CANCER %>%
  dplyr::count(NDImesser_qt, Stage) %>% 
  dplyr::group_by(NDImesser_qt) %>% 
  dplyr::mutate(Sum = sum(n)) %>% 
  dplyr::mutate(percentage = n/Sum*100)

p1c <- ggplot2::ggplot(data = dt) +
  ggplot2::geom_col(ggplot2::aes(x = NDImesser_qt, 
                                 y = percentage,
                                 fill = Stage),
                    position = ggplot2::position_dodge2(preserve = "single")) +
  ggplot2::scale_fill_manual(values = c("#E69F00", "#56B4E9", "#009E73", "#F0E442")) +
  ggplot2::lims(y = c(0, 100)) +
  ggplot2::xlab("NDI (Messer; MD & IL reference)") +
  ggplot2::ylab("Percentage (%)") +
  ggplot2::labs(fill = "Stage", title = "C") + 
  ggplot2::theme_classic()

# Figure 1D
p1d <- ggplot2::ggplot(data = CANCER) +
  ggplot2::geom_boxplot(ggplot2::aes(y = NDImesser_tr,
                                     fill = Stage)) +
  ggplot2::scale_fill_manual(values = c("#E69F00", "#56B4E9", "#009E73", "#F0E442")) +
  ggplot2::ylab("NDI (Messer; MD & IL reference)") +
  ggplot2::labs(fill = "Stage", title = "D") +
  ggplot2::theme_classic() +
  ggplot2::theme(axis.text.x = ggplot2::element_blank())

# Figure 1

tmp_cow <- cowplot::align_plots(p1a, p1b, p1c, p1d, align = "hv", axis = "tblr")
gg_inset_map <- cowplot::ggdraw() +
  cowplot::draw_plot(tmp_cow[[1]], x = -0.25, y =  0.25, scale = 0.5) +
  cowplot::draw_plot(tmp_cow[[2]], x = 0.25, y =  0.25, scale = 0.5) +
  cowplot::draw_plot(tmp_cow[[3]], x = -0.25, y =  -0.25, scale = 0.5) +
  cowplot::draw_plot(tmp_cow[[4]], x = 0.25, y =  -0.25, scale = 0.5)

# Print
grDevices::png(file = "figures/figure1.png", width = 1100, height = 800)
print(gg_inset_map)
grDevices::dev.off()

#################
# MISCELLANEOUS #
#################

# Figure 1A
gmodels::CrossTable(CANCER$Race, CANCER$NDImesser_qt)
stats::t.test(table(CANCER$Race, CANCER$NDImesser_qt))

# Figure 1B
summary(W$NDImesser_qt)
summary(AA$NDImesser_qt)

stats::wilcox.test(W$NDImesser_qt, AA$NDImesser_qt,
                   mu = 0, alt = "two.sided", paired = FALSE, conf.int = TRUE,
                   conf.level = 0.95, exact = FALSE)

# Figure 1C
gmodels::CrossTable(CANCER$STAGE, CANCER$NDImesser_qt)
stats::t.test(table(CANCER$STAGE, CANCER$NDImesser_qt))

# Figure 1D
summary(STAGE1$NDImesser_qt)
summary(STAGE2$NDImesser_qt)
summary(STAGE3$NDImesser_qt)
summary(STAGE4$NDImesser_qt)

stats::wilcox.test(STAGE1$NDImesser_qt, STAGE4$NDImesser_qt,
                   mu = 0, alt = "two.sided", paired = FALSE, conf.int = TRUE,
                   conf.level = 0.95, exact = FALSE)

# By Stage
LinearModel <- stats::lm(CANCER$NDImesser_qt ~ CANCER$STAGEnum)
summary(LinearModel)
confint(LinearModel)
exp(cbind(OR = stats::coef(LinearModel), stats::confint(LinearModel)))

stats::cor.test(CANCER$NDImesser_qt.1, CANCER$STAGEnum,
                mu = 0, alt = "two.sided",
                method = c("spearman"),
                conf.int = TRUE, conf.level = 0.95, exact = FALSE)

# --------------------- END OF CODE --------------------- #
