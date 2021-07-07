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
    
    # Ruido Blanco y simulación en R
    
    set.seed(1)
    w <- rnorm(100)
    plot(w, type = "l", xlab = "")
    title(main = "Ruido Blanco Gaussiano", xlab = "Tiempo")
    
    ###
    
    # Para ilustrar mediante simulación como las muestras pueden diferir 
    # de sus poblaciones subyacentes considere lo siguiente
    
    x <- seq(-3, 3, length = 1000)
    hist(w, prob = T, ylab = "", xlab = "", main = "") 
    points(x, dnorm(x), type = "l")
    title(ylab = "Densidad", xlab = "Valores simulados de la distribución normal estandar",
          main = "Comparación de una muestra con su población subyacente")
    
    ###
    
    acf(w, main = "")
    title(main = "Función de Autocorrelación Muestral", 
          sub = "Valores simulados de la distribución normal estandar")
    
    # ===========================================================
    
    # Caminata Aleatoria
    # Simulación en R
    
    set.seed(2)
    x <- w <- rnorm(1000)
    for(t in 2:1000) x[t] <- x[t-1] + w[t]
    
    plot(x, type = "l", main = "Caminata Aleatoria Simulada", 
         xlab = "t", ylab = expression(x[t]), 
         sub = expression(x[t]==x[t-1]+w[t]))
    
    # Correlograma de la Caminata aleatoria
    acf(x, main = "")
    title(main = "Correlograma para la caminata aleatoria simulada", 
          sub = expression(x[t]==x[t-1]+w[t]))
    
    # El correlograma de las series de diferencias puede usarse para evaluar si una serie dada
    # puede modelarse como una caminata aleatoria
    # La correlacion es muy fuerte debido a los lags, se tiene informacion de la variable anterior
    
    # Correglograma de la Serie de Diferencias
    acf(diff(x), main = "")
    title(main = "Correlograma de la serie de diferencias", 
          sub = expression(nabla*x[t]==x[t]-x[t-1]))
    # Notemos que se obtendra un ruido blanco pues las diferencias tendremos:
    # Xt = (Xt-1 + Wt) - Xt-1 --> Xt = Wt (Solo nos quedara el ruido blanco)
    
    
    #################################################################################
    # Modelos AR(p), MA(q) y ARMA(p, q)
    
    # -----------------------------------------------------
    # Modelo Autoregresivo de orden p
    # Modelos AR(p)
    
    # Correlograma de un proceso AR(1)
    # Definimos una funcion de correlacion
    rho <- function(k, alpha) alpha^k # K es el lag (es una funcion exponencial)
    
    # Ploteo de un modelo Autoregresivo con parametro alpha
    plot(0:10, rho(0:10, 0.7), type = "h", ylab = "", xlab = "")
    title(main = "Correlograma para un proceso AR(1)",
          ylab = expression(rho[k] == alpha^k),
          xlab = "lag k",
          sub = expression(x[t]==0.7*x[t-1]+w[t]))
    
    # Ploteamos con parametro alpha negativo
    # Ya que al ser exponencial unos nos daran positivos y otros negativos(por pares e impares)
    plot(0:10, rho(0:10, -0.7), type = "h", ylab = "", xlab = "")
    title(main = "Correlograma para un proceso AR(1)",
          ylab = expression(rho[k] == alpha^k),
          xlab = "lag k",
          sub = expression(x[t]==-0.7*x[t-1]+w[t]))
    abline(h = 0)
    
    
    # =======================================================================
    # Simulación en R
    # Un proceso AR(1) puede ser simulado en R como sigue:
    
    set.seed(1)
    x <- w <- rnorm(100)
    for(t in 2:100) x[t] <- 0.7 * x[t-1] + w[t] #aplha = 0.7
    
    # Graficamos el modelo AR(1)
    plot(x, type = "l", xlab = "", ylab = "")
    title(main = "Proceso AR(1) simulado",
          xlab = "Tiempo",
          ylab = expression(x[t]),
          sub = expression(x[t]==0.7*x[t-1]+w[t]))
    # Veamos que tiene media cero y varianza constante(que queda dentro de las bandas de la Z)
    
    # Calulamos correlograma
    # acf = autocorrelation function
    acf(x, main = "")
    title(main = "Correlograma del proceso AR(1) simulado", 
          sub = expression(x[t]==0.7*x[t-1]+w[t]))
    
    # Hay un poco de duda con el correlograma anterior pues 3 variables quedan fuera de las bandas
    
    # Correlograma parcial
    # pacf = partial autocorrelation function
    pacf(x, main = "")
    title(main = "Correlograma Parcial del proceso AR(1) simulado", 
          sub = expression(x[t]==0.7*x[t-1]+w[t]))
    # Con el correlograma parcial vemos que no queda duda de que necesitamos un AR(1)
    # Pues todas las variables excepto una quedan dentro de las bandas de correlacion cero
    
    
    # ==============================================================================
    # Modelos Ajustados
    
    # Ajuste de modelos a series simuladas
    # Los modelos AR(p) se ajustan con ar() con metodo de maxima verosimilitud "mle"
    x.ar <- ar(x, method = "mle")
    x.ar$order # nos da la p = 1  (de orden 1)
    x.ar$ar # valor del parametro k (nosotros pusimos uno de 0.7)
    x.ar$ar + c(-2, 2)*sqrt(x.ar$asy.var) # Calculo del intervalo de confianza
    # El parametro a estimar se debe encontrar dentro de rango
    # Entonces proponemos un modelo una vez que conocesmo lo anterior
    
    # ===================================================================================
    # Serie de temperaturas globales, expresadas como anomalías de las medias mensuales: Ajuste de un modelo AR
    
    # Usamos scan para lee archivos txt
    Global <- scan("data/global.txt")
    
    # Graficamos
    plot(Global.ts, xlab = "Tiempo", ylab = "Temperatura en °C", 
         main = "Serie de Temperatura Global",
         sub = "Serie mensual: Enero de 1856 a Diciembre de 2005")
    
    # Convertimos a series de tiempo
    Global.ts <- ts(Global, st = c(1856, 1), end = c(2005, 12), fr = 12)
    
    # Calculo de correlogramas
    acf(Global, main = "ACF Global Temp")
    pacf(Global, main = "PACF Global Temp") # Se oberva que puede ser de orden > 1
    
    # Con aggregate se aplica la funcion promedio para generar la serie de promedios moviles
    # La cual nos sirve para suavizar la serie
    Global.annual <- aggregate(Global.ts, FUN = mean)
    
    # Graficamos
    plot(Global.annual, xlab = "Tiempo", ylab = "Temperatura en °C", 
         main = "Serie de Temperatura Global",
         sub = "Serie anual de temperaturas medias: 1856 a 2005")
    
    
    mean(Global.annual)
    
    # Aplicamos un modelo AR bajo el metodo mle = maximaverosimilitud y vemos de que orden es
    Global.ar <- ar(Global.annual, method = "mle")
    Global.ar$order # AR(4)  Xt = a1Xt-1 + a2Xt-2 + .. a4Xt-4 + Wt (Wt = ruido blanco)
    Global.ar$ar # parametros de las 4 variables (aplhas)
    
    # Observamos los residuales que siempre deben tener distribucion normal
    hist(Global.ar$resid)
    
    # Corrlograma de los residales del modelo
    # Sabemos que el correlograma es correcto si el correlograma corresponde al de
    # un correlograma de ruido blanco, datos que no tiene conrrelacion (caen dentro de las bandas)
    acf(Global.ar$res[-(1:Global.ar$order)], lag = 50, main = "")
    title(main = "Correlograma de la serie de residuales",
          sub = "Modelo AR(4) ajustado a la serie de temperaturas globales anuales")
    

    ####################################################################################################################################################
    # Modelos de Medias Moviles
    # Modelos MA(q)
    
    # Función en R para calcular la Función de Autocorrelación
    # Creamos la funcion para medias moviles
    rho <- function(k, beta){
        q <- length(beta) - 1
        if(k > q) ACF <- 0 else {
            s1 <- 0; s2 <- 0
            for(i in 1:(q-k+1)) s1 <- s1 + beta[i]*beta[i + k]
            for(i in 1:(q+1)) s2 <- s2 + beta[i]^2
            ACF <- s1/s2}
        ACF}
    
    
    # Correlograma para un proceso MA(3)
    beta <- c(1, 0.7, 0.5, 0.2) # Definimos parametros
    rho.k <- rep(1, 10) # Generamos vector de unos
    for(k in 1:10) rho.k[k] <- rho(k, beta)
    
    # Graficamos correlograma
    plot(0:10, c(1, rho.k), ylab = expression(rho[k]), xlab = "lag k", type = "h",
         sub = expression(x[t] == w[t] + 0.7*w[t-1] + 0.5*w[t-2] + 0.2*w[t-3]),
         main = "Función de autocorrelación para un proceso MA(3)")
    abline(0, 0)
    
    # Correlograma para otro proceso MA(3) con betas negativos
    beta <- c(1, -0.7, 0.5, -0.2)
    rho.k <- rep(1, 10)
    for(k in 1:10) rho.k[k] <- rho(k, beta)
    
    plot(0:10, c(1, rho.k), ylab = expression(rho[k]), xlab = "lag k", type = "h",
         sub = expression(x[t] == w[t] - 0.7*w[t-1] + 0.5*w[t-2] - 0.2*w[t-3]),
         main = "Función de autocorrelación para un proceso MA(3)")
    abline(0, 0)
    
    # ------------------------------------------------------------------  
    # Simulación de un proceso MA(3)
    set.seed(1)
    b <- c(0.8, 0.6, 0.4)
    x <- w <- rnorm(1000)
    for(t in 4:1000){
        for(j in 1:3) x[t] <- x[t] + b[j]*w[t-j] # j son los lags
    }
    
    # Garficamos el modelo
    plot(x, type = "l", ylab = expression(x[t]), xlab = "Tiempo t",
         sub = expression(x[t] == w[t] + 0.8*w[t-1] + 0.6*w[t-2] + 0.4*w[t-3]),
         main = "Serie de tiempo simulada de un proceso MA(3)")
    # Observmos media cero y varianza constante
    
    # Calculo del correlograma
    acf(x, main = "")
    title(main = "Correlograma para un proceso MA(3) simulado", 
          sub = expression(x[t] == w[t] + 0.8*w[t-1] + 0.6*w[t-2] + 0.4*w[t-3]))
    # Se observa que si es un MA(3)
    
    # --------------------------------------------------------------------------
    # Ajuste de modelos MA 
    # Usamos la funcion arima de orden 3 ARIMA = Autoregresivo Integrado de medias moviles
    x.ma <- arima(x, order = c(0, 0, 3)) #order = c(AR, diferencias, orden) diferencias = 0 pues no queremos eso
    x.ma
    # Vemos que los parametros que teniamos (0.8, 0.6 y 0.4) se acercan mucho 
    # a los resultados obtenidos (0.78, 0.56, 0.39)

    ####################################################################################################################################################
    # Modelos Autorregresivos de medias moviles (combinamos AR y MA)
    # Modelos ARMA(p, q)
    
    
    # Simulación y Ajuste: ARMA(1, 1)  = AR(1) y MA(1)
    set.seed(1)
    # Con arima.sim() simula el modelo arima y le pasamos parametro ar = AR, ma= promedios moviles
    x <- arima.sim(n = 10000, list(ar = -0.6, ma = 0.5))
    
    #Graficamos sólo 100 datos
    plot(x[1:100], type = "l", xlab = "")
    title(main = "Serie simulada", xlab = "Tiempo", 
          sub = expression(x[t] == -0.6*x[t-1] + w[t] + 0.5*w[t-1]))
    
    # Ajustamos un modelo con arima de orden 1 para AR y 1 para MA
    # y vemos coeficientes
    coef(arima(x, order = c(1, 0, 1)))
    
    # Inspirado en:
    # P. Cowpertwait & A. Metcalfe. (2009). Introductory Time Series with R. 233 Spring Street, New York, NY 10013, USA: Springer Science+Business Media, LLC.
    # Otra referencia:
    # J. Cryer & K. Chan. (2008). Time Series Analysis With Applications in R. 233 Spring Street, New York, NY 10013, USA: Springer Science+Business Media, LLC.
    
    