/*################################################################################
					Martes 11 de Mayo de 2021
                      Lizzeth Gómez Rodríguez
 					      RETOS SESION 1
##################################################################################
*/

#-------------------------------------------------------------------------------------------------
-- RETO 1: Descripcion de las tablas
SHOW TABLES;
DESCRIBE articulo;
DESCRIBE puesto;
DESCRIBE venta;

#--------------------------------------------------------------------------------------------------
/* RETO 2
Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
¿Cuál es el nombre de los empleados con el puesto 4?
¿Qué puestos tienen un salario mayor a $10,000?
¿Qué artículos tienen un precio mayor a $1,000 y un iva mayor a 100?
¿Qué ventas incluyen los artículos 135 o 963 y fueron hechas por los empleados 835 o 369?
*/
SHOW TABLES;
DESCRIBE empleado;

-- Pregunta 1
SELECT NOMBRE
FROM empleado
WHERE id_puesto = 4;

-- Pregunta 2
DESCRIBE puesto;
SELECT *
FROM puesto
WHERE salario > 10000;

-- Pregunta 3
SELECT *
FROM articulo
WHERE precio > 1000
	AND iva > 100;

-- Pregunta 4
SELECT *
FROM venta
WHERE id_articulo IN (135,963)
	AND id_empleado IN (835,369);
    
#--------------------------------------------------------------------------------------------------------
-- RETO 3
-- Usando la base de datos tienda, escribe una consulta que permita obtener el top 5 de puestos por salarios.
SELECT*
FROM puesto
ORDER BY salario DESC
LIMIT 5;