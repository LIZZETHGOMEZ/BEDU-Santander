    # ##########################################################################
    #                           Sesion_1 WORK
    #                   Martes 15 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    

    # ============================================================
    # TIPOS DE DATOS Y VECTORES
 
    # Creacion de varables de diferentes tipos de datos
    var.hola <- "Hola mundo"
    var.number <- 5L
    var.double <- 2.7076
    var.logical <- FALSE    
    vector <- c(1,2)    
    
    
    # Observemos la tipologia de las variables usando la funcion class()
    class(var.hola)    
    class(var.number)    
    class(var.double)
    class(var.logical)
    class(vector)    
    
    
    # Observemos la diferencia entre las funciones class() y typeof()
    class(var.double)
    typeof(var.double)
    
    
    # Creamos vectores, que siempre contienen un mimsmo tipo de datos (prework)
    a <- c(4, 6, 8, 10,12)
    b <- c(3, 5, 7, 9)

    # Conocer la longitud de un vector con la funcion lenght()
    length(a)    
    length(b)
    
    # Accedemos a los elementos de un vector/matriz utilizando un indice(posicion del arreglo)
    a[1]
    b[4]
    
    # Unimos dos vectores creando un nuevo vector que contenga ambos y lo almacenamod en "d" 
    # (se concatenan los dos vectores)
    # Luego lo ordenamos de manera ascendente
    # Pedimos ayuda con ?function
    ?sort
    d <- c(a,b)
    sort(c(a,b), decreasing = F)
    sort(d, decreasing = F) 
    
    # Otra forma de generar un vector
    3:12
    -10:10
    0:10
    
    # Creacion de secuencias usando seq()
    # vector que va de 1:10 con incremento de 2 y otro de 3 en 3
    vector.by2 <- seq(from = 1, to = 10, by = 2)
    vector.by3 <- seq(from = 1, to = 10, by = 3)
    vector.by3 <- seq(1, 10, 3)
    
    # Repetir un elemento un determinado numero de veces
    rep(5, times = 6)
    rep(a,3)
    
    # Suma de vectores se hace bajo el reciclaje de los elementos del vector
    # cuando no son la misma dimension regresa al primer elemento del primer vector
    # y hace la operacion hasta cubrir la dimension mas grande. 
    c(1, 2) + c(7, 8, 9, 10)
    
    # operando los vectores almacenados
    a + b
    a - b
    a*b
    a/b    
    a**2    
    
    
    
    # ===========================================================================
    # MATRICES
    
    # Creacion de matrices
    # Matriz de 3x3, por default llena por columna
    m <- matrix(1:9, nrow = 3, ncol = 3)
    
    # Extraccion de los elementos de una matriz a través de la posicion del elemento
    # Posicion: [fila, columna]
    m[1,1]
    m[1,2]
    
    # Para traer todas las filas o columnas se deja vacio el espacio
    m[,1] 
    m[3,1]

    # Suma de vector y matriz (nuevamente utiliza el recicaje y tambien llena por columnas)
    sum.vecmat <- c(1,2) + m    
    sum.vecmat
    
    # Creamos otra matriz
    n <- matrix(2:7, 4, 6)
    n
    dim(n)
    
    
    # Subconjuntos de matrices
    # Extraemos los elementos de la matriz mayores a 4 (solo valores no posiciones)
    n[n > 4]
    
    # Localizar las posiciones condcionadas de un elemento de la matriz
    # Rendremos un vector de las posiciones contando por columnas
    which(n > 4)
    
    # Creacion de matrices a partir de vectores
    # Creamos dos vectores del mismo tamaño
    a <- 2:6
    b <- 5:9
    
    # Unimos los vectores por columnas usando cbind() tendremos 2 columnas una p/c vector
    # Unimos los vectores por filas usando rbind() tendremos dos filas
    cbind(a,b)
    rbind(a,b)
    
    
    
    
    # ==========================================================================
    # LISTAS Y DATA FRAMES
    
    # LISTAS
    # Creamos una lista que es una collecion de diferentes tipos de datos
    # # Observamos la estrctura del objeto
    milista <- list(nombre = "Pepe", no.hijos = 3, edades.hijos = c(4, 7, 9))
    str(milista) 
    
    # Extraemos una variable particular
    milista$nombre
    
    
    # DATA FRAMES
    # Creacion de Data Frames
    x <- 10:21
    # Letters hace referencia al alfabeto, y extraemos las posiciones de x del afabeto 
    (y <- letters[x])
    # Creamos el df con dos columnas cada una con los valores previos
    mydf <- data.frame(edad = x, grupo = y)
    
    str(mydf)

    # Extraemos elementos al igual que las matrices pues un df es una matriz
    mydf[1] # columna 1
    mydf[,1] # Columna 1 en forma de vector
    mydf$edad 
    
    
    
    # ESTADISTICA BASICA
    # Sacamos la media y agregamos un mensaje a la salida del resultado
    mean(mydf$edad)
    paste("La media de la edad es:", mean(mydf$edad))
    
    
    # Estadistica descriptiva basica (min, max, mean, cuartiles)
    summary(mydf)
    
    
    
    
    # ==========================================================================
    # DESCARGAR Y LECTURA DE DATA SETS
    
    getwd()
    dir <- "C:/Users/GOMEZ/Documents/BEDU_Santander/Programación y Estadística con R/sesion_1"
    
    # Leemos archivos csv
    amazon.books <- read.csv("Data/bestsellers with categories.csv", sep = ",", header = T)
    str(amazon.books) 
    
    # Ejecutamos simultaneamente dos comandos separandolos con ";"
    # Queremos ver los primeros 6 registrso y los ultimos 6
    head(amazon.books); tail(amazon.books)
    
    # Leemos fichero desde una url 
    data.url <- read.csv("https://www.football-data.co.uk/mmz4281/2021/SP1.csv")
    str(data.url)
    head(data.url); tail(data.url) 
    
    
    
    #=============================================================================
    # LOOPS Y PSEUDOCODIGOS
    
    # For Loop
    # Elevar al cuadrado los elementos de mi vector
    w <- c(2,4,6,8,10)
    
    for(i in 1:length(w)) {
        w.sq <- w[i]**2
        print(w.sq)
    }
    
    
    # While Loop
    count <- 0
    while (count < 10) {
        print(count)
        count <- count + 1
    }
    
    
    # If-Else Loop
    # con runif saca uno solo numero aleatrorio entre loa vaores asignados 0 y 10
    (x <- runif(1, 0, 10))
    
    if(x > 5) {
        y <- TRUE
        print(paste(y, ", x =", round(x,2) ,"> 5"))
    } else {
        y <- FALSE
        print(paste(y, ", x =", round(x,2) ," < 5"))
    }
    
    
    
    
 
    