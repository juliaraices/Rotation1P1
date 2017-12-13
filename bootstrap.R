# Julia Raices
# NovembBer 2017
# names:
##  F = female | M = male
##  er = early | Blt = late
##  1 or 2 = replicate number
##  slk = sex-determination linked
##  nslk = not-sex-determination linked
## B = B. jarvisi | D = D. melanogaster
library(affy)
library(ggplot2)

BltF1 <- read.table("abundance_SRR1571147.tsv", header=T, sep = "\t", quote = "")
BltF2 <- read.table("abundance_SRR1571155.tsv", header=T, sep = "\t", quote = "")
BerF1 <- read.table("abundance_SRR1571160.tsv", header=T, sep = "\t", quote = "")
BerF2 <- read.table("abundance_SRR1571161.tsv", header=T, sep = "\t", quote = "")

D14dF <- read.table("abundance_SRR072915.tsv", header=T, sep = "\t", quote = "")
D14aF <- read.table("abundance_SRR072909.tsv", header=T, sep = "\t", quote = "")
D12F <- read.table("abundance_SRR072907.tsv", header=T, sep = "\t", quote = "")

BltF1$length <- NULL
BltF1$eff_length <- NULL
BltF1$est_counts <- NULL
BltF2$length <- NULL
BltF2$eff_length <- NULL
BltF2$est_counts <- NULL
BerF1$length <- NULL
BerF1$eff_length <- NULL
BerF1$est_counts <- NULL
BerF2$length <- NULL
BerF2$eff_length <- NULL
BerF2$est_counts <- NULL
D14dF$length <- NULL
D14dF$eff_length <- NULL
D14dF$est_counts <- NULL
D14aF$length <- NULL
D14aF$eff_length <- NULL
D14aF$est_counts <- NULL
D12F$length <- NULL
D12F$eff_length <- NULL
D12F$est_counts <- NULL



colnames(BltF1) <-c("target_id", "tpm_BltF1")
colnames(BltF2) <-c("target_id", "tpm_BltF2")
colnames(BerF1) <-c("target_id", "tpm_BerF1")
colnames(BerF2) <-c("target_id", "tpm_BerF2")

colnames(D14dF) <-c("target_id", "tpm_D14dF")
colnames(D14aF) <-c("target_id", "tpm_D14aF")
colnames(D12F) <-c("target_id", "tpm_D12F")

temp <- merge(BltF1, BltF2, by='target_id')
temp2 <- merge(temp, BerF1, by='target_id')
temp <- merge(temp2, BerF2, by='target_id')
temp2 <- merge(temp, D14dF, by='target_id')
temp <- merge(temp2, D14aF, by='target_id')
BDall <- merge(temp, D12F, by='target_id')


## comparisons: BerF1 - D12F | BerF2 - D14aF | BltF1 - D14aF | BltF2 - D14dF
#make a new table with columns to be normalized (you can't have 0s, so we add a tiny number to them) - lowest non-zero number is 54.882, so adding 0.000001 should not influence it a lot
BD_normalized<-c(BDall$tpm_BerF1+0.000001, BDall$tpm_BerF2+0.000001, BDall$tpm_BltF1+0.000001, BDall$tpm_BltF2+0.000001, BDall$tpm_D12F+0.000001, BDall$tpm_D14aF+0.000001, BDall$tpm_D14dF+0.000001)
time1<-c(BDall$tpm_BerF1+0.000001, BDall$tpm_D12F+0.000001)
time2<-c(BDall$tpm_BerF2+0.000001, BDall$tpm_D14aF+0.000001)
time3<-c(BDall$tpm_BltF1+0.000001, BDall$tpm_D14aF+0.000001)
time4<-c(BDall$tpm_BltF2+0.000001, BDall$tpm_D14dF+0.000001)
#bolF<-c(lott$e10+0.000001, lott$e11+0.000001, lott$e12+0.000001, lott$e13+0.000001, lott$e14a+0.000001, lott$e14b+0.000001, lott$e14c+0.000001, lott$e14d+0.000001)
BDNormMatrix<-matrix(BD_normalized, nrow(BDall), 7)
NormMatrix1<-matrix(time1, nrow(BDall), 2)
NormMatrix2<-matrix(time2, nrow(BDall), 2)
NormMatrix3<-matrix(time3, nrow(BDall), 2)
NormMatrix4<-matrix(time4, nrow(BDall), 2)
#bolFMat<-matrix(bolF, nrow(lott), 8)

############WARNING: change "8" to however many columns you have selected!!! And "lott" is the table that contained the values that I was normalizing, use your own table name

