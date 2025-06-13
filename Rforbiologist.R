##install.packages("tidyverse")
library(tidyverse)


#Read the data
#citations_raw <- read_csv('Downloads/pone.0166570.s001.csv')
citations_raw <- read_csv('https://journals.plos.org/plosone/article/file?type=supplementary&id=10.1371/journal.pone.0166570.s001')

#Rename columns
citations_temp <- rename(citations_raw,
                         journal = 'Journal identity',
                         impactfactor = '5-year journal impact factor',
                         pubyear = 'Year published',
                         colldate = 'Collection date',
                         pubdate = 'Publication date',
                         nbtweets = 'Number of tweets',
                         woscitations = 'Number of Web of Science citations')
#Modify with mutate
citations <- mutate(citations_temp, journal = as.factor(journal))
#
levels(citations$journal)

##rename and modify
citations_raw %>%
  rename(journal = 'Journal identity',
         impactfactor = '5-year journal impact factor',
         pubyear = 'Year published',
         colldate = 'Collection date',
         pubdate = 'Publication date',
         nbtweets = 'Number of tweets',
         woscitations = 'Number of Web of Science citations') %>%
  mutate(journal = as.factor(journal))
#rename modify and nest
citations <- citations_raw %>%
  rename(journal = 'Journal identity',
         impactfactor = '5-year journal impact factor',
         pubyear = 'Year published',
         colldate = 'Collection date',
         pubdate = 'Publication date',
         nbtweets = 'Number of tweets',
         woscitations = 'Number of Web of Science citations') %>%
  mutate(journal = as.factor(journal))
#Select columns
citations %>%
  select(journal, impactfactor, nbtweets)
#drop columns
citations %>%
  select(-Volume, -Issue, -Authors)
#separate by a character
citations %>%
  separate(pubdate,c('month','day','year'),'/')
#Filter
citations %>%
  filter(str_detect(Authors,'et al'))
#filter and select
citations %>%
  filter(str_detect(Authors,'et al')) %>%
  select(Authors)
#Filter diverse
citations %>%
  filter(!str_detect(Authors,'et al'))
#filter divers and select
citations %>%
  filter(!str_detect(Authors,'et al')) %>%
  select(Authors)
#Filter diverse and get the data
citations %>%
  filter(!str_detect(Authors,'et al')) %>%
  pull(Authors) %>%
  head(10)
#find IF<5
citations %>%
  filter(!str_detect(Authors,'et al'), impactfactor < 5)
##lower case
citations %>%
  mutate(authors_lowercase = str_to_lower(Authors)) %>%
  select(authors_lowercase)
#remove spaces
citations %>%
  mutate(journal = str_remove_all(journal," ")) %>%
  select(journal) %>%
  unique() %>%
  head(5)
#Count
citations %>% count(journal, sort = TRUE)
#Count pubyear
citations %>%
  count(journal, pubyear) %>%
  head()
#count number of tweets
citations %>%
  count(journal, wt = nbtweets, sort = TRUE)
#count mean of tweets per year
citations %>%
  group_by(journal) %>%
  summarise(avg_tweets = mean(nbtweets)) %>%
  head(10)
#sort
citations %>%
  group_by(journal) %>%
  summarise(avg_tweets = mean(nbtweets)) %>%
  arrange(desc(avg_tweets)) %>% # decreasing order (wo desc for increasing)
  head(10)

##ggplots
#Scatterplots
citations %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations) +
  geom_point()
#with colors
citations %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations) +
  geom_point(color = "red")
#species specific colors
citations %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations, color = journal) +
  geom_point()
#picking few data and prepare
citations_ecology <- citations %>%
  mutate(journal = str_to_lower(journal)) %>% # all journals names lowercase
  filter(journal %in%
           c('journal of animal ecology','journal of applied ecology','ecology')) # filter
citations_ecology
#species specific shape
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations, shape = journal) +
  geom_point(size=2)
#lines instead of points
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations) +
  geom_line() +
  scale_x_log10()
#sorted
citations_ecology %>%
  arrange(woscitations) %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations) +
  geom_line() +
  scale_x_log10()
#with their points
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations) +
  geom_line() +
  geom_point() +
  scale_x_log10()
#linear trends
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_log10()
#smoother
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations) +
  geom_point() +
  geom_smooth() +
  scale_x_log10()
#histograms
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets) +
  geom_histogram()
#histograms with colors
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets) +
  geom_histogram(fill = "orange")
#with colors
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets) +
  geom_histogram(fill = "orange", color = "brown")
#with labels and axis
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets) +
  geom_histogram(fill = "orange", color = "brown") +
  labs(x = "Number of tweets",
       y = "Count",
       title = "Histogram of the number of tweets")
