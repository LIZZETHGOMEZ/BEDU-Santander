        
    # ##########################################################################
    #                       Sesion_4 POSTWORK
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################

    # Regresión Lineal Múltiple
    
    # Predecir el precio de cena (platillo). 
    # Datos de encuestas de clientes de 168 restaurantes Italianos
    # en el área deseada están disponibles.
    
    # Y: Price (Precio): el precio (en USD) de la cena
    # X1: Food: Valuación del cliente de la comida (sacado de 30)
    # X2: Décor: Valuación del cliente de la decoración (sacado de 30)
    # X3: Service: Valuación del cliente del servicio (sacado de 30)
    # X4: East: variable dummy: 1 (0) si el restaurante está al este (oeste) de la quinta avenida
    
    # Primero debemos establecer nuestro directorio de trabajo y el archivo
    # de datos (nyc.csv) que importaremos a R deberá de estar en este directorio
    
    setwd("~/BEDU_Santander/Programación y Estadística con R/sesion_5")
    nyc <- read.csv("data/nyc.csv", header = TRUE)
    
    # Observamos algunas filas y la dimensión del data frame
    tail(nyc, 2) 
    dim(nyc)
    attach(nyc) # Para llamar unicamente el nombre de la variable dentro de un df
    # Sin necesidad de usar "$"
    # detach(nyc)
    
    # Matriz de gráficos de dispersión de todas las variables
    pairs(~ Price + Food + Decor + Service, data = nyc, gap = 0.4, cex.labels = 1.5)
    
    # Observamos relaciones aproximadamente lineales
    # Veamos algunas correlaciones
    cor(Price, Food)
    
    # Llevamos a cabo el ajuste de un modelo # lm (lineal model)
    # Y = beta0 + beta1*Food + beta2*Decor + beta3*Service + beta4*East + e
    # Price es la variable dependeinte
    m1 <- lm(Price ~ Food + Decor + Service + East)
    
    # Obtenemos un resumen
    summary(m1)
    
    # Ajustamos nuevamente un modelo pero ahora sin considerar la variable Service
    # ya que en el resultado anterior se observó que su coeficiente de regresión
    # no fue estadísticamente significativo (p-value > 0.05)
    
    # Y = beta0 + beta1*Food + beta2*Decor + beta4*East + e (Reducido)
    
    m2 <- lm(Price ~ Food + Decor + East)
    
    # Obtenemos un resumen del modelo ajustado
    summary(m2)
    
    # Una forma alternativa de obtener m2 es usar el comando update
    m2 <- update(m1, ~.-Service)
    summary(m2)
    
    # =========================================================================
    # Análisis de covarianza
    
    # Para investigar si el efecto de los predictores depende de la variable dummy 
    # East consideraremos el siguiente modelo el cual es una extensión a más de una 
    # variable predictora del modelo de rectas de regresión no relacionadas 
    # Y = beta0 + beta1*Food + beta2*Decor +  beta3*Service + beta4*East 
    #           + beta5*Food*East + beta6*Decor*East + beta7*Service*East + e (Completo)
    
    # Agregamos termino de interaccion con ":"
    mfull <- lm(Price ~ Food + Decor + Service + East + 
                  Food:East + Decor:East + Service:East)
    
    # Note como ninguno de los coeficientes de regresión para los
    # términos de interacción son estadísticamente significativos
    
    summary(mfull)
    
    # Ahora compararemos el modelo completo guardado en mfull contra el modelo
    # reducido guardado en m2. Es decir, llevaremos a cabo una prueba de hipótesis
    # general de
    
    # H0: beta3 = beta5 = beta6 = beta7 = 0
    # es decir Y = beta0 + beta1*Food + beta2*Decor + beta4*East + e (Reducido)
    # contra
    # H1: H0 no es verdad
    # es decir, 
    # Y = beta0 + beta1*Food + beta2*Decor +  beta3*Service + beta4*East 
    #           + beta5*Food*East + beta6*Decor*East + beta7*Service*East + e (Completo)
    
    # La prueba de si el efecto de los predictores depende de la variable dummy
    # East puede lograrse usando la siguiente prueba-F parcial.
    anova(m2, mfull) 
    
    # El valor F es > 0.05, se acepta Ho, El modelo reducido es el mejor.

    
    # ==============================================================================
    # Diagnósticos
    
    # En regresión múltiple, las gráficas de residuales o de residuales
    # estandarizados proporcionan información directa sobre la forma
    # en la cual el modelo está mal especificado cuando se cumplen
    # las siguientes dos condiciones:
    
    # E(Y | X = x) = g(beta0 + beta1*x1 + ... + betap*xp) y
    # E(Xi | Xj) aprox alpha0 + alpha1*Xj
    
    # Cuando estas condiciones se cumplen, la gráfica de Y contra
    # los valores ajustados, proporciona información directa acerca de g.
    # En regresión lineal múltiple g es la función identidad. En
    # este caso la gráfica de Y contra los valores ajustados
    # debe producir puntos dispersos alrededor de una recta.
    # Si las condiciones no se cumplen, entonces un patrón en la
    # gráfica de los residuales indica que un modelo incorrecto
    # ha sido ajustado, pero el patrón mismo no proporciona 
    # información directa sobre como el modelo está mal específicado.
    
    # Ahora tratemos de verificar si el modelo ajustado es un modelo válido.
    
    summary(m2)
    
    # Mostramos una gráfica de Y, el precio contra los valores
    # ajustados 
    
    plot(m2$fitted.values, Price, xlab = "Valores ajustados", ylab = "Price")
    abline(lsfit(m2$fitted.values, Price))
    
    # Acontinuación mostramos una matriz de gráficos de dispersión de los
    # dos predictores continuos. Los predictores parecen estar linealmente
    # relacionados al menos aproximadamente
    
    pairs(~ Food + Decor, data = nyc, gap = 0.4, cex.labels = 1.5)
    
    
    # Acontinuación veremos gráficas de residuales estandarizados contra cada
    # predictor. La naturaleza aleatoria de estas gráficas es un indicativo de
    # que el modelo ajustado es un modelo válido para los datos.
    
    StanRes2 <- rstandard(m2)
    par(mfrow = c(2, 2)) # Creamos grid de 2x2
    plot(Food, StanRes2, ylab = "Residuales Estandarizados")
    plot(Decor, StanRes2, ylab = "Residuales Estandarizados")
    plot(East, StanRes2, ylab = "Residuales Estandarizados")
    # Vemos que np hay patrones en los residuos y ademas estan contenidos
    
    # Buscamos evidencia para soportar la supocisión de normalidad en los errores 
    
    qqnorm(StanRes2) # Distribucion de los errores
    qqline(StanRes2)
    # Notemos que los errores estan cerca de la linea, es decir que se distribuyen 
    # de forma normal
    
    hist(StanRes2) #Se observa que si hay distribucion normal
    dev.off()
    
    # Prueba de distribucion normal de los residuales de Shapiro-Wick
    # Ho = es normal 
    shapiro.test(StanRes2) # p-value > 0.05, por lo tanto se acepta Ho
    
    # Inspirado en:
    # [S.J. Sheather, A Modern Approach to Regression with R, DOI: 10.1007/978-0-387-09608-7_2, © Springer Science + Business Media LLC 2009](https://gattonweb.uky.edu/sheather/book/index.php)
    
    
    
    
    
    
    
    # ==================================================================================
    # MÁQUINAS DE VECTORES DE SOPORTE (SVM)
    # (Compañía de tarjetas de crédito)
    
    # Paquetes de R utilizados
    
    library(dplyr)
    library(e1071)
    library(ggplot2)
    # install.packages("ISLR")
    library(ISLR)
    
    # 1. Observemos algunas características del data frame Default del paquete ISLR, con funciones tales como head, tail, dim y str.
    
    ?Default
    head(Default)
    tail(Default)
    dim(Default)
    str(Default)
    
    # 2. Usando ggplot del paquete ggplot2, realicemos un gráfico de dispersión con la variable balance en el eje x, la variable income en el eje y, diferenciando las distintas categorías en la variable default usando el argumento colour. Lo anterior para estudiantes y no estudiantes usando facet_wrap.
    
    ggplot(Default, aes(x = balance, y = income, colour = default)) + 
        geom_point() + facet_wrap('student') + 
        theme_grey() + ggtitle("Datos Default")
    
    # 3. Generemos un vector de índices llamado train, tomando de manera aleatoria 5000 números de los primeros 10,000 números naturales, esto servirá para filtrar el conjunto de entrenamiento y el conjunto de prueba del data frame Default. Realicemos el gráfico de dispersión análogo al punto 2, pero para los conjuntos de entrenamiento y de prueba.
    
    set.seed(2020)
    # sample(data, size)
    train = sample(nrow(Default), round(nrow(Default)/2))
    tail(Default[train, ])
    
    ggplot(Default[train, ], 
           aes(x = balance, y = income, colour = default)) + 
        geom_point() + facet_wrap('student') + 
        theme_bw() + ggtitle("Conjunto de entrenamiento")
    
    # Ahora el complemento, (todos los que no sean train)
    ggplot(Default[-train, ], 
           aes(x = balance, y = income, colour = default)) + 
        geom_point() + facet_wrap('student') + 
        theme_light() + ggtitle("Conjunto de prueba")
    
    # 4. Ahora utilicemos la función tune junto con la función svm para seleccionar el mejor modelo de un conjunto de modelos, los modelos considerados serán aquellos obtenidos al variar los valores de los parámetros cost y gamma (usaremos un kernel radial).
    
    # Ahora utilizamos la función `tune` junto con la función `svm` para 
    # seleccionar el mejor modelo de un conjunto de modelos, los modelos 
    # considerados son aquellos obtenidos al variar los valores de los 
    # parámetros `cost` y `gamma`. Kernel Radial
    
    
    tune.rad = tune(svm, default~., data = Default[train,],
                   kernel = "radial",
                   ranges = list(
                     cost = c(0.1, 1, 10, 100, 1000),
                     gamma = seq(0.01, 10, 0.5)
                   )
    )
    
    # Arroja cost = 100 y gamma = 151
    
    # Se ha elegido el mejor modelo utilizando *validación cruzada de 10 
    # iteraciones*
    
    # summary(tune.rad)
    
    # Aquí un resumen del modelo seleccionado
    
    # summary(tune.rad$best.model)
    
    # A continuación solo usamos los valores de cost y gamma que producen el menor error de prueba estimado, considerando los conjuntos de valores en el código anterior
    
    best <- svm(default~.,  data = Default[train,],
                kernel = "radial",
                cost = 100,
                gamma = 1.51
    )
    
    # 5. Con el mejor modelo seleccionado y utilizando el conjunto de prueba, obtengamos una matriz de confusión, para observar el número de aciertos y errores cometidos por el modelo. También obtengamos la proporción total de aciertos y la matriz que muestre las proporciones de aciertos y errores cometidos pero por categorías.
    
    mc <- table(true = Default[-train, "default"], 
                pred = predict(best, 
                               newdata = Default[-train,]))
    mc
    
    # El porcentaje total de aciertos obtenido por el modelo usando el 
    # conjunto de prueba es el siguiente
    
    round(sum(diag(mc))/sum(colSums(mc)), 5)
    
    # Ahora observemos las siguientes proporciones
    
    rs <- apply(mc, 1, sum)
    r1 <- round(mc[1,]/rs[1], 5)
    r2 <- round(mc[2,]/rs[2], 5)
    rbind(No=r1, Yes=r2)
    
    # 6. Ajustemos nuevamente el mejor modelo, pero ahora con el argumento decision.values = TRUE. Obtengamos los valores predichos para el conjunto de prueba utilizando el mejor modelo, las funciones predict, attributes y el argumento decision.values = TRUE dentro de predict.
    
    fit <- svm(default ~ ., data = Default[train,], 
               kernel = "radial", cost = 100, gamma = 1.51,
               decision.values = TRUE)
    
    fitted <- attributes(predict(fit, Default[-train,], 
                                 decision.values = TRUE))$decision.values
    
    # 7. Realicemos clasificación de las observaciones del conjunto de prueba utilizando los valores predichos por el modelo y un umbral de decisión igual a cero. También obtengamos la matriz de confusión y proporciones como anteriormente hicimos.
    
    eti <- ifelse(fitted < 0, "Yes", "No")
    
    mc <- table(true = Default[-train, "default"], 
                pred = eti)
    mc
    
    round(sum(diag(mc))/sum(colSums(mc)), 5)
    
    rs <- apply(mc, 1, sum)
    r1 <- round(mc[1,]/rs[1], 5)
    r2 <- round(mc[2,]/rs[2], 5)
    rbind(No=r1, Yes=r2)
    
    # 8. Repitamos el paso 7 pero con un umbral de decisión diferente, de tal manera que se reduzca la proporción del error más grave para la compañía de tarjetas de crédito.
    
    eti <- ifelse(fitted < 1.002, "Yes", "No")
    
    mc <- table(true = Default[-train, "default"], 
                pred = eti)
    mc
    
    round(sum(diag(mc))/sum(colSums(mc)), 5)
    
    rs <- apply(mc, 1, sum)
    r1 <- round(mc[1,]/rs[1], 5)
    r2 <- round(mc[2,]/rs[2], 5)
    rbind(No=r1, Yes=r2)