#normalize
x <- normalize.loess(BDNormMatrix)
y1 <- normalize.loess(NormMatrix1)
y2 <- normalize.loess(NormMatrix2)
y3 <- normalize.loess(NormMatrix3)
y4 <- normalize.loess(NormMatrix4)
#x<-normalize.loess(bolFMat)
newBD <- as.data.frame(x)
new1 <- as.data.frame(y1)
new2 <- as.data.frame(y2)
new3 <- as.data.frame(y3)
new4 <- as.data.frame(y4)
#newDataFrame <- as.data.frame(x)
## comparisons: BerF1 - D12F | BerF2 - D14aF | BltF1 - D14aF | BltF2 - D14dF
BDall$tpmN_BerF1 <- (newBD$V1)
BDall$tpmN_BerF2 <- (newBD$V2)
BDall$tpmN_BltF1 <- (newBD$V3)
BDall$tpmN_BltF2 <- (newBD$V4)
BDall$tpmN_D12F <- (newBD$V5)
BDall$tpmN_D14aF <- (newBD$V6)
BDall$tpmN_D14dF <- (newBD$V7)

BDall$tpmN1_BerF1 <- (new1$V1)
BDall$tpmN1_D12F <- (new1$V2)
BDall$tpmN2_BerF2 <- (new2$V1)
BDall$tpmN2_D14aF <- (new2$V2)
BDall$tpmN3_BltF1 <- (new3$V1)
BDall$tpmN3_D14aF <- (new3$V2)
BDall$tpmN4_BltF2 <- (new4$V1)
BDall$tpmN4_D14dF <- (new4$V2)

# lott$e10 <- (newDataFrame$V1)
# lott$e11 <- (newDataFrame$V2)
# lott$e12 <- (newDataFrame$V3)
# lott$e13 <- (newDataFrame$V4)
# lott$e14a <- (newDataFrame$V5)
# lott$e14b <- (newDataFrame$V6)
# lott$e14c <- (newDataFrame$V7)
# lott$e14d <- (newDataFrame$V8)

BDall_nslk <- subset(BDall, BDall$target_id!='sc' & BDall$target_id!='run' & BDall$target_id!='gro' & BDall$target_id!='dpn' & BDall$target_id!='emc' & BDall$target_id!='da' & BDall$target_id!='sisA' & BDall$target_id!='her' & BDall$target_id!='tra' & BDall$target_id!='upd3' & BDall$target_id!='Sxl' & BDall$target_id!='CG1641' & BDall$target_id!='CG1849' & BDall$target_id!='CG33542' & BDall$target_id!='CG3827' & BDall$target_id!='CG43770' & BDall$target_id!='CG8384' & BDall$target_id!='CG5102' & BDall$target_id!='CG4694' & BDall$target_id!='CG8704' & BDall$target_id!='CG16724' & BDall$target_id!='CG1007' & BDall$target_id!='SxlA' & BDall$target_id!='SxlB' & BDall$target_id!='SxlC')
BDall_slk <- subset(BDall, BDall$target_id=='sc' | BDall$target_id=='run' | BDall$target_id=='gro' | BDall$target_id=='dpn' | BDall$target_id=='emc' | BDall$target_id=='da' | BDall$target_id=='sisA' | BDall$target_id=='her' | BDall$target_id=='tra' | BDall$target_id=='upd3' | BDall$target_id=='Sxl' | BDall$target_id=='CG1641' | BDall$target_id=='CG1849' | BDall$target_id=='CG33542' | BDall$target_id=='CG3827' | BDall$target_id=='CG43770' | BDall$target_id=='CG8384' | BDall$target_id=='CG5102' | BDall$target_id=='CG4694' | BDall$target_id=='CG8704' | BDall$target_id=='CG16724' | BDall$target_id=='CG1007' | BDall$target_id=='SxlA' | BDall$target_id=='SxlB' | BDall$target_id=='SxlC')


par(mfrow=c(1,1))
## comparisons: BerF1 - D12F | BerF2 - D14aF | BltF1 - D14aF | BltF2 - D14dF

bootstrap <- function(set1, set2, repetitions=1000, stats=median){
  n <- length(set1)
  sett2 <- log10(set2)
  sett1 <- log10(set1)
  vec <- vector()
  for(i in 1:repetitions){
    s <- sample(sett2, n)
    vec[i]<-stats(s)
  }
  b <- quantile(vec, probs = c(0.025, 0.975))
  dens <- density(vec)
  dd <- with(dens, data.frame(x,y))
  a <- qplot(x,y,data=dd,geom="line", color=I("cornflowerblue")) + geom_ribbon(data=subset(dd,x>b[[1]] & x<b[[2]]),aes(ymax=y),ymin=0, fill="lightskyblue",colour=NA,alpha=0.5) + geom_vline(xintercept = stats(sett1), color="orchid",size=1)
  return(a)
}

