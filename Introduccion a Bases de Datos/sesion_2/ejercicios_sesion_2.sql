/*#####################################################################
					Jueves 13 de Mayo de 2021
                      Lizzeth Gómez Rodríguez
 					    Ejercicios Sesión 2 
						    SUBCONSULTAS
#####################################################################
*/

-- 1. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con a.
USE classicmodels;
SELECT*
FROM employees;

SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'a%';

-- 2. Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo apellido termina con on.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE lastName LIKE '%on';

-- 3. Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE '%on%';

-- 4. Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen seis letras e inician con G.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'G_____';

-- 5. Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName NOT LIKE 'B%';

-- 6. Dentro de la tabla products, obtén el código de producto y nombre de los productos cuyo código incluye la cadena _20.
SELECT*
FROM products;

SELECT productCode, productName
FROM products
WHERE productCode LIKE '%_20%';
#Notemos que el underscore "_" es un operador, por lo que para ser reconoido como una cadena de carácteres o 'string', deberemos usar slash (/)
# Con la palabra reservada ESCAPE, así "_20" será reconocido tal cual como cadena incluyendo el underscore.
SELECT productCode, productName
FROM products
WHERE productCode LIKE '%/_20%' ESCAPE '/';

-- 7. Dentro de la tabla orderdetails, obtén el total de cada orden.
SELECT*
FROM orderdetails;

# Nota: no se espefcifica si es el precio total o la cantidad total, por lo que se consultan ambos.
SELECT orderNumber, count(quantityOrdered) AS cantidad_total, sum(priceEach) AS precio_total
FROM orderdetails
GROUP BY orderNumber;

-- 8. Dentro de la tabla orders obtén el número de órdenes por año.
SELECT*
FROM orders;

#Nos apoyamos de la palabra reservada YEAR 
SELECT YEAR(orderDate) AS anio, count(*) AS total_ordenes
FROM orders
GROUP BY anio;

-- 9. Obtén el apellido y nombre de los empleados cuya oficina está ubicada en USA.
#Agregamos el pais para comprobar.
SELECT lastName, firstName, (SELECT country FROM offices WHERE officeCode = e.officeCode) AS office_country
FROM employees AS e
WHERE officeCode IN
	(SELECT officeCode
    FROM offices
    WHERE country = 'USA');
    
-- 10. Obtén el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.
SELECT*
FROM payments; #checkpayment, amount

SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount IN
	(SELECT max(amount)
    FROM payments);

-- 11. Obtén el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > (SELECT avg(amount) FROM payments);

-- 12. Obtén el nombre de aquellos clientes que no han hecho ninguna orden.
SELECT customerName
FROM customers
WHERE customerNumber NOT IN
	(SELECT customerNumber
    FROM orders);

-- 13. Obtén el máximo, mínimo y promedio del número de productos en las órdenes de venta.
SELECT*
FROM orderdetails;

SELECT max(quantityOrdered), min(quantityOrdered), avg(quantityOrdered)
FROM orderdetails;

-- 14. Dentro de la tabla orders, Obtén el número de órdenes que hay por cada estado.
#Agregamos comillas invertidas a 'status' ya que lo marca como palabra reservada
SELECT `status`, count(`status`) AS orders_quantity
FROM orders
GROUP BY `status`;

