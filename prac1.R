install.packages(c("sf", "tmap", "tmaptools", "RSQLite", "tidyverse"), 
                 repos = "https://www.stats.bris.ac.uk/R/")
library(sf)
shape <- st_read("C:/Users/zhewang/CASA/CASA0005/W1/statistical-gis-boundaries-london/ESRI/London_Borough_Excluding_MHW.shp")
summary(shape)
plot(shape)
library(sf)
shape %>% 
  st_geometry() %>%
  plot()
library(tidyverse)
#this needs to be your file path again
mycsv <-  read_csv("C:/Users/zhewang/CASA/CASA0005/W1/fly_tipping_borough_edit.csv")
mycsv
shape2 <- shape%>%
  merge(.,
        mycsv,
        by.x="GSS_CODE", 
        by.y="code")
shape2%>%
  head(., n=10)
library(tmap)
tmap_mode("plot")
# change the fill to your column name if different
shape2 %>%
  qtm(.,fill = "2011-12")
packageVersion("tmap")
install.packages("tmap") 
library(tmap)
packageVersion("tmap")
tmap_mode("plot")
shape2 %>%
  qtm(.,fill = "2011-12")

library(sf)


#导出数据
shape %>%
  st_write(.,
           "C:/Users/zhewang/CASA/CASA0005/W1/Rwk1.gpkg",
           "london_boroughs_fly_tipping",
           delete_layer = TRUE)

library(readr)
library(RSQLite)
install.packages("RSQLite")

con <- dbConnect(
  RSQLite::SQLite(),
  dbname = "C:/Users/zhewang/CASA/CASA0005/W1/Rwk1.gpkg")
 
con %>%
  dbListTables()

con %>%
  dbWriteTable(.,
               "original_csv",
               mycsv,
               overwrite = TRUE)
con %>%
  dbDisconnect()
