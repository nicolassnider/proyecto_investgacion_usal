####Ejecución de script para predicciones####
library(mlbench)  
library(e1071)    
library(graphics) 
library(lattice)  
library(ggplot2)
library(caret)
library(corrplot)
library(klaR)
library(clusterGeneration)
library(mnormt)
library(MASS)
library(randomForest)

##Preparación de Working directory
print("Preparando directorio \n")
setwd("E:/Repos/proyecto_investigacion_usal")
getwd()

args = commandArgs(trailingOnly = TRUE)




args[1]

paste("Recuperando archivo ", args[1])

filename = read.csv(args[1], header = TRUE, stringsAsFactors = TRUE)
data = filename
dataset <- data

##Carga modelo
print("Carga modelo \n")
superModel <- readRDS("./finalModel.rds")

##Prepara datos para predecir
print("Preparando datos para predicción \n")
validationIndex<- createDataPartition(dataset$Integrante, p=0.8, list=FALSE)
validation<- dataset[-validationIndex,]
training<- dataset[validationIndex,]

##Realiza predicciones
print("Generando predicciones \n")
finalPredictions <- predict(superModel, validation[1:4])
finalConfusionMatrix<- confusionMatrix(finalPredictions,validation$Integrante)
print(finalConfusionMatrix)

write.csv(x = finalPredictions, file = "predicts.csv", row.names = TRUE) 
write.csv(x = validation[1:4], file = "validation.csv", row.names = TRUE)

fPredictions<-read.csv("./predicts.csv")
fValidations<-read.csv("./validation.csv")
fMerge<-merge(fPredictions[2],fValidations)

write.csv(x = validation[1:5], file = "predicted.csv", row.names = TRUE)
print("Archivo predicted.csv generado \n")
