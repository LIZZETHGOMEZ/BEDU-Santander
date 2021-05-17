/*################################################################################################
		     		 Martes 11 de Mayo de 2021
                      		  Lizzeth Gómez Rodríguez
 		        	      RETOS SESION 2
##################################################################################################*/


#----------------------------------------------------------------------------------------------------
# RETO 1
/*Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
¿Qué artículos incluyen la palabra Pasta en su nombre?
¿Qué artículos incluyen la palabra Cannelloni en su nombre?
¿Qué nombres están separados por un guión (-) por ejemplo Puree - Kiwi?
¿Qué puestos incluyen la palabra Designer?
¿Qué puestos incluyen la palabra Developer?
*/
USE tienda;
SHOW TABLES;
SELECT* FROM articulo WHERE nombre LIKE '%Pasta%';
SELECT* FROM articulo WHERE nombre LIKE '%Cannelloni%';
SELECT* FROM articulo WHERE nombre LIKE '%-%';
SELECT* FROM puesto WHERE nombre LIKE '%Designer%';
SELECT* FROM puesto WHERE nombre LIKE '%Developer%';

#-----------------------------------------------------------------------------------------------
# RETO 2
/*Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
1. ¿Cuál es el promedio de salario de los puestos?
2. ¿Cuántos artículos incluyen la palabra Pasta en su nombre?
3. ¿Cuál es el salario mínimo y máximo?
4. ¿Cuál es la suma del salario de los últimos cinco puestos agregados?
*/

-- Pregunta 1
SELECT avg(salario)
FROM puesto;
-- Para redondear los valores usamos round()
SELECT round(avg(salario))
FROM puesto;
-- Especificando los decimales:
SELECT round(avg(salario), 2)
FROM puesto;
-- Usando simbolo de pesos contruimos una cadena
SELECT concat('$',round(avg(salario), 2))
FROM puesto;

-- Pregunta 2
SELECT count(*)
FROM articulo
WHERE nombre LIKE '%Pasta%';

-- Pregunta 3
SELECT max(salario), min(salario) FROM puesto;

-- Pregunta 4
SELECT id_puesto, salario
FROM puesto
ORDER BY id_puesto DESC
LIMIT 5;
-- Como ya estan ordenados, puedo extraer los últimos 5
SELECT max(id_puesto) - 5
FROM puesto; # Notemos que los últimos 5 puestos están por encima del id 995

SELECT sum(salario)
FROM puesto
WHERE id_puesto >= 996;
# Notemos ademas que esta consulta es muy específica, ya que hay que estar escribiendo el numero del id
# Esto se puede hacer mas general con una subconsulta de acuerdo al prework

#------------------------------------------------------------------------------------------------------
# RETO 3
/*Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
1. ¿Cuántos registros hay por cada uno de los puestos?
2. ¿Cuánto dinero se paga en total por puesto?
3. ¿Cuál es el número total de ventas por vendedor?
4. ¿Cuál es el número total de ventas por artículo?
*/

-- Pregunta 1
SELECT nombre, count(*) AS numero_puestos
FROM puesto
GROUP BY nombre;

-- Pregunta 2
SELECT nombre, sum(salario)
FROM puesto
GROUP BY nombre;

-- Pregunta 3
SELECT id_empleado, count(clave) AS total_ventas
FROM venta
GROUP BY id_empleado;

-- Pregunta 4
SELECT id_articulo, count(*) AS total_por_articulo
FROM venta
GROUP BY id_articulo;

#-------------------------------------------------------------------------------------
# RETO 4
/*
1. ¿Cuál es el nombre de los empleados cuyo sueldo es mayor a $10,000?
2. ¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
3. ¿Cuál es el nombre del puesto de cada empleado?
*/

-- Pregunta 1 #Agreagmos sueldo para comprobar
SELECT nombre apellido_paterno, (SELECT salario FROM puesto WHERE id_puesto = e.id_puesto) AS sueldo
FROM empleado as e
WHERE id_puesto IN
	(SELECT id_puesto
		FROM puesto
		WHERE salario > 10000);

-- Pregunta 2
# Extraemos el total de ventas que hízo cada empleado
SELECT clave, id_empleado, count(*) AS total_ventas
FROM venta
GROUP BY clave, id_empleado;

#Extraemos el max y min
SELECT id_empleado, max(total_ventas), min(total_ventas)
FROM
	(SELECT clave, id_empleado, count(*) AS total_ventas
	FROM venta
	GROUP BY clave, id_empleado) AS subconsulta
GROUP BY id_empleado;

-- Pregunta 3
SELECT nombre, apellido_paterno, (SELECT nombre FROM puesto WHERE id_puesto = e.id_puesto) AS nombre_puesto
FROM empleado AS e;

    
    