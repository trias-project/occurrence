# Pipeline

TrIAS data pipeline from a species checklist over occurrences to indicators.

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
    └── src.Rproj                   : RStudio project file
```

## Contributors

[List of contributors](https://github.com/trias-project/occurrence/contributors)

## License

[MIT License](LICENSE)
