---
Title: "Introduction to Computational and Digital Demography"

Date: "14 February 2020"
---

## Working with Digital Trace Data and ethics - Twitter with rtweet and Facebook

We could define digital traces as alternative sources of data ranging from social media data to web search logs. Below are some impressive examples of studies in the field of computational and digital demography.

## Pre-lecture Instruction

Please read the following research materials carefully for discussion. Participants will be required to share their key takeaway from the articles as a check-in.

-   Gupta, M., Bansal, A., Jain, B., Rochelle, J., Oak, A., & Jalali, M. S. (2021). Whether the weather will help us weather the COVID-19 pandemic: Using machine learning to measure twitter users' perceptions. International journal of medical informatics, 145, 104340. <https://doi.org/10.1016/j.ijmedinf.2020.104340>

-   Koh, J. X., & Liew, T. M. (2020). How loneliness is talked about in social media during COVID-19 pandemic: text mining of 4,492 Twitter feeds. Journal of psychiatric research. <https://doi.org/10.1016/j.jpsychires.2020.11.015>

-   Pittman, M., & Reich, B. (2016). Social media and loneliness: Why an Instagram picture may be worth more than a thousand Twitter words. Computers in Human Behavior, 62, 155-167. <https://doi.org/10.1016/j.chb.2016.03.084>

-   Lohmann, S., White, B. X., & Zhen, Z. U. O. (2018). HIV messaging on Twitter: an analysis of current practice and data-driven recommendations. AIDS (London, England), 32(18), 2799. <http://doi.org/10.1097/QAD.0000000000002018>

-   Blakemore, J. K., Bayer, A. H., Smith, M. B., & Grifo, J. A. (2020). Infertility influencers: an analysis of information and influence in the fertility webspace. Journal of assisted reproduction and genetics, 37, 1371-1378. <https://doi.org/10.1007/s10815-020-01799-2>

-   Bogen, K. W., Bleiweiss, K. K., Leach, N. R., & Orchowski, L. M. (2019). \# MeToo: Disclosure and response to sexual victimization on Twitter. Journal of interpersonal violence, 0886260519851211. <https://doi.org/10.1177%2F0886260519851211>

-   Vijaykumar, S., Nowak, G., Himelboim, I., & Jin, Y. (2018). Virtual Zika transmission after the first US case: who said what and how it spread on Twitter. American journal of infection control, 46(5), 549-557. <https://doi.org/10.1016/j.ajic.2017.10.015>

-   Stubbs-Richardson, M., Rader, N. E., & Cosby, A. G. (2018). Tweeting rape culture: Examining portrayals of victim blaming in discussions of sexual assault cases on Twitter. Feminism & Psychology, 28(1), 90-108. <https://doi.org/10.1177%2F0959353517715874>

-   Smit, A., & Bosch, T. (2020). Television and black Twitter in South Africa: Our perfect wedding. Media, Culture & Society, 42(7-8), 1512-1527. <https://doi.org/10.1177%2F0163443720926040>

From the above examples, you can observe that there has been a wide range of opportunities to answer new and exciting demographic research questions using data from digital platforms. 

## Twitter Data Retreival

In todays session, we use the `rtweet` package to stream online conversations about *condom* use especially during a pandemic. We will explore the sentiments of the tweets as well as the top 10 trigrams.

As with other data analysis, remember to install the `rtweet` package and all the relevant libraries. In addition to some of the libraries that we have used in the previous sessions, we will also use some functions from the `tidytext` package

```{r}
#install.packages("rtweet")
library (rtweet)
library (tidyverse)
library (mosaic)
library (tidytext)
```

In order to be able to stream tweets directly from Twitter, you need to have created a Twitter account. If you don't have one, please click [here](https://twitter.com/). Please note `rtweet` should be used strictly in accordance with Twitter's [developer terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases).

In the next few lines of code, we will create an object `keywords` with all possible keywords that could capture all tweets related to the immigration ban. The " and " have been used together with the keyword to ensure that tweets contain exact matches of the keywords.

