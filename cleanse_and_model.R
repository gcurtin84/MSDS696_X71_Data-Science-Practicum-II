####################################

#load required packages

library(textcat)
library(tm)
library(textclean)
library(topicmodels)
library(tidytext)
library(ggplot2)
library(dplyr)
library(tidyr)
library(SnowballC)
library(quanteda)

###########################################
## Read in album scrape from .Rdata file ##
###########################################

lyrics <- backup32942
lyrics[[1]] <- NULL

###########################################
## Wordcount and Filter Songs #############
###########################################

wc_songs <- as.list("")
z <- 0

for (x in lyrics){
  x <- x[4:(length(x)-10)] #remove first 3 and remove last 10
  x <- sapply(x, stripWhitespace) 
  y <- as.data.frame(sapply(strsplit(x, " "), length)) #word count for each list object entry
  xy <- cbind(x, y) #combine wordcount with documents
  xy <- xy[xy[2]>100, ] #keep entries with 100 or more words
  z <- z+1
  wc_songs[[z]] <- xy
}

###########################################
## Convert dataset from list to DF ########
###########################################

lyrics_clean <- cbind("delete", 1)
lyrics_clean <- as.data.frame(lyrics_clean)
names(lyrics_clean) <- c("lyrics", "wordcount")
lyrics_clean <- transform(lyrics_clean, lyrics = as.character(lyrics),wordcount = as.numeric(wordcount))

for (x in wc_songs){
  names(x) <- c("lyrics", "wordcount")
  x <- transform(x, lyrics = as.character(lyrics),wordcount = as.numeric(wordcount))
  lyrics_clean <- rbind(lyrics_clean, x)
}

write.csv(lyrics_clean, "lyrics_clean.csv")
lyrics_clean <- read.csv("lyrics_clean.csv")

###########################################
## Filter to remove non-English songs #####
###########################################

text <- lyrics_clean[2]
text <- transform(text, lyrics = as.character(lyrics))
lang <- textcat(text[2:(nrow(text)),])
write.csv(lang, "lang.txt")
lang <- as.data.frame(lang)
names(lang) <- "Language" 

language <- lang
lyrics <- text[2:(nrow(text)),]
wrdcnt <- lyrics_clean[2:(nrow(lyrics_clean)),3]

MetalLyrics <- cbind(language, wrdcnt, lyrics)
MetalLyrics <- transform(MetalLyrics, lyrics = as.character(lyrics))
names(MetalLyrics) <- c("language", "word_count", "lyrics")
write.csv(MetalLyrics, "MetalLyrics.csv")

MetalLyrics_en <- MetalLyrics[MetalLyrics$language=="english", ]
write.csv(MetalLyrics_en, "MetalLyrics_en.csv")

###########################################
## Clean and Stem text ####################
###########################################

cleanse_raw <- read.csv("MetalLyrics_en.csv")
cleanse <- removePunctuation(as.character(cleanse$lyrics))
cleanse <- tolower(cleanse)
cleanse <- gsub("´", "'", cleanse, fixed = TRUE)
cleanse <- replace_contraction(cleanse)
cleanse <- gsub("' ", " ", cleanse, fixed = TRUE)
cleanse <- gsub("'s ", " ", cleanse, fixed = TRUE)
cleanse <- gsub(" 'bout ", " about ", cleanse, fixed = TRUE)
cleanse <- gsub("u0092", "", cleanse, fixed = TRUE)
cleanse <- gsub("'", "", cleanse, fixed = TRUE)
stpwrds <- c(stopwords("english"), "will", "youre", "can", "take", "come", "dont", "cant", "can", "just", "ill")
cleanse <- removeWords(cleanse, stpwrds)
cleanse <- stripWhitespace(cleanse)
cleanseStem <- wordStem(cleanse, language = "en")
lyrics_clean <- cleanseStem
lyrics_clean <- transform(lyrics_clean, lyrics_clean = as.character(lyrics_clean))
write.csv(lyrics_clean, "lyrics_clean.csv")

###########################################
## Topic Modeling #########################
###########################################


lyrics_clean <- lyrics_clean$lyrics_clean
lyrics_source <- VectorSource(lyrics_clean)
lyrics_corpus <- Corpus(lyrics_source)
lyrics_dtm <- DocumentTermMatrix(lyrics_corpus)

ui = unique(lyrics_dtm$i)
lyrics_dtm <- lyrics_dtm[ui,]

lyrics_lda <- LDA(lyrics_dtm, k = 2, control = list(seed = 1234))


###########################################
## Show top words per category ############
###########################################

lyrical_cats <- tidy(lyrics_lda, matrix = "beta")

lyrics_top_terms <- lyrical_cats %>%
  group_by(topic) %>%
  top_n(20, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

lyrics_top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()

#https://www.tidytextmining.com/topicmodeling.html

###########################################################
## Show words w/ highest prob to appear in each category ##
###########################################################

beta_spread <- lyrical_cats %>%
  mutate(topic = paste0("topic", topic)) %>%
  spread(topic, beta) %>%
  filter(topic1 > .001 | topic2 > .001) %>%
  mutate(log_ratio = log2(topic2 / topic1))

beta_spread %>%
  group_by(direction = log_ratio > 0) %>%
  top_n(15, abs(log_ratio)) %>%
  ungroup() %>%
  mutate(term = reorder(term, log_ratio)) %>%
  ggplot(aes(term, log_ratio)) +
  geom_col() +
  labs(y = "Log2 ratio of beta in topic 2 / topic 1") +
  coord_flip()



