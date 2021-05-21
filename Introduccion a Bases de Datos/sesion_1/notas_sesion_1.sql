/*######################################################################
					Martes 11 de Mayo de 2021
					Lizzeth Gomez Rodriguez
						Sesión 1 CONSULTAS
######################################################################*/

-- Hay que ver la base a utilizar del servidor
-- El servidor puede tener varias bases
SHOW DATABASES;
-- Seleccionamos la base que queremos
USE tienda;
-- Consultamos las tablas que tiene la base
SHOW TABLES;
-- Consultamos la ESTRUCTURA DE DATOS de las tablas, indicando la tabla que queremos:
DESCRIBE puesto; 

## RETO 1: Véase el archivo retos_sesion_1
# ====================================================================================

-- Sin el punto y coma se ejecta un script
-- Queremos saber los datos almacenados en el campo Nombre de la tabla empleado
SELECT nombre
FROM empleado;

-- Para ver los campos de la tabla usamos *
SELECT*
FROM empleado;

#-------------------------------------------------------------------------
# FILTROS o CONDICIONES usando Operadores Relacionales
SELECT* 
FROM empleado
WHERE apellido_paterno = 'Risom';

SELECT* 
FROM empleado
WHERE id_puesto >= 100
	AND id_puesto <= 200;
    
SELECT* 
FROM empleado
WHERE id_puesto = 100
	OR id_puesto = 200;

# -------------------------------------------------------------------------------
-- El IN se lee como OR y no AND:
SELECT* 
FROM empleado
WHERE id_puesto IN (20,100,110,200);

-- Para rango de valores específico:
SELECT* 
FROM empleado
WHERE id_puesto BETWEEN 100 AND 200;

## RETO 2: vease el archivo retos_sesion_1

# =====================================================================================
-- Clausulas ORDER BY
SELECT*
FROM puesto
ORDER BY salario DESC; #Por default es ascendente ASC

-- Varios criterios de ordenamiento
SELECT*
FROM puesto
ORDER BY salario, nombre DESC;

-- Limit permite limitar el numero de registros que queremos ver
SELECT salario
FROM puesto
LIMIT 5;

## RETO 3: Vease el archivo retos_sesion_3






