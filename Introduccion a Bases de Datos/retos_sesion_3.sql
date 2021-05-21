/*################################################################################################
		     		      Martes 18 de Mayo de 2021
				           Lizzeth Gómez Rodríguez
 		        	           RETOS SESION 3
##################################################################################################*/
USE tienda;

# RETO 1
/*Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
1. ¿Cuál es el nombre de los empleados que realizaron cada venta?
2. ¿Cuál es el nombre de los artículos que se han vendido?
3. ¿Cuál es el total de cada venta? 
*/

-- Pregunta 1
SELECT clave, nombre, apellido_paterno
FROM empleado AS e
JOIN venta AS v
	ON e.id_empleado = v.id_empleado
ORDER BY clave;
    
-- Pregunta 2
SELECT clave, nombre
FROM venta AS v
JOIN articulo AS a
	ON a.id_articulo = v.id_articulo;
    
-- Pregunta 3
SELECT clave, round(sum(precio + iva),2) AS total
FROM venta AS v
JOIN articulo AS a
	ON v.id_articulo = a.id_articulo
    GROUP BY clave
    ORDER BY clave;
    
    
# RETO 2
/*
1. Obtener el puesto de un empleado.
2. Saber qué artículos ha vendido cada empleado.
3. Saber qué puesto ha tenido más ventas.
*/

-- Pregunta 1
CREATE VIEW puesto_600 AS
(SELECT p.nombre, concat(e.nombre, " ", e.apellido_paterno) empleado
FROM puesto AS p
JOIN empleado AS e
	ON p.id_puesto = e.id_puesto);
    
-- Pregunta 2
CREATE VIEW venta_articulo_600 AS
(SELECT concat(e.nombre, " ", e.apellido_paterno) empleado,  a.nombre AS articulo
FROM articulo AS a
JOIN venta AS v
	ON a.id_articulo = v.id_articulo
JOIN empleado AS e
	ON e.id_empleado = v.id_empleado
GROUP BY empleado, a.nombre
ORDER BY empleado);

-- Pregunta 3
# Unimos venta con empleado para conocer las ventas de cada empleado y eso unirlo con el puesto
CREATE VIEW ventas_puesto_600 AS
(SELECT p.nombre AS puesto, count(clave) AS venta
FROM venta AS v
JOIN empleado AS e
	ON v.id_empleado = e.id_empleado
JOIN puesto AS p
	ON e.id_puesto = p.id_puesto
GROUP BY p.nombre, v.id_empleado
ORDER BY venta DESC);

