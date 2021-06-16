    # ##########################################################################
    #                           Sesion_1 RETOS
    #                   Martes 15 de Junio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ##########################################################################
    
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
    
    
    
     
    