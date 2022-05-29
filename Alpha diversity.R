library(vegan)

wd<- "C:/Users/plant/Desktop"
setwd(wd)

otu <- read.delim('microbiome/resistome.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE)
otu <- t(otu)
#Chao1
Chao1  <- estimateR(otu)[2, ]
Chao1
write.csv(Chao1,file="microbiome/resistomeChao1.csv") 

#Shannon index
Shannon <- diversity(otu, index = 'shannon', base = 2)
Shannon
write.csv(Shannon,file="microbiome/resistomeShannon.csv")

#Gini-Simpson
Gini_simpson  <- diversity(otu, index = 'simpson')
Gini_simpson
write.csv(Gini_simpson,file="microbiome/resistomeGini_simpson.csv")
