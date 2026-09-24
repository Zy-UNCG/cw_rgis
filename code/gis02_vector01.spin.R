#vector 1
if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               sf,
               mapview)

rm(list = ls())

## how to read vector data
sf_nc_county <- st_read(dsn = "data/nc.shp",
        quiet = TRUE)

## how to export shape files
st_write(sf_nc_county,
         dsn = "data/sf_nc_county.shp",
         append = FALSE)

## RDS format
saveRDS(sf_nc_county,
        file = "data/sf_nc_county.rds")

sf_nc_county <- readRDS(file = "data/sf_nc_county.rds")


#  point ------------------------------------------------------------------

sf_site <- readRDS("data/sf_finsync_nc.rds")

mapview(
sf_site,
        col.regions = "black",# point's fill color
        legend = FALSE
)


# select the first 10 sistes ----------------------------------------------


sf_site_f10 <- sf_site %>%
  slice(1:10)

mapview(
  sf_site_f10,
  col.regions = "blue",
  legend = FALSE
)


# line --------------------------------------------------------------------

sf_str <- readRDS("data/sf_stream_gi.rds")
  
mapview(
  sf_str,
  col.regions = "purple",
  legend = FALSE
)


# polygon -----------------------------------------------------------------

sf_nc_county <- readRDS("data/sf_nc_county.rds")

mapview(
  sf_nc_county,
  col.regions = "grey",
  legend = FALSE
)

# select "guilford county, then map  --------------------------------------

sf_nc_gi <- sf_nc_county %>% 
  filter(county == "guilford")

mapview(
  sf_nc_gi,
  col.regions = "grey",
  legend = FALSE
)


# static map in ggplot format ---------------------------------------------

ggplot() +
  geom_sf(data = sf_nc_county)

ggplot() +
  geom_sf(data = sf_nc_county) +
  geom_sf(data = sf_str)


# exercise ----------------------------------------------------------------

sf_str_as <- readRDS(file = "data/sf_stream_as.rds")
print(sf_str_as)
print(sf_nc_county)

ggplot() +
  geom_sf(data = sf_nc_county) + geom_sf(data =sf_str_as)

sf_nc_as <- sf_nc_county %>% 
  filter(county == "ashe")
ggplot()
geom_(data = sf_nc_as) +
  geom_sf(data = sf_str_as)
