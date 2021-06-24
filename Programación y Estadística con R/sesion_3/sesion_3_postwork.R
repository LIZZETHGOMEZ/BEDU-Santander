    # ##########################################################################
    #                       Sesion_3 POSTWORK
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    # Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
    # 1. La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0,1,2,)
    # 2. La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
    # 3. La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
    
    library(ggplot2)
    library(dplyr)
    
    data <- read.csv("../sesion_2/Data/postwork/soccer.csv")
    
    # 1. Probabilidades Marginales de anotar en casa
    sort(unique(data$FTHG))
    freq_home <- data.frame(table(data$FTHG))
    proba_home <- data.frame(goles = freq_away$Var1, proba_home = freq_home$Freq/sum(freq_home$Freq))
    
    
    # 2. Probabilidades Marginales de anotar como visitante
    sort(unique(data$FTAG))
    freq_away <- data.frame(table(data$FTAG))
    proba_away <- data.frame(goles = freq_away$Var1, proba_away = freq_away$Freq/sum(freq_away$Freq))
    
    # Tabla de probabilidades de anotar en casa y como visitante
    tabla <- full_join(proba_home, proba_away, by = "goles")
    
    # 3. Probabilida Conjunta
    tabla <- mutate(tabla, proba_conjunta = proba_home*proba_away)
    tabla
    
    # Realiza lo siguiente:
    # Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa.
    # Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
    # Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido. 
    
    tabla <- tabla %>% mutate(proba_away = round(proba_away*100, 2),
                     proba_home = round(proba_home*100, 2),
                     proba_conjunta = round(proba_conjunta*100, 2))
    
    
    
    # Probabilidades en Casa
    tabla %>% 
        ggplot() +
        aes(x = goles, y = proba_home) +
        geom_bar(stat = "identity", fill = "pink") +
        xlab(" Número de goles") +
        ylab("Probabilidad %") +
        ggtitle("Probabilidad de anotar goles en casa")
    
    
    # Probabilidades como visitante
    tabla %>% 
        ggplot() +
        aes(x = goles, y = proba_away) +
        geom_bar(stat = "identity", fill = "yellowgreen") +
        xlab(" Número de goles") +
        ylab("Probabilidad %") +
        ggtitle("Probabilidad de anotar goles como visitante")
    