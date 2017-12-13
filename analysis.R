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

BDall$tpmN_D12F_BerF1 <- BDall$tpmN_D12F/BDall$tpmN_BerF1
BDall$tpmN_D14aF_BerF2 <- BDall$tpmN_D14aF/BDall$tpmN_BerF2
BDall$tpmN_D14aF_BltF1 <- BDall$tpmN_D14aF/BDall$tpmN_BltF1
BDall$tpmN_D14dF_BltF2 <- BDall$tpmN_D14dF/BDall$tpmN_BltF2



BDall_nslk <- subset(BDall, BDall$target_id!='sc' & BDall$target_id!='run' & BDall$target_id!='gro' & BDall$target_id!='dpn' & BDall$target_id!='emc' & BDall$target_id!='da' & BDall$target_id!='sisA' & BDall$target_id!='her' & BDall$target_id!='tra' & BDall$target_id!='upd3' & BDall$target_id!='Sxl' & BDall$target_id!='CG1641' & BDall$target_id!='CG1849' & BDall$target_id!='CG33542' & BDall$target_id!='CG3827' & BDall$target_id!='CG43770' & BDall$target_id!='CG8384' & BDall$target_id!='CG5102' & BDall$target_id!='CG4694' & BDall$target_id!='CG8704' & BDall$target_id!='CG16724' & BDall$target_id!='CG1007' & BDall$target_id!='SxlA' & BDall$target_id!='SxlB' & BDall$target_id!='SxlC')
BDall_slk <- subset(BDall, BDall$target_id=='sc' | BDall$target_id=='run' | BDall$target_id=='gro' | BDall$target_id=='dpn' | BDall$target_id=='emc' | BDall$target_id=='da' | BDall$target_id=='sisA' | BDall$target_id=='her' | BDall$target_id=='tra' | BDall$target_id=='upd3' | BDall$target_id=='Sxl' | BDall$target_id=='CG1641' | BDall$target_id=='CG1849' | BDall$target_id=='CG33542' | BDall$target_id=='CG3827' | BDall$target_id=='CG43770' | BDall$target_id=='CG8384' | BDall$target_id=='CG5102' | BDall$target_id=='CG4694' | BDall$target_id=='CG8704' | BDall$target_id=='CG16724' | BDall$target_id=='CG1007' | BDall$target_id=='SxlA' | BDall$target_id=='SxlB' | BDall$target_id=='SxlC')

for(i in 1:length(BDall_slk$target_id)){
  if(BDall_slk$target_id[[i]]=='sc' | BDall_slk$target_id[[i]]=='run' | BDall_slk$target_id[[i]]=='sisA' | BDall_slk$target_id[[i]]=='upd3' | BDall_slk$target_id[[i]]=='SxlB'){
    BDall_slk$Chromosome[[i]] <- "X-linked"
  }
  else{
    BDall_slk$Chromosome[[i]] <- "Autosomal"
  }
}


## comparisons: BerF1 - D12F | BerF2 - D14aF | BltF1 - D14aF | BltF2 - D14dF

