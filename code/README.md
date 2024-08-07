# Neighborhood-Level Deprivation and Survival in Lung Cancer
<img src='../hex/geomethylation.png' width='120' align='right' />

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
<td><p align='center'><a href='figure1.R'><code>figure1.R</code></a></p></td>
<td>Generate Figure 1</td>
</tr>
<tr>
<td><p align='center'><a href='figure2.R'><code>figure2.R</code></a></p></td>
<td>Generate values for Figure 2 (imported into GraphPad Prism to render full figure)</td>
</tr>
<tr>
<td><p align='center'><a href='figure3.R'><code>figure3.R</code></a></p></td>
<td>Generate Figure 3</td>
</tr>
<tr>
<td><p align='center'><a href='figure4.R'><code>figure4.R</code></a></p></td>
<td>Generate Figure 4</td>
</tr>
<tr>
<td><p align='center'><a href='ndi_messer.R'><code>ndi_messer.R</code></a></td>
<td>Compute and link the Neighborhood Deprivation Index values based on <a href='https://doi.org/10.1007/s11524-006-9094-x'>Messer et al. (2006)</a> to study participants.</td>
</tr>
<tr>
<td><p align='center'><a href='ndi_powell-wiley.R'><code>ndi_powell-wiley.R</code></a></p></td>
<td>Compute and link the Neighborhood Deprivation Index values based on <a href='https://doi.org/10.1080/17445647.2020.1750066'>Andrews et al. (2020)</a> and <a href='https://doi.org/10.1016/j.dib.2022.108002'>Slotman et al. (2022)</a> to study participants.</td>
</tr>
<tr>
<td><p align='center'><a href='preparation.R'><code>preparation.R</code></a></td>
<td>Load and prepare data for analyses, tables, and figures.</td>
</tr>
<tr>
<td><p align='center'><a href='supplementaltable1.R'><code>supplementaltable1.R</code></a></p></td>
<td>Generate values for Supplemental Table 1</td>
</tr>
<tr>
<td><p align='center'><a href='table1.R'><code>table1.R</code></a></p></td>
<td>Generate values for Table 1</td>
</tbody>
</table>