```{r}

pregnant_keywd <- search_tweets(q = "pregnancy",
              geocode = "-0.102613,15.933811,2238mi",
              include_rts = FALSE, 
              n = 5000, 
              retryonratelimit = TRUE)
              
head(pregnant_keywd$text)
```

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">The way I love my Girlfriend errh<br>Only pregnancy can separate us<br>😂😂😂😂😂😂😂💔💔💔💔</p>&mdash; Agedo (@agedo_jnr) <a href="https://twitter.com/agedo_jnr/status/1388478267859128321?ref_src=twsrc%5Etfw">May 1, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I wanna become vegetarian after this pregnancy. Coz I don&#39;t eat any meat at the moment. Do ppl become vegetarian by choice kana its prescribed? 🤔</p>&mdash; 30yearsOfBoitumeloFela! (@Petite_Rene) <a href="https://twitter.com/Petite_Rene/status/1388480878658084869?ref_src=twsrc%5Etfw">May 1, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Our Abortion Prices are reasonable that even Students can afford<br>We go out of our way to make you feel comfortable during an emotionally stressful time because we understand what it is to have an unplanned pregnancy. And we know that deciding to terminate a pregnancy can be one o <a href="https://t.co/U1ZrGUBovl">pic.twitter.com/U1ZrGUBovl</a></p>&mdash; 0713953452 Abortion pills/clinic in Tzaneen (@KaraboSmith6) <a href="https://twitter.com/KaraboSmith6/status/1386583975347564544?ref_src=twsrc%5Etfw">April 26, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
              
migrant_keyphrase <-    search_tweets(q = "\"leave the country\"",
                        geocode = "-0.102613,15.933811,2238mi",
                        include_rts = FALSE, 
                        n = 5000,
                        retryonratelimit = TRUE)

```{r}

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">The way I love my Girlfriend errh<br>Only pregnancy can separate us<br>😂😂😂😂😂😂😂💔💔💔💔</p>&mdash; Agedo (@agedo_jnr) <a href="https://twitter.com/agedo_jnr/status/1388478267859128321?ref_src=twsrc%5Etfw">May 1, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

keywords <- c("\"travel abroad\"", "migrate",
              "migrate", "visa", "japa", 
              "\"leave the country\"",
              "\"leave this country\"")
            
            ## The geocode argument is specified to retain only tweets from Nigeria
            ## Note that the search_tweets function will only work if you are connected to the internet.
            ## The retryonratelimit argument instructs R to retry the downloading of 
            ## tweets once the rate limit has been reached
visaBan_NG <- Map("search_tweets", n=10000, keywords,
              geocode = "9.06048,7.48324,400mi",
              include_rts = FALSE, retryonratelimit = TRUE)

                    ## Convert your downloaded tweets to data.frame()
DF_visaBan_NG <-  do_call_rbind(visaBan_NG)


## Save the downloaded tweets as .csv on your local computer using the `save.csv` function

save_as_csv(DF_visaBan_NG, "visaBan_NG.csv",
            prepend_ids = TRUE, na = "NA")

```

Remember that on Day 1, we covered how to import and export data into R. In the following sections, we will import the dataset from the local computer and do some data cleaning/manipulation. This will include, filtering observations `filter`, selecting relevant variables `select`, checking variables structure, to be sure they are consistent and as desired and recreating new variables `mutate`.

```{r}
DF_visaBan_NG <- read.csv("visaBan_NG.csv")

ImmigrantBan_NG <- DF_visaBan_NG %>% 
                   ## Keep only Tweets without links
                   ## We are doing this to eliminate tweets that we assume might be from New agencies/bloggers
                   ## Perhaps we are interested in Nigerian's response to the ban
                   filter (is.na(urls_url) == TRUE) %>% 
                   
                   ## Keep only the relevant variables
                   select(user_id, account_created_at, 
                          followers_count, friends_count,
                          verified, location, status_id,
                          text, created_at, reply_to_user_id, 
                          retweet_count, favorite_count, source) %>% 
                   ## Check the structure of "account_created_at" and "created_at"
                   ## You will observe that the two variables are characters.
                   ## We will format and convert them to dates using the as.Date function
                   mutate(account_created_at = as.Date(account_created_at, format = "%Y-%m-%d %H:%M:%S"),
                          created_at = as.Date(created_at, format = "%Y-%m-%d %H:%M:%S")) %>% 
                          
                   ## Perhaps we are also interested in the different types of devices that Twitter users use
                   ## This could perhaps give us some background information about
                   ## "socio-economic status" of those who are tweeting
                   
                   mutate(deviceType = derivedFactor("Android" = (source == "Plume for Android" |
                                                           source == "Twidere for Android (Deprecated)" | 
                                                           source == "Twitter for Android" | 
                                                           source == "UberSocial for Android"),
                                                    "iOS" = (source == "Tweetbot for iΟS" |
                                                             source == "Twitter for iPad" |
                                                             source == "Twitter for iPhone" |
                                                             source == "Tweetbot for iΟS"),
                                                    "PC/Mac" = (source == "Twitter for Mac" |
                                                                source == "Twitter Web App" |
                                                                source == "Twitter Web Client"),
                                                    "Unknown" = (source == "Buffer" | source == "Cheap Bots, Done Quick!" |
                                                                source == "Crowdfire App" | source == "dlvr.it" |
                                                                source == "Echobox Social" | source == "Hootsuite Inc." | 
                                                                source == "IFTTT" | source == "Mobile Web (M2)" |
                                                                source == "Sprout Social" | source == "Storm_It" |
                                                                source == "TrafficChiefNG" | source == "TweetDeck"),
                                                    .default = NA)) %>% 
                                                    
                   ## Finally, create a variable to identify Tweets from "Celebrities" or verified users
                   mutate(verified = derivedFactor("Verified" = verified ==(TRUE),
                                                   "Not Verified" = verified ==(FALSE),
                                                    .default = NA))
```

