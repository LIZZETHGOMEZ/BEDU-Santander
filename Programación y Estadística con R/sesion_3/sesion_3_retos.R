        
    # ##########################################################################
    #                       Sesion_3 RETOS
    #                   Martes 22 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    # =========================================================================
    # RETO 1
    
    library(dplyr)
    library(ggplot2)
    
    # 1. Carga el data set BD_Altura_Alunos.csv 
    data <- read.csv("Data/BD_Altura_Alunos.csv", sep = ";")
    colnames(data)
    str(data)
    
    # 2. Realiza el histograma con la función hist(), nativa de R
    hist(data$Altura, breaks = seq(120, 200, 5),
         xlab = " Altura",
         ylab = "Frecuencia")
    
    # 3. Ahora realiza el histograma con la función ggplot. (Recuerda que debes instalar el paquete ggplot2)
    data %>%
        ggplot() + 
        aes(Altura) +
        geom_histogram(binwidth = 3, col = "black", fill = "palegreen") +
        ggtitle(" Histograma de las Alturas de los alumnos") +
        ylab(" Frecuencia")

    
    
    
    # ========================================================================
    # RETO 2
    
    data <- read.csv("Data/players_stats.csv")
    
    
    # 1. Generar un histograma de los minuntos totales (MIN), 
    # de los jugadores y agregar una línea donde se muestre la media 
    # (Hint: para agregar la línea que muestre la media consulta la documentación sobre geom_vline y el argumento xintercept)
    
    data %>%
        ggplot() +
        aes(MIN) +
        geom_histogram(bins = 30, col = "black", fill = "palegreen") +
        geom_vline(xintercept = mean(data$MIN), col = "red", lwd = 1) +
        xlab("Minutos") + ylab("Frecuencia")

        
    # 2. Generar un histograma de edad (Age) y agregar una línea con la media
    data %>%
        ggplot() +
        aes(Age) +
        geom_histogram(binwidth = 1, col = "black", fill = "palegreen") +
        geom_vline(xintercept = mean(data$Age, na.rm = TRUE), col = "red", lwd = 1) +
        xlab("Edad") + ylab("Frecuencia")
    
    # 3. Hacer un scatterplot de las variables Weight y Height y observar la correlación que existe entre ambas variables (1 sola gráfica)
    
    data %>%
        ggplot() +
        aes(Weight, Height) +
        geom_point( col = "blue") +
        xlab("Peso") + ylab(" Altura") +
        ggtitle(" Gráfico de correlación entre altura y peso") 
    
    # Interpretacion ----------------------------------------------------
    # El scatterplot muestra una relación positiva, sin emabrgo se observa que existe bastante dispersión 
    # entre los datos y un outlier en la esquina superior derecha.
    # A su vez, los datos indican que a mayor altura, mayor es el peso del jugador.
    
    
    
    # 4. Utiliza la función which.max para saber quién es el jugador más alto, una vez hecho esto, 
    # presenta los resultados en una leyenda que diga "El jugador más alto es: Name, con una altura de: Height". Las unidades de altura deben ser en metros.
    fila <- which.max(data$Height)
    jugador <- data[fila, "Name"]
    altura <- data[fila, "Height"]
           
    print(paste0("El jugador más alto es: ", jugador, " con una altura de: ", round(altura/100,2), "m"))
    
    
    # 5. Ahora ubicamos al jugador más bajo
    fila <- which.min(data$Height)
    jugador <- data[fila, "Name"]
    altura <- data[fila, "Height"]
    
    print(paste0("El jugador más bajo es: ", jugador, " con una altura de: ", round(altura/100,2), "m"))
    
    # 6. ¿Cuál es la altura promedio?, representa el resultado en una frase que diga: 
    media <- mean(data$Height, na.rm = T)
    print(paste("La altura promedio es:", round(media/100,2), "m"))
    
    # 7. Generar un scatterplot donde se representen las Asistencias totales (AST.TOV) vs Puntos (PTS), además has un face wrap con la posición (Pos).
    library(scales)
    
    data %>% 
        ggplot() +
        aes(AST.TOV, PTS, col = Pos) +
        geom_point() +
        facet_wrap("Pos") +
        xlab("Asistencias Totales") +
        ylab("Puntos") +
        theme_bw() +
        theme(legend.position = 0)

    
    
    
    
    
    
    
     
    