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

BltF1 <- read.table("abundance_SRR1571147_extras.tsv", header=T, sep = "\t", quote = "")
BltF2 <- read.table("abundance_SRR1571155_extras.tsv", header=T, sep = "\t", quote = "")
BerF1 <- read.table("abundance_SRR1571160_extras.tsv", header=T, sep = "\t", quote = "")
BerF2 <- read.table("abundance_SRR1571161_extras.tsv", header=T, sep = "\t", quote = "")
Boleae <- read.table("DatasetS4_BoleaeCDS_DmelGene_BolFembryo_BolMembryo.txt", header=T, sep=" ", quote="")
syn <- read.table("synonims.txt", header=F, sep="\t", quote="")

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

temmp <- merge(Boleae, syn, by.x="Dmel_gene", by.y="V1")
Boleae_all <- merge(temmp, D14aF, by.x="V2", by.y='target_id')

## comparisons: BerF1 - D12F | BerF2 - D14aF | BltF1 - D14aF | BltF2 - D14dF
#make a new table with columns to be normalized (you can't have 0s, so we add a tiny number to them) - lowest non-zero number is 54.882, so adding 0.000001 should not influence it a lot
BD_normalized<-c(BDall$tpm_BerF1+0.000001, BDall$tpm_BerF2+0.000001, BDall$tpm_BltF1+0.000001, BDall$tpm_BltF2+0.000001, BDall$tpm_D12F+0.000001, BDall$tpm_D14aF+0.000001, BDall$tpm_D14dF+0.000001)
#bolF<-c(lott$e10+0.000001, lott$e11+0.000001, lott$e12+0.000001, lott$e13+0.000001, lott$e14a+0.000001, lott$e14b+0.000001, lott$e14c+0.000001, lott$e14d+0.000001)
BDNormMatrix<-matrix(BD_normalized, nrow(BDall), 7)
#bolFMat<-matrix(bolF, nrow(lott), 8)

############WARNING: change "8" to however many columns you have selected!!! And "lott" is the table that contained the values that I was normalizing, use your own table name

#normalize
x <- normalize.loess(BDNormMatrix)
#x<-normalize.loess(bolFMat)
newBD <- as.data.frame(x)
#newDataFrame <- as.data.frame(x)
## comparisons: BerF1 - D12F | BerF2 - D14aF | BltF1 - D14aF | BltF2 - D14dF
BDall$tpmN_BerF1 <- (newBD$V1)
BDall$tpmN_BerF2 <- (newBD$V2)
BDall$tpmN_BltF1 <- (newBD$V3)
BDall$tpmN_BltF2 <- (newBD$V4)
BDall$tpmN_D12F <- (newBD$V5)
BDall$tpmN_D14aF <- (newBD$V6)
BDall$tpmN_D14dF <- (newBD$V7)

Bole_normalized<-c(Boleae_all$tpm_D14aF+0.000001, Boleae_all$M_tpm+0.000001)
BoleNormMatrix<-matrix(Bole_normalized, nrow(Boleae_all), 2)
y <- normalize.loess((BoleNormMatrix))
newBole <- as.data.frame(y)
Boleae_all$tpmN_D14aF<-newBole$V2
Boleae_all$tpmN_bole<-newBole$V1

# lott$e14d <- (newDataFrame$V8)

BDall$tpmN_D12F_BerF1 <- BDall$tpmN_D12F/BDall$tpmN_BerF1
BDall$tpmN_D14aF_BerF2 <- BDall$tpmN_D14aF/BDall$tpmN_BerF2
BDall$tpmN_D14aF_BltF1 <- BDall$tpmN_D14aF/BDall$tpmN_BltF1
BDall$tpmN_D14dF_BltF2 <- BDall$tpmN_D14dF/BDall$tpmN_BltF2

Boleae_all$tpmN_D14aF_bole <- Boleae_all$tpmN_D14aF/Boleae_all$tpmN_bole

