    # ##########################################################################
    #                       Sesion_4 POSTWORK
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    
    # Ahora investigarás la dependencia o independencia del número de goles anotados por el equipo de casa y 
    # el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap.
    
    # 1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote 
    # X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), 
    # en un partido. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
    
    # 2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior. 
    # Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. 
    # Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1,
    # son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).
    
    
    # Retomamos las tablas a ocupar ----------------------------------
    
    # PROBABILIDAD CONJUNTA:
    data <- read.csv("../sesion_2/Data/postwork/soccer.csv")
    
    data <- table(data[,c("FTHG","FTAG")])
    conjunta <- addmargins(data)
    conjunta <- prop.table(conjunta)  # Tabla de probabilidad conjunta
    conjunta
    
    # PROBABILIDADES MARGINALES
    for(i in 1:nrow(conjunta)){
        for(j in 1:ncol(conjunta)){
            conjunta[i,j] <- conjunta[i,j]/conjunta["Sum","Sum"]
        }
    }
    
    
    # 1. TABLA DE COCIENTES
    for(i in 1:nrow(conjunta)){
        for(j in 1:ncol(conjunta)){
            conjunta[i,j] <- conjunta[i,j]/(conjunta[i,"Sum"] * conjunta["Sum",j])
        }
    }
    
    conjunta
    
    
    # 2. BOOTSTRAP
    nueva_poblacion <- sample(conjunta, 8)
    muestra <- sample(nueva_poblacion, replace = T)
    
    bootstrap <- replicate(n = 1000, sample(nueva_poblacion, replace = T))
    
    
    
    
    hist(bootstrap)
    
    library(boot)
    myBootstrap <- boot(nueva_poblacion, foo, R=1000, cor.type='s')    
    
    
    
    
    

    