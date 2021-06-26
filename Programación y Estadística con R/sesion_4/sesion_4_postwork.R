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
    
    # Probabilidad conjunta:
    data <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
    
    data <- data[,c(6:7)]
    conjunta <- table(data)    
    conjunta <- prop.table(conjunta)  # Tabla de probabilidad conjunta

    
    # Probabilidades marginales
    home <- data[,"FTHG"] ; home <- as.data.frame(table(home))
    away <- data[,"FTAG"] ; away <- as.data.frame(table(away))
    
    # Renombramos columnas 
    home <- rename(home, goles = home, home = Freq)
    away <- rename(away, goles = away, away = Freq)
    
    # 1. Tabla de cocientes
    # 1.1 Producto de las probabilidades marginales
    marginales <- full_join(home,away, by = "goles")
    marginales <- mutate(producto, home = home/sum(home), away = away/sum(away, na.rm = T), producto = home*away)
    producto <- marginales[,"producto"]   
    producto  
    
    cocientes <- conjunta/producto
    