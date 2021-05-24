/*#####################################################################
					Jueves 20 de Mayo de 2021
                      Lizzeth Gómez Rodríguez
						   Sesion 4
######################################################################*/

-- Ahora nuestro servidor sera nuestra computadora, y aqui es donde crearemos una Base de Datos
CREATE DATABASE Proyecto_BEDU;
-- Para Borrar usamos DROP DATABASE <name>
-- Para crear si es que no existe: CREATE DATABASE IF NOT EXIST <name>

-- Nos conetamos a la base
USE Proyecto_BEDU;

-- Utilizamos como ayuda el Diagrama Entidad-Relacion, lo que nos permite saber como se encuentran relacionadas las tablas
-- Diamantes azules indican que obligatoriamente son datos necesarios (Campos no nulos)
-- Diamantes rojos son llaves foraneas
-- Diamantes blancos pueden ser campos nulos

# =====================================================================================
-- CREACION DE TABLAS
-- Cuando cargamos base es importante conocer la informacion, preferentemente ver el README
-- Con el README podemos saber cuales definiremos como llaves

CREATE TABLE users (
   id INT PRIMARY KEY, 
   genero VARCHAR(1), 
   edad INT,
   ocup INT,
   cp VARCHAR(20)
);

-- Con esto evitamos errores
CREATE TABLE IF NOT EXISTS users (
   id INT PRIMARY KEY, 
   genero VARCHAR(1), 
   edad INT,
   ocup INT,
   cp VARCHAR(20)
);

-- Para borrar una tabla usamos DROP TABLE users
DESCRIBE users;

#### RETO 1 (Véase retos_sesion_4)

-- Para cargar los datos de las tablas una vez creadas las estructuras
-- Click derecho > Table data import > cargamos > selecionamos cargar a una tabla ya creada y seleccionar tabla > UTF-8

SELECT*
FROM users
LIMIT 10;

-- Para rear registros individuales, ponemos los campos y los llenamos con los valores, en el mismo orden.
INSERT INTO users (id,genero,edad,ocup,cp) VALUES (7000,'F',25,20,'03100');   

### RETO 2 (Véase retos_sesion_4)

-- Procedemos a usar MONGO DB


