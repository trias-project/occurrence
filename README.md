# Indicators

This repository contains pipelines to generate alien species _indicators_, i.e. graphs or tables analyzing specific aspects of their _stage of invasion_. Indicators can be divided in two groups:

1. checklist-based indicators
2. occurrence-based indicators

## Checklist-based indicators

Checklist based indicators developed within the TrIAS project are:

1. [number of introduced species present in Belgium as function of time](https://trias-project.github.io/indicators/indicator_introductions_per_year.html) shown as graphs
2. [cumulative number of introduced species present in Belgium as function of time](https://trias-project.github.io/indicators/indicator_cumulative_number.html) shown as graphs
3. [pathways of introduction](https://trias-project.github.io/indicators/indicator_pathways.html) shown as tables

The indicators are built upon the taxa published in the [Global Register of Introduced and Invasive Species - Belgium](https://doi.org/10.15468/xoidmd). For the data manipulation of the taxonomic information, see Appendix [Preprocessing for checklist-based indicators](https://trias-project.github.io/indicators/get_data_input_checklist_indicators.html).

## Occurrence-based indicators

In order to calculate an emergency index, we take into account:

1. number of occurrences per year, or simply _occurrences_
2. area of occupancy (AOO), or simply _occupancy_

The workflow is divded in the following pipelines:

1. [Appearing or reappearing taxa in current year](https://trias-project.github.io/indicators/occurrence_indicators_appearing_taxa.html)
2. [Assessing partial emerging statuses of alien taxa](https://trias-project.github.io/indicators/occurrence_indicators_modelling.html)
3. [Assessing emerging status and ranking](https://trias-project.github.io/indicators/ranking_emerging_status.html)

We work with GAM (Generalized Additive Models) and decision rules to assess the emerging status of a species. This part is still work in progress, although all workflow steps are now completed. Follow [issue #49](https://github.com/trias-project/indicators/issues/49) for more discussions about the different choices we took at every step of the workflow.

For the data preparation of the taxonomic and occurrence information, see Appendix [Preprocessing for occurrence-based indicators](https://trias-project.github.io/indicators/occurrence_indicators_preprocessing.html). The starting point is the *occurrence cube* as produced in TrIAS repository [occ-cube](https://github.com/trias-project/occ-cube) and published on [Zenodo](https://zenodo.org/record/3637911). The output of this appendix is the starting point of the pipelines described above.

## Repo structure

The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/). Files indicated with `GENERATED` should not be edited manually. This list can be not complete as the content of this repository is still in progress.

```
├── README.md              : Description of this repository
├── LICENSE                : Repository license
├── indicators.Rproj       : RStudio project file
├── .gitignore             : Files and directories to be ignored by git
│
├── data
│   ├── input
│   │   ├── modelling_species.csv               : List of species for risk modelling
│   ├── interim
|       ├── data_input_checklist_indicators.tsv : Data for making checklist indicators. Output of 'get_data_input_checklist_indicators.Rmd'
│   └── output
|       ├── gbif_downloads.csv                  : List of triggered GBIF occurrence downloads 
|       └── intersect_EEA_ref_grid_protected_areas.tsv  : Membership of reference grid cells to (one or more) protected areas.
│   ├── external
│   |   ├── utm_1_bel       : Belgian reference grid of European Environmental Agency (EEA) at 1km<sup>2</sup> resolution
│   |   ├── utm_10_bel      : Belgian reference grid of European Environmental Agency (EEA) at 10km<sup>2</sup> resolution
│   |   ├── utm_100_bel     : Belgian reference grid of European Environmental Agency (EEA) at 100km<sup>2</sup> resolution
│   |   └── utm_5_bel     : Belgian reference grid at 5km<sup>2</sup> resolution created by INBO
│
└── src
    ├── gbif_download.Rmd         : Script to trigger and verify a GBIF occurrence download
    ├── get_data_input_checklist_indicators.Rmd : Script to manipulate taxonomic data from the Global Register of Introduced and Invasive Species - Belgium
    ├── indicator_introductions_per_year.Rmd : Script to generate graphs with number of new introduced species per year
    ├── indicator_cumulative_number.Rmd: Script to generate graphs with cumulative number of introduced species per year
    └── indicator_pathways.Rmd    : Script to generate tables with pathways of introduction
    ├── occurrence_indicators_preprocessing.Rmd    : Script to produce time series from the occurrence cube
    ├── occurrence_indicators_modelling.Rmd    : Apply GAM and decision rules models to assess partial emerging scores
    ├── ranking_emerging_status.Rmd    : Rank alien taxa based on their emerging status derived by the emerging scores
    ├── occurrence_indicators_appearing_taxa.Rmd    : Find appearing and reappearing taxa in the last years
    ├── occurrence_species_protected_areas_level.Rmd    : Assess number of observations, area of occupancy, coverage of Belgian protected areas for all  species and year
```

## Contributors

[List of contributors](https://github.com/trias-project/indicators/contributors)

## License

[MIT License](LICENSE)
