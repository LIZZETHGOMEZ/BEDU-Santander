    # ##########################################################################
    #                        Sesion_4 RETOS
    #                   Jueves 24 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    # =========================================================================
    # RETO 1. Distribución normal
    
    # Una compañía que manufactura y embotella jugo de manzana usa una máquina que 
    # automáticamente llena botellas de 16 onzas. Hay alguna variación, no obstante, 
    # en las cantidades de líquido que se ponen en las botellas que se llenan. 
    # Se ha observado que la cantidad de líquido está normalmente distribuida en 
    # forma aproximada con media de 16 onzas y desviación estándar de 1 onza.
    
    # Determine la proporción de botellas que tendrán más de 18 onzas.
    
    # Calculamos la probabilidad P(X > 18)
    pnorm(q = 18, mean = 16, sd = 1, lower.tail = FALSE)
    
    # Generamos los valores para graficar
    x <- seq(-4, 4, 0.01) + 16
    y <- dnorm(x, 16, 1)
    
    plot(x, y, type = "l", xlab="", ylab="")
    title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 16, " y ", sigma == 1)))
    polygon(c(18, x[x>18], max(x)), c(0, y[x>18], 0), col="blue")
    
    
    # ================================================================================
    # RETO 2: Teorema central del límite
    
    # Las calificaciones de exámenes para todos los estudiantes de último año de 
    # preparatoria en cierto estado tienen media de 60 y varianza de 64. 
    # Una muestra aleatoria de n = 100 estudiantes de una escuela preparatoria 
    # grande tuvo una calificación media de 58. ¿Hay evidencia para sugerir que el 
    # nivel de conocimientos de esta escuela sea inferior? 
    # (Calcule la probabilidad de que la media de una muestra aleatoria sea a lo 
    # sea 58 cuando n = 100.)
    
    
    # Por Teorema del Limite Central:
    # n = media de la muestra
    # media poblacional = media muestral
    # sd = sqr(64)/sqr(100)
    
    pnorm(58, 60, 8/10)
    
    # Notemos que 58 es muy cercano a la media y la desviacion es muy baja
    # El resultado es absurdo
    # Falso, la probabilidad de que la media sea de 58 es muy baja, no podemos decir que 
    # el nivel de conocimientos de la escuela es inferior
    
    
    # ===========================================================================
    # RETO 3: Contraste de hipótesis
    
    # El vicepresidente de ventas de una gran empresa afirma que los vendedores 
    # están promediando no más de 15 contactos de venta por semana. 
    # (Le gustaría aumentar esa cantidad.) Como prueba de su afirmación, 
    # aleatoriamente se seleccionan n = 20 vendedores y se registra el número de 
    # contactos hechos por cada uno para una sola semana seleccionada al azar.
    
    
    
    
    
    
    
    