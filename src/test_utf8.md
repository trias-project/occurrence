A test document to figure out how to consistently read (and write) data
as UTF-8. Use the "Knit" button to run.

Load libraries:

    library(rgbif)

Don't set any locale
====================

Get taxon:

    taxon <- rgbif::name_usage(key = 134087647)
    taxon$data$scientificName

    ## [1] "Loncomelos brevistylus (Wolfner ) Dost<U+00E1>l"

Locale `en_US.UTF-8`
====================

    Sys.setlocale("LC_CTYPE", "en_US.UTF-8")

    ## [1] "en_US.UTF-8"

Get taxon:

    taxon <- rgbif::name_usage(key = 134087647)
    taxon$data$scientificName

    ## [1] "Loncomelos brevistylus (Wolfner ) Dostál"
