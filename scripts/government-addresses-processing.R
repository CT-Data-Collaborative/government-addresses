library(dplyr)
library(datapkg)
library(tidyr)

##################################################################
#
# Processing Script for Government Addresses
# Created by Jenna Daly
# On 06/01/2017
#
##################################################################

#Setup environment
sub_folders <- list.files()
raw_location <- grep("raw$", sub_folders, value=T)
data_location <- grep("data$", sub_folders, value=T)
path_to_raw <- (paste0(getwd(), "/", raw_location))
path_to_data <- (paste0(getwd(), "/", data_location))
GA <- dir(path_to_raw, recursive=T, pattern = "gov")

gov_addresses <- read.csv(paste0(path_to_raw, "/", GA[2]), stringsAsFactors = F, header=T, check.names=F)
gov_addresses18 <- read.csv(paste0(path_to_raw, "/", GA[1]), stringsAsFactors = F, header=T, check.names=F)
gov_addresses$Website <- ""

#bind together previous years and new data
gov_addresses <- rbind(gov_addresses, gov_addresses18)

#arrange by Town
gov_addresses_no_web <- gov_addresses %>% 
  select(-Website) %>% 
  arrange(Town)

#Write to file
write.table(
  gov_addresses_no_web,
  file.path(getwd(), "data", "government-addresses.csv"),
  sep = ",",
  row.names = F
)

