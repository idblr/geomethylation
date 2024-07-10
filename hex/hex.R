# ----------------------------------------------------------------------------------------------- #
# Hexagon sticker for the GitHub Repository idblr/geomethylation
# ----------------------------------------------------------------------------------------------- #
#
# Created by: Ian Buller, Ph.D., M.A. (GitHub: @idblr)
# Created on: 2022-07-23
#
# Recently modified by: @idblr
# Recently modified on: 2024-07-10
#
# Notes:
# A) Uses the 'hexSticker' package
# B) Subplot from two images with CC licenses (THANK YOU TO THE CREATORS!) See below for attribution
# C) Hexsticker for the GitHub Repository https://github.com/idblr/geomethylation
# D) 2024-07-10 (@idblr): Re-formatted code
# ----------------------------------------------------------------------------------------------- #

# Packages
library(hexSticker)

# Image file
## Adaptation of two images with CC licenses
### 1) 'SimpleGeo Places icon' by SoftFacade is licensed under CC BY 2.0.
#### Adaptations: Removed clockwork base and background color
#### Image: https://www.flickr.com/photos/12653829@N02/5244241757
#### Creator: https://www.flickr.com/photos/12653829@N02
### 2) 'Chromosomes and DNA double helix' by National Institutes of Health (NIH) is licensed under CC BY-NC 2.0. 
#### Adaptations: Cut out the double helix, rotated, zoomed, cropped, and artistic glow
#### Image: https://www.flickr.com/photos/132318516@N08/23422132554
#### Creator: https://www.flickr.com/photos/132318516@N08

path_image <- file.path('hex', 'hex_subplot.png')

# Create hexSticker
s <- sticker(
  subplot = path_image,
  package = 'geomethylation',
  # title
  p_size = 35,
  p_x = 1.27,
  p_y = 1.18,
  p_color = '#F7F742',
  # symbol
  s_x = 0.92,
  s_y = 1,
  s_width = 1,
  s_height = 0.67,
  # inside
  h_fill = '#000815',
  # outline
  h_color = '#D524DF',
  # resolution
  dpi = 1000,
  filename = file.path('hex', 'geomethylation.png'),
  white_around_sticker = F
)

# ----------------------------------------- END OF CODE ----------------------------------------- #
