library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)
df <- read_rds("Formatted_Data.rds")


df_sum <- df |> 
  group_by(protein,assay) |> 
  summarise(mean_slope=mean(slope),s_e = sd(slope)/sqrt(n()), .groups="drop")

df_sum2 <- df |> 
  group_by(assay,protein) |> 
  summarise(mean_slope2=mean(slope),s_e2 = sd(slope)/sqrt(n()), .groups="drop")

print(ggplot(df_sum)
  + aes(protein,mean_slope)
  + geom_pointrange(aes(ymin=mean_slope-(2*s_e), ymax=mean_slope+(2*s_e)))
  + facet_grid(assay~.)
)
print(ggplot(df_sum2)
      + aes(assay,mean_slope2)
      + geom_pointrange(aes(ymin=mean_slope2-(2*s_e2), ymax=mean_slope2+(2*s_e2)))
      + facet_grid(protein~.)
)
