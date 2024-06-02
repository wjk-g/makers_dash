library(tidverse)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load pracownie.xlsx
clusters <- readxl::read_xlsx("clust.xlsx") %>%
  filter(!is.na(coord.Dim.1))

head(clusters)

normalize_array <- function(array) {
  min_value <- min(array)
  print(min_value)
  max_value <- max(array)
  print(max_value)
  normalised_array <- map_dbl(array, function(x) {(x - min_value) / (max_value - min_value)})
  return(normalised_array)
}

clusters$coord.Dim.1 <- normalize_array(clusters$coord.Dim.1)
clusters$coord.Dim.2 <- normalize_array(clusters$coord.Dim.2)
clusters$coord.Dim.3 <- normalize_array(clusters$coord.Dim.3)

write_csv(clusters, "clusters.csv")