#### Exercise 5A.1

Using the information available in the `ImmigrantBan_NG` dataset. Find the:

-   Percentage distribution of devices from which tweets were sent.

-   Average number of Retweets/Favourites

-   What percentage of the tweets were posted by verified users

*Hint:* Can the exercise be addressed using any existing package? `stargazer`, `kableExtra`, `compareGroups`

In addition to the previous data wrangling processes, we could also remove some features from our tweets include mentions (@username). A careful review also shows that we streamed some tweets that are not related to the US immigration visa ban. As a result, we could also filter for observations that does not include the keywords - *okada* or *keke*. Note: that R is case sensitive, therefore, we need to take into considerations, that the keywords could include different combinations of cases.

```{r}
tidy_ImmigrantBan_NG <- ImmigrantBan_NG %>%
                        select(created_at, text, 
                              favorite_count, 
                              retweet_count) %>%
                        mutate (text = as.character(text)) %>% 
                        mutate(text = gsub(text, pattern = "@\\w+", replacement = "")) %>% 
                        
                        # removes tweets with the word "okada" OR "keke" since it's not related to the immigrant visa ban
                        filter (!str_detect(text, pattern = "okada"),
                                !str_detect(text, pattern = "Okada"),
                                !str_detect(text, pattern = "OKADA"),
                                !str_detect(text, pattern = "keke"),
                                !str_detect(text, pattern = "Keke"),
                                !str_detect(text, pattern = "KEKE"))
                                
                        ## Create a trigram of words used in the Tweet.              
word_ImmigrantBan_NG <- tidy_ImmigrantBan_NG %>% 
                        unnest_tokens(bigram, text, token = "ngrams", n = 3) %>% 
                        separate(bigram, c("word1", "word2", "word3"), sep = " ") %>%  
                        
                        ## Remove common words (stopwords).
                        filter(!word1 %in% stop_words$word,       # remove stopwords 
                               !word2 %in% stop_words$word,       # remove stopwords
                               !word3 %in% stop_words$word) %>% 
                               
                        filter(!str_detect(word1, pattern = "[[:digit:]]"), # removes any words with numeric digits
                               !str_detect(word2, pattern = "[[:digit:]]"),
                               !str_detect(word3, pattern = "[[:digit:]]"),
                               
                               !str_detect(word1, pattern = "[[:punct:]]"), # removes any remaining punctuations
                               !str_detect(word2, pattern = "[[:punct:]]"),
                               !str_detect(word3, pattern = "[[:punct:]]"),
                               
                               !str_detect(word1, pattern = "(.)\\1{2,}"),  # removes any words with 3 or more repeated letters
                               !str_detect(word2, pattern = "(.)\\1{2,}"),
                               !str_detect(word3, pattern = "(.)\\1{2,}"),
                               
                               !str_detect(word1, pattern = "\\b(.)\\b")) %>%  # removes any remaining single letter words
                               # !str_detect(word2, pattern = "\\b(.)\\b")
                               # !str_detect(word3, pattern = "\\b(.)\\b")) 
                               
                       unite("bigram", c(word1, word2, word3), sep = " ") %>%
                       count(bigram, sort = TRUE)
```

