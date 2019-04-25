# MSDS696_X71_Data-Science-Practicum-II

by Garrett Curtin

## Predicting Categories of Metal Lyrics Using Machine Learning

As a metal enthusiast, it is difficult to find new bands that meet your particular taste within the metal genre.  Within this category of music there are many subgenres which are mostly defined by fans.  Most bands do not advertise themselves as being a member of these fan created sub-genres.  To make things more confusing, sub-genre definitions are not well established.  Sub-genre variables include instrument techniques used, the use or exclusion of certain instruments, overall sound, song composition, and lyrical content. Applications such as Pandora or Amazon Music do not handle recommendations well; especially for an over-opinionated metal-head sucha as myself.  This project attempts to take lyrics from metal songs and predict categories using the topic modeling machine learning algorithms.

## Project Design

This project had three phrases: data collection, text cleansing, and machine learning modeling.  Data collection included a webscrape from [Metallyrica.com](http://www.metallyrica.com/).  

### Phase I: Web Scrape Script

The webscrape resulted in the lyrics of almost 140,000 songs from 8246 bands. (insert link to script)

### Phase II: Text Cleansing

In addition to the usual text cleansing tasks, the textcat function was used to identify text language and filter out non-English lyrics.  Song count lowered to around 110,000 after language identification. (insert link to script)

### Phase III: Topic Modeling

The Latent Dirichlet allocation model was used to separate song lyrics into various numbers of categories.  (insert link to script)

## EDA

Wordcounts

![str](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Str_AllQBStats.png)

![summary](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Summary_AllStats.png)

Looking at the correlations below, I found that the pass stats and FPTS had the highest correlations to the target parameter (NxtWk.FPTS).  For this reason, I decided to use the Pass.Yards and FPTS in my ML models.

![Pass Correlations](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Plot_PassQBStats.png)

![Rush Correlations](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Plot_RushQBStats.png)

![Corrplot](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Corrplot_Allstats.png)

The [Combined Dataset](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Combined_Dataset.R) is created using the [Stats Dataset](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/Stats_Dataset.R).  For each week of football the next week's stats for each player were added to the current week.  For example, I combined the week 1 stats with the week 2 stats.  The goal of this project is to use a week's stats to predict the following weeks fantasy points.

## Results

The best model defined ...

#### KNN Predictions vs. Targets:
![KNN Predictions](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/KNN_Table.png)

#### SVM Predictions vs. Targets:
![SVM Predictions](https://github.com/gcurtin84/MSDS692_X41_Data-Science-Practicum-I/blob/master/SVM_Table.png)

## Abbreviations

## Sources

http://www.metallyrica.com/

https://www.tidytextmining.com/topicmodeling.html
