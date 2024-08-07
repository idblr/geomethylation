# Neighborhood-Level Deprivation and Survival in Lung Cancer
<img src='../hex/geomethylation.png' width='120' align='right' />

Place data here (data not included). Data generated in this study are available upon request from the corresponding author, [Dr. Alicia Hulbert](mailto:ahulbert@uic.edu).

The ['preparation.R'](../code/preparation.R) file in the ['code'](../code) subdirectory calls a CSV file named 'Geocoding.csv'

### Data Availability

Study participant data used in the above manuscript is available upon request from the corresponding author. Study participant geocoded census tracts were found in two files 'UIC_demographics_2822.RDA' and 'Copy_of_Not_included_in_Geocoding_060922_V3_wGeocodes.xlsx' and then merged together to generate the 'Geocoding.csv' file with all metrics per analytic study participant.

U.S. census tract-level neighborhood deprivation indices are available from the [*ndi*](https://CRAN.R-project.org/package=ndi) package in [R](https://cran.r-project.org/). NDI (Messer) linked to study participant census tract identification were computed in the ['ndi_messer.R'](../code/ndi_messer.R) file located in the ['code'](../code) subdirectory. NDI (Powell-Wiley) linked to study participant census tract identification are computed in the ['ndi_powell-wiley.R'](../code/ndi_powell-wiley.R) file located in the ['code'](../code) subdirectory.
