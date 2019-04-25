# MSDS696_X71_Data-Science-Practicum-II

by Garrett Curtin

## Predicting Categories of Metal Lyrics Using Machine Learning

As a metal enthusiast, it is difficult to find new bands that meet your particular taste within the metal genre.  Within this category of music there are many subgenres which are mostly defined by fans.  Most bands do not advertise themselves as being a member of these fan created sub-genres.  To make things more confusing, sub-genre definitions are not well established.  Sub-genre variables include instrument techniques used, the use or exclusion of certain instruments, overall sound, song composition, and lyrical content. Applications such as Pandora or Amazon Music do not handle recommendations well; especially for an over-opinionated metal-head sucha as myself.  This project attempts to take lyrics from metal songs and predict categories using the topic modeling machine learning algorithms.

## Project Design

This project had three phrases: data collection, text cleansing, and machine learning modeling.  Data collection included a webscrape from [Metallyrica.com](http://www.metallyrica.com/).  

### Phase I: [Web Scrape](https://github.com/gMSDS696_X71_Data-Science-Practicum-II/blob/master/metallyrica_scrape.R)

The webscrape resulted in the lyrics of almost 140,000 songs from 8246 bands. (insert link to script)

### Phase II: [Text Cleansing](https://github.com/gMSDS696_X71_Data-Science-Practicum-II/blob/master/cleanse_and_model.R)

In addition to the usual text cleansing tasks, the textcat function was used to identify text language and filter out non-English lyrics.  Song count lowered to around 110,000 after language identification.

### Phase III: [Topic Modeling](https://github.com/gMSDS696_X71_Data-Science-Practicum-II/blob/master/cleanse_and_model.R)

The Latent Dirichlet allocation model was used to separate song lyrics into various numbers of categories.  (insert link to script)

## EDA and Topic Modeling

Wordcounts

![wordcounts](https://github.com/gcurtin84/MSDS696_X71_Data-Science-Practicum-II/blob/master/Cat_Word_Probability.png)


Looking at the correlations below, I found that the pass stats and FPTS had the highest correlations to the target parameter (NxtWk.FPTS).  For this reason, I decided to use the Pass.Yards and FPTS in my ML models.

## Sources

http://www.metallyrica.com/

https://www.tidytextmining.com/topicmodeling.html
