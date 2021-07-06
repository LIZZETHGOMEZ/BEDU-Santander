    # ##########################################################################
    #                        Sesion_6 WORK
    #                       Jueves 01 de Julio
    #                     Lizzeth Gomez Ridriguez
    # ########################################################################### 
    
    
    # SERIES DE TIEMPO
    
    # Datos de pasajeros aéreos (en miles) de una aerolínea
    AP <- AirPassengers
    AP
    
    # Clase de un objeto de AP que es Time Series (ts)
    class(AP)
    start(AP); end(AP); frequency(AP) #Para ver inicio, fin y frecuencia del periodo de la serie
    summary(AP)
    
    # Grafico de la serie de tiempo, representa los bookings multiplicados por 100
    # Se oberva un proceso estacional
    plot(AP, ylab = "Pasajeros (1000's)", xlab = "Tiempo", 
         main = "Reserva de pasajeros aéreos internacionales", 
         sub = "Estados Unidos en el periodo 1949-1960")
    
    
    # ============================================================================
    
    # https://github.com/AtefOuni/ts/tree/master/Data
    
    # Series de Tiempo Múltiple
    # Serie de producción de electricidad, cerveza y chocolate
    
    setwd("~/BEDU_Santander/Programación y Estadística con R/sesion_6")
    
    # Cargamos datos
    CBE <- read.csv("data/cbe.csv", header = TRUE)
    CBE[1:4,]
    class(CBE)
    # Observemos que son 3 vectores, de tipo df no es una serie de tiempo por ahora
    
    # Convertimos a ts para cada vector(columna) y especificamos el año de inicio y freq de 12 meses
    Elec.ts <- ts(CBE[, 3], start = 1958, freq = 12)
    Beer.ts <- ts(CBE[, 2], start = 1958, freq = 12)
    Choc.ts <- ts(CBE[, 1], start = 1958, freq = 12)
    
    # Graficamos las tres series y las pegamos usando cbind()
    plot(cbind(Elec.ts, Beer.ts, Choc.ts), 
         main = "Producción de Chocolate, Cerveza y Electricidad", 
         xlab = "Tiempo",
         sub = "Enero de 1958 - Diciembre de 1990")
    
    # ==================================================================================
    
    # Serie de temperaturas globales, expresadas como anomalías de las medias mensuales
    # Usando otro dataset tipo txt, lo leemos con scan()
    Global <- scan("data/global.txt")
    Global.ts <- ts(Global, st = c(1856, 1), end = c(2005, 12), fr = 12)
    
    # Observemos la grafica
    plot(Global.ts, xlab = "Tiempo", ylab = "Temperatura en °C", main = "Serie de Temperatura Global",
         sub = "Serie mensual: Enero de 1856 a Diciembre de 2005")
    
    # Veamos que es necesario suabisar los datos, para ello usamos aggregate()
    # Dicha funcion calcula promedios moviles
    Global.annual <- aggregate(Global.ts, FUN = mean)
    
    # Graficamos los datos suabizados
    plot(Global.annual, xlab = "Tiempo", ylab = "Temperatura en °C", main = "Serie de Temperatura Global",
         sub = "Serie anual de temperaturas medias: 1856 a 2005")
    
    # -----------------------------------------------------------------------------
    
    # Cambiamos el periodo
    New.series <- window(Global.ts, start = c(1970, 1), end = c(2005, 12)) 
    New.time <- time(New.series)
    plot(New.series, xlab = "Tiempo", ylab = "Temperatura en °C", main = "Serie de Temperatura Global",
         sub = "Serie mensual: Enero de 1970 a Diciembre de 2005"); abline(reg = lm(New.series ~ New.time))
    
    
    # ============================================================================
    # Descomposición de series
    
    # ---------------------------------
    # 1. Modelo Aditivo
    
    # Se debe elegir entre el modelo aditivo o el modelo multiplicativo cuando sea razonable suponer la descomposición
    # Decompose descompone la serie de tiempo
    Elec.decom.A <- decompose(Elec.ts)
    
    plot(Elec.decom.A, xlab = "Tiempo", 
         sub = "Descomposición de los datos de producción de electricidad")
    
    # Comprobamos la descomposicion manualmente, descomponemos
    # Componentes
    Tendencia <- Elec.decom.A$trend
    Estacionalidad <- Elec.decom.A$seasonal
    Aleatorio <- Elec.decom.A$random
    
    plot(Elec.ts, 
         xlab = "Tiempo", main = "Datos de Producción de Electricidad", 
         ylab = "Producción de electricidad", lwd = 2,
         sub = "Tendencia con efectos estacionales aditivos sobrepuestos")
    lines(Tendencia, lwd = 2, col = "blue")
    lines(Tendencia + Estacionalidad, lwd = 2, col = "red", lty = 2)
    
    # Quitando la serie original vemos que hay un par de huecos, quiza el modelo no es muy bueno
    ts.plot(cbind(Tendencia, Tendencia + Estacionalidad), 
            xlab = "Tiempo", main = "Datos de Producción de Electricidad", 
            ylab = "Producción de electricidad", lty = 1:2, 
            col = c("blue", "red"), lwd = 2,
            sub = "Tendencia con efectos estacionales aditivos sobrepuestos")
    
    # Sumamos los graficos, en este caso un valor puntual y comporbamos que 
    # coincide con el de la serie original, por eso se llama Modelo Aditivo, sumando las componentes
    Tendencia[20] + Estacionalidad[20] + Aleatorio[20]
    Elec.ts[20]
    
    # ------------------------------------------------------------------------------
    # 2. Modelo Multiplicativo
    # Parecido al modelo anterior pero en este caso, en vez de sumar, se suman las componentes
    
    # Decompose por default da aditivo, enconces modifcamos a "mult" para indicar que queremos
    # el modelo multiplicativo
    Elec.decom.M <- decompose(Elec.ts, type = "mult")
    
    plot(Elec.decom.M, xlab = "Tiempo", 
         sub = "Descomposición de los datos de producción de electricidad")
    
    # Hacemos el mismo procedimiento manualmente y comprobamos 
    # multilicando los componentes.
    
    # Componentes
    Trend <- Elec.decom.M$trend
    Seasonal <- Elec.decom.M$seasonal
    Random <- Elec.decom.M$random
    
    plot(Elec.ts, 
         xlab = "Tiempo", main = "Datos de Producción de Electricidad", 
         ylab = "Producción de electricidad", lwd = 2,
         sub = "Tendencia con efectos estacionales multiplicativos sobrepuestos")
    lines(Trend, lwd = 2, col = "blue")
    lines(Trend * Seasonal, lwd = 2, col = "red", lty = 2)
    
    # Notemos que se ajsta mejor este modelo que el anterior, pues la roja con la negra
    # se sobreponen mejor
    
    ts.plot(cbind(Trend, Trend * Seasonal), 
            xlab = "Tiempo", main = "Datos de Producción de Electricidad", 
            ylab = "Producción de electricidad", lty = 1:2, 
            col = c("blue", "red"), lwd = 2,
            sub = "Tendencia con efectos estacionales multiplicativos sobrepuestos")
    
    Trend[100]*Seasonal[100]*Random[100]
    Elec.ts[100]
    
    
    # J. Cryer & K. Chan. (2008). Time Series Analysis With Applications 
    # in R. 233 Spring Street, New York, NY 10013, USA: Springer 
    # Science+Business Media, LLC.
    
    # P. Cowpertwait & A. Metcalfe. (2009). Introductory Time Series with R. 
    # 233 Spring Street, New York, NY 10013, USA: Springer Science+Business 
    # Media, LLC.
    
    
    # ########################################################################
    # Modelos estocásticos básicos y modelos estacionarios
    
    # Simulamos Ruido Blanco y graficamos
    set.seed(1)
    w <- rnorm(100)
    plot(w, type = "l", xlab = "")
    title(main = "Ruido Blanco Gaussiano", xlab = "Tiempo")
    
    
    # Para ilustrar mediante simulación como las muestras pueden diferir 
    # de sus poblaciones subyacentes considere lo siguiente
    
    x <- seq(-3, 3, length = 1000)
    hist(w, prob = T, ylab = "", xlab = "", main = "") 
    points(x, dnorm(x), type = "l")
    title(ylab = "Densidad", xlab = "Valores simulados de la distribución normal estandar",
          main = "Comparación de una muestra con su población subyacente")
    
    # Lo anterior demuestra la definicion de ruido blanco, con media cero se observa en el hist
    
    
    # Funcion de Autocorrelacion Muestral
    acf(w, main = "")
    title(main = "Función de Autocorrelación Muestral", 
          sub = "Valores simulados de la distribución normal estandar")
    
    ###
    
    # Caminata Aleatoria
    # Simulación en R
    
    set.seed(2)
    x <- w <- rnorm(1000)
    for(t in 2:1000) x[t] <- x[t-1] + w[t]
    
    plot(x, type = "l", main = "Caminata Aleatoria Simulada", 
         xlab = "t", ylab = expression(x[t]), 
         sub = expression(x[t]==x[t-1]+w[t]))
    
    acf(x, main = "")
    title(main = "Correlograma para la caminata aleatoria simulada", 
          sub = expression(x[t]==x[t-1]+w[t]))
    
    # El correlograma de las series de diferencias puede usarse para evaluar si una serie dada
    # puede modelarse como una caminata aleatoria
    
    acf(diff(x), main = "")
    title(main = "Correlograma de la serie de diferencias", 
          sub = expression(nabla*x[t]==x[t]-x[t-1]))
    
    # ==============================================================================
    # Modelos AR(p), MA(q) y ARMA(p, q)
    
    # --------------------------------------------
    # 1.Modelos AR(p)
    
    # Correlograma de un proceso AR(1)
    
    rho <- function(k, alpha) alpha^k
    
    plot(0:10, rho(0:10, 0.7), type = "h", ylab = "", xlab = "")
    title(main = "Correlograma para un proceso AR(1)",
          ylab = expression(rho[k] == alpha^k),
          xlab = "lag k",
          sub = expression(x[t]==0.7*x[t-1]+w[t]))
    
    plot(0:10, rho(0:10, -0.7), type = "h", ylab = "", xlab = "")
    title(main = "Correlograma para un proceso AR(1)",
          ylab = expression(rho[k] == alpha^k),
          xlab = "lag k",
          sub = expression(x[t]==-0.7*x[t-1]+w[t]))
    abline(h = 0)
    
    ###
    
    # Simulación en R
    
    # Un proceso AR(1) puede ser simulado en R como sigue:
    
    set.seed(1)
    x <- w <- rnorm(100)
    for(t in 2:100) x[t] <- 0.7 * x[t-1] + w[t]
    
    plot(x, type = "l", xlab = "", ylab = "")
    title(main = "Proceso AR(1) simulado",
          xlab = "Tiempo",
          ylab = expression(x[t]),
          sub = expression(x[t]==0.7*x[t-1]+w[t]))
    
    #
    
    acf(x, main = "")
    title(main = "Correlograma del proceso AR(1) simulado", 
          sub = expression(x[t]==0.7*x[t-1]+w[t]))
    
    #
    
    pacf(x, main = "")
    title(main = "Correlograma Parcial del proceso AR(1) simulado", 
          sub = expression(x[t]==0.7*x[t-1]+w[t]))
    
    ###

    # Modelos Ajustados
    
    # Ajuste de modelos a series simuladas
    
    x.ar <- ar(x, method = "mle")
    x.ar$order
    x.ar$ar
    x.ar$ar + c(-2, 2)*sqrt(x.ar$asy.var)
    
    # Serie de temperaturas globales, expresadas como anomalías de las medias mensuales: Ajuste de un modelo AR
    
    Global <- scan("global.txt")
    Global.ts <- ts(Global, st = c(1856, 1), end = c(2005, 12), fr = 12)
    Global.annual <- aggregate(Global.ts, FUN = mean)
    
    plot(Global.ts, xlab = "Tiempo", ylab = "Temperatura en °C", 
         main = "Serie de Temperatura Global",
         sub = "Serie mensual: Enero de 1856 a Diciembre de 2005")
    
    plot(Global.annual, xlab = "Tiempo", ylab = "Temperatura en °C", 
         main = "Serie de Temperatura Global",
         sub = "Serie anual de temperaturas medias: 1856 a 2005")
    
    #
    
    mean(Global.annual)
    Global.ar <- ar(Global.annual, method = "mle")
    Global.ar$order
    Global.ar$ar
    
    acf(Global.ar$res[-(1:Global.ar$order)], lag = 50, main = "")
    title(main = "Correlograma de la serie de residuales",
          sub = "Modelo AR(4) ajustado a la serie de temperaturas globales anuales")
    
    # ---------------------------------------------------------------------------
    # Modelos MA(q)
    
    # Ejemplos en R: Correlograma y Simulación
    # Función en R para calcular la Función de Autocorrelación
    
    rho <- function(k, beta){
        q <- length(beta) - 1
        if(k > q) ACF <- 0 else {
            s1 <- 0; s2 <- 0
            for(i in 1:(q-k+1)) s1 <- s1 + beta[i]*beta[i + k]
            for(i in 1:(q+1)) s2 <- s2 + beta[i]^2
            ACF <- s1/s2}
        ACF}
    
    # Correlograma para un proceso MA(3)
    
    beta <- c(1, 0.7, 0.5, 0.2)
    rho.k <- rep(1, 10)
    for(k in 1:10) rho.k[k] <- rho(k, beta)
    
    plot(0:10, c(1, rho.k), ylab = expression(rho[k]), xlab = "lag k", type = "h",
         sub = expression(x[t] == w[t] + 0.7*w[t-1] + 0.5*w[t-2] + 0.2*w[t-3]),
         main = "Función de autocorrelación para un proceso MA(3)")
    abline(0, 0)
    
    # Correlograma para otro proceso MA(3)
    
    beta <- c(1, -0.7, 0.5, -0.2)
    rho.k <- rep(1, 10)
    for(k in 1:10) rho.k[k] <- rho(k, beta)
    
    plot(0:10, c(1, rho.k), ylab = expression(rho[k]), xlab = "lag k", type = "h",
         sub = expression(x[t] == w[t] - 0.7*w[t-1] + 0.5*w[t-2] - 0.2*w[t-3]),
         main = "Función de autocorrelación para un proceso MA(3)")
    abline(0, 0)
    
    # ------------------------------------------------------------------------------
    # Simulación de un proceso MA(3)
    
    set.seed(1)
    b <- c(0.8, 0.6, 0.4)
    x <- w <- rnorm(1000)
    for(t in 4:1000){
        for(j in 1:3) x[t] <- x[t] + b[j]*w[t-j]
    }
    
    plot(x, type = "l", ylab = expression(x[t]), xlab = "Tiempo t",
         sub = expression(x[t] == w[t] + 0.8*w[t-1] + 0.6*w[t-2] + 0.4*w[t-3]),
         main = "Serie de tiempo simulada de un proceso MA(3)")
    
    ###
    
    acf(x, main = "")
    title(main = "Correlograma para un proceso MA(3) simulado", 
          sub = expression(x[t] == w[t] + 0.8*w[t-1] + 0.6*w[t-2] + 0.4*w[t-3]))
    
    # -
    
    # Ajuste de modelos MA 
    
    x.ma <- arima(x, order = c(0, 0, 3))
    x.ma
    
    ####################################################################################################################################################
    
    # Modelos ARMA(p, q)
    
    
    # Simulación y Ajuste
    
    set.seed(1)
    x <- arima.sim(n = 10000, list(ar = -0.6, ma = 0.5))
    
    plot(x[1:100], type = "l", xlab = "")
    title(main = "Serie simulada", xlab = "Tiempo", 
          sub = expression(x[t] == -0.6*x[t-1] + w[t] + 0.5*w[t-1]))
    
    #
    
    coef(arima(x, order = c(1, 0, 1)))
    
    # Inspirado en:
    
    # P. Cowpertwait & A. Metcalfe. (2009). Introductory Time Series with R. 233 Spring Street, New York, NY 10013, USA: Springer Science+Business Media, LLC.
    
    # Otra referencia:
    
    # J. Cryer & K. Chan. (2008). Time Series Analysis With Applications in R. 233 Spring Street, New York, NY 10013, USA: Springer Science+Business Media, LLC.
    
    
    
    
    
    
    
    
    
    
    
    