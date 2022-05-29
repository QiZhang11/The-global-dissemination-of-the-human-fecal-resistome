library(psych)
library(pheatmap)
data<-read.csv("C:/Users/plant/Desktop/Competition network.csv", head=T, row.names=1)
occor = corr.test(data,use="pairwise",method="spearman",adjust = "fdr", alpha=0.05)
occor.r = occor$r 
occor.p = occor$p
occor.r[occor.p>0.05, occor.r>0] = 0
write.csv(occor.r,file="competition network.csv")
