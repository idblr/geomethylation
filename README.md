# Neighborhood-Level Deprivation and Survival in Lung Cancer 
<img src='hex/geomethylation.png' width='120' align='right' />

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![GitHub last commit](https://img.shields.io/github/last-commit/idblr/geomethylation)

**Date repository last updated**: 2024-08-07

### Authors

* **Kathleen Kennedy**<sup>1</sup> - *Co-First Author*
* **Ignacio Jusué-Torres**<sup>2</sup> - *Co-First Author* - [ORCID](https://orcid.org/0000-0002-9749-1912)
* **Ian D. Buller**<sup>3,4</sup> - *Co-First Author* - [ORCID](https://orcid.org/0000-0001-9477-8582)
* **Emily Rossi**<sup>3,5</sup> - [ORCID](https://orcid.org/0000-0002-2312-4239)
* **Apurva Mallisetty**<sup>6</sup> - [ORCID](https://orcid.org/0000-0002-3130-2453)
* **Kristen Rodgers**<sup>7,8</sup> - [ORCID](https://orcid.org/0000-0003-4302-9578)
* **Beverly Lee**<sup>7,8</sup>
* **Martha Menchaca**<sup>9</sup>
* **Mary Pasquinelli**<sup>10</sup> - [ORCID](https://orcid.org/0000-0002-1015-1908)
* **Ryan H. Nguyen**<sup>1</sup>
* **Frank Weinberg**<sup>1</sup>
* **Israel Rubinstein**<sup>10,11</sup> - [ORCID](https://orcid.org/0000-0002-3628-0601)
* **James G. Herman**<sup>8,12</sup>
* **Malcolm Brock**<sup>7,8</sup>
* **Lawrence Feldman**<sup>1,11</sup>
* **Melinda Aldrich**<sup>13</sup> - [ORCID](https://orcid.org/0000-0003-3833-8448)
* **Alicia Hulbert**<sup>6,8,11</sup> - *Corresponding Author* - [ORCID](https://orcid.org/0000-0002-1196-1953)

1.	Department of Hematology Oncology University of Illinois of Chicago College of Medicine, Chicago IL, USA
2.  Department of Neurologic Surgery, Mayo Clinic, Rochester, MN, USA
3.  Cancer Prevention Fellowship Program, Division of Cancer Prevention, National Cancer Institute, Rockville, MD, USA
4.	Occupational and Environmental Epidemiology Branch, Division of Cancer Epidemiology and Genetics, National Cancer Institute, Rockville, MD, USA
5.  Laboratory of Human Carcinogenesis, Center for Cancer Research, National Cancer Institute, Bethesda, MD, USA
6.  Department of Surgery, University of Illinois of Chicago College of Medicine, Chicago IL, USA
7.  Department of Surgery, The Johns Hopkins University School of Medicine, Baltimore MD, USA
8.  Sidney Kimmel Comprehensive Cancer Center at Johns Hopkins, Baltimore, MD, USA
9.  Department of Radiology, University of Illinois of Chicago College of Medicine, Chicago IL, USA
10.  Division of Pulmonary, Critical Care, Sleep and Allergy, Department of Medicine, University of Illinois at Chicago, College of Medicine, Chicago, IL, USA
11.  Division of Research Services, Jesse Brown VA Medical Center, Chicago, IL, USA
12.  Lung Cancer Program, University of Pittsburgh Cancer Institute, The Hillman Cancer Center, Pittsburgh, PA, USA
13.  Department of Thoracic Surgery, Vanderbilt University Medical Center, Nashville, TN, USA

### Project Details

In a multicentric retrospective cohort study, higher U.S. Census tract-level neighborhood deprivation and later stage at diagnosis were associated with increasing DNA methylation suggesting a role of epigenetic changes in driving the biologic aggressiveness of lung cancer. Higher neighborhood deprivation was associated with a later stage at diagnosis and an increased mortality risk, which underscores the importance of addressing neighborhood-level socioeconomic barriers to equitably reduce lung cancer mortality.

#### Project Timeframe

<table>
<colgroup>
<col width='20%' />
<col width='80%' />
</colgroup>
<thead>
<tr class='header'>
<th>Time</th>
<th>Event</th>
</tr>
</thead>
<tbody>
<tr>
<td><p align='center'>2000, 2007-2022</p></td>
<td>Year collection of biospecimens</td>
</tr>
<tr>
<td><p align='center'>2010-2020</p></td>
<td>Years Neighborhood Deprivation Indices are available</td>
</tr>
<tr>
<td><p align='center'>November 2021</p></td>
<td>Project Initiation</td>
</tr>
<tr>
<td><p align='center'>October 2023</p></td>
<td>Initial manuscript submission to a peer-reviewed journal</td>
</tr>
<tr>
<td><p align='center'>May 2024</p></td>
<td>Manuscript submitted to <a href='https://bmccancer.biomedcentral.com/'><i>BMC Cancer</i></a></td>
</tr>
<tr>
<td><p align='center'>July 2024</p></td>
<td>Manuscript accepted in <a href='https://bmccancer.biomedcentral.com/'><i>BMC Cancer</i></a></td>
</tr>
<tr>
<td><p align='center'>August 2024</p></td>
<td><a href='https://doi.org/10.1186/s12885-024-12720-w'>Manuscript published</a> in <a href='https://bmccancer.biomedcentral.com/'><i>BMC Cancer</i></a></td>
</tr>
</tbody>
</table>

### R Scripts Included In This Repository

This repository includes [R](https://cran.r-project.org/) scripts used to compute and link the census tract-level neighborhood deprivation indices, link these values to the study participants using their census tract identification, and render the visualizations for the following peer-reviewed manuscript:

Kennedy K (co-first), Jusue-Torres I (co-first), Buller ID (co-first), Rossi E, Mallisetty A, Rodgers K, Lee B, Menchaca M, Pasquinelli M, Nguyen RH, Weinberg F, Rubinstein I, Herman JG, Brock M, Feldman L, Aldrich MC, Hulbert A. (2024) Neighborhood-level deprivation and survival in lung cancer. *BMC Cancer*, 24(1):959. DOI:[10.1186/s12885-024-12720-w](https://doi.org/10.1186/s12885-024-12720-w) PMID:[39107707](https://pubmed.ncbi.nlm.nih.gov/39107707/)
    
<table>
<colgroup>
<col width='20%' />
<col width='80%' />
</colgroup>
<thead>
<tr class='header'>
<th>R Script</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><p align='center'><a href='code/figure1.R'><code>figure1.R</code></a></p></td>
<td>Generate Figure 1</td>
</tr>
<tr>
<td><p align='center'><a href='code/figure2.R'><code>figure2.R</code></a></p></td>
<td>Generate values for Figure 2 (imported into GraphPad Prism to render full figure)</td>
</tr>
<tr>
<td><p align='center'><a href='code/figure3.R'><code>figure3.R</code></a></p></td>
<td>Generate Figure 3</td>
</tr>
<tr>
<td><p align='center'><a href='code/figure4.R'><code>figure4.R</code></a></p></td>
<td>Generate Figure 4</td>
</tr>
<tr>
<td><p align='center'><a href='code/ndi_messer.R'><code>ndi_messer.R</code></a></td>
<td>Compute and link the Neighborhood Deprivation Index values based on <a href='https://doi.org/10.1007/s11524-006-9094-x'>Messer et al. (2006)</a> to study participants.</td>
</tr>
<tr>
<td><p align='center'><a href='code/ndi_powell-wiley.R'><code>ndi_powell-wiley.R</code></a></p></td>
<td>Compute and link the Neighborhood Deprivation Index values based on <a href='https://doi.org/10.1080/17445647.2020.1750066'>Andrews et al. (2020)</a> and <a href='https://doi.org/10.1016/j.dib.2022.108002'>Slotman et al. (2022)</a> to study participants.</td>
</tr>
<tr>
<td><p align='center'><a href='code/preparation.R'><code>preparation.R</code></a></td>
<td>Load and prepare data for analyses, tables, and figures.</td>
</tr>
<tr>
<td><p align='center'><a href='code/supplementaltable1.R'><code>supplementaltable1.R</code></a></p></td>
<td>Generate values for Supplemental Table 1</td>
</tr>
<tr>
<td><p align='center'><a href='code/table1.R'><code>table1.R</code></a></p></td>
<td>Generate values for Table 1</td>
</tbody>
</table>

The repository also includes the code and resources to create the project hexagon sticker.

### Getting Started

* Step 1: You must obtain a unique access key from the U.S. Census Bureau. Follow [this link](http://api.census.gov/data/key_signup.html) to obtain one.
* Step 2: Specify your access key in the `messer()` or `powell_wiley()` functions from the [*ndi*](https://CRAN.R-project.org/package=ndi) package in [R](https://cran.r-project.org/) using the `key` argument or by using the `census_api_key()` function from the [*tidycensus*](https://CRAN.R-project.org/package=tidycensus) package in [R](https://cran.r-project.org/) before running the `messer()` or `powell_wiley()` functions.

### Data Availability

Study participant data used in the above manuscript is available upon request from the corresponding author, [Dr. Alicia Hulbert](mailto:ahulbert@uic.edu). U.S. census tract-level neighborhood deprivation indices are available from the [*ndi*](https://CRAN.R-project.org/package=ndi) package in [R](https://cran.r-project.org/). 

### Questions?

For questions about the manuscript please e-mail the corresponding author [Dr. Alicia Hulbert](mailto:ahulbert@uic.edu).