BDall_nslk <- subset(BDall, BDall$target_id!='sc' & BDall$target_id!='run' & BDall$target_id!='gro' & BDall$target_id!='dpn' & BDall$target_id!='emc' & BDall$target_id!='da' & BDall$target_id!='sisA' & BDall$target_id!='her' & BDall$target_id!='tra' & BDall$target_id!='upd3' & BDall$target_id!='Sxl' & BDall$target_id!='CG1641' & BDall$target_id!='CG1849' & BDall$target_id!='CG33542' & BDall$target_id!='CG3827' & BDall$target_id!='CG43770' & BDall$target_id!='CG8384' & BDall$target_id!='CG5102' & BDall$target_id!='CG4694' & BDall$target_id!='CG8704' & BDall$target_id!='CG16724' & BDall$target_id!='CG1007' & BDall$target_id!='SxlA' & BDall$target_id!='SxlB' & BDall$target_id!='SxlC')
BDall_slk <- subset(BDall, BDall$target_id=='sc' | BDall$target_id=='run' | BDall$target_id=='gro' | BDall$target_id=='dpn' | BDall$target_id=='emc' | BDall$target_id=='da' | BDall$target_id=='sisA' | BDall$target_id=='her' | BDall$target_id=='tra' | BDall$target_id=='upd3' | BDall$target_id=='Sxl' | BDall$target_id=='CG1641' | BDall$target_id=='CG1849' | BDall$target_id=='CG33542' | BDall$target_id=='CG3827' | BDall$target_id=='CG43770' | BDall$target_id=='CG8384' | BDall$target_id=='CG5102' | BDall$target_id=='CG4694' | BDall$target_id=='CG8704' | BDall$target_id=='CG16724' | BDall$target_id=='CG1007' | BDall$target_id=='SxlA' | BDall$target_id=='SxlB' | BDall$target_id=='SxlC')

Boleae_all_nslk <- subset(Boleae_all, Boleae_all$V2!='sc' & Boleae_all$V2!='run' & Boleae_all$V2!='gro' & Boleae_all$V2!='dpn' & Boleae_all$V2!='emc' & Boleae_all$V2!='da' & Boleae_all$V2!='sisA' & Boleae_all$V2!='her' & Boleae_all$V2!='tra' & Boleae_all$V2!='upd3' & Boleae_all$V2!='Sxl' & Boleae_all$V2!='CG1641' & Boleae_all$V2!='CG1849' & Boleae_all$V2!='CG33542' & Boleae_all$V2!='CG3827' & Boleae_all$V2!='CG43770' & Boleae_all$V2!='CG8384' & Boleae_all$V2!='CG5102' & Boleae_all$V2!='CG4694' & Boleae_all$V2!='CG8704' & Boleae_all$V2!='CG16724' & Boleae_all$V2!='CG1007' & Boleae_all$V2!='SxlA' & Boleae_all$V2!='SxlB' & Boleae_all$V2!='SxlC')
Boleae_all_slk <- subset(Boleae_all, Boleae_all$V2=='sc' | Boleae_all$V2=='run' | Boleae_all$V2=='gro' | Boleae_all$V2=='dpn' | Boleae_all$V2=='emc' | Boleae_all$V2=='da' | Boleae_all$V2=='sisA' | Boleae_all$V2=='her' | Boleae_all$V2=='tra' | Boleae_all$V2=='upd3' | Boleae_all$V2=='Sxl' | Boleae_all$V2=='CG1641' | Boleae_all$V2=='CG1849' | Boleae_all$V2=='CG33542' | Boleae_all$V2=='CG3827' | Boleae_all$V2=='CG43770' | Boleae_all$V2=='CG8384' | Boleae_all$V2=='CG5102' | Boleae_all$V2=='CG4694' | Boleae_all$V2=='CG8704' | Boleae_all$V2=='CG16724' | Boleae_all$V2=='CG1007' | Boleae_all$V2=='SxlA' | Boleae_all$V2=='SxlB' | Boleae_all$V2=='SxlC')

## comparisons: BerF1 - D12F | BerF2 - D14aF | BltF1 - D14aF | BltF2 - D14dF
## here as I only have relative expression, I can do:
# sex-related X non-sex-relate , and that's all folks

pdf(file="analysis_relative_norm7_extras.pdf", onefile = T, width = 11, height = 11) 
par(mfrow=c(2,2))

