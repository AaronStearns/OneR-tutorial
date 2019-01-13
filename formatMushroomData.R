library(dplyr)
library(rjson)

mushrooms <- read.csv("http://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data", stringsAsFactors = TRUE)

colnames(mushrooms) <- c("poisonous", "cap_shape", "cap_surface", "cap_color", "bruises", "odor", "gill_attachment", "gill_spacing", "gill_size", "gill_color", "stalk_shape", "stalk_root", "stalk_surface_above_ring", "stalk_surface_below_ring", "stalk_color_above_ring", "stalk_color_below_ring", "veil_type", "veil_color", "ring_number", "ring_type", "spore_print_color", "population", "habitat")

mushrooms$id <- 1:nrow(mushrooms)

# Mushroom dataset uses single-character factor variables in dataframe
# Changing to full word representations of variable factor levels
mushrooms <- mushrooms %>%
  mutate(poisonous = recode(poisonous, e = "edible", p = "poisonous")) %>%
  mutate(stalk_root = recode(stalk_root, b = "bulbous", c = "club", u = "cup", e = "equal", z = "rhizomorphs", r = "rooted", "?" = "missing")) %>% 
  mutate(cap_shape = recode(cap_shape, b = "bell", c = "conical", x = "convex", f = "flat", k = "knobbed", s = "sunken")) %>% 
  mutate(cap_surface = recode(cap_surface, f = "fibrous", g = "grooves", y = "scaly", s = "smooth")) %>% 
  mutate(cap_color = recode(cap_color, n = "brown", b = "buff", c = "cinnamon", g = "gray", r = "green", p = "pink", u = "purple", e = "red", w = "white", y = "yellow")) %>% 
  mutate(bruises = recode(bruises, t = "bruises", f = "no")) %>% 
  mutate(odor = recode(odor, a = "almond", l = "anise", c = "creosote", y = "fishy", f = "foul", m = "musty", n = "none", p = "pungent", s = "spicy")) %>% 
  mutate(gill_attachment = recode(gill_attachment, a = "attached", d = "descending", f = "free", n = "notched")) %>% 
  mutate(gill_spacing = recode(gill_spacing, c = "close", w = "crowded", d = "distant")) %>% 
  mutate(gill_size = recode(gill_size, b = "broad", n = "narrow")) %>% 
  mutate(gill_color = recode(gill_color, k = "black", n = "brown", b = "buff", h = "chocolate", g = "gray", r = "green", o = "orange", p = "pink", u = "purple", r = "red", w = "white", y = "yellow")) %>%
  mutate(stalk_shape = recode(stalk_shape, e = "enlarging", t = "tapering")) %>% 
  mutate(stalk_root = recode(stalk_root, b = "bulbous", c = "club", u = "cup", e = "equal", z = "rhizomorphs", r = "rooted", "?" = "missing")) %>% 
  mutate(stalk_surface_above_ring = recode(stalk_surface_above_ring, f = "fibrous", y = "scaly", k = "silky", s = "smooth")) %>% 
  mutate(stalk_surface_below_ring = recode(stalk_surface_below_ring, f = "fibrous", y = "scaly", k = "silky", s = "smooth")) %>% 
  mutate(stalk_color_above_ring = recode(stalk_color_above_ring, n = "brown", b = "buff", c= "cinnamon", g = "gray", o = "orange", p = "pink", e = "red", w = "white", y = "yellow")) %>% 
  mutate(stalk_color_below_ring = recode(stalk_color_below_ring, n = "brown", b = "buff", c= "cinnamon", g = "gray", o = "orange", p = "pink", e = "red", w = "white", y = "yellow")) %>% 
  mutate(veil_type = recode(veil_type, p = "partial", u = "universal")) %>% 
  mutate(veil_color = recode(veil_color, n = "brown", o = "orange", w = "white", y = "yellow")) %>% 
  mutate(ring_number = recode(ring_number, n = "none", o = "one", t = "two")) %>% 
  mutate(ring_type = recode(ring_type, c = "cobwebby", e = "evanescent", f = "flaring", l = "large", n = "none", p = "pendant", s = "sheathing", z = "zone")) %>% 
  mutate(spore_print_color = recode(spore_print_color, k = "black", n = "brown", b = "buff", h = "chocolate", r = "green", o = "orange", u = "purple", w = "white", y = "yellow")) %>% 
  mutate(population = recode(population, a = "abundant", c = "clustered", n = "numerous", s = "scattered", v = "several", y = "solitary")) %>% 
  mutate(habitat = recode(habitat, g = "grasses", l = "leaves", m = "meadows", p = "paths", u = "urban", w = "waste", d = "woods"))

write.csv(mushrooms, file = "mushroom_data.csv", row.names = FALSE)
