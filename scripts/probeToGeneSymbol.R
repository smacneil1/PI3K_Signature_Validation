#!/bin/bash
library("GEOquery")


outClassFile=commandArgs()[7]
outDataFile=commandArgs()[8]
dataset=commandArgs()[9]

outClassFile
outDataFile
dataset
#load the data sets
GSE1 <- getGEO(dataset)

GSE1data = exprs(GSE1[[1]])
phenoData = pData(GSE1[[1]])
classInfo =phenoData[1]

#classFile= write.table(classInfo, outClassFile, quote=F, sep= "\t", row.names=T, col.names=F)

gpl=getGEO("GPL6947")
platformTable=Table(dataTable(gpl))

ID_Symbols=subset(platformTable, select= c(ID, Symbol) )
#ID_Symbols=subset(platformTable, Symbol !="" & Probe_Type=="S", select= c(ID, Symbol) )
dim(ID_Symbols)

matrixGLP= as.matrix(ID_Symbols)
GSE1data=exprs(GSE1[[1]])

mdata= merge(matrixGLP, GSE1data, by.x=1, by.y=0, sort=TRUE)

GSE24537=write.table(mdata[,-1], outDataFile, quote=F, sep= "\t", row.names=F, col.names=T)






# tells how many times each gene occurs
#sort(table(as.character(mdata[,2])))





##### Trying to do with with the raw files ####
#platformFile = commandArgs()[7]
#microArrayFile = commandArgs()[8]
#microArrayFile
#outFile = commandArgs()[9]
#platform=read.table(platformFile, sep= "\t", header=TRUE)
#platform=as.matrix(read.table(platformFile, sep= "\t", header=TRUE))

#colsWithMissingData = which(apply(platform, 2, function(x) { any(is.na(platform)) }))
#if (length(colsWithMissingData) > 0)
   #platform = platform[,-colsWithMissingData]


#geneExpression=as.matrix(read.table(microArrayFile, sep= "\t", header=TRUE))



##### Using the .db package #######
#x =  hgu133plus2SYMBOL
#head(x)
# Get the probe identifiers that are mapped to a gene symbol
#mapped_probes = mappedkeys(x)
#probes=data.frame(mapped_probes)
# Convert to a list
#xx = as.list(x[mapped_probes])
#symbols=NULL
#for(i in 1:length(xx)){
  #  genes=xx[[i]]
   # symbols=c(symbols, genes)
#}
