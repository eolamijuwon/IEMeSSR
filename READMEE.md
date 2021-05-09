
## Working with Digital Trace Data and ethics - Twitter with rtweet and Facebook

We could define digital traces as alternative sources of data ranging
from social media data to web search logs. Below are some impressive
examples of studies in the field of computational and digital
demography.

## Pre-lecture Instruction

Please read the following research materials carefully for discussion.
Participants will be required to share their key takeaway from the
articles as a check-in.

-   Gupta, M., Bansal, A., Jain, B., Rochelle, J., Oak, A., & Jalali, M.
    S. (2021). Whether the weather will help us weather the COVID-19
    pandemic: Using machine learning to measure twitter users’
    perceptions. International journal of medical informatics,
    145, 104340. <https://doi.org/10.1016/j.ijmedinf.2020.104340>

-   Koh, J. X., & Liew, T. M. (2020). How loneliness is talked about in
    social media during COVID-19 pandemic: text mining of 4,492 Twitter
    feeds. Journal of psychiatric research.
    <https://doi.org/10.1016/j.jpsychires.2020.11.015>

-   Pittman, M., & Reich, B. (2016). Social media and loneliness: Why an
    Instagram picture may be worth more than a thousand Twitter words.
    Computers in Human Behavior, 62, 155-167.
    <https://doi.org/10.1016/j.chb.2016.03.084>

-   Lohmann, S., White, B. X., & Zhen, Z. U. O. (2018). HIV messaging on
    Twitter: an analysis of current practice and data-driven
    recommendations. AIDS (London, England), 32(18), 2799.
    <http://doi.org/10.1097/QAD.0000000000002018>

-   Blakemore, J. K., Bayer, A. H., Smith, M. B., & Grifo, J. A. (2020).
    Infertility influencers: an analysis of information and influence in
    the fertility webspace. Journal of assisted reproduction and
    genetics, 37, 1371-1378.
    <https://doi.org/10.1007/s10815-020-01799-2>

-   Bogen, K. W., Bleiweiss, K. K., Leach, N. R., & Orchowski, L. M.
    (2019). \# MeToo: Disclosure and response to sexual victimization on
    Twitter. Journal of interpersonal violence, 0886260519851211.
    <https://doi.org/10.1177%2F0886260519851211>

-   Vijaykumar, S., Nowak, G., Himelboim, I., & Jin, Y. (2018). Virtual
    Zika transmission after the first US case: who said what and how it
    spread on Twitter. American journal of infection control, 46(5),
    549-557. <https://doi.org/10.1016/j.ajic.2017.10.015>

-   Stubbs-Richardson, M., Rader, N. E., & Cosby, A. G. (2018). Tweeting
    rape culture: Examining portrayals of victim blaming in discussions
    of sexual assault cases on Twitter. Feminism & Psychology, 28(1),
    90-108. <https://doi.org/10.1177%2F0959353517715874>

-   Smit, A., & Bosch, T. (2020). Television and black Twitter in South
    Africa: Our perfect wedding. Media, Culture & Society, 42(7-8),
    1512-1527. <https://doi.org/10.1177%2F0163443720926040>

From the above examples, you can observe that there has been a wide
range of opportunities to answer new and exciting demographic research
questions using data from digital platforms.

## Twitter Data Retreival

In todays session, we use the `rtweet` package to stream online
conversations about *condom* use especially during a pandemic. We will
explore the sentiments of the tweets as well as the top 10 trigrams.

As with other data analysis, remember to install the `rtweet` package
and all the relevant libraries. In addition to some of the libraries
that we have used in the previous sessions, we will also use some
functions from the `tidytext` package

``` r
library (httpuv)

library (rtweet)
library (tidyverse)
library (mosaic)
library (tidytext)
library (tweetrmd)
```

In order to be able to stream tweets directly from Twitter, you need to
have created a Twitter account. If you don’t have one, please click
[here](https://twitter.com/). Please note `rtweet` should be used
strictly in accordance with Twitter’s [developer
terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases).

## Activity - Pregnancy during a Pandemic?

In the next few lines of code, we retrieve public tweets related to
pregnancy during the pandemic. Reference to “during the pandemic” in
part because we are in the middle of a pandemic - although much better
in some regions now than before. To retrieve the tweets, we will use the
`rtweet` package to download tweets within the past eight days that
includes all keywords related to pregnancy e.g.: pregnant, pregnancy,
expecting a baby, e.t.c.

``` r
# tt <- get_token()
# 
# pregnant_keywd <- search_tweets(q = "pregnancy",
#                                 geocode = "-0.102613,15.933811,2238mi",
#                                 include_rts = FALSE, n = 5000,
#                                 retryonratelimit = TRUE,
#                                 token = tt)
              
```

``` r
#tweet_screenshot(tweet_url("700453054714355712", "1389211526234578944"))
#tweet_screenshot(tweet_url("2447372096", "1389187992539992068"))
```

We can also retrieve tweets that follow a keyphrase pattern like
“expecting a baby” or “baby bump”

``` r
# pregnant_keyphrase <-   search_tweets(q = "\"expecting a baby\"",
#                         geocode = "-0.102613,15.933811,2238mi",
#                         include_rts = FALSE, 
#                         n = 5000,
#                         retryonratelimit = TRUE)
# write_rds(pregnant_keyphrase, "data/pregnant_keyphrase.rds")
```

``` r
include_tweet("https://twitter.com/dsquintana/status/1275705042385940480")
```

<blockquote class="twitter-tweet" data-width="550" data-lang="en" data-dnt="true" data-theme="light"><p lang="en" dir="ltr">{bookdown} folks: I&#39;m trying to knit a PDF version of a HTML book that contains HTML elements (embedded tweets). <br><br>Is there a way to automatically take a screenshot of embedded tweets for PDF output? <br><br>Using the {webshot} package + PhantomJS didn&#39;t work...<a href="https://twitter.com/hashtag/Rstats?src=hash&amp;ref_src=twsrc%5Etfw">#Rstats</a></p>&mdash; Dan Quintana (@dsquintana) <a href="https://twitter.com/dsquintana/status/1275705042385940480?ref_src=twsrc%5Etfw">June 24, 2020</a></blockquote>

``` r
pregnant_keyphrase <- readRDS("data/pregnant_keyphrase.rds")

# tweet_screenshot(tweet_url(pregnant_keyphrase$user_id[8], pregnant_keyphrase$status_id[8]))
# 
# tweet_screenshot(tweet_url(pregnant_keyphrase$user_id[2], pregnant_keyphrase$status_id[2]))
```

keywords &lt;- c(“"travel abroad"”, “migrate”, “migrate”, “visa”,
“japa”, “"leave the country"”, “"leave this country"”)

            ## The geocode argument is specified to retain only tweets from Nigeria
            ## Note that the search_tweets function will only work if you are connected to the internet.
            ## The retryonratelimit argument instructs R to retry the downloading of 
            ## tweets once the rate limit has been reached

visaBan\_NG &lt;- Map(“search\_tweets”, n=10000, keywords, geocode =
“9.06048,7.48324,400mi”, include\_rts = FALSE, retryonratelimit = TRUE)

                    ## Convert your downloaded tweets to data.frame()

DF\_visaBan\_NG &lt;- do\_call\_rbind(visaBan\_NG)
