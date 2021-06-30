    
    # Reto 1. Regresión Lineal Múltiple
    
    # Supongamos que nuestro trabajo consiste en aconsejar a un cliente sobre 
    # como mejorar las ventas de un producto particular, y el conjunto de datos 
    # con el que disponemos son datos de publicidad que consisten en las ventas 
    # de aquel producto en 200 diferentes mercados, junto con presupuestos de 
    # publicidad para el producto en cada uno de aquellos mercados para tres 
    # medios de comunicación diferentes: TV, radio, y periódico. No es posible 
    # para nuestro cliente incrementar directamente las ventas del producto. Por 
    # otro lado, ellos pueden controlar el gasto en publicidad para cada uno de 
    # los tres medios de comunicación. Por lo tanto, si determinamos que hay una 
    # asociación entre publicidad y ventas, entonces podemos instruir a nuestro 
    # cliente para que ajuste los presupuestos de publicidad, y así 
    # indirectamente incrementar las ventas. En otras palabras, nuestro objetivo 
    # es desarrollar un modelo preciso que pueda ser usado para predecir las 
    # ventas sobre la base de los tres presupuestos de medios de comunicación.
    
    # 1. Ajuste modelos de regresión lineal múltiple a los datos 
    # advertisement.csv y elija el modelo "más adecuado" siguiendo los 
    # procedimientos vistos en el Ejemplo 1.
    
    data <- read.csv("data/advertising.csv")
    str(data)
    attach(data)
    
    pairs(~ Sales + TV + Radio + Newspaper, data, gap = 0.4, cex.labels = 1.5)
    
    # Corremos el modelo
    m1 <- lm(Sales ~ TV + Radio + Newspaper)
    summary(m1)
    
    
    # Ajustamos
    m2 <- update(m1, ~. -Newspaper)
    summary(m2)
   
    plot(m2$fitted.values, Sales, xlab = "Valores ajustados", ylab = "Price")
    abline(lsfit(m2$fitted.values, Sales))
    
    
    StanRes2 <- rstandard(m2)
    par(mfrow = c(2, 2)) # Creamos grid de 2x2
    plot(TV, StanRes2, ylab = "Residuales Estandarizados")
    plot(Radio, StanRes2, ylab = "Residuales Estandarizados")
    plot(Newspaper, StanRes2, ylab = "Residuales Estandarizados")
    
    qqnorm(StanRes2) # Distribucion de los errores
    qqline(StanRes2)
        
    hist(StanRes2)
    dev.off()
    
    shapiro.test(StanRes2) # p-value < 0.05, por lo tanto no se acepta Ho  
    # no hay normalidad en los datos
    