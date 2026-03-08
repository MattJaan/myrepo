library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)
library(emmeans)
library(effects)

slopes <- read_rds("Formatted_Data.rds")

slopes$assay<-as.character(slopes$assay) 

#Sort the factors to better order
slopes$assay <- factor(slopes$assay, levels = c("negative", "No protein", "Reductase","NADPH","positive"))

## JD: What am I seeing here? There is no explanation of the models or the questions here or in the README.

lm_all<- lm(slope~assay*protein,data=slopes)

plot(emmeans(lm_all, ~ assay*protein),comparison=TRUE)

newdata <- expand.grid(assay = levels(slopes$assay),protein = levels(slopes$protein))

datapred <- predict(lm_all, newdata, se.fit = TRUE)
newdata$fit <- datapred$fit
newdata$se <- datapred$se.fit
newdata$lower <- newdata$fit - 1.96 * newdata$se
newdata$upper <- newdata$fit + 1.96 * newdata$se

ggplot() +
  geom_point(data = slopes, aes(x=assay, y=slope, color = protein),
             position = position_jitter(width = 0.1),
             alpha = 0.6) +
  
  geom_line(data = newdata, aes(x=assay, y=fit, color = protein, group = protein)) +
  
  geom_ribbon(data = newdata,
              aes(assay, ymin = lower, ymax = upper, fill = protein, group = protein),
              alpha = 0.2) 
  
plot(lm_all)
