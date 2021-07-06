    
    # #######################################################################
    #                           sesion_5 prework
    #                       Lizzeth Gomez Rodriguez
    # ########################################################################
    
    setwd("C:/Users/GOMEZ/Documents/BEDU_Santander/Programación y Estadística con R/sesion_5")
    production <- read.table("data/production.txt", header = T)    
    head(production)
    dim(production)
    
    # Para manipualr por nombres al df usamos attach()
    attach(production)
    
    plot(RunSize, RunTime, xlab = "Tamaño de ejecución", 
         ylab = "Tiempo de ejecución", pch = 16)
    
    # REGRESION LINEAL SIMPLE
    m1 <- lm(RunTime ~ RunSize)
    summary(m1)
    
    # Grafica con la recta de regresion ajustada
    plot(RunSize, RunTime, xlab = "Tamaño de ejecución", 
         ylab = "Tiempo de ejecución", pch = 16)
    abline(lsfit(RunSize, RunTime)) # Trazamos la recta de regresión estimada
    mtext(expression(paste('Modelo de regresión lineal simple:',
                           ' ',
                           y[i] == beta[0] + beta[1]*x[i] + e[i])),
          side = 3, adj=1, font = 2)
    
    # Recta de regresión poblacional
    text(x = 200, y = 240, expression(paste('Recta de regresión:',
                                            ' ',
                                            y[i] == beta[0] + beta[1]*x[i])),
         adj = 1, font = 2)
    
    # Recta de regresión estimada
    text(x = 350, y = 180, expression(paste('Recta estimada:',
                                            ' ',
                                            hat(y)[i] == hat(beta)[0] + hat(beta)[1]*x[i])),
         adj = 1, font = 2)
    
    # Recta de regresión estimada
    text(x = 350, y = 160, expression(paste('Recta estimada:',
                                            ' ',
                                            hat(y)[i] == 149.74770 + 0.25924*x[i])),
         adj = 1, font = 2)
    
    # Residuales
    points(189, 215, pch=16, col = "red") # Punto muestral
    149.74770 + 0.25924 * 189 # Valor y sobre la recta estimada
    ## [1] 198.7441
    lines(c(189, 189), c(198.7441, 215), col = "red")
    
    points(173, 166, pch=16, col = "red") # Punto muestral
    149.74770 + 0.25924 * 173 # Valor y sobre la recta estimada
    ## [1] 194.5962
    lines(c(173, 173), c(166, 194.5962), col = "red")
    
    
    # Intervalor de confianza del modelo al 95%
    round(confint(m1, level = 0.95), 3)
    
    
    # Intervalos de confianza para la reta poblacional de la variable Runsize
    RunSize0 <- c(50,100,150,200,250,300,350) # Algunos posibles valores de RunSize
    
    (conf <- predict(m1, newdata = data.frame(RunSize = RunSize0), interval = "confidence", level = 0.95))
    
    # Graficamos los intervalos de confianza
    plot(RunSize, RunTime, xlab = "Tamaño de ejecución", ylab = "Tiempo de ejecución", pch = 16)
    abline(lsfit(RunSize, RunTime)) # Trazamos la recta de regresión estimada
    
    lines(RunSize0, conf[, 2], lty = 2, lwd = 2, col = "green") # límites inferiores
    lines(RunSize0, conf[, 3], lty = 2, lwd = 2, col = "green") # límites superiores
    
    # Ahora los intervalos para RunTime
    (pred <- predict(m1, newdata = data.frame(RunSize = RunSize0), interval = "prediction", level = 0.95))
    
    lines(RunSize0, pred[, 2], lty = 2, lwd = 2, col = "blue") # límites inferiores
    lines(RunSize0, pred[, 3], lty = 2, lwd = 2, col = "blue") # límites superiores
    
    # ==================================================================================
    # Dividimos el canvas
    par(mfrow = c(2, 2))
    plot(m1)
    dev.off()
    
    # Maquina de vectres de soport (MVS)
    suppressMessages(suppressWarnings(library(dplyr))) # también usaremos dplyr
    # install.packages("e1071") para instalarlo
    library(e1071)
    
    