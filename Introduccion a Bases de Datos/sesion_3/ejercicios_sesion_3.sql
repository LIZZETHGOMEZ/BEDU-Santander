/*#####################################################################
					Martes 18 de Mayo de 2021
                      Lizzeth Gómez Rodríguez
 					    Ejercicios Sesión 3 
						 JOINS  y VIEWS
######################################################################*/

USE classicmodels;

/* INNER JOIN
1. Obtén la cantidad de productos de cada orden.
2. Obtén el número de orden, estado y costo total de cada orden.
3. Obtén el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza.
4. Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza. 
*/

-- Ejercicio 1
SELECT o.orderNumber, sum(quantityOrdered) AS cantidad
FROM orders AS o
JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber;
    
-- Ejercicio 2
# Esto se requiere:
# SELECT orderNumber, `status`, priceEach * quantityOrdered

SELECT o.orderNumber, `status`, sum(priceEach * quantityOrdered) AS costo_total
FROM orders AS o
JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber;

-- Ejercicio 3
# Esto se requiere:
# SELECT orderNumber, orderDate, orderlineNumber, productName, quantityOrder, priceEach

SELECT o.orderNumber, orderDate, orderlineNumber, productName, quantityOrdered, priceEach
FROM orders AS o
JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
JOIN products AS p
	ON od.productCode = p.productCode
ORDER BY quantityOrdered DESC, priceEach DESC;

-- Ejercicio 4 
SELECT o.orderNumber, productName, MSRP AS fabricPrice, priceEach
FROM orders AS o
JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
JOIN products AS p
	ON od.productCode = p.productCode
ORDER BY fabricPrice DESC, priceEach DESC;

/* LEFT JOIN
5. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. 
¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
6. Obtén los clientes que no tienen una orden asociada.
7. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
*/

-- Ejercicio 5
SELECT c.customerNumber, customerName, orderNumber, `status`
FROM customers AS c
LEFT JOIN orders AS o
	ON c.customerNumber = o.customerNumber;

# Para responder el porqué LEFT JOIN es preferible para este caso, relicemos una consulta con INNER JOIN y veamos las diferencias:
SELECT c.customerNumber, customerName, orderNumber, `status`
FROM customers AS c
JOIN orders AS o
	ON c.customerNumber = o.customerNumber;

/*Notemos que con el INNER JOIN la estructura de la tabla está desorganizada, mientras que con LEFT JOIN toma la estructura de la tabla customers
Ademas, debido a que INNER JOIN es la intereseccion de los registros que hay en ambas tablas, en este caso es preferible el LEFT JOIN
porque obtenemos todos los registros de la tabla de clientes y ademas si hacemos el conteo de registros podemos ver que el INNER JOIN tiene menos registros(326) mientras que
mientras que LEFT JOIN trae todos (350), es decir que estamos eliminado clientes con el INNER JOIN por ser una interseccion, se eliminan los clientes que no han realizado ordenes.
*/

-- Ejercicio 6 
# Agregamos el orderNumber para verificar
SELECT c.customerNumber, customerName, orderNumber
FROM customers AS c
LEFT JOIN orders AS o
	ON c.customerNumber = o.customerNumber
WHERE orderNumber IS NULL;

-- Ejercicio 7,
SELECT concat(lastName,' ', firstName) AS employee_name, c.customerName, p.checkNumber, p.amount #total
FROM employees AS e
LEFT JOIN customers AS c
	ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments AS p
	ON c.customerNumber = p.customerNumber;

/*RIGHT JOIN
8. Repite los ejercicios 5 a 7 usando RIGHT JOIN. ¿Representan lo mismo? Explica las diferencias en un comentario.
9. Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta para cada una.*/

-- Ejercicio 8
-- 8.5
SELECT c.customerNumber, customerName, orderNumber, `status`
FROM customers AS c
RIGHT JOIN orders AS o
	ON c.customerNumber = o.customerNumber;
    
-- 8.6
SELECT c.customerNumber, customerName, orderNumber
FROM customers AS c
RIGHT JOIN orders AS o
	ON c.customerNumber = o.customerNumber
WHERE orderNumber IS NULL;

-- 8.7
SELECT concat(lastName,' ', firstName) AS employee_name, c.customerName, p.checkNumber, p.amount #total
FROM employees AS e
RIGHT JOIN customers AS c
	ON c.salesRepEmployeeNumber = e.employeeNumber
RIGHT JOIN payments AS p
	ON c.customerNumber = p.customerNumber;
    
/* Usando el RIGHT JOIN no se representa lo mismo, ya que el RIGHT JOIN nos devuelve todos los registros de la tabla de la derecha
mientras que si usamos INNER JOIN solo nos traerá los registros que cumplan con las condiciones, pues es una intersección y el LEFT JOIN traerá todos los d ela tabla
izquierda mas los registros de la tabla derecha que cumplan la condición.
Así con el RIGHT JOIN estamos trayendo todas las ordenes y podemos saber si hay clientes que no están ordenando, pero no podemos saber que empleados no han realizado ventas.
*/

-- Ejericio 9 
-- 9.1
CREATE VIEW product_table_600 AS(
SELECT o.orderNumber, orderDate, orderlineNumber, productName, quantityOrdered, priceEach
FROM orders AS o
JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
JOIN products AS p
	ON od.productCode = p.productCode
ORDER BY quantityOrdered DESC, priceEach DESC);

# Obtener el numero de orden, la fecha de la orden y el total a pagar por orden de mayor a meno
SELECT orderNumber, orderDate, sum(priceEach) as total
FROM product_table_600
GROUP BY orderNumber
ORDER BY total DESC;

-- 9.2
CREATE VIEW product_fabricprice_600 AS (
SELECT o.orderNumber, productName, MSRP AS fabricPrice, priceEach
FROM orders AS o
JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
JOIN products AS p
	ON od.productCode = p.productCode
ORDER BY fabricPrice DESC, priceEach DESC);

# Obtener el precio sugerido de fábrica y su precio actual de todos los modelos Mercedes
SELECT productName, fabricprice, priceEach
FROM product_fabricprice_600
WHERE productName LIKE "%Mercedes%";

-- 9.3
CREATE VIEW employee_customer_600 AS (
SELECT concat(lastName,' ', firstName) AS employee_name, c.customerName, p.checkNumber, p.amount #total
FROM employees AS e
LEFT JOIN customers AS c
	ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments AS p
	ON c.customerNumber = p.customerNumber);

# Obtener el nombre de los empleados que no han generado ventas, ordenados por orden alfabético.
SELECT employee_name, amount
FROM employee_customer_600
WHERE amount IS NULL
ORDER BY employee_name;