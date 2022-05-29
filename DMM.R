library(BiocManager)
#BiocManager::install("microbiome")
library(devtools)
library(DirichletMultinomial)
#BiocManager::install("DirichletMultinomial")
library(microbiome)
library(reshape2)
library(magrittr)
library(dplyr)

wd<- "C:/Users/plant/Desktop"
setwd(wd)

count=read.table("Coretaxa-genus.txt", head=T, row.names=1)
count <- as.matrix(count)
fit <- lapply(1:50, dmn, count = count, verbose=TRUE)

lplc <- sapply(fit, laplace) # AIC / BIC / Laplace
aic  <- sapply(fit, AIC) # AIC / BIC / Laplace
bic  <- sapply(fit, BIC) # AIC / BIC / Laplace
plot(lplc, type="b", xlab="Number of Dirichlet Components", ylab="Model Fit")
lines(aic, type="b", lty = 2)
lines(bic, type="b", lty = 3)

best <- fit[[which.min(unlist(lplc))]]
mixturewt(best)

ass <- apply(mixture(best), 1, which.max)
dev.off
dev.new

for (k in seq(ncol(fitted(best)))) {
  d <- melt(fitted(best))
  colnames(d) <- c("OTU", "cluster", "value")
  d <- subset(d, cluster == k) %>%
    # Arrange OTUs by assignment strength
    arrange(value) %>%
    mutate(OTU = factor(OTU, levels = unique(OTU))) %>%
    # Only show the most important drivers
    filter(abs(value) > quantile(abs(value), 0.8))     
  
  p <- ggplot(d, aes(x = OTU, y = value)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    labs(title = paste("Top drivers: community type", k))
  print(p)
}
write.csv(best@fit[["Estimate"]],file="Laplace approximation.csv")
write.csv(ass,file="Classfications.csv")
write.csv(best@group,file="Contributions.csv")
