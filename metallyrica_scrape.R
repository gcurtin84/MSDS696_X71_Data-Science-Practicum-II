###########################################
## load required packages #################
###########################################

library(rvest) #html scraping
library(tm) #removepunctuation
library(dplyr)
library(tidytext) #tidy
library(xml2)
library(qdap) #bracketX
library(wordcloud)
library(sos)
library(doParallel)
library(xml2)

###########################################
## scrape band names ######################
###########################################

#urls to bands are separated on separate web-pages by the first letter of the band name

metallyrica <- "http://www.metallyrica.com/VAR.html" #raw metallyrica.com url
ltrpg <- c(letters, 0) #web-page variables a-z plus "0" for bands names that start with a number
metallyrica_bands <- "" #create variable for the forloop below.  If not created forloop will result in error

for(x in ltrpg){
  y <- gsub("VAR", x, metallyrica) #create full url
  y <- read_html(y)
  y <- html_attr(html_nodes(y, "a"), "href")
  metallyrica_bands <- c(metallyrica_bands, y)
}

###########################################
## Clean band URLS ########################
###########################################

rm.urls <- c(
  "^0.html$", "^a.html$", "^b.html$", "^c.html$", "^d.html$", "^e.html$", 
  "^f.html$", "^g.html$", "^h.html$", "^i.html$", "^j.html$", "^k.html$", 
  "^l.html$", "^m.html$", "^n.html$", "^o.html$", "^p.html$", "^q.html$", 
  "^r.html$", "^s.html$", "^t.html$", "^u.html$", "^v.html$", "^w.html$", 
  "^x.html$", "^y.html$", "^z.html$", "^about.html$", "^submit.html$", 
  "^privacy.html$", "^disclaimer.html$", "^links.html$"
)

metallyrica_bands.clean <- metallyrica_bands

for (x in rm.urls) {
  metallyrica_bands.clean <- metallyrica_bands.clean[-(grep(x, metallyrica_bands.clean))]
}

metallyrica_bands.clean <- metallyrica_bands.clean[grep(".html", metallyrica_bands.clean)]

metallyrica_bands <- metallyrica_bands.clean
rm(metallyrica_bands.clean)
write.table(metallyrica_bands, "metallyrica_bands.txt")

###########################################
## scrape album names #####################
###########################################

album_scrape <- as.data.frame(metallyrica_bands)

for (x in album_scrape){
  x <- paste("http://www.metallyrica.com/", x, sep = "")
  stop <- paste("Stopped at ", x, sep = "")
  x <- tryCatch(read_html(x), error=function(e) e)
  y <- class(x)
  if(y[2]=="error") {next} else {
    x <- html_attr(html_nodes(x, "a"), "href")
    metallyrica_albums <- c(metallyrica_albums, x)
    }
}

write.csv(metallyrica_albums, "metallyrica_albums.csv")

###########################################
## Clean album names ######################
###########################################

albums_clean <- metallyrica_albums

rm.urls2 <- c(
  "../0.html$", "../a.html$", "../b.html$", "../c.html$", "../d.html$", "../e.html$", 
  "../f.html$", "../g.html$", "../h.html$", "../i.html$", "../j.html$", "../k.html$", 
  "../l.html$", "../m.html$", "../n.html$", "../o.html$", "../p.html$", "../q.html$", 
  "../r.html$", "../s.html$", "../t.html$", "../u.html$", "../v.html$", "../w.html$", 
  "../x.html$", "../y.html$", "../z.html$", "../about.html$", "../submit.html$", 
  "../privacy.html$", "../disclaimer.html$", "../links.html$"
)

for (x in rm.urls2) {
  albums_clean <- albums_clean[-(grep(x, albums_clean))]
}

albums_clean <- albums_clean[grep(".html#0", albums_clean)]
albums_clean <- unique(albums_clean)

metallyrica_albums <- albums_clean
write.table(albums_clean, "albums_clean3.txt")

###########################################
## Scrape lyrics ##########################
###########################################

lyric_scrape <- metallyrica_albums

metallyrica_lyrics = as.list("")

for (x in lyric_scrape){
  url <- gsub("..", "http://www.metallyrica.com", x, fixed = TRUE)
  obj <- gsub("../lyrica", "", x, fixed = TRUE)
  obj <- gsub(".html#0", "", obj, fixed = TRUE)
  x <- tryCatch(read_html(url), error=function(e) e)
    if(class(x)=="xml_document") {
    x <- x %>% html_nodes("font") %>% html_text()
    metallyrica_lyrics[[obj]] <- x
  } else {next} 
}

backup32942 <- metallyrica_lyrics
save(backup32942, file = "backup32942.RData")