pdf(file="analysis_BjarVsDmel_norm7.pdf", onefile = T, width = 7, height = 7)
par(mfrow=c(2,2))
# BerF1 vs D12F
ggplot(data=NULL, aes(x=log10(BDall_nslk$tpmN_BerF1), y=log10(BDall_nslk$tpmN_D12F))) + geom_point(colour='aliceblue') + theme(legend.position="none") + scale_colour_manual(values=c('lightskyblue1','lightskyblue1','darkorchid','violet')) + labs(x= "Log Expression in B. jarvisi 2-3h embryo (replicate 1)", y="Log Expression in D. melanogaster cell cycle 12") + ggtitle(" Loess Normalized expression") +
  geom_point(data=NULL, aes(x=log10(BDall$tpmN_BerF1), y=log10(BDall$tpmN_D12F), col=cut(log10(BDall$tpmN_D12F/BDall$tpmN_BerF1),quantile(log10(BDall$tpmN_D12F/BDall$tpmN_BerF1), c(0,0.025))))) +
  #geom_point(data=NULL, aes(x=log10(BDall_nslk$tpmN_BerF1), y=log10(BDall_nslk$tpmN_D12F), col=cut(log10(BDall_nslk$tpmN_D12F/BDall_nslk$tpmN_BerF1),quantile(log10(BDall_nslk$tpmN_D12F/BDall_nslk$tpmN_BerF1), c(0.975, 1))))) +
  geom_point(data=NULL, aes(x=log10(BDall$tpmN_BerF1), y=log10(BDall$tpmN_D12F), col=cut(log10(BDall$tpmN_D12F/BDall$tpmN_BerF1),quantile(log10(BDall$tpmN_D12F/BDall$tpmN_BerF1), c(0.975, 1))))) +
  #geom_point(data=NULL, aes(x=log10(BDall_nslk$tpmN_BerF1), y=log10(BDall_nslk$tpmN_D12F), col=cut(log10(BDall_nslk$tpmN_D12F/BDall_nslk$tpmN_BerF1),quantile(log10(BDall_nslk$tpmN_D12F/BDall_nslk$tpmN_BerF1), c(0, 0.025))))) + 
  geom_point(data=BDall_slk, aes(log10(tpmN_BerF1), log10(tpmN_D12F), colour=(Chromosome))) + geom_text(data=BDall_slk, aes(log10(tpmN_BerF1)+0.2, log10(tpmN_D12F)+0.2, label=BDall_slk$target_id), size=3) 


# BerF2 vs D14aF
ggplot(data=NULL, aes(x=log10(BDall_nslk$tpmN_BerF2), y=log10(BDall_nslk$tpmN_D14aF))) + geom_point(colour='aliceblue') + theme(legend.position="none") +
  geom_point(data=NULL, aes(x=log10(BDall$tpmN_BerF2), y=log10(BDall$tpmN_D14aF), col=cut(log10(BDall$tpmN_D14aF/BDall$tpmN_BerF2),quantile(log10(BDall$tpmN_D14aF/BDall$tpmN_BerF2), c(0, 0.025))))) +
  #geom_point(data=NULL, aes(x=log10(BDall_nslk$tpmN_BerF2), y=log10(BDall_nslk$tpmN_D14aF), col=cut(log10(BDall_nslk$tpmN_D14aF),quantile(log10(BDall_nslk$tpmN_D14aF), c(0.975, 1))))) +
  geom_point(data=NULL, aes(x=log10(BDall$tpmN_BerF2), y=log10(BDall$tpmN_D14aF), col=cut(log10(BDall$tpmN_D14aF/BDall$tpmN_BerF2),quantile(log10(BDall$tpmN_D14aF/BDall$tpmN_BerF2), c(0.975, 1))))) +
  #geom_point(data=NULL, aes(x=log10(BDall_nslk$tpmN_BerF2), y=log10(BDall_nslk$tpmN_D14aF), col=cut(log10(BDall_nslk$tpmN_BerF2),quantile(log10(BDall_nslk$tpmN_BerF2), c(0, 0.025))))) + 
  geom_point(data=BDall_slk, aes(log10(tpmN_BerF2), log10(tpmN_D14aF), colour=(Chromosome))) + geom_text(data=BDall_slk, aes(log10(tpmN_BerF2)+0.2, log10(tpmN_D14aF)+0.2, label=BDall_slk$target_id), size=3) +
  scale_colour_manual(values=c('lightskyblue1','lightskyblue1','darkorchid', 'violet')) + labs(x= "Log Expression in B. jarvisi 2-3h embryo (replicate 2)", y="Log Expression in D. melanogaster cell cycle 14a") + ggtitle(" Loess Normalized expression")

