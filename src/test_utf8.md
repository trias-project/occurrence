A test document to figure out how to consistently read (and write) data
as UTF-8. Use the "Knit" button to run.

Load libraries:

    library(rgbif)
    library(jsonlite)

Set taxonKey:

    taxon_key <- "134087647"

Get locale:

    Sys.getenv("LC_CTYPE")

    ## [1] "en_BE.UTF-8"

Default
=======

Get taxon with rgbif:

    rgbif_taxon <- rgbif::name_usage(key = taxon_key)
    rgbif_taxon$data$scientificName

    ## [1] "Loncomelos brevistylus (Wolfner ) Dost<U+00E1>l"

Get taxon with jsonlite:

    jsonlite_taxon <- jsonlite::read_json(paste0("http://api.gbif.org/v1/species/", taxon_key))
    jsonlite_taxon$scientificName

    ## [1] "Loncomelos brevistylus (Wolfner ) Dost<U+00E1>l"

Locale `en_US.UTF-8`
====================

    Sys.setlocale("LC_CTYPE", "en_US.UTF-8")

    ## [1] "en_US.UTF-8"

Get taxon:

    rgbif_taxon <- rgbif::name_usage(key = taxon_key)
    rgbif_taxon$data$scientificName

    ## [1] "Loncomelos brevistylus (Wolfner ) Dostál"
