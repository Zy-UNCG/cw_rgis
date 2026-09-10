##install.packages("tidyverse")
library(tidyverse)

# Point figure ------------------------------------------------------------


iris %>% 
  ggplot(
     aes(x =Sepal.Length,
           y = Sepal.Width)
  ) +
  geom_point()

iris %>% 
  ggplot(
    aes(x = Sepal.Length,
        y = Sepal.Width,
        color = Species)
  ) +
geom_point()

iris %>% 
  ggplot(
    aes(x = Sepal.Length,
        y = Sepal.Width)
    ) +
        geom_point(color = "red")

# Line figure -------------------------------------------------------------
df_x <- tibble(x =1.50,
               y = 2 * x)




df_x %>% 
  ggplot(
    aes(x = x,
       y = y)
  )+
  geom_line()

# histogram ---------------------------------------------------------------

iris %>% 
  ggplot(
    aes(x = Sepal.Length)
  )+
  geom_histogram()
  

# boxplot -----------------------------------------------------------------

iris %>% 
  ggplot(
    aes(x = Species,
        y = Sepal.Length)
    ) +
        geom_boxplot()
  
    

# ## change color (border) ------------------------------------------------

iris %>% 
  ggplot(
    aes(x = Species,
         y = Sepal.Length,
         fill = Species)
  ) + 
  geom_boxplot()
  

# ## change inside box ----------------------------------------------------

iris %>% 
  ggplot(
    aes(x = Species,
        y = Sepal.Length,
        fill = Species)
    ) +
      geom_boxplot()

-

# Exercise ----------------------------------------------------------------
# Q1 Using iris date, identify the longest sepal.length using arrange () function

iris %>% 
  arrange(desc(Sepal.Length))

# Q2 using iris data, filter/select individuals with sepal.width greater then 3.0
# - use filter ()
iris %>%
  filter(Sepal.Width> 3.0)

# Q3 using iris data, select the columns"petal.Length" and petal width",and then arrange order of rows by petal.Length"
#ssign the result to object "de_petal"

iris %>% 
  select(Petal.Length, Petal.Width)%>% 
  arrange(desc(Petal.Length))

#q4 Calculate mean Sepal.width by Species; assign the results to df_mean"
#int group_by() and summarize()

df_mean <- iris %>% 
  group_by(Species) %>% 
  summarise(mean = mean(Sepal.Width))

#q5 Create a point figure of Petal.width (y-axis) and Sepal.width (x-axis) with colors distiguishing species

 iris %>% 
   ggplot(aes(x = Sepal.Width,
              y = Petal.Length,
              color = Species)
   ) +
   geom_point()
