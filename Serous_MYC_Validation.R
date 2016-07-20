#title: "Serous_MYC_Validation"
#author: "Shelley"
#date: "January 3, 2015"


import os, sys
#add input and output files

outfile_micrraydata= sys.argv[1]
outfile_classFile= sys.argv[2]
  

  
#outfile_micrraydata="~/Dropbox/GenomeMedicine/Revisons/GSE24537_microarray_filtered.txt"
#outfile_classFile="~/Dropbox/GenomeMedicine/Revisons/GSE24537_classFile.txt"
  
# Download GEO query 

source("http://bioconductor.org/biocLite.R")
biocLite("GEOquery")
library("GEOquery")


# Download GEO 24537 data 

GSE1 <- getGEO("GSE24537")
head(GSE1)
head(exprs(GSE1[[1]]))
dim(exprs(GSE1[[1]])) # 48785    33

GSE1data = exprs(GSE1[[1]])
dim(GSE1data) # 48785    33  probes in the normalized file 
row.names(GSE1data)

# Get phenotype data

head(pData(phenoData(GSE1[[1]]))[1:5,c(1,6,8)])
head(pData(phenoData(GSE1[[1]])))
head(pData(featureData(GSE1[[1]])))

phenoData = pData(GSE1[[1]])
classInfo =phenoData[1]
colnames(classInfo)
head(classInfo)
colnames(classInfo)=NULL
dim(classInfo)
classInfo
sort(classInfo)

write.table(classInfo, outfile_classFile, sep = "\t", quote=F, col.names = NA)


# obtain the probe information from Illumina GPL file 
gpl=getGEO("GPL6947")
platformTable=Table(dataTable(gpl))
head(platformTable)

ID_Symbols=subset(platformTable, select= c(ID, Symbol) )
head(ID_Symbols)
dim(ID_Symbols) # 49676 probes from Illumina file

# filter out the probes that dont map to genes
ID_Symbols_probes_map2genes=subset(platformTable, Symbol !="", select= c(ID, Symbol) )
class(ID_Symbols_probes_map2genes)
row.names(ID_Symbols_probes_map2genes)=ID_Symbols_probes_map2genes[,1]
row.names(ID_Symbols_probes_map2genes)
dim(ID_Symbols_probes_map2genes) #36157 only 36157 of the probes map to genes. 
head(ID_Symbols_probes_map2genes)


GSE_probes=merge(ID_Symbols_probes_map2genes,GSE1data, by.x=0, by.y=0, sort=TRUE)
head(GSE_probes)
row.names(GSE_probes)
head(GSE_probes)
dim(GSE_probes) #36140
GSE_probes= GSE_probes[,-1]
head(GSE_probes)
GSE_probes= GSE_probes[,-1]
head(GSE_probes)
GSE_probes= GSE_probes[,-1]
head(GSE_probes)
row.names(GSE_probes)

Gene_expr_sum= rowSums(GSE_probes,na.rm = FALSE, dims = 1)
length(Gene_expr_sum) #36140 probes that map to genes

Gene_expr_sum_sorted = sort(Gene_expr_sum, decreasing = TRUE)
length(Gene_expr_sum_sorted) #36140

remove_bottom_30= Gene_expr_sum_sorted[1:25298]
length(remove_bottom_30)
remove_bottom_30=as.matrix(remove_bottom_30)
row.names(remove_bottom_30)
length(remove_bottom_30) #25298

#
math=36140*0.30
math  #remove the bottom 10842 expressing genes
to_keep= length(Gene_expr_sum_sorted)-math
to_keep #25298

#now filter the the botton 30 expressing
dim(GSE_probes) #36140    33
head(GSE_probes)
merge_30= merge(remove_bottom_30, GSE_probes, by=0 )
merge_30=merge_30[,-2]
head(merge_30)
row.names(merge_30)=merge_30[,1]

dim(merge_30) #25298    35 (added the)
head(merge_30)
row.names(merge_30)
merge_30=merge_30[,-1]
head(merge_30)
row.names(merge_30)

#merge the gene symbols with the prboes
gene_merge=merge(matrixGLP, merge_30, , by.x=1, by.y=0)
head(gene_merge)
dim(gene_merge) #25298

remove_probes=gene_merge[,-1]
dim(remove_probes) #25298    34
head(remove_probes)
View(remove_probes)

write.table(remove_probes,outfile_micrraydata, sep = "\t", quote=F, row.names=FALSE)


#A - probe targets all isoforms 7713
#I - probe targets only one of multiple isoforms, 6372
#S - probe targets the only isoform), 34719