#abnormal, rs
berf1 <- bootstrap(BDall_slk$tpm_BerF1, BDall_nslk$tpm_BerF1)
berf2 <- bootstrap(BDall_slk$tpm_BerF2, BDall_nslk$tpm_BerF2)
bltf1 <- bootstrap(BDall_slk$tpm_BltF1, BDall_nslk$tpm_BltF1)
bltf2 <- bootstrap(BDall_slk$tpm_BltF2, BDall_nslk$tpm_BltF2)

d12f <- bootstrap(BDall_slk$tpm_D12F, BDall_nslk$tpm_D12F)
d14af <- bootstrap(BDall_slk$tpm_D14aF, BDall_nslk$tpm_D14aF)
d14df <- bootstrap(BDall_slk$tpm_D14dF, BDall_nslk$tpm_D14dF)

#normalized 7
berf1N <- bootstrap(BDall_slk$tpmN_BerF1, BDall_nslk$tpmN_BerF1)
berf2N <- bootstrap(BDall_slk$tpmN_BerF2, BDall_nslk$tpmN_BerF2)
bltf1N <- bootstrap(BDall_slk$tpmN_BltF1, BDall_nslk$tpmN_BltF1)
bltf2N <- bootstrap(BDall_slk$tpmN_BltF2, BDall_nslk$tpmN_BltF2)

d12fN <- bootstrap(BDall_slk$tpmN_D12F, BDall_nslk$tpmN_D12F)
d14afN <- bootstrap(BDall_slk$tpmN_D14aF, BDall_nslk$tpmN_D14aF)
d14dfN <- bootstrap(BDall_slk$tpmN_D14dF, BDall_nslk$tpmN_D14dF)

#normalized 2
berf1N1 <- bootstrap(BDall_slk$tpmN1_BerF1, BDall_nslk$tpmN1_BerF1)
berf2N2 <- bootstrap(BDall_slk$tpmN2_BerF2, BDall_nslk$tpmN2_BerF2)
bltf1N3 <- bootstrap(BDall_slk$tpmN3_BltF1, BDall_nslk$tpmN3_BltF1)
bltf2N4 <- bootstrap(BDall_slk$tpmN4_BltF2, BDall_nslk$tpmN4_BltF2)

d12fN1 <- bootstrap(BDall_slk$tpmN1_D12F, BDall_nslk$tpmN1_D12F)
d14afN2 <- bootstrap(BDall_slk$tpmN2_D14aF, BDall_nslk$tpmN2_D14aF)
d14afN3 <- bootstrap(BDall_slk$tpmN3_D14aF, BDall_nslk$tpmN3_D14aF)
d14dfN4 <- bootstrap(BDall_slk$tpmN4_D14dF, BDall_nslk$tpmN4_D14dF)

pdf("bootstrap_non-norm.pdf")
berf1 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of expression median for B. jarvisi early 1")
berf2 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of expression median for B. jarvisi early 2")
bltf1 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of expression median for B. jarvisi late 1")
bltf2 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of expression median for B. jarvisi late 2")

d12f + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of expression median for D. melanogaster cell cycle 12")
d14af + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of expression median for D. melanogaster cell cycle 14a")
d14df + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of expression median for D. melanogaster cell cycle 14d")
dev.off()

pdf("bootstrap_norm7.pdf")
berf1N + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for B. jarvisi early 1\n (normalized using all 7 samples)")
berf2N + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for B. jarvisi early 2\n (normalized using all 7 samples)")
bltf1N + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for B. jarvisi late 1\n (normalized using all 7 samples)")
bltf2N + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for B. jarvisi late 2\n (normalized using all 7 samples)")

d12fN + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for D. melanogaster\n cell cycle 12 (normalized using all 7 samples)")
d14afN + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for D. melanogaster\n cell cycle 14a (normalized using all 7 samples)")
d14dfN + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for D. melanogaster\n cell cycle 14d (normalized using all 7 samples)")
dev.off()

pdf("bootstrap_norm2.pdf")
berf1N1 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for\n B. jarvisi early 1 (normalized with D. melanogaster cell cycle 12)")
berf2N2 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for\n B. jarvisi early 2 (normalized with D. melanogaster cell cycle 14a)")
bltf1N3 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for\n B. jarvisi late 1 (normalized with D. melanogaster cell cycle 14a)")
bltf2N4 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median for\n B. jarvisi late 2 (normalized with D. melanogaster cell cycle 14d)")

d12fN1 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median\n for D. melanogaster cell cycle 12 (normalized with B. jarvisi early sample 1)")
d14afN2 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median\n for D. melanogaster cell cycle 14a (normalized with B. jarvisi early sample 2)")
d14afN3 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median\n for D. melanogaster cell cycle 14a (normalized with B. jarvisi late sample 1)")
d14dfN4 + xlab("Median expression") + ylab("Log Expression Density") + ggtitle("Bootstrap of normalized expression median\n for D. melanogaster cell cycle 14d (normalized with B. jarvisi late sample 2)")
dev.off()



