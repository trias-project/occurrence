# Indicators

[![Build Status](https://travis-ci.org/trias-project/indicators.svg?branch=master)](https://travis-ci.org/trias-project/indicators)

This repository contains pipelines to generate alien species _indicators_, i.e. graphs or tables analyzing specific aspects of their _stage of invasion_. Indicators can be divided in two groups:

1. checklist-based indicators
2. occurrence-based indicators

## Checklist-based indicators

Checklist based indicators developed within the TrIAS project are:

1. [number of introduced species present in Belgium as function of time](https://trias-project.github.io/indicators/indicator_introductions_per_year.html): graph
2. [cumulative number of introduced species present in Belgium as function of time](https://trias-project.github.io/indicators/indicator_cumulative_number.html): graph
3. [pathways of introduction](https://trias-project.github.io/indicators/indicator_pathways.html): table

The indicators are built upon the taxa published in the [Global Register of Introduced and Invasive Species - Belgium](https://doi.org/10.15468/xoidmd). For the data manipulation of the taxonomic information, see [this pipeline](https://github.com/trias-project/indicators/blob/master/src/get_data_input_checklist_indicators.Rmd).

## Occurrence-based indicators

In order to calculate an emergency index, we take into account:

1. number of occurrences per year
2. area of occupancy (AOO)

Still work in progress.

## Repo structure

The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/). Files indicated with `GENERATED` should not be edited manually.

```
├── README.md              : Description of this repository
├── LICENSE                : Repository license
├── indicators.Rproj       : RStudio project file
├── .gitignore             : Files and directories to be ignored by git
│
├── data
│   ├── input
│   │   ├── modelling_species.csv : List of species for risk modelling
|   │   └── belgian_species.csv   : List of alien species in Belgium
│   │
│   └── output
|       └── gbif_downloads.csv    : List of triggered GBIF occurrence downloads GENERATED
│
└── src
    ├── gbif_download.Rmd         : Script to trigger and verify a GBIF occurrence download
    ├── get_data_input_checklist_indicators.Rmd : Script to manipulate taxonomic data from the Global Register of Introduced and Invasive Species - Belgium
    ├── indicator_introductions_per_year.Rmd : Script to generate graphs with number of new introduced species per year
    └── indicator_pathways.Rmd    : Script to generate tables with pathways of introduction
```

## Contributors

[List of contributors](https://github.com/trias-project/indicators/contributors)

## License

[MIT License](LICENSE)
