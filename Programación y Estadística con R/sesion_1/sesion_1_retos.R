    # ##########################################################################
    #                           Sesion_1 RETOS
    #                   Martes 15 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    
    
    # =======================================================================
    # RETO 1: LECTURA Y ESCRITURA DE DATOS
    
    # 1) Leer el archivo "netflix_titles.csv" desde Github
    data <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2021/main/Sesion-01/Data/netflix_titles.csv")
    
    
    # 2) Obtener la dimensión y el tipo de objeto que se obtiene
    dim(data)
    str(data)
    
    # 3) Obtener los títulos que se estrenaron después del 2015. 
    # Almacenar este df en una variable llamada net.2015
    (net.2015 <- data[data$release_year > 2015,])
    
    # Ordenamos para comprobar que todos son mayores a 2015
    sort(net.2015$release_year, decreasing = F)
    
    # 4) Escribir los resultados en un archivo .csv llamado res.netflix.csv 
    # (Hint: consulta la función write.csv)
    write.csv(net.2015, "net_2015.csv")
    
    
    # ========================================================================
    # RETO 2: OPERACIONES CON DATA FRAMES
    
    # Utiliza el data frame de ventas de libros por Amazon y realiza las siguientes actividades:
    # 1. Almacénalo en un data frame que se llame amazon.best
    # 2. Calcula el data frame transpuesto, asígnale el nombre de tAmazon y 
    # conviértelo en un data frame (Hint: consulta la ayuda sobre las funciones t y as.data.frame)
    # 3. Usa el nombre de los libros como el nombre de las columnas
    # (Hint: consulta la documentación de names, tienes que hacer algo similar a names(dataframe) <- vector de nuevos nombres)
    # 4. ¿Cuál es el libro de menor y mayor precio?
    
    
    # 1. Cargamos y almacenamos los datos
    amazon.best <- read.csv("https://raw.githubusercontent.com/ecoronadoj/Sesion_1/main/Data/bestsellers%20with%20categories.csv")
    
    # 2. Transponemos el df y almacenamos
    tAmazon <- as.data.frame(t(amazon.best))  # Transponemos
    
    # 3. Agregamos el nombre de las columnas extrayendo la primera columna del df original
    colnames(tAmazon) <- amazon.best[,1] 
    
    # 4. Libro de menor y mayor precio
    which.min(tAmazon["Price",]) # De menor precio
    which.max(tAmazon["Price",]) # De mayor precio
    
    
    # =========================================================================
    # RETO 3: LOOPS
    
    # 1. Genera un vector de 44 entradas (aleatorias), llamado ran (Hint: utiliza la función rnorm()).
    # 2. Escribe un loop que eleve al cubo las primeras 15 entradas y les sume 12.
    # 3. Guarda el resultado en un data frame, donde la primera columna sea el número aleatorio y la segunda el resultado, nómbralo df.al.
    # 4. Escribe el pseudocódigo del loop anterior
    
    
    ran <- rnorm(44)
    
    # Creamos un vector vacio donde almacenaremos las nuevas entradas
    entradas <- vector()
    
    # Creamos un loop que va de 1 a 15, y asignamos a nuestro vectos los nuevos valores
    for (i in 1:15) {
        entradas[i] <- (ran[i]^3) + 12
    }
    
    # Vector con las nuevas entradas
    entradas
    
    # Almacenamos en un data frame las entradas originales y las nuevas entradas
    df.al <- data.frame(ran = ran[1:15], new_val = entradas)
    df.al
    