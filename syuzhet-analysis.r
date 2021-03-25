## Julian Lemmerich
## 24.03.2021
## Code für 1087-se Sentiment Analysis on Obama and Trump


library(syuzhet)
library(readr)


# OBAMA-Korpus
setwd("C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 7/1087-se Textmining/Hausarbeit/Corpora/obama_corpus")
# TRUMP-Korpus
setwd("C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 7/1087-se Textmining/Hausarbeit/Corpora/trump_corpus v2.3 - ASCII")


### Analysis of full Text  ###

filelist <- list.files()
sumlist <- c()
meanlist <- c()


for (f in filelist) {
  t <- read_file(f)
  
  poa_word_v <- get_tokens(t, pattern = "\\W")
  syuzhet_vector <- get_sentiment(poa_word_v, method="syuzhet")
  
  sumlist <- c(sumlist, sum(syuzhet_vector))
  meanlist <- c(meanlist, mean(syuzhet_vector))
}

#View(data.frame(filelist, sumlist, meanlist)) #für die anzeige direkt in R-Studio
write.csv(data.frame(filelist, sumlist, meanlist),"C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 7/1087-se Textmining/Hausarbeit/Analysis/dataframe_x.csv", row.names = FALSE)

mean(meanlist)


### Analysis of a single text ###

#vorher den richtigen Korpus als wd setzen!
speech <- read_file("2021-01-19_farewell-address-the-nation-3_ascii.txt")

speech.tokens <- get_tokens(speech, pattern = "\\W")
speech.sentiment <- get_sentiment(speech.tokens, method="syuzhet")

# then create a dataframe from that
speech.df <- data.frame(speech.tokens, speech.sentiment)

# from https://stackoverflow.com/questions/1660124/how-to-sum-a-variable-by-group
speech.df.aggregate <- aggregate(speech.df$speech.sentiment, by=list(Category=speech.df$speech.tokens), FUN=sum)

write.csv(speech.df.aggregate,"C:/Users/julian.lemmerich/OneDrive/User Data/Uni/Semester 7/1087-se Textmining/Hausarbeit/Analysis/dataframe_speech-aggregate.csv", row.names = FALSE)

