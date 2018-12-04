#load libraries
library(tidyverse)
library(tibble)
library(lubridate)

gbif_key <- "0012469-181108115102211"

species_df <- data.frame(
  species = c(
    "Baccharis halimifolia",
    "Impatiens glandulifera",
    "Impatiens capensis",
    "Hydrocotyle ranunculoides",
    "Branta canadensis",
    "Harmonia axyridis"
    ),
  species_key = c(
    3129663,
    2891770,
    2891774,
    7978544,
    5232437,
    4989904
    ),
  family = c(
    "Asteraceae",
    "Balsaminaceae",
    "Balsaminaceae",
    "Apiaceae",
    "Anatidae",
    "Coccinellidae"
  ),
  family_key = c(
    3065, # Asteraceae
    6699, # Balsaminaceae
    6699, # Balsaminaceae
    6720, # Apiaceae
    2986, # Anatidae
    7782 # Coccinellidae
  ),
  kingdom = c(
    "Plantae",
    "Plantae",
    "Plantae",
    "Plantae",
    "Animalia",
    "Animalia"
  ),
  stringsAsFactors = FALSE
)

occ_df_file <- paste0("../data/interim/occ_df_",
                      gbif_key, ".csv")
# downloaded zip file in ./data/interim/ if still not exists
file_path <- paste0("../data/interim/")
if (!file.exists(file_path))
  dir.create(file_path)
if (!file.exists(occ_df_file)){
  occ <- occ_download_get(key = gbif_key, overwrite = TRUE, path = file_path)
  fn <- "occurrence.txt"
  unzip(zipfile = occ, files = fn,
        exdir = "../data/interim/.")
  file.rename(from = "../data/interim/occurrence.txt",
              to = occ_df_file)
}

# Load occurrences
col_types <- cols(acceptedNameUsage = col_character(),
     acceptedNameUsageID = col_character(),
     accessRights = col_character(),
     associatedReferences = col_character(),
     associatedSequences = col_character(),
     associatedTaxa = col_character(),
     bed = col_character(),
     behavior = col_character(),
     bibliographicCitation = col_character(),
     catalogNumber = col_character(),
     collectionID = col_character(),
     continent = col_character(),
     coordinatePrecision = col_double(),
     county = col_character(),
     created = col_date(),
     dateIdentified = col_character(),
     dataGeneralizations = col_character(),
     datasetID = col_character(),
     day = col_integer(),
     disposition = col_character(),
     dynamicProperties = col_character(),
     earliestEonOrLowestEonothem = col_character(),
     elevation = col_double(),
     elevationAccuracy = col_double(),
     endDayOfYear = col_integer(),
     establishmentMeans = col_character(),
     fieldNotes = col_character(),
     fieldNumber = col_character(),
     footprintSRS = col_character(),
     footprintSpatialFit = col_character(),
     footprintWKT = col_character(),
     georeferencedBy = col_character(),
     georeferencedDate = col_date(),
     georeferenceProtocol = col_character(),
     georeferenceRemarks = col_character(),
     georeferenceSources = col_character(),
     georeferenceVerificationStatus = col_character(),
     habitat = col_character(),
     higherClassification = col_character(),
     identificationID = col_character(),
     identificationQualifier = col_character(),
     identificationReferences = col_character(),
     identificationRemarks = col_character(),
     identificationVerificationStatus = col_character(),
     individualCount = col_integer(),
     infraspecificEpithet = col_character(),
     informationWithheld = col_character(),
     institutionID = col_character(),
     language = col_character(),
     latestEraOrHighestErathem = col_character(),
     latestPeriodOrHighestSystem = col_character(),
     lifeStage = col_character(),
     lithostratigraphicTerms = col_character(),
     locationAccordingTo = col_character(),
     locationRemarks = col_character(),
     minimumDistanceAboveSurfaceInMeters = col_double(),
     month = col_integer(),
     municipality = col_character(),
     nameAccordingTo = col_character(),
     nameAccordingToID = col_character(),
     namePublishedInID = col_character(),
     nomenclaturalCode = col_character(),
     nomenclaturalStatus = col_character(),
     organismQuantity = col_character(),
     otherCatalogNumbers = col_character(),
     ownerInstitutionCode = col_character(),
     parentNameUsage = col_character(),
     parentNameUsageID = col_character(),
     pointRadiusSpatialFit = col_double(),
     preparations = col_character(),
     recordNumber = col_character(),
     reproductiveCondition = col_character(),
     sampleSizeUnit = col_character(),
     sampleSizeValue = col_double(),
     samplingEffort = col_character(),
     scientificNameID = col_character(),
     sex = col_character(),
     taxonConceptID = col_character(),
     taxonID = col_character(),
     taxonRemarks = col_character(),
     type = col_character(),
     typeStatus = col_character(),
     verbatimElevation = col_character(),
     verbatimSRS = col_character(),
     verbatimTaxonRank = col_character(),
     vernacularName = col_character(),
     waterBody = col_character(),
     year = col_integer()
)
occ_df_test <- read_delim(
  file = occ_df_file, delim = "\t", n_max = 1000,
  escape_double = FALSE, trim_ws = TRUE,
  col_types = col_types)

