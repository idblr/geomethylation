# ------------------------------------------------------------------------------ #
# Hexsticker for the GitHub Repository idblr/geomethylation
# ------------------------------------------------------------------------------ #
#
# Created by: Ian Buller, Ph.D., M.A. (GitHub: @idblr)
# Created on: July 23, 2022
#
# Recently modified by: @idblr
# Recently modified on: November 11, 2022
#
# Notes:
# A) Uses the "hexSticker" package
# B) Subplot from two images with CC licenses (THANK YOU TO THE CREATORS!) See below for attribution
# C) Hexsticker for the GitHub Repository https://github.com/idblr/geomethylation
# ------------------------------------------------------------------------------ #

# Packages
library(hexSticker)

# Image file
## Adaptation of two images with CC licenses
### 1) "SimpleGeo Places icon" by SoftFacade is licensed under CC BY 2.0.
#### Adaptations: Removed clockwork base and background color
#### Image: https://www.flickr.com/photos/12653829@N02/5244241757
#### Creator: https://www.flickr.com/photos/12653829@N02
### 2) "Chromosomes and DNA double helix" by National Institutes of Health (NIH) is licensed under CC BY-NC 2.0. 
#### Adaptations: Cut out the double helix, rotated, zoomed, cropped, and artistic glow
#### Image: https://www.flickr.com/photos/132318516@N08/23422132554
#### Creator: https://www.flickr.com/photos/132318516@N08

path_image <- "hex/hex_subplot.png"

# Create hexSticker
s <- hexSticker::sticker(subplot = path_image,
                         package = "geomethylation",
                         p_size = 35, p_x = 1.27, p_y = 1.18, p_color = "#F7F742", # title
                         s_x = 0.92, s_y = 1, s_width = 1, s_height = 0.67, # symbol
                         h_fill = "#000815", # inside
                         h_color = "#D524DF", # outline
                         dpi = 1000, # resolution
                         filename = "hex/geomethylation.png",
                         white_around_sticker = F)

# -------------------------------- END OF CODE --------------------------------- #
