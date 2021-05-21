/*################################################################################
						Jueves 13 de Mayo de 2021
                         Lizzeth Gómez Rodríguez
					Sesión 2 Agrupaciones y subconsultas
							Pattern Matching
###################################################################################
*/

USE tienda;

# Extraer los campos donde el nombre empieza con M
SELECT*
FROM empleado WHERE nombre LIKE 'M%';

## RETO 1: véase el archivo retos_sesion_2
# ================================================================================

-- También se pueden hacer operaciones sin usar tabla:
SELECT (1 + 7) * (10 / (6 - 4));

-- A su vez se puede usar en tablas y las operaciones se harán por columnas
SELECT id_puesto + 8
FROM empleado;

SELECT count(*)
FROM articulo; #Cuenta todas las filas

-- Para contar valores distintos
SELECT DISTINCT count(precio)
FROM articulo;

-- Aqui esta arrojando los precios sin repetir
SELECT DISTINCT precio
FROM articulo;

## RETO 2: vease el archivo retos_sesion_2
# ===========================================================================

-- Agrupamientos por grupos
-- Sumar los precios por cada nombre de articulo
SELECT nombre, sum(precio) AS total
FROM articulo
GROUP BY nombre;

SELECT nombre, count(*) AS cantidad
FROM articulo
GROUP BY nombre
ORDER BY cantidad DESC;

SELECT nombre, min(salario) AS menor, max(salario) AS mayor
FROM puesto
GROUP BY nombre;

SELECT nombre, apellido_paterno, sum(id_puesto)
FROM empleado
GROUP BY nombre, apellido_paterno;

## RETO 3: véase el archivo reto_sesion_2
# =================================================================================

-- Tenemos aqui por cada clave, que articulos se vendieron
SELECT clave, id_articulo, count(*) AS cantidad
FROM venta
GROUP BY clave, id_articulo
ORDER BY clave;

SELECT id_articulo, min(cantidad), max(cantidad)
FROM 
   (SELECT clave, id_articulo, count(*) AS cantidad
   FROM venta
   GROUP BY clave, id_articulo
   ORDER BY clave) AS subconsulta
GROUP BY id_articulo;

## RETO 4: Véase el archivo retos_sesion_2

