#!/bin/bash

# Read in our packages
source("https://bioconductor.org/biocLite.R")
biocLite("GEOquery")
n
library("GEOquery")

#Read in Pi3k data



#classFile= write.table(classInfo, outClassFile, quote=F, sep= "\t", row.names=T, col.names=F)

gpl=getGEO("GPL3921")
class(gpl)
platformTable=Table(dataTable(gpl))
class(platformTable)
platformTable
colnames(platformTable)


Symbol_Gene=subset(platformTable, select= c(1,11))
pi3k_stm_path="C:/Users/10002293/Documents/GSE12815_PI3K_STM_Signature_Probes.txt"
pi3k_stm_path
pi3k_gfp_stm_signature_probe<-as.matrix(read.table(pi3k_stm_path, sep='\t', header=T, row.names=1))
#ID_Symbols=subset(platformTable, Symbol !="" & Probe_Type=="S", select= c(ID, Symbol) )
dim(Symbol_Gene)

matrixGLP= as.matrix(Symbol_Gene)
pi3k_gfp_stm_signature= merge(matrixGLP, pi3k_gfp_stm_signature_probe, by.x=1, by.y=0, sort=TRUE)
dim(pi3k_gfp_stm_signature)
pi3k_gfp_stm_signature=pi3k_gfp_stm_signature[,-1]
#rownames(pi3k_gfp_stm_signature)=pi3k_gfp_stm_signature[,1]
class(pi3k_gfp_stm_signature)
View(pi3k_gfp_stm_signature)
pi3k_gfp_stm_signature=pi3k_gfp_stm_signature[order(pi3k_gfp_stm_signature$'Gene Symbol')]
pi3k_gfp_stm_signature['Gene Symbol']
length(unique(pi3k_gfp_stm_signature$`Gene Symbol`))
colnames(pi3k_gfp_stm_signature)
table(pi3k_gfp_stm_signature$`Gene Symbol`)
dim(pi3k_gfp_stm_signature)

(GSE24537=write.table(mdata[,-1], outDataFile, quote=F, sep= "\t", row.names=F, col.names=T)




# tells how many times each gene occurs
#sort(table(as.character(mdata[,2])))










