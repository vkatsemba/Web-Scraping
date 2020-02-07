img <- sapply(url, function(url) {tryCatch(url %>% as.character() %>% read_html() %>% html_nodes('.image_and_captions-image') %>% html_attr('src'), error = function(e){NA})})
img <- unlist(img)
img <- paste("https://www.adamsstreetpartners.com", img, sep = "")
dest <- paste(name, ".jpg", sep = "")
x <- Map(function(u,d) download.file(u, d, mode = "wb"), img, dest)

knitr::include_graphics(path = dest)
