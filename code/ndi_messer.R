# --------------------------------------------------------------------------------- #
# Neighborhood-Level Deprivation and Survival in Lung Cancer
# --------------------------------------------------------------------------------- #
#
# U.S. Census Neighborhood Deprivation Index (Messer et al. 2006)
#
# Created by: Ian Buller, Ph.D., M.A. (GitHub: @idblr)
# Created on: 2022-07-21
#
# Most recently modified by: @idblr
# Most recently modified on: 2024-08-06
#
# Notes:
# A) Messer et al. (2006) Neighborhood Deprivation Index (NDI):
#    https://doi.org/10.1007/s11524-006-9094-x
# B) Assign U.S. Census tracts based on decennial at time of collection (2000 v. 2010)
# C) NDI years (ACS-5) available: 2010-2020
# D) Referent is Illinois and Maryland, combined (not U.S. National [for now])
# E) Link patients to NDI at or before date of collection: [2000-2010], [2011], ..., [2020-2021]
# F) Format file paths for your own directory
# G) 2024-07-10 (@idblr): Re-formatted code
# H) 2024-08-06 (@idblr): Re-formatted code
# --------------------------------------------------------------------------------- #

# -------- #
# PACKAGES #
# -------- #

loadedPackages <- c('dplyr', 'ndi', 'sf', 'tidycensus', 'tigris')
suppressMessages(invisible(lapply(loadedPackages, library, character.only = TRUE)))

# -------- #
# SETTINGS #
# -------- #

options(tigris_use_cache = TRUE)

## Access Key for census data download
### Obtain one at http://api.census.gov/data/key_signup.html
census_api_key('...') # INSERT YOUR OWN KEY FROM U.S. CENSUS API

# ---------------- #
# DATA IMPORTATION #
# ---------------- #

# Participant geocodes
load(file.path('data', 'UIC_demographics_2822.RDA'))
str(hulbert5)

# tibble [217 × 23] (S3: tbl_df/tbl/data.frame)
# $ UIC_ID             : chr [1:217]
# $ year_collected     : num [1:217]
# $ UIC_Address        : chr [1:217]
# $ Match_status       : chr [1:217]
# $ Match_type         : chr [1:217]
# $ GEO_address        : chr [1:217]
# $ GEO_coord          : chr [1:217]
# $ tigerline_ID       : num [1:217]
# $ tigerline_side     : chr [1:217]
# $ state_ID           : num [1:217]
# $ county_ID          : num [1:217]
# $ census_tract_ID    : num [1:217]
# $ block_ID           : num [1:217]
# $ CB_GEOID           : num [1:217]
# $ Track_Code         : num [1:217]
# $ CT_Name            : num [1:217]
# $ reason_for_no_match: chr [1:217]
# $ ...17              : chr [1:217]
# $ ...18              : num [1:217]
# $ Tract              : chr [1:217]
# $ County             : chr [1:217]
# $ State              : chr [1:217]
# $ GEOID              : num [1:217]

table(hulbert5$year_collected)

# Additional Illinois Samples (06/09/2022)
hulbert6 <-
  read.xlsx(
    file = file.path(
      'data',
      'Copy_of_Not_included_in_Geocoding_060922_V3_wGeocodes.xlsx'
    ),
    sheetIndex = 1
  )
str(hulbert6)

# 'data.frame':	60 obs. of  8 variables:
# $ Hulbert.study.ID              : chr
# $ Deidentifier.for.Ian.and.Emily: logi
# $ Year.of.baseline.visit        : num
# $ Address                       : chr
# $ Postal.Code...Current         : num
# $ X                             : num
# $ Y                             : num
# $ Notes                         : chr

table(hulbert6$Year.of.baseline.visit)

# US States
us <- states()
n51 <-
  c(
    'Commonwealth of the Northern Mariana Islands',
    'Guam',
    'American Samoa',
    'Puerto Rico',
    'United States Virgin Islands'
  )
y51 <- us$STUSPS[!(us$NAME %in% n51)]

# NDI 2010
ndi2010 <- messer(state = c('IL', 'MD'), year = 2010)
ndi2010US <- messer(state = y51, year = 2010)

# NDI 2011
ndi2011 <- messer(state = c('IL', 'MD'), year = 2011)
ndi2011US <- messer(state = y51, year = 2011)

# NDI 2012
ndi2012 <- messer(state = c('IL', 'MD'), year = 2012)
ndi2012US <- messer(state = y51, year = 2012)

# NDI 2013
ndi2013 <- messer(state = c('IL', 'MD'), year = 2013)
ndi2013US <- messer(state = y51, year = 2013)

# NDI 2014
ndi2014 <- messer(state = c('IL', 'MD'), year = 2014)
ndi2014US <- messer(state = y51, year = 2014)

