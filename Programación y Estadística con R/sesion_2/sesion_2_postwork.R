    # ##########################################################################
    #                       Sesion_2 POSTWORK
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################

    
    # 1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la 
    # primera división de la liga española a R, los datos los puedes encontrar en el siguiente enlace: 
    # https://www.football-data.co.uk/spainm.php
     
    # 2.Revisa la estructura de de los data frames al usar las funciones: str, head, View y summary
     
    # 3. Con la función select del paquete dplyr selecciona únicamente las columnas 
    # Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames. 
    # (Hint: también puedes usar lapply).
    
    # 4. Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean 
    # del mismo tipo (Hint 1: usa as.Date y mutate para arreglar las fechas). 
    # Con ayuda de la función rbind forma un único data frame que contenga las seis columnas mencionadas 
    # en el punto 3 (Hint 2: la función do.call podría ser utilizada).
    
    
    
    # 1. Importamos los datos
    
    dir <- "C:/Users/GOMEZ/Documents/BEDU_Santander/Programación y Estadística con R/sesion_2/Data/postwork"
    setwd(dir)
    
    
    D1_1718 <- 'https://www.football-data.co.uk/mmz4281/1718/SP1.csv'
    D1_1819 <- 'https://www.football-data.co.uk/mmz4281/1819/SP1.csv'
    D1_1920 <- 'https://www.football-data.co.uk/mmz4281/1920/SP1.csv'
    
    
    download.file(url = D1_1718, destfile = "D1_1718.csv", mode = "wb")
    download.file(url = D1_1819, destfile = "D1_1819.csv", mode = "wb")
    download.file(url = D1_1920, destfile = "D1_1920.csv", mode = "wb")
    
    
    # Guardamos los archivos en una lista para facilirtar manipulacion
    lista <- lapply(dir(), read.csv)
    
    
    # 2. Revisar estructra de datos
    for(df in lista){
        str(df); head(df); summary(df)
    }
    
    
    # 3 seleccionamos columnas de interes, almacenamos y corregimos fechas
    library(dplyr)
    
    # 4. Acomodamos fechas y creamos un unico data frame
    lista <- lapply(lista, select, Date, HomeTeam:FTR)
    lista <- lapply(lista, mutate, Date = as.Date(Date,"%d/%m/%y"))
    lista[2] 
    
    data <- do.call(rbind, lista)
    data    
    
    
     
    