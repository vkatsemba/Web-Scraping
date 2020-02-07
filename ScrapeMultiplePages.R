library(rvest)
library(dplyr)
library(purrr)
library(kableExtra)

team <- xml2::read_html("https://www.adamsstreetpartners.com/team/")
name <- team %>% html_nodes('.tiles-item-name') %>% html_text()
title <- team %>% html_nodes('.tiles-item-title') %>% html_text()

url <- team %>% html_nodes('a') %>% html_attr('href')
url <- url[31:235]
url <- paste("https://www.adamsstreetpartners.com", url, sep = "")

exp <- sapply(url, function(url) {tryCatch(url %>% as.character() %>% read_html() %>% html_nodes('.markdown') %>% html_text(), error = function(e){NA})})

bio <- as.data.frame(cbind(name,title,exp))

pr <- xml2::read_html("https://www.adamsstreetpartners.com/news/")
pr_head <- pr %>% html_nodes('.tiles-item-name') %>% html_text()
pr_url <- pr %>% html_nodes('a') %>% html_attr('href')
pr_url <- pr_url[31:91]
pr_url <- paste("https://www.adamsstreetpartners.com", pr_url, sep = "")

text <- sapply(pr_url, function(url) {tryCatch(url %>% as.character() %>% read_html() %>% html_nodes('.markdown-content p:nth-child(1)') %>% html_text(), error = function(e){NA})})
text <- text[1,]

press_release <- as.data.frame(cbind(pr_head,text))
press_release %>% kable(format = "html", col.names = NULL, row.names = FALSE) %>% kable_styling()