#by species
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets) +
  geom_histogram(fill = "orange", color = "brown") +
  labs(x = "Number of tweets",
       y = "Count",
       title = "Histogram of the number of tweets") + 
  facet_wrap(vars(journal))
#boxplots
citations_ecology %>%
  ggplot() +
  aes(x = "", y = nbtweets) +
  geom_boxplot() +
  scale_y_log10()
#with colors
citations_ecology %>%
  ggplot() +
  aes(x = "", y = nbtweets) +
  geom_boxplot(fill = "green") +
  scale_y_log10()
#colors with species
citations_ecology %>%
  ggplot() +
  aes(x = journal, y = nbtweets, fill = journal) +
  geom_boxplot() +
  scale_y_log10()
#cleaner
citations_ecology %>%
  ggplot() +
  aes(x = journal, y = nbtweets, fill = journal) +
  geom_boxplot() +
  scale_y_log10() + 
  theme(axis.text.x = element_blank()) +
  labs(x = "")
#user specific color
citations_ecology %>%
  ggplot() +
  aes(x = journal, y = nbtweets, fill = journal) +
  geom_boxplot() +
  scale_y_log10() +
  scale_fill_manual(
    values = c("red", "blue", "purple")) +
  theme(axis.text.x = element_blank()) +
  labs(x = "")
#changed label settings
citations_ecology %>%
  ggplot() +
  aes(x = journal, y = nbtweets, fill = journal) +
  geom_boxplot() +
  scale_y_log10() +
  scale_fill_manual(
    values = c("red", "blue", "purple"),
    name = "Journal name",
    labels = c("Ecology", "J Animal Ecology", "J Applied Ecology")) +
  theme(axis.text.x = element_blank()) +
  labs(x = "")
##barplots
citations %>%
  count(journal) %>%
  ggplot() +
  aes(x = journal, y = n) +
  geom_col()
#flipped
citations %>%
  count(journal) %>%
  ggplot() +
  aes(x = n, y = journal) +
  geom_col()
#reorders
citations %>%
  count(journal) %>%
  ggplot() +
  aes(x = n, y = fct_reorder(journal, n)) +
  geom_col()
#cleaning
citations %>%
  count(journal) %>%
  ggplot() +
  aes(x = n, y = fct_reorder(journal, n)) +
  geom_col() + 
  labs(x = "counts", y = "")
#density plots
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets, fill = journal) +
  geom_density() +
  scale_x_log10()
#transparency
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets, fill = journal) +
  geom_density(alpha = 0.5) +
  scale_x_log10()
#changed theme
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets, fill = journal) +
  geom_density(alpha = 0.5) +
  scale_x_log10() +
  theme_bw()
#changed theme
citations_ecology %>%
  ggplot() +
  aes(x = nbtweets, fill = journal) +
  geom_density(alpha = 0.5) +
  scale_x_log10() +
  theme_classic()



#########################
#Exercise on ggplot
#########################
library(tidyverse)
data(PlantGrowth)
glimpse(PlantGrowth)
#1
PlantGrowth %>%
  group_by(group) %>%
  summarise(
    mean_wt = mean(weight),
    sd_wt   = sd(weight),
    n       = n()
  )

#2
PlantGrowth %>%
  ggplot(aes(x = group, y = weight, fill = group)) +
  geom_boxplot() +
  labs(
    title = "Plant dry weight by treatment group",
    x     = "Treatment group",
    y     = "Weight (g)"
  ) +
  coord_flip()
#3
PlantGrowth %>%
  ggplot(aes(x = group, y = weight, fill = group)) +
  geom_boxplot(alpha = 0.6) +
  geom_jitter(width = 0.2, size = 2) +
  coord_flip() +
  theme_minimal()
#4
PlantGrowth %>%
  ggplot(aes(x = weight)) +
  geom_histogram(bins = 10, fill = "lightgreen", color = "darkgreen") +
  geom_density(aes(y = ..count.., fill = group), alpha = 0.4) +
  labs(x = "Weight (g)", y = "Count / Density")
#5

pg_sum <- PlantGrowth %>%
  group_by(group) %>%
  summarise(
    mean_wt  = mean(weight),
    se_wt    = sd(weight) / sqrt(n())
  )


pg_sum %>%
  ggplot(aes(x = group, y = mean_wt, fill = group)) +
  geom_col(width = 0.6) +
  geom_errorbar(aes(ymin = mean_wt - se_wt, ymax = mean_wt + se_wt),
                width = 0.2) +
  labs(
    title = "Mean plant weight ± SE by treatment",
    x     = "Group",
    y     = "Mean weight (g)"
  ) +
  theme_classic()
