# MSDS696_X71_Data-Science-Practicum-II

by Garrett Curtin

## Predicting Categories of Metal Lyrics Using Machine Learning

As a metal enthusiast, it is difficult to find new bands that meet your particular taste within the metal genre.  Within this category of music there are many subgenres which are mostly defined by fans.  Most bands do not advertise themselves as being a member of these fan created sub-genres.  To make things more confusing, sub-genre definitions are not well established.  Sub-genre variables include instrument techniques used, the use or exclusion of certain instruments, overall sound, song composition, and lyrical content. Applications such as Pandora or Amazon Music do not handle recommendations well; especially for an over-opinionated metal-head such as myself.  This project attempts to take lyrics from metal songs and predict categories using the topic modeling machine learning algorithms.

## Project Design

This project had three phrases: data collection, text cleansing, and machine learning modeling.  Data collection included a webscrape from [Metallyrica.com](http://www.metallyrica.com/).  

### Phase I: [Web Scrape](https://github.com/gMSDS696_X71_Data-Science-Practicum-II/blob/master/metallyrica_scrape.R)

The webscrape resulted in the lyrics of almost 140,000 songs from 8246 bands.

### Phase II: [Text Cleansing](https://github.com/gMSDS696_X71_Data-Science-Practicum-II/blob/master/cleanse_and_model.R)

In addition to the usual text cleansing tasks, the textcat function was used to identify text language and filter out non-English lyrics.  Song count lowered to around 110,000 after language identification.

### Phase III: [Topic Modeling](https://github.com/gMSDS696_X71_Data-Science-Practicum-II/blob/master/cleanse_and_model.R)

The Latent Dirichlet allocation model was used to separate song lyrics into various numbers of categories.

## EDA and Topic Modeling

### Data Set

After scraping and cleansing the data, the metal lyrics data set was comprised of just under 140,000 songs which were labeled by language.   This data set was then 

Language Counts

![Lang Counts](https://github.com/gcurtin84/MSDS696_X71_Data-Science-Practicum-II/blob/master/language_barplot.png)

The chart above shows the highest occuring song lyric languages.  The vast majority of songs were in the English language. I opted to remove English from the output to better show the runner's up.  The next most frequent language is Scots which is a dialect of English.  The majority of languages originate from Northern Europe.  This makes sense due to the fact that many metal bands come from Northern European countries.

Word Counts

![Word Counts](https://github.com/gcurtin84/MSDS696_X71_Data-Science-Practicum-II/blob/master/Word_Counts.png)

This visualization shows a histogram depicting the frequency of word counts in 50 word buckets.  As part of cleaning the scraped data set, I removed any entries that had less than 100 words.  This made the cleaning process simplier than identifying which entries were actual songs and which were unwanted entries left over from the HTML document they came from.  This explains why the 0 to 50 and 50 to 100 bins are empty.  The majority of song word counts were between 100 and 400.  The lowest word count is 100 while the largest was over 5000.

### Topic Model Categories

Top Words by Frequency
![Top Words](https://github.com/gcurtin84/MSDS696_X71_Data-Science-Practicum-II/blob/master/Cat_Top_Words.png)

Top Words by Probability
![Most Probable Words](https://github.com/gcurtin84/MSDS696_X71_Data-Science-Practicum-II/blob/master/Cat_Word_Probability.png)


Looking at the correlations below, I found that the pass stats and FPTS had the highest correlations to the target parameter (NxtWk.FPTS).  For this reason, I decided to use the Pass.Yards and FPTS in my ML models.

## Sources

http://www.metallyrica.com/

https://www.tidytextmining.com/topicmodeling.html
