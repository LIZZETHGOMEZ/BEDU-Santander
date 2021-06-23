        
    # ##########################################################################
    #                       Sesion_3 RETOS
    #                   Martes 22 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    # =========================================================================
    # RETO 1
    
    # 1. Carga el data set BD_Altura_Alunos.csv 
    data <- read.csv("Data/BD_Altura_Alunos.csv", sep =  = ";")
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
        geom_histogram(bin = 40, col = "black", fill = "palegreen") +
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
        ggtitle(" Grafico de correlacion entre altura y peso") 
    
    # 4. Utiliza la función which.max para saber quién es el jugador más alto, una vez hecho esto, 
    # presenta los resultados en una leyenda que diga "El jugador más alto es: Name, con una altura de: Height". Las unidades de altura deben ser en metros.
    which.max(data$Height)
    data[which.max(data$Height)]$Name
    

    
    
    # Utiliza la función which.min para saber quién es el jugador más bajito, una vez hecho esto, presenta los resultados en una leyenda que diga "El jugador más bajito es: Name, con una altura de: Height". Las unidades de altura deben ser en metros.
    # 
    # ¿Cuál es la altura promedio?, representa el resultado en una frase que diga: "La altura promedio es: ALTURA"
    # 
    # Generar un scatterplot donde se representen las Asistencias totales (AST.TOV) vs Puntos (PTS), además has un face wrap con la posición (Pos).