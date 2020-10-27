####Ejecución de script para predicciones####

##Preparación de Working directory
setwd("/Repos/udemy_machine_learning_r_python/udemy_Machine_Learning_con_R_Data_Analytics_de_b-sico_a_experto/project/usal/")
getwd()
filename = read.csv('horas_insumidas2.csv', header = TRUE, stringsAsFactors = TRUE)
data = filename
dataset <- data

##Carga modelo
superModel <- readRDS("./finalModel.rds")

##Prepara datos para predecir
validationIndex<- createDataPartition(dataset$Integrante, p=0.8, list=FALSE)
validation<- dataset[-validationIndex,]
training<- dataset[validationIndex,]

##Realiza predicciones
finalPredictions <- predict(superModel, validation[1:4])
finalConfusionMatrix<- confusionMatrix(finalPredictions,validation$Integrante)
print(finalConfusionMatrix)

write.csv(x = finalPredictions, file = "predicts.csv", row.names = TRUE) 
write.csv(x = validation[1:4], file = "validation.csv", row.names = TRUE)

fPredictions<-read.csv("./predicts.csv")
fValidations<-read.csv("./validation.csv")
fMerge<-merge(fPredictions[2],fValidations)

write.csv(x = validation[1:5], file = "predicted.csv", row.names = TRUE)
