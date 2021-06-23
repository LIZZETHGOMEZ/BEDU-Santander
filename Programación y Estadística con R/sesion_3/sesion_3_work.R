    # ##########################################################################
    #                           Sesion_3 WORK
    #                   Martes 22 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################

    
    # ========================================================================
    # ggplot
    
    library(ggplot2)
    
    # Usaremos el dataset mtcars
    names(mtcars)
    
    # Grafico de dispersion
    ggplot(mtcars, aes(x = cyl, y = hp, colour = mpg )) + 
        geom_point()
    
    # Agregamos caracteristicas al grafico
    ggplot(mtcars, aes(x = cyl, y = hp, colour = mpg )) + 
        geom_point() +   
        theme_gray() + 
        facet_wrap("cyl")  # Lo divide por el núm de cilindros (cyl)
    
    # Agregamos labels
    ggplot(mtcars, aes(x = cyl, y = hp, colour = cyl)) + 
        geom_point() +   
        theme_bw() +   
        facet_wrap("cyl") +  
        xlab('Núm de cilindros') + 
        ylab('Caballos de Fuerza')    
    
    
    # ========================================================================
    # Manipulacion de datos con dplyr
    
    dir <- "C:/Users/GOMEZ/Documents/BEDU_Santander/Programación y Estadística con R/sesion_3"
    setwd(dir)
    library(dplyr)
    
    data <- read.csv("Data/boxp.csv")
    head(data)
    names(data)
    
    # HISTOGRAMA
    # Histograma que rompe de 0 a 300, con incrementos de 20
    hist(data$Mediciones, breaks = seq(0, 300, 20),
         main = "Histograma de Mediciones",
         xlab = "Mediciones",
         ylab = "Frecuencia")
    
    
    # OMICION DE NAs
    data <- na.omit(data) 
    
   grafico_1 <- data %>%
        ggplot() + 
        aes(Mediciones) +
        geom_histogram(binwidth = 10)
   
   # GRAFICOS DINAMICOS
   library(plotly)
   ggplotly(grafico_1)
    
    # Personalizamos
    grafico_2 <- data %>%
        ggplot() + 
        aes(Mediciones) +
        geom_histogram(binwidth = 10, col="black", fill = "palegreen") + 
        ggtitle("Histograma de Mediciones") +
        ylab("Frecuencia") +
        xlab("Mediciones") + 
        theme_bw()
    
    ggplotly(grafico_2)
    
    
    # =========================================================================
    # GRAFICOS DE DISÉRSION (SCATTER PLOT)
    
    my_scatplot <- ggplot(mtcars, aes(x = wt, y = mpg)) +
        geom_point() +
        xlab("Peso (wt)") +
        ylab("Millas por galón")
    
    my_scatplot
    
    # MATRIZ DE CORRELACION
    cor(mtcars)
    
    # Coeficiente de correlacion
    cor(mtcars$wt, mtcars$mpg)
    
    
    my_scatplot <- ggplot(mtcars, aes(x = wt, y = mpg)) + 
        geom_point() + 
        geom_smooth(method = "lm", se = T) + # Para plotear la tendencia (regresion lineal)
        xlab("Peso (wt)") +
        ylab("Millas por galón")
        
    my_scatplot

    # Agregamos a nuestro objeto los labels
    my_scatplot + xlab('Weight (x 1000lbs)') + ylab('Miles per Gallon')
    
    # Gradiente por  cilindros
    my_scatplot <- ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
        geom_point()
    my_scatplot
    
    # Convirtiendo a factor los cilindros (categorias)
    my_scatplot <- ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
        geom_point()
    my_scatplot
    
    # Agregamos labels
    my_scatplot <- my_scatplot + labs(x ='Weight (x1000lbs)', y ='Miles per Gallon', colour='Number of\n Cylinders')
   
    # DIvidimos por cilindro
    my_scatplot <- my_scatplot + facet_wrap("cyl")
    

    # Separándolas por por dos tipos de variables usando facet_grid() 
    # am = Transmission (0 = automatic, 1 = manual))
    my_scatplot + facet_grid(am~cyl)
    
    
    grafico_3 <- my_scatplot + facet_wrap("am")
    ggplotly(grafico_3)
    
    
    # ========================================================================
    # BOXPLOT
    data <- read.csv("Data/boxp.csv")
    
    head(data)
    names(data)
    summary(data)
    
    # Eliminamos NAs
    data <- na.omit(data)
    
    # Transformamos la variable categoria y grupo
    data <- mutate(data, Categoria = factor(Categoria), Grupo = factor(Grupo))
    
    str(data)
    
    # GRAFICAMOS BOXPLOTS
    ggplot(data, aes(x = Categoria, y = Mediciones, fill = Grupo)) + geom_boxplot() +
        ggtitle("Boxplots") +
        xlab("Categorias") +
        ylab("Mediciones")
    
    
    # Cambiamos nombres de etiquetas de categorias 0 = G1, 1 = G2
    grafico_4 <- ggplot(data, aes(x = Categoria, y = Mediciones, fill = Grupo)) + geom_boxplot() +
        scale_fill_discrete(name = "Dos Gps", labels = c("G1", "G2")) + #Cambiamps la escala de la variable discreta
        ggtitle("Boxplots") +
        xlab("Categorias") +
        ylab("Mediciones")
    ggplotly(grafico_4)
    
