library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)

## BMB: df masks a built-in R function (usually harmless, but
## occasionally causes confusing errors) -- suboptimal variable name
df <- read_rds("Formatted_Data.rds")


## BMB: why not use .by for this?
df_sum <- df |> 
  group_by(protein,assay) |> 
  summarise(mean_slope=mean(slope),s_e = sd(slope)/sqrt(n()), .groups="drop")

## BMB: isn't this the same computation with the observations in a different order?
df_sum2 <- df |> 
  group_by(assay,protein) |> 
  summarise(mean_slope2=mean(slope),s_e2 = sd(slope)/sqrt(n()), .groups="drop")

## showing that these two objects are basically the same ...
df_tmp <- (df_sum2
  |> arrange(protein, assay)
  |> relocate(protein, .before = assay)
  |> rename(mean_slope = "mean_slope2", s_e = "s_e2")
)
identical(df_sum, df_tmp)

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

## mark: 2
