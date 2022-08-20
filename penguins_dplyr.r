library('tidyverse')
penguins <- read_csv('penguins_lter.csv')

#[ Check out our data ]
glimpse(penguins)
head(penguins)
summary(penguins)
names(penguins)

#[ Exploring our data with dplyr ]
penguins %>% filter(Island=='Torgersen') %>% head()
penguins %>% arrange('Flipper Length') %>% head(10)

#[ Creating a subset ]
# creating a random subset of the penguins dataset
set.seed(406)
penguins_subset <- penguins %>% sample_n(12)
penguins_subset %>% arrange(Species)

#[ Nesting desc() inside arrange() ]
penguins_subset %>% arrange(desc('Culmen Length (mm)'))

#[ Fun with filter() ]
penguins_subset %>%
  filter("Culmen Length (mm)" > 50)
penguins_subset %>%
  filter(Island == "Dream")
penguins_subset %>%
  filter(between("Culmen Depth (mm)", 16.2, 18.1 ))

#[ Starting with select() ]
penguins_subset %>% select(Island,"Culmen Depth (mm)")
penguins_subset %>% select(where(is.character))
penguins_subset %>% select(where(is.numeric))
penguins_subset %>% select(!where(is.numeric))

#[ Math with mutate() ]
penguins_subset <-penguins_subset %>% rename("Body_Mass_g"="Body Mass (g)")
penguins_subset %>%
  mutate(Body_Mass_pound = Body_Mass_g / 453.59237) %>%
  select(Species, Body_Mass_g, Body_Mass_pound, everything())

#[ Summaries with summarise(), with help from group_by() ]
penguins_subset %>% summarise(avg_body_mass = mean(Body_Mass_g))

#The NAs!
penguins <- penguins %>% rename(Body_Mass_g ="Body Mass (g)")
penguins %>% summarise (avg_body_mass = mean(Body_Mass_g))
penguins %>% summarise (avg_body_mass = mean(Body_Mass_g,na.rm =TRUE))

penguins %>% group_by(Species) %>% 
  summarise(avg_body_mass = mean(Body_Mass_g,na.rm=TRUE))
                       
penguins %>% group_by(Species,Island) %>% 
  summarise(avg_body_mass = mean(Body_Mass_g,na.rm=TRUE))
