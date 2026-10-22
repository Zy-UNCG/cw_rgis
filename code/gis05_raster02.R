if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               terra,
               tidyterra,
               mapview,
               stars)

# erase existing objects --------------------------------------------------
rm(list = ls())

# precipitation example ---------------------------------------------------

(spr_prec <- rast("data/spr_prec_us.tif"))
ext(spr_prec)

ggplot() +
  geom_spatraster(data = spr_prec)

spr_prec_crop <- crop(x = spr_prec,
                      y = c(-80, -75, 34,37))

# a map of croppedd data --------------------------------------------------
ggplot() +
  geom_spatraster(data = spr_prec_crop)

# get county polygon data -------------------------------------------------
sf_nc_county <- readRDS('data/sf_nc_county.rds')

ggplot() +
  geom_spatraster(data = spr_prec_crop) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

# use polygon layer to crop raster ----------------------------------------
spr_prec_nc <- crop(x = spr_prec,
                    y = sf_nc_county)

# map spr_prec-nc with sf_nc_county ---------------------------------------
ggplot() +
  geom_spatraster(data = spr_prec_nc) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

# merge -------------------------------------------------------------------
spr_nw <- rast("data/spr_prec_ncnw.tif")
spr_ne <- rast("data/spr_prec_ncne.tif")
spr_sw <- rast("data/spr_prec_ncsw.tif")
spr_se <- rast("data/spr_prec_ncse.tif")

# north west portion of NC ------------------------------------------------
ggplot() +
  geom_spatraster(data = spr_nw)
geom_sf(data = sf_nc_county,
        alpha = 0.25)

# south west portion of NC ------------------------------------------------
ggplot() +
  geom_spatraster(data = spr_sw) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

# merge more than two panels into one -------------------------------------
list_spr <- list(spr_ne,
                 spr_nw,
                 spr_se,
                 spr_sw)

# convert from lost to spatraster collection ------------------------------
spr_col <- sprc(list_spr)

# merge more than two panels ----------------------------------------------
spr_merge <- merge(spr_col)

# map spr_merge and sf_nc_county ------------------------------------------
ggplot() +
  geom_spatraster(data = spr_merge) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25,
          fill = "tomato")

writeRaster(spr_merge,
            "data/spr_prec_nc.tif",
            overwrite = TRUE)


# stack -------------------------------------------------------------------
spr_prec_nc <- rast("data/spr_prec_nc.tif")
spr_tmp_nc <- rast("data/spr_tmp_nc.tif")

ggplot() +
  geom_spatraster(data = spr_tmp_nc) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

spr_pt_nc <- c(spr_prec_nc,
               spr_tmp_nc)

# create a muti-layer raster ("stack") ------------------------------------
spr_pt_nc <- c(spr_prec_nc,
               spr_tmp_nc)

# access one layer ---------------------------------------------------------

# precipitation -----------------------------------------------------------
spr_pt_nc$precipitation

# temperature -------------------------------------------------------------
spr_pt_nc$temperature

# try to stack "spr_ne" and "spr_tmp_nc" ----------------------------------
# c(spr_ne, spr_tmp_nc)
# this would not work because of spatial extent mismatch ------------------


# reprojection ------------------------------------------------------------
# reprojection - tranfrom CRS from one to another --------------------------
# most cases, from geodetic to project CRS --------------------------------

spr_prec_nc_proj <- project(x = spr_prec_nc,
        y= "EPSG:32617")


# exercise ----------------------------------------------------------------
spr_tmp_nw <- rast("data/spr_tmp_ncnw.tif")
spr_tmp_ne <- rast("data/spr_tmp_ncne.tif")
spr_tmp_sw <- rast("data/spr_tmp_ncsw.tif")
spr_tmp_se <- rast("data/spr_tmp_ncse.tif")

list_tmp <- list(
  spr_tmp_nw,
  spr_tmp_ne,
  spr_tmp_sw,
  spr_tmp_se
)

tmp_sprc <- sprc(list_tmp)
spr_temp <- merge(tmp_sprc)

ggplot() +
  geom_spatraster(data = spr_temp) +
  geom_sf(data = sf_nc_county,
          fill = "green",
          alpha = 0.25)

sf_camden <- sf_nc_county %>% 
  filter(county == "camden")
ext(sf_camden)

spr_tmp_camden <- crop(x = spr_merge,
                       y = sf_camden)

ggplot() +
  geom_spatraster(data = spr_tmp_camden) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

spr_tmp_camden_proj <- project(x =spr_tmp_camden,
        y = "EPSG:32618",
        method = "bilinear")



  