# BltF1 vs D14aF
ggplot(data=NULL, aes(x=log10(BDall_nslk$tpmN_BltF1), y=log10(BDall_nslk$tpmN_D14aF))) + geom_point(colour='aliceblue') + theme(legend.position="none") +
  geom_point(data=NULL, aes(x=log10(BDall$tpmN_BltF1), y=log10(BDall$tpmN_D14aF), col=cut(log10(BDall$tpmN_D14aF/BDall$tpmN_BltF1),quantile(log10(BDall$tpmN_D14aF/BDall$tpmN_BltF1), c(0, 0.025))))) +
  #geom_point(data=NULL, aes(x=log10(BDall_nslk$tpmN_BltF1), y=log10(BDall_nslk$tpmN_D14aF), col=cut(log10(BDall_nslk$tpmN_D14aF),quantile(log10(BDall_nslk$tpmN_D14aF), c(0.975, 1))))) +
  geom_point(data=NULL, aes(x=log10(BDall$tpmN_BltF1), y=log10(BDall$tpmN_D14aF), col=cut(log10(BDall$tpmN_D14aF/BDall$tpmN_BltF1),quantile(log10(BDall$tpmN_D14aF/BDall$tpmN_BltF1), c(0.975, 1))))) +
  #geom_point(data=NULL, aes(x=log10(BDall_nslk$tpmN_BltF1), y=log10(BDall_nslk$tpmN_D14aF), col=cut(log10(BDall_nslk$tpmN_BltF1),quantile(log10(BDall_nslk$tpmN_BltF1), c(0, 0.025))))) + 
  geom_point(data=BDall_slk, aes(log10(tpmN_BltF1), log10(tpmN_D14aF), colour=(Chromosome))) + geom_text(data=BDall_slk, aes(log10(tpmN_BltF1)+0.2, log10(tpmN_D14aF)+0.2, label=BDall_slk$target_id), size=3) +
  scale_colour_manual(values=c('lightskyblue1','lightskyblue1','darkorchid', 'violet')) + labs(x= "Log Expression in B. jarvisi 3-5h embryo (replicate 1)", y="Log Expression in D. melanogaster cell cycle 14a") + ggtitle(" Loess Normalized expression")

# BltF2 vs D14dF
ggplot(data=NULL, aes(x=log10(BDall_nslk$tpmN_BltF2), y=log10(BDall_nslk$tpmN_D14dF))) + geom_point(colour='aliceblue') + theme(legend.position="none") +
  geom_point(data=NULL, aes(x=log10(BDall$tpmN_BltF2), y=log10(BDall$tpmN_D14dF), col=cut(log10(BDall$tpmN_D14dF/BDall$tpmN_BltF2),quantile(log10(BDall$tpmN_D14dF/BDall$tpmN_BltF2), c(0, 0.025))))) +
  #geom_point(data=NULL, aes(x=log10(BDall_nslk$tpmN_BltF2), y=log10(BDall_nslk$tpmN_D14dF), col=cut(log10(BDall_nslk$tpmN_D14dF),quantile(log10(BDall_nslk$tpmN_D14dF), c(0.975, 1))))) +
  geom_point(data=NULL, aes(x=log10(BDall$tpmN_BltF2), y=log10(BDall$tpmN_D14dF), col=cut(log10(BDall$tpmN_D14dF/BDall$tpmN_BltF2),quantile(log10(BDall$tpmN_D14dF/BDall$tpmN_BltF2), c(0.975, 1))))) +
  #geom_point(data=NULL, aes(x=log10(BDall_nslk$tpmN_BltF2), y=log10(BDall_nslk$tpmN_D14dF), col=cut(log10(BDall_nslk$tpmN_BltF2),quantile(log10(BDall_nslk$tpmN_BltF2), c(0, 0.025))))) + 
  geom_point(data=BDall_slk, aes(log10(tpmN_BltF2), log10(tpmN_D14dF), colour=(Chromosome))) + geom_text(data=BDall_slk, aes(log10(tpmN_BltF2)+0.2, log10(tpmN_D14dF)+0.2, label=BDall_slk$target_id), size=3) +
  scale_colour_manual(values=c('lightskyblue1','lightskyblue1','darkorchid', 'violet')) + labs(x= "Log Expression in B. jarvisi 3-5h embryo (replicate 2)", y="Log Expression in D. melanogaster cell cycle 14d") + ggtitle(" Loess Normalized expression")
dev.off()

