    # ##########################################################################
    #                        Sesion_6 retos
    #                     Lizzeth Gomez Ridriguez
    # ########################################################################### 
    
    # Reto 1. Proceso AR(1)
    
    # 1. Simule un proceso AR(1) de la forma x[t] = 0.5 * x[t-1] + w[t] para
    # t = 1, 2, ..., 200 y muestre gráficamente la serie de tiempo obtenida
    
    # 2. Obtenga el correlograma y el correlograma parcial del proceso AR(1)
    # simulado
    
    # 3. Ajuste un modelo autorregresivo a la serie simulada utilizando la
    # función ar, observe el orden del módelo y el parámetro 
    # estimado (los paramétros estimados) 
    
    # 1. Simulacion
    set.seed(1)
    x <- w <- rnorm(200)
    for(t in 2:200) x[t] <- 0.5 * x[t-1] + w[t] #aplha = 0.5
    
    # Graficamos el modelo AR(1)
    plot(x, type = "l", xlab = "", ylab = "")
    title(main = "Proceso AR(1) simulado",
          xlab = "Tiempo",
          ylab = expression(x[t]),
          sub = expression(x[t]==0.5*x[t-1]+w[t]))
    
    # 2. Calulamos correlograma
    # acf = autocorrelation function
    acf(x, main = "")
    title(main = "Correlograma del proceso AR(1) simulado", 
          sub = expression(x[t]==0.5*x[t-1]+w[t]))
    
    # Sacamos el parcial
    pacf(x, main = "")
    title(main = "Correlograma del proceso AR(1) simulado", 
          sub = expression(x[t]==0.5*x[t-1]+w[t]))
    
    # 3. Ajuste del modelo
    x.ar <- ar(x, method = "mle")
    x.ar$order # nos da la p = 1  (de orden 1)
    x.ar$ar # valor del parametro k (nosotros pusimos uno de 0.4)
    x.ar$ar + c(-2, 2)*sqrt(x.ar$asy.var) # Calculo del intervalo de confianza
    