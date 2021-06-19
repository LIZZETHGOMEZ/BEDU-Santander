    # ##########################################################################
    #                           Sesion_2 WORK
    #                   Jueves 17 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    
    # ====================================================================
    # MEDIDAS DE TENDENCIA CENTRAL, DE POSICION Y DISPERCION 
    
    # Media, mediana y moda
    x = c(4000, 9000, 9000, 10000); mean(x)
    median(x)
    
    # Moda
    # install.packages("DescTools")
    library(DescTools)
    Mode(x)    

    # Medidas de posicion
    x <- c(29, 13, 62, 4, 63, 96, 1, 90, 50, 46)
    
    quantile(x, 0.25) # cuantil del 25% El valor dado es a partir del cual los demas datos estaran por debajo
    quantile(x, c(0.25,0.50,0.75)) # Todos los cuartiles
    quantile(x, seq(0.1,0.9, by = 0.1)) # Deciles
    
    # Rango intercuartile  (Q3- Q1)
    IQR(x) 
    # El valor es de 45 en comparacion con la mediana que es de 48,
    # podemos decir que hay un poco de dispersion entre los datos
    
    # Veamos la dispersion de los datos
    plot(x) 
    
    # Manualmente:
    quantile(x, probs = 0.75) - quantile(x, probs = 0.25)
    
    # Varianza y desviacion estandar
    var(x)
    sd(x)    

    
    
    # ========================================================================
    # CARACTERISTICAS DE LOS OBJETOS
    # (str sobre df, summary, head y view) y funciones
    set.seed(57)
    x <- rnorm(35)
    e <- rnorm(35)
    y <- 5 + 2*x + e
    modelo <- lm(y~x)
    summary(modelo)
    
    View(iris)
    
    # Creacion de nuestra porpia funcion en este caso moda
    moda <- function(vector){
        f.abs <- table(vector) # frecuencias absolutas
        max.f.abs <- max(f.abs) # obtenemos la máxima frecuencia absoluta
        pos.max <- which(f.abs == max.f.abs) # posición(es) de la(s) máxima(s) frecuencia(s) absoluta(s)
        print("La(s) moda(s) es(son): ")
        print(names(f.abs[pos.max]))
        paste("Con una frecuencia de: ", unique(f.abs[pos.max]))
    } 
    
    
    # Usamos la funcion
    x <- sample(1:100, 100, replace = T) # Tomamos una muestra aleatoria de tamaño 100 con reemplazo de los primeros 100 números naturales
    table(x) # obtenemos las frecuencias absolutas de los valores de la muestra
    moda(x) # obtenemos la moda de los valores de la muestra
    
    
    # =========================================================================
    # Funciones `na.omit` y `complete.cases`
    
    library(dplyr)
    
    # Usamoas dataset de R
    head(airquality)
    
    # Vemos la estructura de los datos
    str(airquality)
    dim(airquality)
    summary(airquality) # Observemos aqui los NAs de cada columna
    
    
    # Con la funcion complete.cases() podemos osbervar las entradas que presentan o no NAs
    # Es de dato booleano donde TRUE son los casos sin NAs y FLASE aquellos con NAs
    bien <- complete.cases(airquality) 
    
    # Para conocer el numero de registros sompletos sin NAs
    sum(bien)
    
    # Filtramos todas las filas que no contengan NAs para ello le decimos
    # traeme todas las filas TRUE(por default) del vector bien
    airquality[bien, ]
    
    
    # Filtrando con la funcion select()
    # selaccionamos de airquality, de la columna Ozone a la Temp
    data <- select(airquality, Ozone:Temp)
    
    # Calcular la media de cada columna del data frame
    # apply sirve para aplicar una funcion en este caso mean() sobre las columnas (1 = filas 2 = Col)
    apply(data, 2, mean)
    apply(data, 2, mean, na.rm = T)

    
    # ===================================================================
    #IMPORTANTE Y RAPIDO

    # `na.omit` devuelve el objeto con casos incompletos eliminados
    (m1 <- apply(na.omit(data), 2, mean)) # Aplicamos la funcion na omit a las columnas de data
    
    # Usando complete cases
    b <- complete.cases(data)
    (m2 <- apply(data[b,], 2, mean))
    
    # Comparamos los dos objetos usando na.omit y coplete cases
    identical(m1, m2) # son identicos
        
    
    # ======================================================================
    # MANIPULACION DE DATA FRAMES
    
    # Unimos vectores por columna usando cbind()
    cbind(1:10, 11:20, 21:30) # 3 columnas
    
    # Unimos un vector con una matriz por columnas y tendremos una matriz
    cbind(1:10, matrix(11:30, ncol = 2))
    
    # Unimos por columnas un data frame con un vectr y tendremos un data frame
    cbind(data.frame(x = 1:10, y = 11:20), z = 21:30)
    
    # rbind union por filas
    df1 <- data.frame(x = 1:5, y = 6:10, z = 16:20)
    df2 <- data.frame(x = 51:55, y = 101:105, z = 151:155)
    df1; df2
    rbind(df1, df2)
    
    
    # Un data frame con un vector, el vector solo se tomara el numero de columnas de df, en este caso 2
    df3 <- rbind(data.frame(x = 1:10, y = 11:20), 21:22)
    
    
    # ========================================================================
    # FUNCION APPLY
    
    X <- matrix(1:49, ncol = 7)
    X
    apply(X, 1, mean) # cálculo de la media para las filas
    apply(X, 2, median) # cálculo de la mediana para las columnas
    
    # FUNCION LAPPLY
    
    dir <- "C:/Users/GOMEZ/Documents/BEDU_Santander/Programación y Estadística con R/sesion_2/Data"
    setwd(dir)
    
    
    u1011 <- "https://www.football-data.co.uk/mmz4281/1011/SP1.csv"
    u1112 <- "https://www.football-data.co.uk/mmz4281/1112/SP1.csv"
    u1213 <- "https://www.football-data.co.uk/mmz4281/1213/SP1.csv"
    u1314 <- "https://www.football-data.co.uk/mmz4281/1314/SP1.csv"
    
    download.file(url = u1011, destfile = "SP1-1011.csv", mode = "wb")
    download.file(url = u1112, destfile = "SP1-1112.csv", mode = "wb")
    download.file(url = u1213, destfile = "SP1-1213.csv", mode = "wb")
    download.file(url = u1314, destfile = "SP1-1314.csv", mode = "wb")
    
    
    dir() 
    
    # Metemos los archivos en una lista
    lista <- lapply(dir(), read.csv)
    lista
    
    # LAPPLY trabaja con listas
    # Seleccionamos de cada lista las columnas desde Date hasta FTR
    lista <- lapply(lista, select, Date:FTR) # seleccionamos solo algunas columnas de cada data frame
    lista
    
    head(lista[[1]]); head(lista[[2]]); head(lista[[3]]); head(lista[[4]])
    
    # Usamos la funcion do.call() lo que permite combinar las listas y tendremos un solo df
    data <- do.call(rbind, lista)
    head(data)
    dim(data)
    
    
    # ==========================================================================
    # DPLYR
    
    suppressMessages(suppressWarnings(library(dplyr)))
    
    url1 <- "https://data.humdata.org/hxlproxy/data/download/time_series_covid19_confirmed_global_narrow.csv?dest=data_edit&filter01=explode&explode-header-att01=date&explode-value-att01=value&filter02=rename&rename-oldtag02=%23affected%2Bdate&rename-newtag02=%23date&rename-header02=Date&filter03=rename&rename-oldtag03=%23affected%2Bvalue&rename-newtag03=%23affected%2Binfected%2Bvalue%2Bnum&rename-header03=Value&filter04=clean&clean-date-tags04=%23date&filter05=sort&sort-tags05=%23date&sort-reverse05=on&filter06=sort&sort-tags06=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv"
    url2 <- "https://data.humdata.org/hxlproxy/data/download/time_series_covid19_deaths_global_narrow.csv?dest=data_edit&filter01=explode&explode-header-att01=date&explode-value-att01=value&filter02=rename&rename-oldtag02=%23affected%2Bdate&rename-newtag02=%23date&rename-header02=Date&filter03=rename&rename-oldtag03=%23affected%2Bvalue&rename-newtag03=%23affected%2Binfected%2Bvalue%2Bnum&rename-header03=Value&filter04=clean&clean-date-tags04=%23date&filter05=sort&sort-tags05=%23date&sort-reverse05=on&filter06=sort&sort-tags06=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_deaths_global.csv"
    
    # Descargamos los datos en nuestro directorio de trabajo con la siguiente instrucción
    
    dir <- "C:/Users/GOMEZ/Documents/BEDU_Santander/Programación y Estadística con R/sesion_2/Data/data_2"
    setwd(dir)
    
    download.file(url = url1, destfile = "st19ncov-confirmados.csv", mode = "wb")
    download.file(url = url2, destfile = "st19ncov-muertes.csv", mode = "wb")
    
    conf <- read.csv("st19ncov-confirmados.csv") #Casos confirmados
    dec <- read.csv("st19ncov-muertes.csv")     # Decesos confirmados
    
    str(conf); str(dec)
    head(conf); head(dec)
    
    # Limpiamos los dats
    Sconf <- conf[-1,] # Quitamos la primara fila
    Sdec <- dec[-1, ]
    
    # Otra forma es seleccionar simplemente las que necesitamos
    Sconf <- select(Sconf, Country.Region, Date, Value) # País, fecha y acumulado de infectados
    
    # Renmbramos las columnas
    Sconf <- rename(Sconf, Country = Country.Region, Fecha = Date, Infectados = Value)
    
    # Modificamos la columna Date y Infectados
    Sconf <- mutate(Sconf, Fecha = as.Date(Fecha, "%Y-%m-%d"), Infectados = as.numeric(Infectados))   
    
    
    # Hacemos lo mismo para sdec
    Sdec <- select(Sdec, Country.Region, Date, Value) # Seleccionamos país, fecha y acumulado de decesos
    Sdec <- rename(Sdec, Country = Country.Region, Fecha = Date, Decesos = Value) # Renombramos
    Sdec <- mutate(Sdec, Fecha = as.Date(Fecha, "%Y-%m-%d"), Decesos = as.numeric(Decesos)) 
    
    
    # sdec y sconf tienen la misma estrutura y las variables osn las mismas, entonces hacemos un merge
    
    Scm <- merge(Sconf, Sdec) # Unimos infectados y decesos acumulados para fecha
    dim(Scm)
    
    
    # Filtramos por pais y luego los infectados sean distinto de 0
    mex <- filter(Scm, Country == "Mexico") # Seleccionamos sólo a México
    mex <- filter(mex, Infectados != 0) # Primer día de infectados    
    
    
    # Calculamos los infectados por dia
    # Creamos una nueva columna con mutate, diff() hace la resta entre infectados con el dato anterior
    mex <- mutate(mex, NI = c(1, diff(Infectados))) # Nuevos infectados por día
    mex <- mutate(mex, ND = c(0, diff(Decesos))) # Nuevos decesos por día
    
    mex <- mutate(mex, Letalidad = round(Decesos/Infectados*100, 1)) # Tasa de letalidad
    
    mex <- mutate(mex, IDA = lag(Infectados), DDA = lag(Decesos)) # Valores día anterior
    mex <- mutate(mex, FCI = Infectados/IDA, FCD = Decesos/DDA) # Factores de Crecimiento
    mex <- mutate(mex, Dia = 1:dim(mex)[1]) # Días de contingencia
    
    head(mex); tail(mex)
    write.csv(mex, "C19Mexico.csv", row.names = FALSE)
    
    
    
    
    
    
    
    
    
    