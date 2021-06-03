# Ejercicio de la sesión 7

El ejercicio consiste en obtener, por país, el número de películas que hay de cada género:

Se utiliza `unwind` para desagregar por país("$countries") y por género("$genres")
Una vez desagregados los campos, procedemos a realizar el agrupamiento de ambas categorías, país y género usando la función `$sum`.

![image](https://github.com/LIZZETHGOMEZ/BEDU-Santander-2021/blob/main/Introduccion%20a%20Bases%20de%20Datos/sesion_7/ejercicios_sesion_7/ejercicio_sesion_7.PNG)

Una vez que ya tenemos el agrupamiento nos damos cuenta que el arreglo solo contiene dos elementos, el país y el género, por lo que es fácil extraerlos con `addfields`

Y con ello hacer la proyección para facilitar la visualización de la información pedida.

![image](https://github.com/LIZZETHGOMEZ/BEDU-Santander-2021/blob/main/Introduccion%20a%20Bases%20de%20Datos/sesion_7/ejercicios_sesion_7/ejercicio_sesion_7_parte2.PNG)
