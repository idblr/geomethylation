# ----------------------------------------------------------------------------------------------- #
# Neighborhood-Level Deprivation and Survival in Lung Cancer
# ----------------------------------------------------------------------------------------------- #
#
# Figure 1: Higher neighborhood deprivation index (NDI) values among Black patients and among
# patients with late lung cancer stages
#
# Created by: Ian D. Buller, Ph.D., M.A. (@idblr)
# Created on: 2022-11-07
#
# Most recently modified by: @idblr
# Most recently modified on: 2024-07-10
#
# Notes:
# A) 2022-10-30 (@idblr): Initial script created by Ignacio Jusué-Torres, MD
# B) 2023-04-26 (@idblr): Updated script created by Ignacio Jusué-Torres, MD
# C) 2023-07-09 (@idblr): Relabeled factor levels of 'Race' variable
# D) 2024-07-10 (@idblr): Re-formatted code
# ----------------------------------------------------------------------------------------------- #

####################
# DATA IMPORTATION #
####################

source(file.path('code', 'preparation.R'))

#######################
# ADDITIONAL PACKAGES #
#######################

loadedPackages <- c('cowplot', 'ggplot2', 'stats')
suppressMessages(invisible(lapply(loadedPackages, library, character.only = TRUE)))

############
# FIGURE 1 #
############

# Label preparation
CANCER <- CANCER %>%
  mutate(Race = fct_relevel(Race, c('W', 'B', 'O')))
levels(CANCER$Race) <- c('white', 'Black', 'other')

# Figure 1A
dt <- CANCER %>%
  count(NDImesser_qt, Race) %>%
  group_by(NDImesser_qt) %>%
  mutate(Sum = sum(n)) %>%
  mutate(percentage = n / Sum * 100)

p1a <- ggplot(data = dt) +
  geom_col(
    aes(
      x = NDImesser_qt,
      y = percentage,
      fill = Race
    ),
    position = position_dodge2(preserve = 'single')
  ) +
  scale_fill_manual(values = c('#E69F00', '#56B4E9', '#009E73')) +
  lims(y = c(0, 100)) +
  xlab('NDI (Messer; MD & IL reference)') +
  ylab('Percentage (%)') +
  labs(fill = 'Race/Ethnicity', title = 'A') +
  theme_classic()

# Figure 1B
p1b <- ggplot(data = CANCER) +
  geom_boxplot(aes(y = NDImesser_tr, fill = Race)) +
  scale_fill_manual(values = c('#E69F00', '#56B4E9', '#009E73')) +
  ylab('NDI (Messer; MD & IL reference)') +
  labs(fill = 'Race/Ethnicity', title = 'B') +
  theme_classic() +
  theme(axis.text.x = element_blank())

# Figure 1C
dt <- CANCER %>%
  count(NDImesser_qt, Stage) %>%
  group_by(NDImesser_qt) %>%
  mutate(Sum = sum(n)) %>%
  mutate(percentage = n / Sum * 100)

p1c <- ggplot(data = dt) +
  geom_col(
    aes(
      x = NDImesser_qt,
      y = percentage,
      fill = Stage
    ),
    position = position_dodge2(preserve = 'single')
  ) +
  scale_fill_manual(values = c('#E69F00', '#56B4E9', '#009E73', '#F0E442')) +
  lims(y = c(0, 100)) +
  xlab('NDI (Messer; MD & IL reference)') +
  ylab('Percentage (%)') +
  labs(fill = 'Stage', title = 'C') +
  theme_classic()

# Figure 1D
p1d <- ggplot(data = CANCER) +
  geom_boxplot(aes(y = NDImesser_tr, fill = Stage)) +
  scale_fill_manual(values = c('#E69F00', '#56B4E9', '#009E73', '#F0E442')) +
  ylab('NDI (Messer; MD & IL reference)') +
  labs(fill = 'Stage', title = 'D') +
  theme_classic() +
  theme(axis.text.x = element_blank())

# Figure 1

tmp_cow <- align_plots(p1a, p1b, p1c, p1d, align = 'hv', axis = 'tblr')
gg_inset_map <- ggdraw() +
  draw_plot(
    tmp_cow[[1]],
    x = -0.25,
    y =  0.25,
    scale = 0.5
  ) +
  draw_plot(
    tmp_cow[[2]],
    x = 0.25,
    y =  0.25,
    scale = 0.5
  ) +
  draw_plot(
    tmp_cow[[3]],
    x = -0.25,
    y =  -0.25,
    scale = 0.5
  ) +
  draw_plot(
    tmp_cow[[4]],
    x = 0.25,
    y =  -0.25,
    scale = 0.5
  )

# Print
png(file = file.path('figures', 'figure1.png'), width = 1100, height = 800)
print(gg_inset_map)
dev.off()

#################
# MISCELLANEOUS #
#################

# Figure 1A
CrossTable(CANCER$Race, CANCER$NDImesser_qt)
t.test(table(CANCER$Race, CANCER$NDImesser_qt))

# Figure 1B
summary(W$NDImesser_qt)
summary(AA$NDImesser_qt)

wilcox.test(
  W$NDImesser_qt.1,
  AA$NDImesser_qt.1,
  mu = 0,
  alt = 'two.sided',
  paired = FALSE,
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE
)

# Figure 1C
CrossTable(CANCER$STAGE, CANCER$NDImesser_qt)
t.test(table(CANCER$STAGE, CANCER$NDImesser_qt))

# Figure 1D
summary(STAGE1$NDImesser_qt)
summary(STAGE2$NDImesser_qt)
summary(STAGE3$NDImesser_qt)
summary(STAGE4$NDImesser_qt)

wilcox.test(
  STAGE1$NDImesser_qt.1,
  STAGE4$NDImesser_qt.1,
  mu = 0,
  alt = 'two.sided',
  paired = FALSE,
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE
)

# By Stage
LinearModel <- lm(as.numeric(CANCER$NDImesser_qt) ~ CANCER$STAGEnum)
summary(LinearModel)
confint(LinearModel)
exp(cbind(OR = coef(LinearModel), confint(LinearModel)))

cor.test(
  CANCER$NDImesser_qt.1,
  CANCER$STAGEnum,
  mu = 0,
  alt = 'two.sided',
  method = c('spearman'),
  conf.int = TRUE,
  conf.level = 0.95,
  exact = FALSE
)

# ----------------------------------------- END OF CODE ----------------------------------------- #