occ_df <- occ_df %>%
  mutate(dateIdentified = as_datetime(dateIdentified))

rds_file <- paste0(file_path, gbif_key, ".RData")
saveRDS(occ_df, file = rds_file)
occ_df <- readRDS(file = rds_file)

# Relative Observation Trend
tot_occ_df <- occ_df %>%
  group_by(year, familyKey) %>%
  summarize(n_tot = n())

relative_obs_trend <-
  occ_df %>%
  filter(speciesKey %in%
           (species_df %>%
           pull(species_key))) %>%
  group_by(year, familyKey, speciesKey) %>%
  summarize(n = n()) %>%
  left_join(tot_occ_df, by = c("year", "familyKey")) %>%
  mutate(rel_obs = n/n_tot) %>%
  left_join(species_df,
            by = c("familyKey" = "family_key",
                   "speciesKey" = "species_key"))
View(relative_obs_trend)

ggplot(data = relative_obs_trend) +
  geom_point(aes(x = year, y = rel_obs, color = species)) +
  ggtitle("Relative number of occurrences: n_species/n_family")

ggplot(data = relative_obs_trend %>%
         filter(speciesKey == 2891770)) +
  geom_point(aes(x = year, y= n))

# make everything via facets: no download needed
taxonKey <-  c(3065, # Asteraceae
               # 6699, # Balsaminaceae
               # 6699, # Balsaminaceae
               # 6720, # Apiaceae
               # 2986, # Anatidae
               7782 # Coccinellidae)
)
rank <- map(taxonKey, function(key) {
  name_usage(key, return = "data")$rank
})
basisOfRecord <- c("HUMAN_OBSERVATION", "PRESERVED_SPECIMEN")
country <- "BE"
facet <- "familyKey"
hasCoordinate <- TRUE
year <- 2017:2017

inputs <- crossing(taxonKey, year, basisOfRecord, country)
progress_bar <- progress_estimated(nrow(inputs))
counts <- pmap_dfr(inputs, function(taxonKey, year, basisOfRecord, country) {
  progress_bar$tick()$print()
  df_facet <- occ_search(
    year = year,
    taxonKey = taxonKey,
    basisOfRecord = basisOfRecord,
    country = country,
    facet = facet,
    hasCoordinate = TRUE,
    return = "facets",
    curlopts = list(verbose = TRUE)
  )$facets[[facet]]
  if (!is.null(df_facet)) {
    df_facet <-
      df_facet %>%
      mutate(year = c(year),
             basisOfRecord = c(basisOfRecord))
  }
  return(df_facet)
})
counts <-
  counts %>%
  rename(!!facet := name)
counts
library(dplyr)
new_name <- "key"
df <- data.frame(k = c(1, 2, 3))
df %>%
  rename(!!new_name := k)
