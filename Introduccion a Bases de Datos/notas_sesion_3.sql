/*################################################################################
						Martes 18 de Mayo de 2021
                         Lizzeth Gómez Rodríguez
						 Sesión 3 Joins y Vistas
###################################################################################
*/
USE tienda;

-- Para conocer las llaves primarias de una tabla usamos KEY
SHOW KEYS FROM venta; #Notemos que todas las llaves que arroja que no son PRIMARY, seran llaves foraneas
DESCRIBE venta;
DESCRIBE articulo; #Aqui vemos una relacion con la tabla venta pues la llave primaria de la tabla articulo es una foranea de venta

SHOW KEYS FROM empleado;
# Hacemos un JOIN con la tabla puesto
SELECT*
FROM empleado AS e
JOIN puesto AS p
	# EL ON nos permite traer unicamente los registros de ambas tablas que cumplen la condicion
	ON e.id_puesto = p.id_puesto;
    
SELECT*
FROM puesto AS p
LEFT JOIN empleado AS e
	# Traemos toda la tabla de la izq. y le agregamos los registros de la tabla derecha que cumplan la condicion
	ON e.id_puesto = p.id_puesto;

# La misma tabla de arriba pero usando RIGHT JOIN    
SELECT*
FROM empleado AS e
RIGHT JOIN puesto p
	ON e.id_puesto = p.id_puesto;

## RETO 1: Véase el archivo retos_sesion_3
# ==========================================================================================

# GUARDADO DE TABLAS CON VISTAS

-- 1. Primero creamos la consulta, luego le metemos la palabra reservada
CREATE VIEW tickets_416 AS
(SELECT v.clave, v.fecha, a.nombre producto, a.precio, concat(e.nombre, ' ', e.apellido_paterno) empleado 
FROM venta v
JOIN empleado e
  ON v.id_empleado = e.id_empleado
JOIN articulo a
  ON v.id_articulo = a.id_articulo);

SELECT*
FROM tickets_416;

# Para eliminar vistas 
DROP VIEW tickets_416

## RETO 2: Véase el archivo retos_sesion_3
