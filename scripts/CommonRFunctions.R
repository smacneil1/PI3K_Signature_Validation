#common R functions 

#Read in a File 
readFile= function(fileName){
dataset <-read.table(fileName,stringsAsFactors=FALSE, header=1, row.names=1,sep='\t')
return(dataset)  
}


#write a file


#read in multiple files from the same folder

read_many_file=function(folder_path){
setwd(folder_path)
files=system("ls", intern=TRUE)
print(files)

for(i in 1:length(files)){
  f<-read.table(files[i], header=1,sep='\t')
  var_name=gsub('\\..*$','',files[i])
  print(var_name)
  assign(var_name, f) 
}  
print(files)



# sort 
newdata <- mtcars[order(mpg),] 

#subset
data <- data[ which(data$adj.P.Val < 0.01),]

 


}