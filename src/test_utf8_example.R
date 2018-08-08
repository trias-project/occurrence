library(readr)
library(readxl)

# Get locale
Sys.getlocale(category = "LC_CTYPE")

# read UTF-8 text files
string_utf8 <- "¡I¢£¤¥¦§¨©ª«¬®¯°±²³´µ¶ČŽÃÐč"
string_utf8 <- iconv(string_utf8, "latin1", "UTF-8",sub='')
string_utf8

all_characters_utf8 <- "#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[ \ ]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡¢£¤¥¦§¨©ª«¬ ®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞ"
Encoding(all_characters_utf8)
test_write <- data.frame(name = string_utf8,
                         stringsAsFactors = FALSE)
# write UTF8 characters to fil
# read UTF8 characters from file
test_read <- readLines("../data/input/test_utf8.tsv", encoding = 'UTF-8')
all(test_read$name == string_utf8)

# text read Excel files with UTF-8 characters
test_read_xl <- read_xlsx("../data/input/test_utf8.xlsx", 
                          sheet = "Blad1",
                          col_names = TRUE)
all(test_read_xl$name == test_read$name)




