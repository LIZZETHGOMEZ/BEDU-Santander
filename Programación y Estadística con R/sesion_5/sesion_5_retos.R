        
    # ##########################################################################
    #                         Sesion_5 RETOS
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################

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
    
    # Graficamos correlacion de las variables
    pairs(~ Sales + TV + Radio + Newspaper, data, gap = 0.4, cex.labels = 1.5)
    
    # Corremos el modelo de regresion lineal
    m1 <- lm(Sales ~ TV + Radio + Newspaper)
    summary(m1)
    
    
    # Ajustamos el modelo eliminando la variable Newspaper por falta de significancia estadistica
    m2 <- update(m1, ~. -Newspaper)
    summary(m2)
   
    # Graficamos la regresion lienal
    plot(m2$fitted.values, Sales, xlab = "Valores ajustados", ylab = "Price")
    abline(lsfit(m2$fitted.values, Sales))
    
    # Veamos la distribucion de los residuos estandarizados para cada variable predictora
    StanRes2 <- rstandard(m2)
    par(mfrow = c(2, 2)) # Creamos grid de 2x2
    plot(TV, StanRes2, ylab = "Residuales Estandarizados")
    plot(Radio, StanRes2, ylab = "Residuales Estandarizados")
    plot(Newspaper, StanRes2, ylab = "Residuales Estandarizados")
    
    # Distribucion de los errores
    qqnorm(StanRes2)
    qqline(StanRes2)
        
    hist(StanRes2)
    dev.off()
    
    # Prueba de Normalidad
    shapiro.test(StanRes2) # p-value < 0.05, por lo tanto no se acepta Ho  
    # no hay normalidad en los datos
    
    
    # =========================================================================
    # Reto 2. Máquinas de vectores de soporte
    
    # En el archivo de datos csv adjunto se encuentran observaciones correspondientes a dos clases diferentes indicadas por la variable y. 
    # Únicamente hay dos variables predictoras o características. Realice lo siguiente:
    
    # 1. Cargue los paquetes ggplot2 y e1071; observe algunas características del data frame con las funciones tail y dim. 
    # Obtenga el gráfico de dispersión de los datos diferenciando las dos clases.
    # 2. Genere de manera aleatoria un vector de índices para filtrar un conjunto de entrenamiento a partir del conjunto de datos dado. 
    # Con ayuda de las funciones tune y svm ajuste máquinas de vectores de soporte con un kernel radial a los datos de entrenamiento, para valores del parámetro cost igual a 0.1, 1, 10, 100, 1000 y valores del parámetro gamma igual a 0.5, 1, 2, 3, 4. Obtenga un resumen de los resultados.
    # 3. Con el modelo que tuvo el mejor desempeño en el paso anterior realice clasificación con la función predict y el conjunto de datos de prueba.
    # Muestre la matriz de confusión.
    
    library(ggplot2)
    library(e1071)
    
    data <- read.csv("data/datosclases.csv")
    tail(data)
    dim(data)
    
    data <- data %>% mutate(y = as.factor(y))
    
    data %>% ggplot() +
        aes(x.1, x.2, colour = y) +
        geom_point()
    
    data %>% ggplot() +
        aes(x.1, x.2, colour = y) +
        geom_point() +
        facet_wrap("y")
    
    
    set.seed(2020)
    # sample(data, size) 
    train = sample(nrow(data), round(nrow(data)/2))
    tail(data[train, ])
    
    ggplot(data[train, ], 
           aes(x.1, x.2, colour = y)) + 
        geom_point() + facet_wrap('y') + 
        theme_bw() + ggtitle("Conjunto de entrenamiento")
    
    # Ahora el complemento, (todos los que no sean train)
    ggplot(data[-train, ], 
           aes(x.1,x.2, colour = y)) + 
        geom_point() + facet_wrap('y') + 
        theme_light() + ggtitle("Conjunto de prueba")
    
    
    
    # Modelamos
    tune.rad = tune(svm, y~., data[train,],
                    kernel = "radial",
                    ranges = list(cost = c(0.1, 1, 10, 100, 1000),gamma = c(0.5, 1, 2, 3, 4))
    )
    
    summary(tune.rad)
    tune.rad$best.model # Sacamos el mejor modelo
    
    best <- svm(y~.,  data = data[train,],
                kernel = "radial",
                cost = 1,
                gamma = 1.5
    )
    
    
    mc <- table(true = data[-train, "y"], 
                pred = predict(best, 
                               newdata = data[-train,])) 
    mc
    
    round(sum(diag(mc))/sum(colSums(mc)), 5)
    
    rs <- apply(mc, 1, sum)
    r1 <- round(mc[1,]/rs[1], 5)
    r2 <- round(mc[2,]/rs[2], 5)
    rbind(No = r1, Yes = r2)
    
    # Ajustamos
    fit <- svm(default ~ ., data = Default[train,], 
               kernel = "radial", cost = 0.1, gamma = 1.51,
               decision.values = TRUE)
   
    
    