# NDI 2015
ndi2015 <- messer(state = c('IL', 'MD'), year = 2015)
ndi2015US <- messer(state = y51, year = 2015)

# NDI 2016
ndi2016 <- messer(state = c('IL', 'MD'), year = 2016)
ndi2016US <- messer(state = y51, year = 2016)

# NDI 2017
ndi2017 <- messer(state = c('IL', 'MD'), year = 2017)
ndi2017US <- messer(state = y51, year = 2017)

# NDI 2018
ndi2018 <- messer(state = c('IL', 'MD'), year = 2018)
ndi2018US <- messer(state = y51, year = 2018)

# NDI 2019
ndi2019 <- messer(state = c('IL', 'MD'), year = 2019)
ndi2019US <- messer(state = y51, year = 2019)

# NDI 2020
ndi2020 <- messer(state = c('IL', 'MD'), year = 2020)
ndi2020US <- messer(state = y51, year = 2020)

# 2010 Census Tract Files
IL2010_tract <- tracts(state = 'Illinois', year = 2010)
MD2010_tract <- tracts(state = 'Maryland', year = 2010)
tract2010 <- rbind(IL2010_tract, MD2010_tract)

IL2020_tract <- tracts(state = 'Illinois', year = 2020)
MD2020_tract <- tracts(state = 'Maryland', year = 2020)
tract2020 <- rbind(IL2020_tract, MD2020_tract)

# ------------------------- #
# U.S. CENSUS TRACT GEOCODE #
# ------------------------- #

# Coordinates
## Format longitude into a separate feature (column)
hulbert5$Longitude <- as.numeric(gsub(',.*$', '', hulbert5$GEO_coord)) 
## Format latitude into a separate feature (column)
hulbert5$Latitude <- as.numeric(gsub('.*\\,', '', hulbert5$GEO_coord)) 

## Format longitude into a separate feature (column)
hulbert6$Longitude <- as.numeric(gsub(',.*$', '', hulbert6$X)) 
## Format latitude into a separate feature (column)
hulbert6$Latitude <- as.numeric(gsub('.*\\,', '', hulbert6$Y)) 

# Convert to sf object
hulbert1 <-
  st_as_sf(
    hulbert5,
    coords = c('Longitude', 'Latitude'),
    crs = 4269,
    agr = 'constant'
  ) #NAD83 to match U.S. Census tract data
hulbert2 <-
  st_as_sf(
    hulbert6,
    coords = c('Longitude', 'Latitude'),
    crs = 4269,
    agr = 'constant'
  ) #NAD83 to match U.S. Census tract data

# Separate by year
## Which year for tracts
hulbert1$year_tr <- cut(
  x = hulbert1$year_collected,
  breaks = c(0, 2020, 2023),
  right = FALSE,
  labels = c('2010', '2020')
)
table(hulbert1$year_tr, hulbert1$year_collected)
table(hulbert1$year_tr)

hulbert2$year_tr <- cut(
  x = hulbert2$Year_of_baseline_visit,
  breaks = c(0, 2020, 2023),
  right = FALSE,
  labels = c('2010', '2020')
)
table(hulbert2$year_tr, hulbert2$Year_of_baseline_visit)
table(hulbert2$year_tr)

## Which year for NDI
hulbert1$year_ndi <- cut(
  x = hulbert1$year_collected,
  breaks = c(0, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2023),
  right = FALSE,
  labels = c(
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020'
  )
)
table(hulbert1$year_ndi, hulbert1$year_collected)
table(hulbert1$year_ndi)

hulbert2$year_ndi <- cut(
  x = hulbert2$Year_of_baseline_visit,
  breaks = c(0, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2023),
  right = FALSE,
  labels = c(
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020'
  )
)
table(hulbert2$year_ndi, hulbert2$Year_of_baseline_visit)
table(hulbert2$year_ndi)

## Which year census tract
hulbert1_2010 <- hulbert1[hulbert1$year_tr == '2010',]
hulbert1_2020 <- hulbert1[hulbert1$year_tr != '2010',]

hulbert2_2010 <- hulbert2[hulbert2$year_tr == '2010',] # zero
hulbert2_2020 <- hulbert2[hulbert2$year_tr != '2010',] # all additional IL samples

# Census tract by year
hulbert1_2010$GEOID_tr <- tract2010$GEOID10[unlist(st_intersects(hulbert1_2010, tract2010))]
hulbert1_2020$GEOID_tr <- tract2020$GEOID[unlist(st_intersects(hulbert1_2020, tract2020))]

hulbert2_2010$GEOID_tr <- tract2010$GEOID10[unlist(st_intersects(hulbert2_2010, tract2010))]
hulbert2_2020$GEOID_tr <- tract2020$GEOID[unlist(st_intersects(hulbert2_2020, tract2020))]

