# https://www.kaggle.com/code/jessemostipak/dive-into-dplyr-tutorial-1/notebook
library('tidyverse')
penguins <- read_csv('penguins_lter.csv')

#Check out our data 
glimpse(penguins)
head(penguins)
summary(penguins)
names(penguins)

#Renames columns 
names(penguins) <- gsub("[[:punct:]]", " ", names(penguins))
names(penguins) <- gsub("\\s\\s", "_", names(penguins))
names(penguins) <- gsub("\\s", "_", names(penguins))
names(penguins) <- gsub("[[:punct:]]$", "", names(penguins))


#Exploring our data with dplyr 
penguins %>% filter(Island=='Torgersen') %>% head()
penguins %>% arrange(Flipper_Length_mm) %>% head(10)

#Creating a subset 
# creating a random subset of the penguins dataset
set.seed(406)
penguins_subset <- penguins %>% sample_n(12)
penguins_subset %>% arrange(Species)

#Nesting desc() inside arrange() 
penguins_subset %>% arrange(desc(Culmen_Length_mm))

#Fun with filter() 
penguins_subset %>%
  filter(Culmen_Length_mm > 50)
penguins_subset %>%
  filter(Island == "Dream")
penguins_subset %>%
  filter(between(Culmen_Length_mm, 16.2, 18.1 ))

#[ Starting with select() ]
penguins_subset %>% select(Island,Culmen_Length_mm)
penguins_subset %>% select(where(is.character))
penguins_subset %>% select(where(is.numeric))
penguins_subset %>% select(!where(is.numeric))

#Math with mutate() 

penguins_subset %>%
  mutate(Body_Mass_pound = Body_Mass_g / 453.59237) %>%
  select(Species, Body_Mass_g, Body_Mass_pound, everything())

#Summaries with summarise(), with help from group_by() 
penguins_subset %>% summarise(avg_body_mass = mean(Body_Mass_g))

#The NAs!
penguins %>% summarise (avg_body_mass = mean(Body_Mass_g))
penguins %>% summarise (avg_body_mass = mean(Body_Mass_g,na.rm =TRUE))

penguins %>% group_by(Species) %>% 
  summarise(avg_body_mass = mean(Body_Mass_g,na.rm=TRUE))
                       
penguins %>% group_by(Species,Island) %>% 
  summarise(avg_body_mass = mean(Body_Mass_g,na.rm=TRUE))


