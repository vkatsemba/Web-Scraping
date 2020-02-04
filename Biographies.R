library(rvest)
library(dplyr)
library(purrr)
library(kableExtra)

team <- xml2::read_html("http://www.aeainvestors.com/about-aea/team/")
name <- team %>% html_nodes('.teamlist a') %>% html_text()
url <- team %>% html_nodes('.teamlist a') %>% html_attr('href')
url <- paste("http://www.aeainvestors.com/about-aea/team/", url, sep = "")

bio <- sapply(url, function(url) {tryCatch(url %>% as.character() %>% read_html() %>% html_nodes('.content p') %>% html_text(), error = function(e){NA})})

for(i in 1:length(bio)) {
  bio[i] <- sapply(bio[i], paste, collapse = " ")
}
bio <- as.character(bio)

title <- sapply(url, function(url) {tryCatch(url %>% as.character() %>% read_html() %>% html_nodes('h5') %>% html_text(), error = function(e){NA})})
title <- title[2,]

fullbio <- as.data.frame(cbind(name, title, bio))