#### Exercise 5A.2

Using the `word_ImmigrantBan_NG` data created above:

-   Create a dataframe with the top 10 bigrams.

-   Visualize the distribution using `ggplot2`

    -   What `geom_` is most applicable for your exercise?

## Sentiment Analysis

Sentiment analysis is the contextual mining of text in order to identify, interprete, and classify emotions with voice or text data using text analysis techniques. This opportunity allows us as researchers, and students to identify sentiments (positive, negative or neutral) towards a prevalent social problem or online conversation. For example we could be interested in the sentiments of tweets on the US immigration ban. Are they more positive, negative or neutral? In the following sections, we'll attempt to examine the sentiments of tweets on each day.

```{r}
text_immigration <-  tidy_ImmigrantBan_NG %>%
                     select(created_at, text, 
                            favorite_count, 
                            retweet_count) %>%
                     unnest_tokens("word", text) %>%
                     
                     ## Filter for words that are not in the stopwords dictionary
                     anti_join(stop_words, by = "word") %>%
                     
                     ## Filter for words that are in the sentiment dictionary and our dataframe
                     inner_join(y = sentiments, by = "word") %>% 
                     
                     ## Count the number sentiments used each day
                     count(created_at, sentiment) %>% 
                     group_by(created_at) %>% 
                     mutate (perc_nega = (n/sum(n))*100) %>% 
                     mutate (perc_nega = round (perc_nega, digits = 2),
                             sentiment = as.factor (sentiment))
```

We could also visualize the sentiment of tweets on each day using the new dataframe created above `text_immigration`.

```{r}
library(ggthemes)

    text_immigration %>% 
    ggplot (aes(x = created_at, y = perc_nega,
                fill = factor(sentiment, 
                        labels = c("Negative",
                                    "Positive")))) +
    geom_bar (stat = "identity") + 
    theme_fivethirtyeight () +
    labs (title = "Sentiment of Tweets Related to US Immigration Ban") +
    guides(fill=guide_legend(title="Sentiment of Tweets")) +
    scale_fill_manual(values = c("#ffb612", "#000000"))
```

## What Next

**The Summer Institute for Computational Social Science**

The Summer Institute for Computational Social Science [SICSS] is currently accepting applications (until March 20) for this years summer school. The institute brings together graduate students, postdoctoral researchers, and junior faculty for 2 weeks of intensive study and interdisciplinary research. This year there are more than 20 partner locations. Feel free to review the application requirements and apply to attend the location nearest to you. [**Apply Now**](https://compsocialscience.github.io/summer-institute/2020/stellenbosch/)

**The Barcelona Summer School of Demography**

The Barcelona Summer School of Demography [BSSD] is also accepting applications (until March 31) for participation at this years summer school. The BSSD is based at the Centre for Demographic Studies (CED), Universitat Autònoma de Barcelona, and offers a four-week intensive course in R covering three major strengths of R: statistical and demographic analysis, data visualization, and spatial analysis. Participants are free to apply for the entire course or any of the individual modules. [**Apply Now**](https://ced.uab.cat/en/courses/barcelona-summer-school-of-demography/)

## Supplemental Readings

-   Alburez-Gutierrez, D., Aref, S., Gil-Clavel, B. S., Grow, A., Negraia, D. V., Zagheni, E. In: Arbia, G., Peluso, S., Pini, A., Rivellini, G. (Eds.): Smart statistics for smart applications : book of short papers SIS2019, 23--30 Pearson (2019) <https://osf.io/preprints/socarxiv/24jp7/>

-   Cesare, N., Lee, H., McCormick, T., Spiro, E., & Zagheni, E. (2018). "Promises and pitfalls of using digital traces for demographic research." Demography. 55(5), 1979-1999. <https://doi.org/10.1007/s13524-018-0715-2>

-   Pham, Katherine Hoffmann, Francesco Rampazzo, and Leah R. Rosenzweig. (2019). "Online Surveys and Digital Demography in the Developing World: Facebook Users in Kenya." arXiv preprint arXiv:[1910.03448](https://arxiv.org/abs/1910.03448).

-   Salganik, Matthew J. (2017). Bit by Bit: Social Research in the Digital Age. Princeton, NJ: Princeton University Press. Open review edition. <https://www.bitbybitbook.com/en/1st-ed/preface/>
