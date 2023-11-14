# Load Libraries
library(reshape2)
library(dplyr)
library(ggalluvial)
library(magrittr)
library(tidyr)

# Simple alluvial plot
afdata<- read.csv(file = "alluvial_data.csv")
# Alluvial plot of ethnobotany uses and species
source(file = "functions/agroforestry_alluvial.R")
agroforestry_alluvial(afdata)


