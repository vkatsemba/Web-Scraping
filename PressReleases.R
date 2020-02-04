pr <- xml2::read_html("http://www.aeainvestors.com/news/")
pr_head <- pr %>% html_nodes('p a') %>% html_text()
pr_date <- pr %>% html_nodes('strong') %>% html_text()

pr_1 <- xml2::read_html("http://www.aeainvestors.com/news/aea-investors-closes-seventh-flagship-fund-at-4-8-billion-hard-cap/")
pr_1_text <- pr_1 %>% html_nodes('p') %>% html_text()
pr_2 <- xml2::read_html("http://www.aeainvestors.com/news/aea-investors-closes-fourth-small-business-fund-above-target-at-877-million/")
pr_2_text <- pr_2 %>% html_nodes('p') %>% html_text()

pr_1_text <- pr_1_text[4:12]
pr_2_text <- pr_2_text[3:10]
pr_1_text <- paste(pr_1_text, collapse = " ")
pr_2_text <- paste(pr_2_text, collapse = " ")
pr_text <- rbind(pr_1_text, pr_2_text)
pr_full <- as.data.frame(cbind(pr_head, pr_date, pr_text))

pr_full %>% kable(format = "html", col.names = NULL, row.names = FALSE) %>% kable_styling()
