    # ##########################################################################
    #                       Sesion_2 RETOS
    #                   Jueves 17 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
    
    # ==========================================================================
    # RETO 1
    
    # Considere el siguiente vector
    set.seed(134)
    x <- round(rnorm(1000, 175, 6), 1)
    
    # 1. Calcule, la media, mediana y moda de los valores en x
    mean(x)
    median(x)
    DescTools::Mode(x)
    
    # 2. Obtenga los deciles de los números en x
    quantile(x, seq(0.1,0.9, by = 0.1))
    
    # 3. Encuentre el rango intercuartílico, la desviación estándar y varianza muestral
    IQR(x)
    sd(x)
    var(x)
    
    
    # ==========================================================================
    # RETO 2
    
    # Considere el data frame `mtcars` de `R` y utilice las funciones `str`, 
    # `summary`, `head` y `View` para observar las características del objeto
    # y tener una mayor comprensión de este.
    
    # Crea una función que calcule la mediana de un conjuntos de valores, 
    # sin utilizar la función median
    
    
    str(mtcars)
    summary(mtcars)
    head(mtcars)
    View(mtcars)
    
    # Creacion de una funcion
    
    # Forma 1
    medianaa <- function(vector){
        n <- length(vector) # Número de elementos del vector
        vector <- sort(vector) # Ordenamos los valores de menor a mayor
        if(n %% 2 == 0){ # Si es par
            paste("La mediana es: ", mean(vector[c(n/2, n/2+1)])) 
        } else{ 
            paste("La mediana es: ", vector[round(n/2)])
        }
    }
    
    
    # Forma 2    
    medianaa <- function(x){
        
        # Si es par:
        if (length(x) %% 2 == 1) {
            x <- sort(x)
            mid = (length(x)/2) + 0.5
            print(x[mid]) 
            
        } else  {
            x <- sort(x)
            mid =  length(x)/2
            y <- x[(mid):(mid + 1)]
            print(mean(y[1]+ y[2]))
            
        }
        
    }
    
    # Usamos la funcion
    x = c(1,3,5,6,7,8,13,54,67,99,100)
    medianaa(x)
    
    # =========================================================================
    # RETO 3
    
    
    # Descargue los archivos csv que corresponden a las temporadas 2017/2018, 2018/2019, 2019/2020 y 2020/2021 
    # de la Bundesliga 1 y que se encuentran en el siguiente enlace https://www.football-data.co.uk/germanym.php
    # Importe los archivos descargados a R
    # Usando la función select del paquete dplyr, seleccione únicamente las columnas Date, HomeTeam, AwayTeam,
    # FTHG, FTAG y FTR
    # Combine cada uno de los data frames en un único data frame con ayuda de las funciones rbind y do.call
    
    dir <- "C:/Users/GOMEZ/Documents/BEDU_Santander/Programación y Estadística con R/sesion_2/Data/retos"
    setwd(dir)
    
    B1.2021 <- "https://www.football-data.co.uk/mmz4281/2021/D1.csv"
    B1.1920 <- "https://www.football-data.co.uk/mmz4281/1920/D1.csv"
    B1.1819 <- "https://www.football-data.co.uk/mmz4281/1819/D1.csv"
    B1.1718 <- "https://www.football-data.co.uk/mmz4281/1718/D1.csv"
    
    download.file(url = B1.2021, destfile = "B1.2021.csv", mode = "wb")
    download.file(url = B1.1920, destfile = "B1.1920.csv", mode = "wb")
    download.file(url = B1.1819, destfile = "B1.1819.csv", mode = "wb")
    download.file(url = B1.1718, destfile = "B1.1718.csv", mode = "wb")
    
    lista <- lapply(dir(), read.csv)
    lista
    
    lista <- lapply(lista, select, Date, HomeTeam:FTR) 
    lista
    
    data <- do.call(rbind, lista)
    data    
             