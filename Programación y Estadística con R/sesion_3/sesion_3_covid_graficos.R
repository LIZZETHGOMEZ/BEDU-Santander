    
    # ######################################################################
    #                      Sesion_3 WORK
    #        Varios graficos sobre estadistica de Covid
            
            

    # ========================================================================
   
    library(scales)
    mex <- read.csv("../sesion_2/Data/data_2/C19Mexico.csv")
    head(mex); tail(mex)
    
    # Modificamos la fecha
    mex <- mutate(mex, Fecha = as.Date(Fecha, "%Y-%m-%d"))
    str(mex)
    
    # ===============================================================
    # Casos Confirmados por Día (NI)  NUMERO DE CASOS NUEVOS
    
    p <- ggplot(mex, aes(x = Fecha, y = NI)) + 
        geom_line(stat = "identity") + 
        labs(x = "Fecha", y = "Incidencia (Número de casos nuevos)",
             title = paste("Casos de Incidencia de COVID-19 en México:", 
                           format(Sys.time(), 
                                  tz = "America/Mexico_City", usetz = TRUE))) +
        theme(plot.title = element_text(size = 12))  +
        theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
              axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, Ángulo y estilo de las abcisas y ordenadas
    
    # Cambiamos formato de fecha con libreria scales
    p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))
    p
    
    ggplotly(p)
    # Le pegamos una leyenda
    p <- p +
        theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
        annotate("text", x = mex$Fecha[round(dim(mex)[1]*0.4)], y = max(mex$NI), colour = "blue", size = 5, 
                 label = paste("Última actualización: ", mex$NI[length(mex$NI)]))
    p
    
    
    # =========================================================================
    # MUESRTES ACUMULADAS
    
    mexm <- subset(mex, Decesos > 0) # Tomamos el subconjunto desde que comenzaron las muertes
    
    p <- ggplot(mexm, aes(x = Fecha, y = Decesos)) + geom_line( color="red") + 
        geom_point() +
        labs(x = "Fecha", 
             y = "Muertes acumuladas",
             title = paste("Muertes por COVID-19 en México:", format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
        theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
              axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, Ángulo y estilo de las abcisas y ordenadas
    
    p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))
    
    p
    
    p <- p +
        theme(plot.margin = margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
        annotate("text", x = mexm$Fecha[round(dim(mexm)[1]*0.4)], 
                 y = max(mexm$Muertos), colour = "red", size = 5, label = paste("Última actualización: ", mexm$Muertos[dim(mexm)[1]]))
    p
    
    # ========================================================================
    # Muertes por Día
    p <- ggplot(mexm, aes(x = Fecha, y = NM)) + 
        geom_line(stat = "identity") + 
        labs(x = "Fecha", y = "Número de nuevos decesos",
             title = paste("Nuevos decesos por COVID-19 en México:", 
                           format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
        theme(plot.title = element_text(size=12)) +
        theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
              axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, Ángulo y estilo de las abcisas y ordenadas
    
    p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))
    
    ###
    
    p <- p +
        theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
        annotate("text", x = mexm$Fecha[round(dim(mexm)[1]*0.2)], 
                 y = max(mexm$NM), colour = "red", size = 5, label = paste("Última actualización: ", mexm$NM[dim(mexm)[1]]))
    p
    
    # ========================================================================
    # Acumulado de Casos Confirmados y Muertes
    p <- ggplot(mex, aes(x=Fecha, y=Infectados)) + geom_line(color="blue") + 
        labs(x = "Fecha", 
             y = "Acumulado de casos",
             title = paste("COVID-19 en México:", format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
        geom_line(aes(y = Muertos), color = "red") +
        theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
              axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, Ángulo y estilo de las abcisas y ordenadas
    
    p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))
    
    ###
    
    p <- p +
        theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
        annotate("text", x = mex$Fecha[round(dim(mex)[1]*0.4)], 
                 y = max(mex$Infectados), colour = "blue", size = 5, label = paste("Última actualización para Infectados:", mex$Infectados[dim(mex)[1]])) +
        annotate("text", x = mex$Fecha[round(dim(mex)[1]*0.4)], 
                 y = max(mex$Infectados)-100000, colour = "red", size = 5, label = paste("Última actualización para Muertes:", mex$Muertos[dim(mex)[1]])) 
    p
    
    
    # =======================================================================================
    # Tasa de Letalidad: La tasa de letalidad observada para un día determinado, la calculamos dividiendo las muertes acumuladas reportadas hasta ese día, entre el acumulado de casos confirmados para el mismo día. Multiplicamos el resultado por 100 para reportarlo en forma de porcentaje. Lo que obtenemos es el porcentaje de muertes del total de casos confirmados.
    
    p <- ggplot(mexm, aes(x=Fecha, y=Letalidad)) + geom_line(color="red") + 
        labs(x = "Fecha", 
             y = "Tasa de letalidad",
             title = paste("COVID-19 en México:", format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
        theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
              axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1)) + # color, Ángulo y estilo de las abcisas y ordenadas 
        scale_y_discrete(name ="Tasa de letalidad", 
                         limits=factor(seq(1, 13.5, 1)), labels=paste(seq(1, 13.5, 1), "%", sep = ""))
    
    p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))
    
    ###
    
    p <- p +
        theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
        annotate("text", x = mexm$Fecha[round(length(mexm$Fecha)*0.2)], 
                 y = max(mexm$Letalidad)-1, colour = "red", size = 4, label = paste("Última actualización: ", mexm$Letalidad[dim(mexm)[1]], "%", sep = "")) 
    p
    
    
    # ===================================================================================
    # Factores de Crecimiento:
    # El factor de crecimiento de infectados para un día determinado, lo calculamos al dividir el acumulado de infectados para ese día, entre el acumulado de infectados del día anterior. El factor de crecimiento de muertes lo calculamos de forma similar.
    
    mex <- filter(mex, FCM < Inf) # Tomamos solo valores reales de factores de crecimiento
    
    p <- ggplot(mex, aes(x=Fecha, y=FCI)) + geom_line(color="blue") + 
        labs(x = "Fecha", 
             y = "Factor de crecimiento",
             title = paste("COVID-19 en México:", format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
        geom_line(aes(y = FCM), color = "red") + theme(plot.title = element_text(size=12)) +
        theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
              axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, Ángulo y estilo de las abcisas y ordenadas
    
    p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))
    
    ###
    
    p <- p +
        annotate("text", x = mex$Fecha[round(length(mex$Fecha)*0.4)], y = max(mex$FCM), colour = "blue", size = 5, label = paste("Última actualización para infectados: ", round(mex$FCI[dim(mex)[1]], 4))) +
        annotate("text", x = mex$Fecha[round(length(mex$Fecha)*0.4)], y = max(mex$FCM)-0.2, colour = "red", size = 5, label = paste("Última actualización para muertes: ", round(mex$FCM[dim(mex)[1]], 4))) 
    p