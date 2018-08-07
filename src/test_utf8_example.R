library(readr)
library(readxl)

# Get locale
Sys.getlocale(category = "LC_CTYPE")

# read UTF-8 text files
string_utf8 <- "¡I¢£¤¥¦§¨©ª«¬®¯°±²³´µ¶"
test_write <- data.frame(name = string_utf8,
                         stringsAsFactors = FALSE)
# read UTF8 characters from file
test_read <- read_tsv("./data/input/test_utf8.tsv")
all(test_read$name == string_utf8)

# text read Excel files with UTF-8 characters
test_read_xl <- read_xlsx("./data/input/test_utf8.xlsx", 
                          sheet = "Blad1",
                          col_names = TRUE)
all(test_read_xl$name == test_read$name)