## Combine census tract
hulbert1 <- rbind(as.data.frame(hulbert1_2010), as.data.frame(hulbert1_2020))
hulbert1$GEOID_tr <- as.numeric(hulbert1$GEOID_tr)
hulbert1 <- hulbert1[order(as.numeric(hulbert1$UIC_ID)),]

hulbert2 <- rbind(as.data.frame(hulbert2_2010), as.data.frame(hulbert2_2020))
hulbert2$GEOID_tr <- as.numeric(hulbert2$GEOID_tr)
hulbert2 <- hulbert2[order(as.numeric(hulbert2$Hulbert_study_ID)),]

######################
# GEOGRAPHIC LINKAGE #
######################

length(unique(as.data.frame(hulbert1)[!is.na(hulbert1$GEOID), 'GEOID'])) / 195
## n=175 unique census tracts (90%)
length(unique(as.data.frame(hulbert1)[!is.na(hulbert1$GEOID_tr), 'GEOID_tr'])) / 195 
## n=195 unique census tracts (100%)
length(unique(as.data.frame(hulbert2)[!is.na(hulbert2$GEOID_tr), 'GEOID_tr'])) / 60
## n=57 unique census tracts (95%)

# Assign NDI (continuous) by year
## MD and IL as referent
hulbert1$NDImesser_tr <-
  ifelse(
    hulbert1$year_ndi == '2010',
    pull(ndi2010$ndi[match(hulbert1$GEOID_tr, ndi2010$ndi$GEOID),], NDI),
    ifelse(
      hulbert1$year_ndi == '2011',
      pull(ndi2011$ndi[match(hulbert1$GEOID_tr, ndi2011$ndi$GEOID),], NDI),
      ifelse(
        hulbert1$year_ndi == '2012',
        pull(ndi2012$ndi[match(hulbert1$GEOID_tr, ndi2012$ndi$GEOID),], NDI),
        ifelse(
          hulbert1$year_ndi == '2013',
          pull(ndi2013$ndi[match(hulbert1$GEOID_tr, ndi2013$ndi$GEOID),], NDI),
          ifelse(
            hulbert1$year_ndi == '2014',
            pull(ndi2014$ndi[match(hulbert1$GEOID_tr, ndi2014$ndi$GEOID),], NDI),
            ifelse(
              hulbert1$year_ndi == '2015',
              pull(ndi2015$ndi[match(hulbert1$GEOID_tr, ndi2015$ndi$GEOID),], NDI),
              ifelse(
                hulbert1$year_ndi == '2016',
                pull(ndi2016$ndi[match(hulbert1$GEOID_tr, ndi2016$ndi$GEOID),], NDI),
                ifelse(
                  hulbert1$year_ndi == '2017',
                  pull(ndi2017$ndi[match(hulbert1$GEOID_tr, ndi2017$ndi$GEOID),], NDI),
                  ifelse(
                    hulbert1$year_ndi == '2018',
                    pull(ndi2018$ndi[match(hulbert1$GEOID_tr, ndi2018$ndi$GEOID),], NDI),
                    ifelse(
                      hulbert1$year_ndi == '2019',
                      pull(ndi2019$ndi[match(hulbert1$GEOID_tr, ndi2019$ndi$GEOID),], NDI),
                      ifelse(
                        hulbert1$year_ndi == '2020',
                        pull(ndi2020$ndi[match(hulbert1$GEOID_tr, ndi2020$ndi$GEOID),], NDI),
                        NA
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
# Remove values for excluded participants
hulbert1$NDImesser_tr <- ifelse(is.na(hulbert1$GEOID), NA, hulbert1$NDImesser_tr)
table(is.na(hulbert1$NDImesser_tr), is.na(hulbert1$GEOID_tr)) # n=22 missing NDI

hulbert2$NDImesser_tr <-
  ifelse(
    hulbert2$year_ndi == '2010',
    pull(ndi2010$ndi[match(hulbert2$GEOID_tr, ndi2010$ndi$GEOID),], NDI),
    ifelse(
      hulbert2$year_ndi == '2011',
      pull(ndi2011$ndi[match(hulbert2$GEOID_tr, ndi2011$ndi$GEOID),], NDI),
      ifelse(
        hulbert2$year_ndi == '2012',
        pull(ndi2012$ndi[match(hulbert2$GEOID_tr, ndi2012$ndi$GEOID),], NDI),
        ifelse(
          hulbert2$year_ndi == '2013',
          pull(ndi2013$ndi[match(hulbert2$GEOID_tr, ndi2013$ndi$GEOID),], NDI),
          ifelse(
            hulbert2$year_ndi == '2014',
            pull(ndi2014$ndi[match(hulbert2$GEOID_tr, ndi2014$ndi$GEOID),], NDI),
            ifelse(
              hulbert2$year_ndi == '2015',
              pull(ndi2015$ndi[match(hulbert2$GEOID_tr, ndi2015$ndi$GEOID),], NDI),
              ifelse(
                hulbert2$year_ndi == '2016',
                pull(ndi2016$ndi[match(hulbert2$GEOID_tr, ndi2016$ndi$GEOID),], NDI),
                ifelse(
                  hulbert2$year_ndi == '2017',
                  pull(ndi2017$ndi[match(hulbert2$GEOID_tr, ndi2017$ndi$GEOID),], NDI),
                  ifelse(
                    hulbert2$year_ndi == '2018',
                    pull(ndi2018$ndi[match(hulbert2$GEOID_tr, ndi2018$ndi$GEOID),], NDI),
                    ifelse(
                      hulbert2$year_ndi == '2019',
                      pull(ndi2019$ndi[match(hulbert2$GEOID_tr, ndi2019$ndi$GEOID),], NDI),
                      ifelse(
                        hulbert2$year_ndi == '2020', 
                        pull(ndi2020$ndi[match(hulbert2$GEOID_tr, ndi2020$ndi$GEOID),], NDI), 
                        NA
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
# Remove values for excluded participants
hulbert2$NDImesser_tr <- ifelse(is.na(hulbert2$GEOID), NA, hulbert2$NDImesser_tr)
table(is.na(hulbert2$NDImesser_tr), is.na(hulbert2$GEOID_tr)) # n=0 missing NDI

## US as referent
hulbert1$NDImesser_tr_US <-
  ifelse(
    hulbert1$year_ndi == '2010',
    pull(ndi2010US$ndi[match(hulbert1$GEOID_tr, ndi2010US$ndi$GEOID),], NDI),
    ifelse(
      hulbert1$year_ndi == '2011',
      pull(ndi2011US$ndi[match(hulbert1$GEOID_tr, ndi2011US$ndi$GEOID),], NDI),
      ifelse(
        hulbert1$year_ndi == '2012',
        pull(ndi2012US$ndi[match(hulbert1$GEOID_tr, ndi2012US$ndi$GEOID),], NDI),
        ifelse(
          hulbert1$year_ndi == '2013',
          pull(ndi2013US$ndi[match(hulbert1$GEOID_tr, ndi2013US$ndi$GEOID),], NDI),
          ifelse(
            hulbert1$year_ndi == '2014',
            pull(ndi2014US$ndi[match(hulbert1$GEOID_tr, ndi2014US$ndi$GEOID),], NDI),
            ifelse(
              hulbert1$year_ndi == '2015',
              pull(ndi2015US$ndi[match(hulbert1$GEOID_tr, ndi2015US$ndi$GEOID),], NDI),
              ifelse(
                hulbert1$year_ndi == '2016',
                pull(ndi2016US$ndi[match(hulbert1$GEOID_tr, ndi2016US$ndi$GEOID),], NDI),
                ifelse(
                  hulbert1$year_ndi == '2017',
                  pull(ndi2017US$ndi[match(hulbert1$GEOID_tr, ndi2017US$ndi$GEOID),], NDI),
                  ifelse(
                    hulbert1$year_ndi == '2018',
                    pull(ndi2018US$ndi[match(hulbert1$GEOID_tr, ndi2018US$ndi$GEOID),], NDI),
                    ifelse(
                      hulbert1$year_ndi == '2019',
                      pull(ndi2019US$ndi[match(hulbert1$GEOID_tr, ndi2019US$ndi$GEOID),], NDI),
                      ifelse(
                        hulbert1$year_ndi == '2020', 
                        pull(ndi2020US$ndi[match(hulbert1$GEOID_tr, ndi2020US$ndi$GEOID),], NDI), 
                        NA
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
# Remove values for excluded participants
hulbert1$NDImesser_tr_US <- ifelse(is.na(hulbert1$GEOID), NA, hulbert1$NDImesser_tr_US)
table(is.na(hulbert1$NDImesser_tr_US), is.na(hulbert1$GEOID_tr)) # n=22 missing NDI

hulbert2$NDImesser_tr_US <-
  ifelse(
    hulbert2$year_ndi == '2010',
    pull(ndi2010US$ndi[match(hulbert2$GEOID_tr, ndi2010US$ndi$GEOID),], NDI),
    ifelse(
      hulbert2$year_ndi == '2011',
      pull(ndi2011US$ndi[match(hulbert2$GEOID_tr, ndi2011US$ndi$GEOID),], NDI),
      ifelse(
        hulbert2$year_ndi == '2012',
        pull(ndi2012US$ndi[match(hulbert2$GEOID_tr, ndi2012US$ndi$GEOID),], NDI),
        ifelse(
          hulbert2$year_ndi == '2013',
          pull(ndi2013US$ndi[match(hulbert2$GEOID_tr, ndi2013US$ndi$GEOID),], NDI),
          ifelse(
            hulbert2$year_ndi == '2014',
            pull(ndi2014US$ndi[match(hulbert2$GEOID_tr, ndi2014US$ndi$GEOID),], NDI),
            ifelse(
              hulbert2$year_ndi == '2015',
              pull(ndi2015US$ndi[match(hulbert2$GEOID_tr, ndi2015US$ndi$GEOID),], NDI),
              ifelse(
                hulbert2$year_ndi == '2016',
                pull(ndi2016US$ndi[match(hulbert2$GEOID_tr, ndi2016US$ndi$GEOID),], NDI),
                ifelse(
                  hulbert2$year_ndi == '2017',
                  pull(ndi2017US$ndi[match(hulbert2$GEOID_tr, ndi2017US$ndi$GEOID),], NDI),
                  ifelse(
                    hulbert2$year_ndi == '2018',
                    pull(ndi2018US$ndi[match(hulbert2$GEOID_tr, ndi2018US$ndi$GEOID),], NDI),
                    ifelse(
                      hulbert2$year_ndi == '2019',
                      pull(ndi2019US$ndi[match(hulbert2$GEOID_tr, ndi2019US$ndi$GEOID),], NDI),
                      ifelse(
                        hulbert2$year_ndi == '2020', 
                        pull(ndi2020US$ndi[match(hulbert2$GEOID_tr, ndi2020US$ndi$GEOID),], NDI), 
                        NA
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
# Remove values for excluded participants
hulbert2$NDImesser_tr_US <- ifelse(is.na(hulbert2$GEOID), NA, hulbert2$NDImesser_tr_US)
table(is.na(hulbert2$NDImesser_tr_US), is.na(hulbert2$GEOID_tr)) # n=0 missing NDI

# Assign NDI (categorical, quartiles) by year
## MD and IL as referent
hulbert1$NDImesser_qt <-
  ifelse(
    hulbert1$year_ndi == '2010',
    pull(ndi2010$ndi[match(hulbert1$GEOID_tr, ndi2010$ndi$GEOID),], NDIQuart),
    ifelse(
      hulbert1$year_ndi == '2011',
      pull(ndi2011$ndi[match(hulbert1$GEOID_tr, ndi2011$ndi$GEOID),], NDIQuart),
      ifelse(
        hulbert1$year_ndi == '2012',
        pull(ndi2012$ndi[match(hulbert1$GEOID_tr, ndi2012$ndi$GEOID),], NDIQuart),
        ifelse(
          hulbert1$year_ndi == '2013',
          pull(ndi2013$ndi[match(hulbert1$GEOID_tr, ndi2013$ndi$GEOID),], NDIQuart),
          ifelse(
            hulbert1$year_ndi == '2014',
            pull(ndi2014$ndi[match(hulbert1$GEOID_tr, ndi2014$ndi$GEOID),], NDIQuart),
            ifelse(
              hulbert1$year_ndi == '2015',
              pull(ndi2015$ndi[match(hulbert1$GEOID_tr, ndi2015$ndi$GEOID),], NDIQuart),
              ifelse(
                hulbert1$year_ndi == '2016',
                pull(ndi2016$ndi[match(hulbert1$GEOID_tr, ndi2016$ndi$GEOID),], NDIQuart),
                ifelse(
                  hulbert1$year_ndi == '2017',
                  pull(ndi2017$ndi[match(hulbert1$GEOID_tr, ndi2017$ndi$GEOID),], NDIQuart),
                  ifelse(
                    hulbert1$year_ndi == '2018',
                    pull(ndi2018$ndi[match(hulbert1$GEOID_tr, ndi2018$ndi$GEOID),], NDIQuart),
                    ifelse(
                      hulbert1$year_ndi == '2019',
                      pull(ndi2019$ndi[match(hulbert1$GEOID_tr, ndi2019$ndi$GEOID),], NDIQuart),
                      ifelse(
                        hulbert1$year_ndi == '2020', 
                        pull(ndi2020$ndi[match(hulbert1$GEOID_tr, ndi2020$ndi$GEOID),], NDIQuart), 
                        NA
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
# Remove values for excluded participants
hulbert1$NDImesser_qt <- ifelse(is.na(hulbert1$GEOID), NA, hulbert1$NDImesser_qt)
hulbert1$NDImesser_qt <-
  factor(hulbert1$NDImesser_qt, labels = levels(ndi2020$ndi$NDIQuart)[-5])
table(is.na(hulbert1$NDImesser_qt), is.na(hulbert1$GEOID_tr)) # n=22 missing NDI
table(hulbert1$NDImesser_qt, useNA = 'always')
# 1-Least deprivation 2-BelowAvg deprivation 3-AboveAvg deprivation     4-Most deprivation    <NA>
#                  49                     24                     32                     90      22

hulbert2$NDImesser_qt <-
  ifelse(
    hulbert2$year_ndi == '2010',
    pull(ndi2010$ndi[match(hulbert2$GEOID_tr, ndi2010$ndi$GEOID),], NDIQuart),
    ifelse(
      hulbert2$year_ndi == '2011',
      pull(ndi2011$ndi[match(hulbert2$GEOID_tr, ndi2011$ndi$GEOID),], NDIQuart),
      ifelse(
        hulbert2$year_ndi == '2012',
        pull(ndi2012$ndi[match(hulbert2$GEOID_tr, ndi2012$ndi$GEOID),], NDIQuart),
        ifelse(
          hulbert2$year_ndi == '2013',
          pull(ndi2013$ndi[match(hulbert2$GEOID_tr, ndi2013$ndi$GEOID),], NDIQuart),
          ifelse(
            hulbert2$year_ndi == '2014',
            pull(ndi2014$ndi[match(hulbert2$GEOID_tr, ndi2014$ndi$GEOID),], NDIQuart),
            ifelse(
              hulbert2$year_ndi == '2015',
              pull(ndi2015$ndi[match(hulbert2$GEOID_tr, ndi2015$ndi$GEOID),], NDIQuart),
              ifelse(
                hulbert2$year_ndi == '2016',
                pull(ndi2016$ndi[match(hulbert2$GEOID_tr, ndi2016$ndi$GEOID),], NDIQuart),
                ifelse(
                  hulbert2$year_ndi == '2017',
                  pull(ndi2017$ndi[match(hulbert2$GEOID_tr, ndi2017$ndi$GEOID),], NDIQuart),
                  ifelse(
                    hulbert2$year_ndi == '2018',
                    pull(ndi2018$ndi[match(hulbert2$GEOID_tr, ndi2018$ndi$GEOID),], NDIQuart),
                    ifelse(
                      hulbert2$year_ndi == '2019',
                      pull(ndi2019$ndi[match(hulbert2$GEOID_tr, ndi2019$ndi$GEOID),], NDIQuart),
                      ifelse(
                        hulbert2$year_ndi == '2020', 
                        pull(ndi2020$ndi[match(hulbert2$GEOID_tr, ndi2020$ndi$GEOID),], NDIQuart), 
                        NA
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
# Remove values for excluded participants
hulbert2$NDImesser_qt <- ifelse(is.na(hulbert2$GEOID), NA, hulbert2$NDImesser_qt)
hulbert2$NDImesser_qt <- factor(hulbert2$NDImesser_qt, labels = levels(ndi2020$ndi$NDIQuart)[-5])
table(is.na(hulbert2$NDImesser_qt), is.na(hulbert2$GEOID_tr)) # n=0 missing NDI
table(hulbert2$NDImesser_qt)
# 1-Least deprivation 2-BelowAvg deprivation 3-AboveAvg deprivation     4-Most deprivation
#                   7                      1                     10                     42

## US as referent
hulbert1$NDImesser_qt_US <-
  ifelse(
    hulbert1$year_ndi == '2010',
    pull(ndi2010US$ndi[match(hulbert1$GEOID_tr, ndi2010US$ndi$GEOID),], NDIQuart),
    ifelse(
      hulbert1$year_ndi == '2011',
      pull(ndi2011US$ndi[match(hulbert1$GEOID_tr, ndi2011US$ndi$GEOID),], NDIQuart),
      ifelse(
        hulbert1$year_ndi == '2012',
        pull(ndi2012US$ndi[match(hulbert1$GEOID_tr, ndi2012US$ndi$GEOID),], NDIQuart),
        ifelse(
          hulbert1$year_ndi == '2013',
          pull(ndi2013US$ndi[match(hulbert1$GEOID_tr, ndi2013US$ndi$GEOID),], NDIQuart),
          ifelse(
            hulbert1$year_ndi == '2014',
            pull(ndi2014US$ndi[match(hulbert1$GEOID_tr, ndi2014US$ndi$GEOID),], NDIQuart),
            ifelse(
              hulbert1$year_ndi == '2015',
              pull(ndi2015US$ndi[match(hulbert1$GEOID_tr, ndi2015US$ndi$GEOID),], NDIQuart),
              ifelse(
                hulbert1$year_ndi == '2016',
                pull(ndi2016US$ndi[match(hulbert1$GEOID_tr, ndi2016US$ndi$GEOID),], NDIQuart),
                ifelse(
                  hulbert1$year_ndi == '2017',
                  pull(ndi2017US$ndi[match(hulbert1$GEOID_tr, ndi2017US$ndi$GEOID),], NDIQuart),
                  ifelse(
                    hulbert1$year_ndi == '2018',
                    pull(ndi2018US$ndi[match(hulbert1$GEOID_tr, ndi2018US$ndi$GEOID),], NDIQuart),
                    ifelse(
                      hulbert1$year_ndi == '2019',
                      pull(ndi2019US$ndi[match(hulbert1$GEOID_tr, ndi2019US$ndi$GEOID),], NDIQuart),
                      ifelse(
                        hulbert1$year_ndi == '2020',
                        pull(ndi2020US$ndi[match(hulbert1$GEOID_tr, ndi2020US$ndi$GEOID),], NDIQuart), 
                        NA
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
# Remove values for excluded participants
hulbert1$NDImesser_qt_US <- ifelse(is.na(hulbert1$GEOID), NA, hulbert1$NDImesser_qt_US)
hulbert1$NDImesser_qt_US <- factor(
  hulbert1$NDImesser_qt_US, labels = levels(ndi2020$ndi$NDIQuart)[-5]
)
table(is.na(hulbert1$NDImesser_qt_US), is.na(hulbert1$GEOID_tr)) # n=22 missing NDI
table(hulbert1$NDImesser_qt_US, useNA = 'always')
# 1-Least deprivation 2-BelowAvg deprivation 3-AboveAvg deprivation     4-Most deprivation    <NA>
#                  57                     22                     36                     80      22

hulbert2$NDImesser_qt_US <-
  ifelse(
    hulbert2$year_ndi == '2010',
    pull(ndi2010US$ndi[match(hulbert2$GEOID_tr, ndi2010US$ndi$GEOID),], NDIQuart),
    ifelse(
      hulbert2$year_ndi == '2011',
      pull(ndi2011US$ndi[match(hulbert2$GEOID_tr, ndi2011US$ndi$GEOID),], NDIQuart),
      ifelse(
        hulbert2$year_ndi == '2012',
        pull(ndi2012US$ndi[match(hulbert2$GEOID_tr, ndi2012US$ndi$GEOID),], NDIQuart),
        ifelse(
          hulbert2$year_ndi == '2013',
          pull(ndi2013US$ndi[match(hulbert2$GEOID_tr, ndi2013US$ndi$GEOID),], NDIQuart),
          ifelse(
            hulbert2$year_ndi == '2014',
            pull(ndi2014US$ndi[match(hulbert2$GEOID_tr, ndi2014US$ndi$GEOID),], NDIQuart),
            ifelse(
              hulbert2$year_ndi == '2015',
              pull(ndi2015US$ndi[match(hulbert2$GEOID_tr, ndi2015US$ndi$GEOID),], NDIQuart),
              ifelse(
                hulbert2$year_ndi == '2016',
                pull(ndi2016US$ndi[match(hulbert2$GEOID_tr, ndi2016US$ndi$GEOID),], NDIQuart),
                ifelse(
                  hulbert2$year_ndi == '2017',
                  pull(ndi2017US$ndi[match(hulbert2$GEOID_tr, ndi2017US$ndi$GEOID),], NDIQuart),
                  ifelse(
                    hulbert2$year_ndi == '2018',
                    pull(ndi2018US$ndi[match(hulbert2$GEOID_tr, ndi2018US$ndi$GEOID),], NDIQuart),
                    ifelse(
                      hulbert2$year_ndi == '2019',
                      pull(ndi2019US$ndi[match(hulbert2$GEOID_tr, ndi2019US$ndi$GEOID),], NDIQuart),
                      ifelse(
                        hulbert2$year_ndi == '2020',
                        pull(ndi2020US$ndi[match(hulbert2$GEOID_tr, ndi2020US$ndi$GEOID),], NDIQuart),
                        NA
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
# Remove values for excluded participants
hulbert2$NDImesser_qt_US <- ifelse(is.na(hulbert2$GEOID), NA, hulbert2$NDImesser_qt_US)
hulbert2$NDImesser_qt_US <- factor(
  hulbert2$NDImesser_qt_US, labels = levels(ndi2020$ndi$NDIQuart)[-5]
)
table(is.na(hulbert2$NDImesser_qt_US), is.na(hulbert2$GEOID_tr)) # n=0 missing NDI
table(hulbert2$NDImesser_qt_US)
# 1-Least deprivation 2-BelowAvg deprivation 3-AboveAvg deprivation     4-Most deprivation
#                   7                      3                     13                     37

# Diagnostics
table(is.na(hulbert1$NDImesser_tr))
table(is.na(hulbert1$NDImesser_tr_US))
table(is.na(hulbert1$NDImesser_qt))
table(is.na(hulbert1$NDImesser_qt_US))
table(is.na(hulbert1$GEOID))
table(is.na(hulbert1$GEOID_tr))
table(is.na(hulbert1[!is.na(hulbert1$GEOID), 'NDImesser_tr']), hulbert1[!is.na(hulbert1$GEOID), 'year_ndi'], useNA = 'always')

table(is.na(hulbert2$NDImesser_tr))
table(is.na(hulbert2$NDImesser_tr_US))
table(is.na(hulbert2$NDImesser_qt))
table(is.na(hulbert2$NDImesser_qt_US))
table(is.na(hulbert2$GEOID))
table(is.na(hulbert2$GEOID_tr))
table(is.na(hulbert2[!is.na(hulbert2$GEOID_tr), 'NDImesser_tr']), hulbert2[!is.na(hulbert2$GEOID_tr), 'year_ndi'], useNA = 'always')

# Descriptive
summary(hulbert1$NDImesser_tr)
summary(hulbert2$NDImesser_tr)
summary(hulbert1$NDImesser_tr_US)
summary(hulbert2$NDImesser_tr_US)
table(c(hulbert1$NDImesser_qt, hulbert2$NDImesser_qt), useNA = 'always')
table(c(hulbert1$NDImesser_qt_US, hulbert2$NDImesser_qt_US),
      useNA = 'always')
table(
  c(hulbert1$NDImesser_qt, hulbert2$NDImesser_qt),
  c(hulbert1$NDImesser_qt_US, hulbert2$NDImesser_qt_US),
  useNA = 'always'
)
#                        1-Least deprivation 2-BelowAvg deprivation 3-AboveAvg deprivation 4-Most deprivation <NA>
# 1-Least deprivation                     56                      0                      0                  0    0
# 2-BelowAvg deprivation                   8                     17                      0                  0    0
# 3-AboveAvg deprivation                   0                      8                     34                  0    0
# 4-Most deprivation                       0                      0                     15                117    0
# <NA>                                     0                      0                      0                  0   22

cor(
  c(hulbert1$NDImesser_tr, hulbert2$NDImesser_tr),
  c(hulbert1$NDImesser_tr_US, hulbert2$NDImesser_tr_US),
  use = 'complete.obs'
) # Pearson's rho = 0.99957

# ---------------- #
# DATA EXPORTATION #
# ---------------- #

# rename object for identifiability with other metric linkages
hulbert_nditractILMD_messer <- hulbert1
names(hulbert_nditractILMD_messer)

write.csv(
  hulbert_nditractILMD_messer,
  file = file.path('data', 'UIC_demographics_2822_ndi_tract_ILMD_messer.csv')
)

str(hulbert_nditractILMD_messer)
# New variables since load:
# $ geometry           : sfc_POINT of length 217; first list element:  'XY' num
# $ year_ndi           : Factor w/ 5 levels (year of NDI linked to participant)
# $ year_tr            : Factor w/ 2 levels (decade of tract of participant)
# $ GEOID_tr           : num [1:217] (geocoded tract based on lon/lat coordinates)
# $ NDImesser_tr       : num [1:217] (Neighborhood Deprivation Index at the tract-level, referent as Illinois and Maryland)
# $ NDImesser_tr_US    : num [1:217] (Neighborhood Deprivation Index at the tract-level, Messer, continuous referent as United States)
# $ NDImesser_qt       : Factor w/ 4 levels (Neighborhood Deprivation Index at the tract-level, Messer, categorical quartiles, referent as Illinois and Maryland)
# $ NDImesser_qt_US    : Factor w/ 4 levels (Neighborhood Deprivation Index at the tract-level, Messer, categorical quartiles, referent as United States)

# rename object for identifiability with other metric linkages
hulbert_nditractadditionalIL_messer <- hulbert2
names(hulbert_nditractadditionalIL_messer)

write.csv(
  hulbert_nditractadditionalIL_messer,
  file = file.path(
    'data',
    'UIC_demographics_2822_ndi_tract_additionalIL_messer.csv'
  )
)

str(hulbert_nditractadditionalIL_messer)
# New variables since load:
# $ geometry           : sfc_POINT of length 60; first list element:  'XY' num
# $ year_ndi           : Factor w/ 5 levels (year of NDI linked to participant)
# $ year_tr            : Factor w/ 2 levels (decade of tract of participant)
# $ GEOID_tr           : num [1:60] (geocoded tract based on lon/lat coordinates)
# $ NDImesser_tr       : num [1:60] (Neighborhood Deprivation Index at the tract-level, referent as Illinois and Maryland)
# $ NDImesser_tr_US    : num [1:60] (Neighborhood Deprivation Index at the tract-level, Messer, continuous referent as United States)
# $ NDImesser_qt       : Factor w/ 4 levels (Neighborhood Deprivation Index at the tract-level, Messer, categorical quartiles, referent as Illinois and Maryland)
# $ NDImesser_qt_US    : Factor w/ 4 levels (Neighborhood Deprivation Index at the tract-level, Messer, categorical quartiles, referent as United States)

# ---------------------------------- END OF CODE ---------------------------------- #
