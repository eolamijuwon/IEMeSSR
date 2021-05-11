

pregnant_keywd <- search_tweets(q = "pregnant",
                                geocode = "-0.102613,15.933811,2238mi",
                                include_rts = FALSE, n = 5000,
                                retryonratelimit = TRUE)

keywords <- c("\"travel abroad\"", 
              "\"leave the country\"",
              "\"leave this country\"",
              "migrate",
              "migrate", "visa", "japa")
