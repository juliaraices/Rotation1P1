# Code for orthologs in yeast, celegans, mouse, human and dmel
library(compare)

y_aliases <- read.table("yeast_aliases.txt", header = F, sep="\t")
y_interactions <- read.table("yeast_experimental.txt", header = F, sep=" ")
y_orth <- read.table("yeast_orthologs.txt", header=F, sep="\t")

f <- sapply(y_aliases, is.factor)
y_aliases[f] <- lapply(y_aliases[f], as.character)

f <- sapply(y_interactions, is.factor)
y_interactions[f] <- lapply(y_interactions[f], as.character)

f <- sapply(y_orth, is.factor)
y_orth[f] <- lapply(y_orth[f], as.character)

colnames(y_aliases) <- c("stringDBID", "aliases", "source")
colnames(y_orth) <- c("gene", "dmel_orth")
colnames(y_interactions) <- c("gene1", "gene2", "confidence")

yeast_orth<-merge(y_orth, y_aliases, by.x = "gene", by.y = "aliases")
colnames(yeast_orth)<-c("gene", "ortholog", "stringDBID", "source")

# y_orthint <- data.frame(gene=character(), dmel_homo=character(), string_id=character(), interaction_id=character(), interaction_coeficient=double())
# for(i in 1:(length(yeast_orth[[3]]))){
#   for(j in 1:(length(y_interactions[[1]]))){
#     if(yeast_orth[i,3] == y_interactions[j,1]){
#       tempi<-data.frame(list(yeast_orth[i,1], yeast_orth[i,2], yeast_orth[i,3], y_interactions[j,2], y_interactions[j,3]))
#       colnames(tempi)<-c("gene", "dmel_homo", "string_id", "interaction_id", "interaction_coeficient")
#       y_orthint <- rbind(y_orthint, tempi)
#     } else if(yeast_orth[i,3] == y_interactions[j,2]) {
#       tempi<-data.frame(list(yeast_orth[i,1], yeast_orth[i,2], yeast_orth[i,3], y_interactions[j,1], y_interactions[j,3]))
#       colnames(tempi)<-c("gene", "dmel_homo", "string_id", "interaction_id", "interaction_coeficient")
#       y_orthint<-rbind(y_orthint, tempi)
#     }
#   }
# }

#length(y_orthint[!duplicated(y_orthint),][[1]])


ncol(y_orthint)
a <- merge.data.frame(yeast_orth, y_interactions, by.x = c("stringDBID"), by.y = c("gene2"))
b <- merge.data.frame(yeast_orth, y_interactions, by.x = c("stringDBID"), by.y = c("gene1"))
#y_orthinteractions <- rbind(merge.data.frame(yeast_orth, y_interactions, by.x = c("V1"), by.y = c("gene1")),merge.data.frame(yeast_orth, y_interactions, by.x = c("V1"), by.y = c("gene2")))
colnames(a)<-c("stringDBID", "gene", "ortholog", "source", "gene2", "confidence")
y_orthinteractions <- rbind(a, b)

compare(a[[5]], b[[5]])

y_orthinteractions<y_orthinteractions[, c(2,3,1,5,6)]
y_orthinteractions <- unique(y_orthinteractions[3:5])

