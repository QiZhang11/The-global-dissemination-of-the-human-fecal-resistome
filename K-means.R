library(infotheo)
nbins <- 3
data <- read.delim('risk-Meta.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,na.strings="na")
k_means <- kmeans(data$risk, nbins)
table(k_means$cluster)
k_means$cluster
k=data.frame(rank=k_means$cluster,sample=rownames(data),risk=data$risk)
write.csv(as.matrix(k),'k.csv')
