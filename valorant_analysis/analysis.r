library(ggplot2)
library(tidyverse)

# Load data
setwd("./data/event_scores")
file_names <- dir()
data <- do.call(rbind, lapply(file_names, read.csv, header = FALSE))

setwd("../event_matchdata")
file_names <- dir()
kda_data <- do.call(rbind, lapply(file_names, read.csv, header = FALSE))

setwd("../event_scores_tagged")
file_names <- dir()
kda_stomps <- do.call(rbind, lapply(file_names, read.csv, header = FALSE))
kda_stomps$stomps <- ifelse(kda_stomps$V1 >= 13, # if bo1
  ifelse(kda_stomps$V1 - kda_stomps$V2 <= 3, FALSE, TRUE), #process a bo1
  ifelse(kda_stomps$V2 == 0, TRUE, FALSE)) # otherwise, process a bo3
kda_data$stomps <- kda_stomps$stomps
kda_data$col <- ifelse(kda_data$stomps == TRUE, "steelblue", "brown2")

# Sanity check just in case there's differences in the data you need to find
#kda_stomps$in_kda_data <- ifelse(kda_data$V1 == kda_stomps$V3, TRUE,
# FALSE)


# Competitive graph in general case
bo3 <- subset(data, V1 < 3)
bo3_stomps <- subset(bo3, V2 == 0)
bo3_close <- subset(bo3, V2 == 1)

stomps_vs_close <- data.frame(type = c("close", "stomps"),
                              number = c(nrow(bo3_close),
                                     c(nrow(bo3_stomps))))
p <- ggplot(data = stomps_vs_close, aes(x = type, y = number)) +
            geom_bar(stat = "identity", fill = "steelblue") + theme_minimal()

p + ggtitle("Competitive vs non-competitive matches") +
  theme(plot.title = element_text(hjust = 0.5))


# Histogram of bo1 win differentials
bo1 <- subset(data, V1 > 3)
bo1$diff <- bo1$V1 - bo1$V2
bo1_dist <- as.data.frame(table(bo1$diff))
bo1_dist <- bo1_dist %>% rename(Difference = Var1)
p <- ggplot(data = bo1_dist, aes(x = Difference, y = Freq)) +
            geom_bar(stat = "identity", fill = "steelblue") + theme_minimal()
p + ggtitle("Distribution of difference in score on match termination") +
  theme(plot.title = element_text(hjust = 0.5))


# Competitive graph in finals case
finals_data <- do.call(rbind, lapply(c("205.csv", "251.csv", "198.csv",
  "66.csv", "40.csv", "274.csv", "40.csv", "256.csv", "280.csv"),
  read.csv, header = FALSE))
finals_stomps <- subset(finals_data, V2 == 0)
finals_close <- subset(finals_data, V2 == 1)
stomps_vs_close <- data.frame(type = c("close", "stomps"),
                              number = c(nrow(finals_close),
                                     c(nrow(finals_stomps))))
p <- ggplot(data = stomps_vs_close, aes(x = type, y = number)) +
            geom_bar(stat = "identity", fill = "steelblue") + theme_minimal()

p + ggtitle("Competitive vs non-competitive matches in finals matches") +
  theme(plot.title = element_text(hjust = 0.5))


# kda analysis
kd_rat_win <- (kda_data$V2 / kda_data$V3)
a_rat_win <- (kda_data$V4 / kda_data$V5)
kda_rat_win <- ((kda_data$V2 + kda_data$V4) / (kda_data$V3 + kda_data$V5))
kd_rat_lose <- (kda_data$V3 / kda_data$V2)
a_rat_lose <- (kda_data$V5 / kda_data$V4)
kda_rat_lose <- ((kda_data$V3 + kda_data$V5) / (kda_data$V2 + kda_data$V4))

boxplot(kd_rat_win, a_rat_win, kda_rat_win, kd_rat_lose,
        a_rat_lose, kda_rat_lose, main = "Distribution of Teams' KDAs",
  xlab = "KDAs", ylab = "Ratios", notch = TRUE,
  col = (c("dodgerblue4", "deepskyblue2", "steelblue",
           "brown4", "brown2", "brown3")),
  names = c("Winning KD", "Winning Assist Ratio", "Winning KDA",
            "Losing KD", "Losing Assist Ratio", "Losing KDA"))


# A/D analysis
ad_rat_win <- (kda_data$V4 / kda_data$V3)
ad_rat_lose <- (kda_data$V5 / kda_data$V2)

boxplot(ad_rat_win, ad_rat_lose, main = "Distribution of Team Coordination",
  xlab = "A/D", ylab = "Ratio", notch = TRUE,
  col = (c("deepskyblue2", "brown2")),
  names = c("Winning Coordination", "Losing Coordination"))


# Does coordination track more with stomps than raw kills?
plot(kda_data$V2, kda_data$V3, main = "Winner KD Plot, Colored with Stomp(blue)/No stomp(red)",
   xlab = "Deaths", ylab = "Kills", pch = 19, col=kda_data$col)


plot(kda_data$V4, kda_data$V3, main = "Winner Coordination Plot, Colored with Stomp(blue)/No stomp(red)",
   xlab = "Deaths", ylab = "Assists", pch = 19, col=kda_data$col)
abline(h = 175, col="purple")

plot(kda_data$V5, kda_data$V2, main = "Loser Coordination Plot, Colored with Stomp(blue)/No stomp(red)",
   xlab = "Deaths", ylab = "Assists", pch = 19, col=kda_data$col)
segments(10, 83, 50, 83, col="purple")
segments(45, 180, 200, 285, col="purple")