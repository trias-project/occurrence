# Indicators

[![Build Status](https://travis-ci.org/trias-project/indicators.svg?branch=master)](https://travis-ci.org/trias-project/indicators)

This repository contains pipelines to generate _indicators_, i.e. graphs or tables analyzing specific aspects of the _stage of invasion_. Indicators can be divided in two groups:

1. checklist-based indicators
2. occurrence-based indicators

## Checklist-based indicators

Checklist based indicators developed within TrIAS project are:

1. [number of introduced species present in Belgium as function of time](https://trias-project.github.io/indicators/indicator_introductions_per_year.html)
2. [cumulative number of introduced species present in Belgium as function of time](https://trias-project.github.io/indicators/indicator_cumulative_number.html)
3. [pathways of introduction](https://trias-project.github.io/indicators/indicator_pathways.html)

The first two indicators are in the form of graphs, while the pathway of introductions are given in the form of a table.

The indicators are built upon the taxa published in the [Global Register of Introduced and Invasive Species - Belgium](https://www.gbif.org/dataset/6d9e952f-948c-4483-9807-575348147c7e). For the data manipulation of the taxonomic information, see [this pipeline](https://github.com/trias-project/indicators/blob/master/src/get_data_input_checklist_indicators.Rmd).

## Occurrence-based indicators

We take into account:

1. number of occurrences per year
2. area of occupancy (AOO)

in order to calculate an emergency index. Still work in progress.

## Repo structure

The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/). Files indicated with `GENERATED` should not be edited manually.

```
├── README.md                       : Top-level description of the project and how to run it
├── LICENSE                         : Project license
├── .gitignore                      : Files and folders to be ignored by git
│
├── data
│   ├── input
│   │   ├── modelling_species.csv   : List of species for risk modelling
|   │   └── belgian_species.csv     : List of alien species in Belgium
│   │
│   └── output
|       └── gbif_downloads.csv      : List of triggered GBIF occurrence downloads GENERATED
│
└── src
    ├── gbif_download.Rmd           : Script to trigger and verify a GBIF occurrence download
    ├── get_data_input_checklist_indicators.Rmd:
                                    : Script to manipulate taxonomic data from the Global Register of Introduced and Invasive Species - Belgium
    ├── indicator_introductions_per_year.Rmd
                                    : Script to generate graphs with number of new introduced species per year
    ├── indicator_pathways.Rmd      : Script to generate tables with pathways of introduction
    └── src.Rproj                   : RStudio project file
```

## Contributors

[List of contributors](https://github.com/trias-project/occurrence/contributors)

## License

[MIT License](LICENSE)
