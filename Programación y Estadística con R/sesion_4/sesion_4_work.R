    # ##########################################################################
    #                           Sesion_4 WORK
    #                   Jueves 24 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    # ESTADISTICA INFERENCIAL
    
    dir <- "C:/Users/GOMEZ/Documents/BEDU_Santander/Programación y Estadística con R/sesion_4"
    setwd(dir)
    
    
    library(ggplot2)
    
    # =============================================================================
    # DISTRIBUCION NORMAL
    
    
    # Consideremos una variable aleatoria (v.a.) X que se distribuye como normal
    # con media 175 y desviación estándar 6 (parámetros mu = 175 y sigma = 6)
    # Algunos posibles valores que puede tomar la v.a. X (mínimo: mu-4sigma, máximo: mu+4sigma)
    x <- seq(-4, 4, 0.01)*6 + 175 
    
    ### Función de densidad
    y <- dnorm(x, mean = 175, sd = 6)
    
    
    # Graficamos la Densidad de la normal (Campana de Gauss), agregamos titulo y 
    # linea de la media v = vertical, tly indica la fragmentacion de la linea
    # type = l indica de tipo linea
    
    plot(x, y, type = "l", xlab = "", ylab = "")
    title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
    abline(v = 175, lwd = 2, lty = 2)
    
    
    # AREA BAJO LA CURVA
    # Calculo de la probabilidad de la distribucion
    
    # Para obtener P(X <= 180) --------------------------------------------
    # es decir, la probabilidad de que X tome un valor
    # menor o igual a 180
    
    ### Función de distribución
    # q indica el valor en x, es decir el quantil (todos los valores por debajo)
    pnorm(q = 180, mean = 175, sd = 6)
    
    # Rompemos el canvas en 2 filas para ir metiendo graficos
    par(mfrow = c(2, 2))
    
    # Graficamos la probabilidad por debajo de 180, y coloreamos con polygon
    plot(x, y, type = "l", xlab = "", ylab = "")
    title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
    polygon(c(min(x), x[x<=180], 180), c(0, y[x<=180], 0), col="red")
    
    
    # Calcular P(X <= 165) ------------------------------------
    pnorm(q = 165, mean = 175, sd = 6)
    
    # Graficamos y coloreamos la porba por debajo de 165
    plot(x, y, type = "l", xlab = "", ylab = "")
    title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
    polygon(c(min(x), x[x<=165], 165), c(0, y[x<=165], 0), col="yellow")
    
    
    # Calcular P(165 <= X <= 180) -------------------------------------- 
    # es decir, la probabilidad de que X tome un valor
    # mayor o igual a 165 y menor o igual a 180, debemos correr
    pnorm(q = 180, mean = 175, sd = 6) - pnorm(q = 165, mean = 175, sd = 6)
    
    # Graficamos
    plot(x, y, type = "l", xlab="", ylab="")
    title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
    polygon(c(165, x[x>=165 & x<=180], 180), c(0, y[x>=165 & x<=180], 0), col="green")
    
    
    # Calcular P(X >= 182)---------------------------------------------
    # Con lower.tail calcula el area de la cola superior
    pnorm(q = 182, mean = 175, sd = 6, lower.tail = FALSE)
    
    # Graficamos
    plot(x, y, type = "l", xlab="", ylab="")
    title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
    polygon(c(182, x[x>=182], max(x)), c(0, y[x>=182], 0), col="blue")
    
    
    # Desavilitamos el grid del canvas que dividimos al inicio
    dev.off()
    
    
    
    # ===============================================================================
    # CUANTILES 
    # Calculo del valor del eje de las x dada una probabilidad
    
    # Para encontrar el número b, tal que P(X <= b) = 0.75, es decir,
    # el cuantil de orden 0.75 se va a encontrar en el valor x
    b <- qnorm(p = 0.75, mean = 175, sd = 6)
    b
    
    # Comprobamos
    pnorm(b, 175, 6)
    
    # Graficamos y resaltamos el valor usando axis(at = valor)
    plot(x, y, type = "l", xlab="", ylab="")
    title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 175, " y ", sigma == 6)))
    axis(side = 1, at = b, font = 2, padj = 1, lwd = 2)
    
    
    # ==============================================================================
    # MUESTRAS ALEATORIAS
    
    # Para generar una muestra aleatoria de tamaño n = 1000 de la v.a. X
    # corremos la siguiente instrucción
    
    # Generamos una semilla para generar numeros pseudoaleatorios
    set.seed(7563)
    
    muestra <- rnorm(n = 1000, mean = 175, sd = 6)
    length(muestra)
    
    # Convertimos la muestra a df pra generar un vector
    mdf <- as.data.frame(muestra) 
    tail(mdf) #Observamos los ultimos registros
    
    # Graficamos Histgrama
    # Similar a la densidad de una normal
    
    ggplot(mdf, aes(muestra)) + 
        geom_histogram(colour = 'red', 
                       fill = 'blue',
                       alpha = 0.3, # Intensidad del color fill
                       binwidth = 3) + 
        geom_density(aes(y = 3*..count..)) +
        geom_vline(xintercept = mean(mdf$muestra), linetype = "dashed", color = "black") + 
        ggtitle('Histograma para la muestra normal') + 
        labs(x = 'Valores obtenidos', y = 'Frecuencia') +
        theme_grey() +
        theme(plot.title = element_text(hjust = 0.5, size = 16))  
    
    
    # ===========================================================================
    # DISTRIBUCION T-STUDENT Para muestras pequeñas, (Siempre centrada en cero)
    
    # En `R` para calcular valores de las funciones de densidad, distribución 
    # o cuantiles de la distribución t de Student (continua), usamos las funciones dt,
    # pt y  qt respectivamente. Para generar muestras aleatorias de esta
    # distribución utilizamos la función rt.
    
    # Consideremos una variable aleatoria (v.a.) T que se distribuye como t
    # de Student con 7 grados de libertad (gl) (parámetro gl = 7)
    
    
    #### Función de densidad
    
    x <- seq(-4, 4, 0.01)
    y <- dt(x, df = 7) # Valores correspondientes de la densidad t de Student con 7 gl
    
    # Graficamos
    plot(x, y, type = "l", main = "Densidad t de Student, gl = 7", xlab="", ylab="")
    abline(v = 0, lwd = 2, lty = 2)
    
    
    #### Función de distribución
    # Calcular (T <= 1.5)
    pt(q = 1.5, df = 7) 
    
    # Graficamos
    plot(x, y, type = "l", main = "Densidad t de Student, gl = 7", xlab="", ylab="")
    polygon(c(min(x), x[x<=1.5], 1.5), c(0, y[x<=1.5], 0), col="purple")
    
    # Calcular P(T >= 2)
    pt(q = 2, df = 7, lower.tail = FALSE)
    
    # Graficamos
    plot(x, y, type = "l", main = "Densidad t de Student, gl = 7", xlab="", ylab="")
    polygon(c(2, x[x>=2], max(x)), c(0, y[x>=2], 0), col="orange")
    
    
    
    # ============================================================================
    # CUANTILES para T-student (Colas sueriores)
    
    # Para encontrar el número d tal que P(T <= d) = 0.025, es decir, 
    # el cuantil de orden 0.025, corremos la siguiente instrucción
    (d <- qt(p = 0.025, df = 7))
    
    # Comprobamos
    pt(q = d, df = 7)
    
    # Graficamos
    plot(x, y, type = "l", main = "Densidad t de Student, gl = 7", xlab="", ylab="")
    axis(side = 1, at = d, font = 2, padj = 1, lwd = 2)
    
    # ==============================================================================
    # MUESTRAS ALEATORIAS
    
    # Para generar una muestra aleatoria de tamaño n = 1000 de la v.a. T
    # corremos la siguiente instrucción
    
    set.seed(777)
    
    muestra <- rt(n = 1000, df = 7)
    length(muestra)
    mdf <- as.data.frame(muestra)
    tail(mdf)
    
    # Observamos que el histograma de la muestra generada tiene forma de campana
    # similar a la densidad t de Student
    
    ggplot(mdf, aes(muestra)) + 
        geom_histogram(colour = "orange", 
                       fill = 'green',
                       alpha = 0.7, # Intensidad del color fill
                       binwidth = 0.5) + 
        geom_density(aes(y = 0.5*..count..)) +
        geom_vline(xintercept = mean(mdf$muestra), linetype="dashed", color = "black") + 
        ggtitle('Histograma para la muestra t de Student') + 
        labs(x = 'Valores obtenidos', y = 'Frecuencia') +
        theme_gray() +
        theme(plot.title = element_text(hjust = 0.5, size = 16))  
    
    
    
    
    
    
    # =======================================================================
    # DISTRIBUCION EXPONENCIAL
    
    # v.a con distribcion exponencial y lambda = 2
    x <- seq(0, 5, 0.02)
    
    # Grafica de la distribucion
    # dexp para grafica exponencial con parametro lambda = 2
    # mu = sd = 1/2
    plot(x, dexp(x, rate = 2), type = "l", lwd = 2, ylab = "")
    title(main = "Función de Densidad Exponencial", ylab = "f(x)",
          sub = expression("Parámetro " ~ lambda == 2))
    text(x = 3, y = 1.5, labels = expression(f(x)==2*exp(-2*x) ~ " para x "  >= 0))
    text(x = 3, y = 1.3, labels = paste("0 en otro caso"))
    text(x = 1, y = 1, labels = expression("E(X) = " ~ 1/lambda == 1/2), col = 2)
    text(x = 3, y = 0.5, labels = expression("DE(X) = " ~ 1/lambda == 1/2), col = 4)
    
    
    set.seed(10) 
    
    # Con muestra aleatoria de tamaño n = 4
    (m1.4 <- rexp(n = 4, rate = 2))
    
    # Obtenemos la media
    mean(m1.4)
    
    # Ahora obtenemos 5 muestras de tamaño 3
    # spply aplica una funcion (FUN) al vector o matriz (X) = rep (3,5)  = 5 muestras de tamaño 3
    set.seed(64) 
    (m5.3 <- sapply(X = rep(3, 5), FUN = rexp, 2))
    
    # Obtenemos las medias de las 5 muestras
    # Con apply aplica al objeto, la media a las columnas (2 = col, 1 = rows) del objeto
    (media5.3 <- apply(m5.3, 2, mean))
    
    
   
    # Ahora obtenemos 1000 muestras de tamaño 7 y 
    # las 1000 medias correspondientes a las muestras
    set.seed(465) 
    m1000.7 <- sapply(X = rep(7, 1000), FUN = rexp, 2)
    media1000.7 <- apply(m1000.7, 2, mean)
    mdf <- as.data.frame(media1000.7)
    tail(mdf)
    
    # Graficamos Histograma
    ggplot(mdf, aes(media1000.7)) + 
        geom_histogram(colour = 'blue', 
                       fill = 'pink',
                       alpha = 0.7) + # Intensidad del color fill
        geom_vline(xintercept = mean(media1000.7), linetype="dashed", color = "black") + 
        ggtitle('Histograma para las 1000 medias') + 
        labs(x = 'medias', y = 'Frecuencia')+
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5, size = 16)) 
    
    mean(media1000.7); 1/2 # Media de las 1000 medias y media de la población de la cual vienen las 1000 muestras
    sd(media1000.7); (1/2)/sqrt(7) # DE de las 1000 medias y DE de la población de la cual vienen las 1000 muestras dividida por la raíz del tamaño de la muestra
    
    
    # Ahora obtenemos 1000 muestras de tamaño 33 y las 1000 medias correspondientes a las muestras

    set.seed(4465)
    m1000.33 <- sapply(X = rep(33, 1000), FUN = rexp, 2)
    media1000.33 <- apply(m1000.33, 2, mean)
    mdf <- as.data.frame(media1000.33)
    tail(mdf)
    
    
    # Graficamos el Histograma
    ggplot(mdf, aes(media1000.33)) + 
        geom_histogram(colour = 'yellow', 
                       fill = 'purple',
                       alpha = 0.7) + # Intensidad del color fill
        geom_vline(xintercept = mean(media1000.33), linetype="dashed", color = "black") + 
        ggtitle('Histograma para las 1000 medias') + 
        labs(x = 'medias', y = 'Frecuencia')+
        theme_get() +
        theme(plot.title = element_text(hjust = 0.5, size = 16)) 
    mean(media1000.33); 1/2 # Media de las 1000 medias y media de la población de la cual vienen las 1000 muestras
    sd(media1000.33); (1/2)/sqrt(33) # DE de las 1000 medias y DE de la población de la cual vienen las 1000 muestras dividida por la raíz del tamaño de la muestra
    
    
    
    # =============================================================================
    # PRUEBAS DE HIPOTESIS
    
    # Contrastes comunes con muestras grandes
    
    # Contraste de dos colas
    # Dada dos muestras aleatorias de tamaños n1 = 56 y n2 = 63
    
    set.seed(174376)
    m1 <- rexp(n = 56, rate = 4.1); 1/4.1 # media real de la población
    tail(as.data.frame(m1))
    m2 <- rexp(n = 63, rate = 3.4); 1/3.4 # media real de la población
    tail(as.data.frame(m2))
    1/4.1-1/3.4 # diferencia de medias real
    
    boxplot(m1, m2)
    
    # estamos interesados en contrastar las hipótesis 
    # H0: mu1-mu2 = 0 
    # H1: mu1-mu2 diferente de 0 (contraste de dos colas)
    
    # El valor observado del estadístico de prueba en este caso está dado por
    z0 <- (mean(m1)-mean(m2)-0)/sqrt(var(m1)/56 + var(m2)/63)
    z0
    # que proviene de una distribución normal estándar aproximadamente.
    
    # Supongamos que estamos interesados en encontrar la región de rechazo (de dos colas) 
    # con un nivel de significancia alpha = 0.05, 
    # debemos encontrar el valor z_{0.025} que satisface P(Z > z_{0.025}) = 0.025.
    
    (z.025 <- qnorm(p = 0.025, lower.tail = FALSE)) # Area limite del lado derecho
    (z0 < -z.025) | (z0 > z.025)
    
    # fallamos en rechazar la hipótesis nula.
    # El valor se encuentra dentro del limite superior, dentro del area de aceptacion,
    # por lo que se acepta la Ho
    
    # p-value El p-value lo podemos calcular como
    (pvalue <- 2*pnorm(z0, lower.tail = FALSE)) # p-value > 0.05 Se acepta Ho
    x <- seq(-4, 4, 0.01)
    y <- dnorm(x)
    plot(x, y, type = "l", xlab="", ylab="")
    title(main = "Densidad normal estándar", sub = expression(paste(mu == 0, " y ", sigma == 1)))
    
    polygon(c(min(x), x[x<=-z0], -z0), c(0, y[x<=-z0], 0), col="purple")
    axis(side = 1, at = -z0, font = 2, padj = 1, lwd = 2)
    
    polygon(c(z0, x[x>=z0], max(x)), c(0, y[x>=z0], 0), col="purple")
    axis(side = 1, at = z0, font = 2, padj = 1, lwd = 2)
    
    
    # ------------------------------------------------------------------------
    # Contraste de hipótesis con muestras pequeñas (n < 30) para mu y mu1 - mu2
    
    # Contraste de dos colas
    # Dada dos muestras aleatorias de tamaños n1 = 23 y n2 = 20
    
    set.seed(1776)
    m1 <- rnorm(n = 23, mean = 175, sd = 3)
    tail(as.data.frame(m1))
    m2 <- rnorm(n = 20, mean = 160, sd = 3)
    tail(as.data.frame(m2))
    175-160 # diferencia de medias real
    
    boxplot(m1, m2)
    
    # estamos interesados en contrastar las hipótesis 
    # H0: mu1-mu2 = 0 vs 
    # H1: mu1-mu2 diferente de 0 (contraste de dos colas)
    
    # El valor observado del estadístico de prueba en este caso está dado por
    # (Noteos que por ser muestra pequeña la distribucion debe ser t -student)
    t0 <- (mean(m1)-mean(m2)-0)/(sqrt((22*var(m1)+19*var(m2))/(23+20-2))*sqrt(1/23+1/20))
    t0
    
    # Los grados de libertado se obtiene sumando las dos muestras, quitandole 2, por ser dos muestras
    # que proviene de una distribución t de Student con 23 + 20 - 2 = 41 gl
    
    # Supongamos que estamos interesados en encontrar la región de rechazo (de dos colas) con un nivel de significancia alpha = 0.05, debemos encontrar el valor t_{0.025} que satisface P(T > t_{0.025}) = 0.025.
    # Calculamos el cuantil de la distribucion t con qt()
    (t.025 <- qt(p = 0.025, df= 41, lower.tail = FALSE))
    (-t0 < -t.025) | (t0 > t.025)
    
    # rechazamos la hipótesis nula.
    
    # p-value El p-value lo podemos calcular como
    (pvalue <- 2*pt(t0, df = 41, lower.tail = FALSE))
    
    ### También podemos usar la función t.test para llevar a cabo el procedimiento 
    # de contraste de hipótesis
    
    t.test(x = m1, y = m2, alternative = "two.sided", mu = 0, paired = FALSE, var.equal = TRUE)
    
    
    
    
    