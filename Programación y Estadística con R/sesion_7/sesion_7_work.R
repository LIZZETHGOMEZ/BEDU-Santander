    # ##########################################################################
    #                        Sesion_7 Work
    #                     Martes 6 de Julio de 2021
    #                     Lizzeth Gomez Ridriguez
    # ########################################################################### 
    # CONEXION A SQL
    
    # install.packages("DBI")
    # install.packages("RMySQL")
    
    library(DBI)
    library(RMySQL)
    
    # Una vez que se tengan las librerias necesarias se procede a la lectura 
    # (podría ser que necesites otras, si te las solicita instalalas y cargalas), 
    # de la base de datos de Shiny la cual es un demo y nos permite interactuar con 
    # este tipo de objetos. El comando dbConnect es el indicado para realizar la 
    # lectura, los demás parametros son los que nos dan acceso a la BDD.
    
    
    # Hacemos conexion a SQL 
    MyDataBase <- dbConnect(
        drv = RMySQL::MySQL(),
        dbname = "shinydemo",
        host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
        username = "guest",
        password = "guest")
    
    # Observamos la BDD
    # Veamos las tablas de la Base
    dbListTables(MyDataBase)
    
    # Observamos los campos de una tabla especifica
    dbListFields(MyDataBase, 'City')
    
    # Para realizar una consulta tipo MySQL sobre la tabla seleccionada haremos lo 
    # siguiente
    
    DataDB <- dbGetQuery(MyDataBase, "select * from City")
    head(DataDB)
    
    # Observemos que el objeto DataDB es un data frame, por lo tanto ya es un objeto 
    # de R y podemos aplicar los comandos usuales
    
    class(DataDB)
    head(DataDB)
    
    # Sacamos promedio de la poblacion
    pop.mean <- mean(DataDB$Population)
    pop.mean 
    
    # Operacion aritmetica
    pop.3 <- pop.mean *3 
    pop.3
    
    # Comandos de busqueda
    # Ciudades del país de México con más de 50,000 habitantes
    library(dplyr)
    pop50.mex <-  DataDB %>% filter(CountryCode == "MEX" ,  Population > 50000)   
    head(pop50.mex)
    
    # Países que contiene la BDD
    unique(DataDB$CountryCode)
    
    # Nos desconectamos de la base
    dbDisconnect(MyDataBase)

    
    # ===================================================================
    # Variantes en la lectura de BDD con R
    
    # install.packages("pool")
    library(dbplyr)
    library(pool)
    
    # Se realiza la lectura de la BDD con el comando dbPool, los demás parámetros 
    # se siguen utilizando igual que el ejemplo anterior
    
    my_db <- dbPool(
        RMySQL::MySQL(), 
        dbname = "shinydemo",
        host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
        username = "guest",
        password = "guest"
    )
    
    # Veamos las tablas
    dbListTables(my_db)
    
    # Obtener los primeros 5 registros de Country
    # Con tbl entro directo a la tabla y extraigo lo que quiero sin generar el df
    my_db %>% tbl("Country") %>% head(5) 
    
    # Obtener los primeros 5 registros de CountryLanguage
    my_db %>% tbl("CountryLanguage") %>% head(5)
    
    
    # --------------------------------------------------------
    # Otra forma de generar una búsqueda será con la librería DBI, utilizando el 
    # comando dbSendQuery
    
    library(DBI)
    conn <- dbConnect(
        drv = RMySQL::MySQL(),
        dbname = "shinydemo",
        host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
        username = "guest",
        password = "guest")
    
    # Hacemos la consulta
    rs <- dbSendQuery(conn, "SELECT * FROM City LIMIT 5;")
    
    # Consultamos el resultado sin manipular dfs
    dbFetch(rs)
    
    # Para finalizar nos desconectamos de la BDD
    dbClearResult(rs) 
    dbDisconnect(conn)
    
    
    # ####################################################################
    # Lectura de archivos JSON, XML y tablas en HTML

    library(rjson)
  
    # Leemos archivo JSON
    URL <- "https://tools.learningcontainer.com/sample-json-file.json" 
    
    # Guardamos el documento JSON en un objeto
    JsonData <- fromJSON(file = URL) 
    
    class(JsonData) #Es una lista
    str(JsonData)  
    
    # realizar la manipulación de los datos dentro del Json, por ejemplo:
    sqrt(JsonData$Mobile)
    
    # Para entrar a las demás variables recuerda que puedas usar el operador de $, 
    # es decir, JsonData$
    
    
    # ------------------------------------------------------
    # Archivos XLM
    # install.packages("XML")
    library(XML)
    link <- "http://www-db.deis.unibo.it/courses/TW/DOCS/w3schools/xml/cd_catalog.xml"
    
    # Analizando el XML desde la web. leemos y guardamos
    xmlfile <- xmlTreeParse(link)
    class(xmlfile)
    
    # Aun no se tiene Data Frame
    summary(xmlfile)
    head(xmlfile)

    #Extraer los valores xml
    topxml <- xmlSApply(xmlfile, function(x) xmlSApply(x, xmlValue))
    
    # Colocandolos en un Data Frame
    xml_df <- data.frame(t(topxml), row.names= NULL)
    
    str(xml_df) 
    # Convertiremos incluso las variables de PRICE y YEAR en datos numéricos para 
    # poder realizar operaciones con este dato
    
    xml_df$PRICE <- as.numeric(xml_df$PRICE) 
    xml_df$YEAR <- as.numeric(xml_df$YEAR)
    
    mean(xml_df$PRICE)
    mean(xml_df$YEAR)
    
    # Todo esto se puede realizar en un solo paso utilizando el siguiente comando
    # Para convertir XML a Data Frame en un solo paso
    data_df <- xmlToDataFrame(link)
    head(data_df)
    class(data_df)
    
    # ---------------------------------------------------------------------
    # Tablas en HTML
    # Extraccion de tablas desde la web
    
    # install.packages("rvest")
    library(rvest)
    # Introducimos una dirección URL donde se encuentre una tabla
    
    theurl <- "https://solarviews.com/span/data2.htm"
    # Leemos el html
    file <- read_html(theurl)  
    
    # Selecciona pedazos dentro del HTML para identificar la tabla
    tables <- html_nodes(file, "table")
    tables
    
    # Hay que analizar 'tables' para determinar cual es la posición en la lista 
    # que contiene la tabla, en este caso es la no. 4
    
    # Extraemos la tabla de acuerdo a la posición en la lista que es el 4
    table1 <- html_table(tables[4], fill = TRUE)
    class(table1)
    table1
    
    # Hacemos la limpeza de los datos y convertimos la lista a df
    table <- na.omit(as.data.frame(table1))    

    str(table)

    table$Albedo <- as.numeric(table$Albedo)
    str(table)
    
    sqrt((table$Albedo))
    sqrt(na.omit(table$Albedo))
    
    
    