boxplot(log10(BDall_slk$tpmN_D12F_BerF1), log10(BDall_nslk$tpmN_D12F_BerF1), main="D. melanogaster cell cycle 12 /\n B. jarvisi early expression 1", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression (7samples toghether)", notch=T)
text(c(1.5,1.5), c(10,9), c(wilcox.test(log10(BDall_slk$tpmN_D12F_BerF1), log10(BDall_nslk$tpmN_D12F_BerF1))$p.value, "(Wilcox test)"))

boxplot(log10(BDall_slk$tpmN_D14aF_BerF2), log10(BDall_nslk$tpmN_D14aF_BerF2), main="D. melanogaster cell cycle 14a /\n B. jarvisi early expression 2", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression (7samples toghether)", notch=T)
text(c(1.5,1.5), c(10,9), c(wilcox.test(log10(BDall_slk$tpmN_D14aF_BerF2), log10(BDall_nslk$tpmN_D14aF_BerF2))$p.value, "(Wilcox test)"))

boxplot(log10(BDall_slk$tpmN_D14aF_BltF1), log10(BDall_nslk$tpmN_D14aF_BltF1), main="D. melanogaster cell cycle 14a /\n B. jarvisi late expression 1", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression (7samples toghether)", notch=T)
text(c(1.5,1.5), c(10,9), c(wilcox.test(log10(BDall_slk$tpmN_D14aF_BltF1), log10(BDall_nslk$tpmN_D14aF_BltF1))$p.value, "(Wilcox test)"))

boxplot(log10(BDall_slk$tpmN_D14dF_BltF2), log10(BDall_nslk$tpmN_D14dF_BltF2), main="D. melanogaster cell cycle 14d /\n B. jarvisi late expression 2", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression (7samples toghether)", notch=T)
text(c(1.5,1.5), c(10,9), c(wilcox.test(log10(BDall_slk$tpmN_D14dF_BltF2), log10(BDall_nslk$tpmN_D14dF_BltF2))$p.value, "(Wilcox test)"))


boxplot(log10(BDall_slk$tpmN_D12F_BerF1), log10(BDall_nslk$tpmN_D12F_BerF1), main="D. melanogaster cell cycle 12 /\n B. jarvisi early expression 1", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression (7samples toghether)", notch=T, outline=F)
text(c(1.5,1.5), c(-1.5,-2), c(wilcox.test(log10(BDall_slk$tpmN_D12F_BerF1), log10(BDall_nslk$tpmN_D12F_BerF1))$p.value, "(Wilcox test)"))

boxplot(log10(BDall_slk$tpmN_D14aF_BerF2), log10(BDall_nslk$tpmN_D14aF_BerF2), main="D. melanogaster cell cycle 14a /\n B. jarvisi early expression 2", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression (7samples toghether)", notch=T, outline=F)
text(c(1.5,1.5), c(-1.5,-2), c(wilcox.test(log10(BDall_slk$tpmN_D14aF_BerF2), log10(BDall_nslk$tpmN_D14aF_BerF2))$p.value, "(Wilcox test)"))

boxplot(log10(BDall_slk$tpmN_D14aF_BltF1), log10(BDall_nslk$tpmN_D14aF_BltF1), main="D. melanogaster cell cycle 14a /\n B. jarvisi late expression 1", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression (7samples toghether)", notch=T, outline=F)
text(c(1.5,1.5), c(3,2.5), c(wilcox.test(log10(BDall_slk$tpmN_D14aF_BltF1), log10(BDall_nslk$tpmN_D14aF_BltF1))$p.value, "(Wilcox test)"))

boxplot(log10(BDall_slk$tpmN_D14dF_BltF2), log10(BDall_nslk$tpmN_D14dF_BltF2), main="D. melanogaster cell cycle 14d /\n B. jarvisi late expression 2", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression (7samples toghether)", notch=T, outline=F)
text(c(1.5,1.5), c(2.8,2.5), c(wilcox.test(log10(BDall_slk$tpmN_D14dF_BltF2), log10(BDall_nslk$tpmN_D14dF_BltF2))$p.value, "(Wilcox test)"))

dev.off()

pdf(file="analysis_relative_boleae_extra.pdf", onefile = T, width = 11, height = 11) 
par(mfrow=c(1,1))

boxplot(log10(Boleae_all_slk$tpmN_D14aF_bole), log10(Boleae_all_nslk$tpmN_D14aF_bole), main="D. melanogaster cell cycle 14a /\n B. oleae early expression", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression", notch=T)
text(c(1.5,1.5), c(8,7), c(wilcox.test(log10(Boleae_all_slk$tpmN_D14aF_bole), log10(Boleae_all_nslk$tpmN_D14aF_bole))$p.value, "(Wilcox test)"))

boxplot(log10(Boleae_all_slk$tpmN_D14aF_bole), log10(Boleae_all_nslk$tpmN_D14aF_bole), main="D. melanogaster cell cycle 14a /\n B. oleae early expression", col=c("turquoise","lightseagreen"), names=c("Sex-related genes", "Non-sex-related genes"), ylab="Relative Log Loess Normalized Expression", notch=T, outline=F)
text(c(1.5,1.5), c(3,2.5), c(wilcox.test(log10(Boleae_all_slk$tpmN_D14aF_bole), log10(Boleae_all_nslk$tpmN_D14aF_bole))$p.value, "(Wilcox test)"))

dev.off()

