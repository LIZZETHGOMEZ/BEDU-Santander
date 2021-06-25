    # ##########################################################################
    #                       Sesion_1 POSTWORK
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    # 1. Importa los datos de soccer de la temporada 2019/2020 de la primera división 
    # de la liga española a R, los datos los puedes encontrar en el siguiente enlace: 
    # https://www.football-data.co.uk/spainm.php
    
    # 2. Extrae las columnas que contienen los números de goles anotados por los equipos 
    # que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)
    
    # 3. Consulta cómo funciona la función table en R al ejecutar en la consola ?table
    
    dir <- "C:/Users/GOMEZ/Documents/BEDU_Santander/Programación y Estadística con R/sesion_1"
    setwd(dir)
    library(dplyr)
    
    
    # 1. cargamos los datos
    data <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
    
    # 2. Extraemos columnas de la forma comun y usando la funcion select de la biblioteca dplyr
    data$FTHG; data$FTAG
    dplyr::select(data, FTHG, FTAG)
    
    # 3. Consultamos la funcion table()
    ?table
    # Arroja una tabla de frecuencia
     
     
    # Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
    # 1. La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
    # 2. La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
    # 3. La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y 
    # el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
    
    
    # Veamos los valores de las variables que ocuparemos
    sort(unique(data$FTHG))
    sort(unique(data$FTAG))
    
    # Usando la funcion table() sacamos la tabla de frecuencias
    # Donde x: Equipo en casa, y: Equipo visitante
    table(data$FTAG, data$FTHG)
    
    
    # Agregamos los totales
    total_visitante <- sum(table(data$FTAG))
    total_casa <- sum(table(data$FTHG))
    
    # Frecuencia de goles en casa y visitante, almacenamos como data frame
    freq_home <- data.frame(table(data$FTHG))
    freq_away <- data.frame(table(data$FTAG))
    
    
    # Probabilidad marginal (o simple) de anotar x goles en casa:
    proba_home <- data.frame(goles = c(0:6), proba_casa = freq_home$Freq/total_casa)
    proba_away <- data.frame(goles = c(0:5), proba_visitante = freq_away$Freq/total_visitante)
   
    (probabilidades <- proba_home %>% full_join(proba_away))
    
    
    # PROBABILIDAD CONJUNTA
    probabilidades <- mutate(probabilidades, proba_conjunta = proba_casa*proba_visitante)
    
    # RESULTADO FINAL con probabilidades de gol en casa, como visitante y conjunta
    probabilidades
    
    
    
    
    