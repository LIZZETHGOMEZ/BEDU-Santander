# Retos de la sesion 7

### RETO 1
Con base en el ejemplo 1, modifica el agrupamiento para que muestre el costo promedio por habitación por país de las propiedades de tipo casa.

![image](https://github.com/LIZZETHGOMEZ/BEDU-Santander-2021/blob/main/Introduccion%20a%20Bases%20de%20Datos/sesion_7/retos_sesion_7/reto_1.PNG)

### RETO 2
Usando las colecciones comments y users, se requiere conocer el correo y contraseña de cada persona que realizó un comentario. 
Construye un pipeline que genere como resultado estos datos.

Utilizando `$lookup` seleccionamos los id con los que se unirán los documentos, y esto nos arrojará un arreglo que extraemos con `$addFields`

![image](https://github.com/LIZZETHGOMEZ/BEDU-Santander-2021/blob/main/Introduccion%20a%20Bases%20de%20Datos/sesion_7/retos_sesion_7/reto_2_parte1.PNG)

Por último, el arreglo anterior ahora es un objeto del cual podemos extraer la información buscada también usando `$addFields` y finalmente hacemos la poryección de los
campos de interés.

![image](https://github.com/LIZZETHGOMEZ/BEDU-Santander-2021/blob/main/Introduccion%20a%20Bases%20de%20Datos/sesion_7/retos_sesion_7/reto_2_parte2.PNG)

### RETO 3
Usando el pipeline del Reto 2, generar la vista correspondiente.

![image](https://github.com/LIZZETHGOMEZ/BEDU-Santander-2021/blob/main/Introduccion%20a%20Bases%20de%20Datos/sesion_7/retos_sesion_7/reto_3.PNG)
