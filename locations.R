# analysing wether gene sinvolved in the counting of X:A ratio in Drosophila were alredy in their muller elements, or if they moved.
# if they moved, it suggests they might have moved after being recruited for that network
# if they didn't move, they probably were recruited due to their good location
# Julia Raices
# December 2017

locations1 <- read.table("Genes_CcapLocation_DmelLocation.txt", header = T, sep=" ", quote="")
converter <- read.table("FlyBase_IDs.txt", header=F, sep="\t", quote="")
locations2 <- read.table("Genes_CcapLocation_Dmel_Location.txt", header = F, sep=" ", quote="")
locations3 <- read.table("Genes_Ccap_Dmel_locations14.txt", header=F, sep=" ", quote="")
locations4 <- read.table("Genes_Ccap_Dmel_Locations2.txt", header = F, sep=" ", quote="")
locations5 <- read.table("Genes_Ccap_Dmel_Locations_7646.txt", header = F, sep=" ", quote="")
locations6 <- read.table("BLAST_Ccap_Dmel_Locations.txt", header=F, sep=" ", quote="")


interests1 <- merge(locations1, converter, by.x='gene', by.y='V3')
interests2 <- merge(locations2, converter, by.x='V6', by.y='V3')
interests3 <- merge(locations3, converter, by.x='V6', by.y='V3')
interests4 <- merge(locations4, converter, by.x='V6', by.y='V3')
interests5 <- merge(locations5, converter, by.x='V6', by.y='V3')


test <- merge(locations1, locations5, by.x='gene', by.y='V6')

for(i in 1:nrow(test)){
  if(test$CcChr[[i]] == test$V7[[i]]){
  } else
    print(test$gene[[i]])
  }
}

for(i in 1:nrow(test)){
  if(test$DmChr[[i]] == test$V7[[i]]){
  } else{
    print(test$gene[[i]])
  }
}
