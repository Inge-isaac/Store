         /*Lista el nombre de todos los productos que hay en la tabla producto.*/
SELECT p.nombre FROM producto p

/*Lista los nombres y los precios de todos los productos de la tabla producto.*/
SELECT p.nombre, p.precio
FROM producto p

/*Lista todas las columnas de la tabla producto.*/
SELECT * FROM producto p

/*Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD)*/
SELECT p.nombre, p.precio AS Euros, (p.precio * 1.05) AS Dolares
FROM producto p

/*Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.*/
SELECT p.nombre AS 'Nombre de Producto' , p.precio AS Euros, (p.precio * 1.05) AS Dolares
FROM producto p

/*Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.*/
SELECT UPPER(nombre) FROM producto

/*Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.*/
SELECT LOWER(nombre) FROM producto

/* Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas
los dos primeros caracteres del nombre del fabricante.*/
SELECT f.nombre AS nombre, SUBSTRING(UPPER(f.nombre),1,2)
FROM fabricante f

/*Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.*/
SELECT p.nombre, ROUND(p.precio) AS redondeado FROM producto p

/*Lista los nombres y los precios de todos los productos de la tabla producto,
truncando el valor del precio para mostrarlo sin ninguna cifra decimal.*/
SELECT p.nombre, TRUNCATE(p.precio, -3)
FROM producto p

/*Lista el código de los fabricantes que tienen productos en la tabla producto.*/
SELECT f.codigo
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante

/*Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.*/
SELECT DISTINCTROW(f.codigo) AS distintos
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante

/* Lista los nombres de los fabricantes ordenados de forma ascendente.*/
SELECT nombre
FROM fabricante
ORDER BY nombre ASC; 

/*Lista los nombres de los fabricantes ordenados de forma descendente.*/
SELECT nombre
FROM fabricante
ORDER BY nombre DESC;  

/*Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente
y en segundo lugar por el precio de forma descendente.*/
SELECT p.nombre, p.precio
FROM producto p
ORDER BY nombre, precio DESC;

/*Devuelve una lista con las 5 primeras filas de la tabla fabricante.*/
SELECT *
FROM fabricante
LIMIT 5; 

/*Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. 
La cuarta fila también se debe incluir en la respuesta.*/
SELECT codigo, nombre FROM 
(SELECT ROW_NUMBER()
OVER(ORDER BY codigo DESC)
AS lista_a, nombre, codigo
FROM fabricante) AS a
where lista_a >= 4 and lista_a <= 5;

/*Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y ROWNUM).*/
SELECT precio, nombre FROM 
(SELECT ROW_NUMBER()
OVER(ORDER BY precio ASC)
AS lista_a, nombre, precio
FROM producto LIMIT 1) AS a;

/*Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y ROWNUM)*/
SELECT precio, nombre FROM 
(SELECT ROW_NUMBER()
OVER(ORDER BY precio DESC)
AS lista_a, nombre, precio
FROM producto LIMIT 1) AS a;
/*Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.*/
SELECT p.nombre
FROM producto p
JOIN  fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.codigo = 2;

/* Lista el nombre de los productos que tienen un precio menor o igual a 120€.*/
SELECT p.nombre, p.precio
FROM producto p
WHERE p.precio <= 120
ORDER BY precio ASC 

/*Lista el nombre de los productos que tienen un precio mayor o igual a 400€.*/
SELECT p.nombre, p.precio
FROM producto p
WHERE p.precio >= 400
ORDER BY precio ASC 

/*Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.*/
SELECT p.nombre AS 'Nombre Producto', p.precio AS Precio
FROM producto p
WHERE p.precio >= 80 AND p.precio<= 300;

/* Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.*/
SELECT p.nombre AS 'Nombre Producto', p.precio AS Precio
FROM producto p
WHERE p.precio BETWEEN 60 AND 200;

/*Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea igual a 6.*/
SELECT p.nombre AS 'Nombre Producto', p.precio AS Precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio > 200 AND f.codigo =6


/*Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.*/
SELECT *
FROM producto p
WHERE p.codigo_fabricante = 1 OR p.codigo_fabricante= 3 OR p.codigo_fabricante = 5;

/*Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.*/
SELECT * 
FROM producto p
WHERE p.codigo_fabricante IN(1,3,5); 

/*Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). 
Cree un alias para la columna que contiene el precio que se llame céntimos.*/
SELECT p.nombre AS 'Nombre Producto', (p.precio * 100) AS Centimos
FROM producto p;

/*Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.*/
SELECT f.nombre
FROM fabricante f
WHERE LOWER(f.nombre) LIKE 's%';

/* Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT f.nombre 
FROM fabricante f
WHERE f.nombre LIKE '%e';

/*Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.*/
SELECT f.nombre 
FROM fabricante f
WHERE f.nombre LIKE '%w%';

/*Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.*/
SELECT f.nombre, LENGTH(f.nombre) AS conteo 
FROM fabricante f
HAVING conteo = 4;

/*Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.*/
SELECT p.nombre
FROM producto p
WHERE nombre LIKE'%Portátil%';

/*Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor
 en el nombre y tienen un precio inferior a 215 €.*/
SELECT p.nombre
FROM producto p
WHERE nombre LIKE'%Monitor%' AND p.precio < 215;

/*Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€.
Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).*/
SELECT p.nombre, precio
FROM producto p
WHERE  p.precio >=180
ORDER BY precio DESC, nombre ASC 

/*Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.*/
SELECT p.nombre, 
		 p.precio,
		 f.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

/*Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
Ordene el resultado por el nombre del fabricante, por orden alfabético.*/
SELECT p.nombre, 
		 p.precio,
		 f.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre ASC;

/*Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante,
de todos los productos de la base de datos.*/
SELECT p.codigo,
		 p.nombre, 
		 f.codigo,
		 f.nombre
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

/*Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.*/
SELECT p.nombre, p.precio, f.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
AND p.precio = (SELECT MIN(precio) FROM producto);

/* Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.*/
SELECT p.nombre, p.precio, f.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
AND p.precio = (SELECT MAX(precio) FROM producto);

/*Devuelve una lista de todos los productos del fabricante Lenovo.*/
SELECT * 
FROM producto p, fabricante f
WHERE f.codigo = p.codigo_fabricante
AND f.nombre = 'Lenovo'; 

/*Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.*/
SELECT * 
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial' AND p.precio > 200; 

/*Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.*/
SELECT * 
FROM producto p
 JOIN fabricante f ON p.codigo_fabricante = f.codigo
 WHERE f.nombre = 'Asus' or f.nombre = 'Hewlett-Packard' or f.nombre = 'Seagate';

/*Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.*/
SELECT * 
FROM producto p
 JOIN fabricante f ON p.codigo_fabricante = f.codigo
 WHERE f.nombre IN('Asus','Hewlett-Packard', 'Seagate');

/*Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT p.nombre, p.precio
FROM producto p
 WHERE p.nombre LIKE '%e';

/*Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga 
el carácter w en su nombre.*/
SELECT p.nombre, p.precio, f.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
 WHERE f.nombre LIKE "%w%";

/*Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos 
que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en
orden descendente) y en segundo lugar por el nombre (en orden ascendente)*/ 
SELECT p.nombre, p.precio, f.nombre 
FROM producto p
 JOIN fabricante f ON p.codigo_fabricante = f.codigo
 WHERE p.precio > 180
 ORDER BY precio DESC, p.nombre ASC;  
 
 /*Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes
  que tienen productos asociados en la base de datos.*/
SELECT f.codigo, f.nombre
 FROM fabricante f
JOIN producto p ON f.codigo =p.codigo_fabricante 
 
/* Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos
que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.*/
SELECT * 
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

/* Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.*/
SELECT f.nombre
FROM fabricante f
 LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.nombre IS NULL;

/*Devuelve un listado de todos los fabricantes que existen en la base de datos, junto
con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos 
fabricantes que no tienen productos asociados.*/

SELECT f.nombre, p.codigo, p.nombre, p.precio
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante

/*¿Pueden existir productos que no estén relacionados con un fabricante? Justifica tu respuesta.*/



/*Calcula el número total de productos que hay en la tabla productos.*/
SELECT COUNT(p.codigo) AS conteo
FROM producto p
 
/*Calcula el número total de fabricantes que hay en la tabla fabricante.*/
SELECT COUNT(f.codigo) AS conteo
FROM fabricante f;
  
/*Calcula el número de valores distintos de código de fabricante que aparecen en la tabla productos.*/
SELECT COUNT(DISTINCTROW(p.codigo_fabricante)) AS conteo_distinto
FROM producto p;

/*Calcula la media del precio de todos los productos.*/
 SELECT AVG(p.precio) AS Promedio
 FROM producto p;
 
/*Calcula el precio más barato de todos los productos.*/
 SELECT MIN(p.precio) AS MasBajo
 FROM producto p;

/*Calcula el precio más caro de todos los productos.*/ 
 SELECT MAX(p.precio) AS MasAlto
 FROM producto p;

/*Lista el nombre y el precio del producto más barato.*/
SELECT  p.nombre, p.precio
FROM producto p
WHERE p.precio = (SELECT MIN(precio) FROM  producto );

/* Lista el nombre y el precio del producto más caro.*/
SELECT  p.nombre, p.precio
FROM producto p
WHERE p.precio = (SELECT MAX(precio) FROM  producto );

/*Calcula la suma de los precios de todos los productos.*/
SELECT SUM(p.precio) AS Suma
FROM producto p

/*Calcula el número de productos que tiene el fabricante Asus.*/
SELECT COUNT(p.codigo_fabricante) AS Numero_Produ
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus';

/*Calcula la media del precio de todos los productos del fabricante Asus.*/
SELECT AVG(p.precio) AS Media
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus';

/*Calcula el precio más barato de todos los productos del fabricante Asus.*/
SELECT MIN(p.precio) AS PrecioBajo 
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus';

/* Calcula el precio más caro de todos los productos del fabricante Asus.*/
SELECT MAX(p.precio) AS PrecioCaro
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus';

/*Calcula la suma de todos los productos del fabricante Asus.*/
SELECT SUM(p.precio) AS Suma
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus';

/*Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.*/
SELECT MIN(p.precio) AS minimo,
		 MAX(p.precio) AS precioMax, 
		 AVG(p.precio) AS PrecioMedio,
		 COUNT(p.codigo) AS Conteo_Productos_Crucial
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial';

/*Muestra el número total de productos que tiene cada uno de los fabricantes.
El listado también debe incluir los fabricantes que no tienen ningún producto.
El resultado mostrará dos columnas, una con el nombre del fabricante y otra con 
el número de productos que tiene. Ordene el resultado descendentemente por el número de productos.*/
SELECT f.nombre, COUNT(p.codigo) AS TotalP
FROM fabricante f
LEFT JOIN producto p ON p.codigo_fabricante = f.codigo
GROUP BY f.nombre
ORDER BY TotalP DESC;

/*Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. 
El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.*/
SELECT
		f.nombre,
		 MIN(p.precio) AS precioMin,
		 MAX(p.precio) AS precioMax,
		 AVG(p.precio) AS precioPro 
FROM producto p
	JOIN fabricante f ON p.codigo_fabricante = f.codigo
	GROUP BY f.nombre

/*Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes
que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante,
con el código del fabricante es suficiente.*/
SELECT f.codigo,
		 MIN(p.precio) AS minimo,
		 MAX(p.precio) AS Maximo,
		 AVG(p.precio) AS Medio
FROM producto p
	JOIN fabricante f ON p.codigo_fabricante = f.codigo
	GROUP BY f.codigo
HAVING AVG(p.precio)> 200;

/*Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, 
precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€.
 Es necesario mostrar el nombre del fabricante.*/
SELECT
		f.nombre,
		 MIN(p.precio) AS precioMin,
		 MAX(p.precio) AS precioMax,
		 AVG(p.precio) AS precioPro,
		 COUNT(p.codigo) AS Total_Productos
FROM producto p
	JOIN fabricante f ON p.codigo_fabricante = f.codigo
	GROUP BY f.nombre
		HAVING AVG(p.precio) > 200;

/*Calcula el número de productos que tienen un precio mayor o igual a 180€.*/
SELECT COUNT(p.codigo) AS c
FROM producto p
WHERE precio >= 180;

/*Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.*/
SELECT f.nombre, COUNT(*) AS c
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE precio >= 180
GROUP BY f.nombre;

/*Lista el precio medio de los productos de cada fabricante, mostrando solamente el código del fabricante.*/
SELECT AVG(p.precio) AS medio, p.codigo_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
GROUP BY p.codigo_fabricante

/* Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.*/
SELECT AVG(p.precio), f.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
GROUP BY f.nombre;

/* Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.*/
SELECT f.nombre, AVG(p.precio) AS medio
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.nombre
HAVING medio >= 150;

/*Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.*/
SELECT COUNT(p.codigo) AS medio, p.codigo_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
GROUP BY p.codigo_fabricante

/* Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno
 con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes que no 
 tienen productos que cumplan la condición. Ejemplo del resultado esperado:*/
SELECT f.nombre, COUNT(*) AS TotalP
FROM fabricante f
 JOIN producto p ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 220
GROUP BY f.nombre
ORDER BY TotalP DESC;

/*Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno 
con un precio superior o igual a 220 €
. El listado debe mostrar el nombre de todos los fabricantes, es decir, si hay algún fabricante que no tiene productos 
con un precio superior o igual a 220€ deberá aparecer en el listado con un valor igual a 0 en el número de productos. */

SELECT DISTINCT f.nombre,
					 (SELECT COUNT(*) 
					  FROM producto 
					  WHERE codigo_fabricante = p.codigo_fabricante
					  AND precio >= 220) AS Total
FROM fabricante f
	LEFT JOIN producto p ON p.codigo_fabricante = f.codigo
ORDER BY Total DESC;

/* Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.*/
SELECT f.nombre, SUM(p.precio)
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.nombre
HAVING SUM(p.precio)> 1000



/*Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. 
El resultado debe tener tres columnas: nombre del producto, precio y nombre del fabricante. 
El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.*/
SELECT p.nombre, p.precio, f.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
AND p.precio = (SELECT MAX(precio) FROM producto WHERE  codigo_fabricante = p.codigo_fabricante)
ORDER by f.nombre

/*Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN)*/
SELECT *
FROM producto p , fabricante f
WHERE p.codigo_fabricante = f.codigo AND f.nombre ='Lenovo';


/*Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT *
FROM producto 
WHERE precio =(SELECT MAX(precio) AS s FROM producto
 										  			  WHERE codigo_fabricante = 
													 (SELECT codigo FROM fabricante WHERE nombre ='Lenovo'));

/*Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT p.nombre
FROM producto p
WHERE p.precio = (SELECT  MAX(precio) FROM producto
					 WHERE codigo_fabricante= (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
					 
/*Lista el nombre del producto más barato del fabricante Hewlett-Packard.*/
SELECT p.nombre
FROM producto p
WHERE p.precio = (SELECT MIN(precio) FROM producto
						WHERE codigo_fabricante = (SELECT codigo FROM fabricante
						WHERE nombre = 'Hewlett-Packard'))

/*Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.*/
SELECT *
FROM producto p
WHERE p.precio>= (SELECT MAX(precio) 
			 FROM producto
			 WHERE codigo_fabricante = (SELECT codigo 
			 									 FROM fabricante
												  WHERE nombre = 'Lenovo'));

/*Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.*/
SELECT *
FROM producto p
WHERE codigo_fabricante = (SELECT codigo FROM fabricante f
									WHERE f.nombre= 'Asus')
					  				AND precio>(SELECT AVG(precio) FROM producto
									WHERE codigo_fabricante = (SELECT codigo FROM fabricante f
									WHERE f.nombre= 'Asus'));

/*Subconsultas (En la cláusula HAVING). Devuelve un listado con todos los nombres de los fabricantes que tienen el
 mismo número de productos que el fabricante Lenovo.*/
SELECT COUNT(*) AS s, f.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
GROUP BY p.codigo_fabricante
HAVING s>=2

/*Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT nombre 
FROM producto p
WHERE p.precio >= ALL (SELECT precio FROM producto)

/*Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.*/
SELECT nombre 
FROM producto p
WHERE p.precio <= ALL (SELECT precio FROM producto)

/*Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).*/
SELECT f.nombre 
FROM fabricante f
WHERE codigo = ANY(SELECT codigo_fabricante FROM producto);

/* Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).*/
SELECT nombre FROM fabricante f
WHERE codigo <> ALL (SELECT codigo_fabricante FROM producto);

/*Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT f.nombre 
FROM fabricante f
WHERE codigo IN(SELECT codigo_fabricante FROM producto);

/* Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT f.nombre 
FROM fabricante f
WHERE codigo NOT IN(SELECT codigo_fabricante FROM producto);

/*Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT f.nombre 
FROM fabricante f
WHERE  EXISTS (SELECT codigo_fabricante FROM producto);

/*Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT f.nombre 
FROM fabricante f
WHERE NOT EXISTS (SELECT codigo_fabricante FROM producto WHERE codigo_fabricante = f.codigo);

/* Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.*/
SELECT f.nombre, precio
FROM fabricante f, producto p
WHERE precio = (SELECT MAX(precio)  AS cx FROM producto
					 WHERE codigo_fabricante = f.codigo )


/*Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos
 de su mismo fabricante.*/
SELECT *
FROM producto p
WHERE precio >= (SELECT AVG(precio)  AS cx FROM producto
					 WHERE codigo_fabricante = p.codigo_fabricante);


/*Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT p.nombre, MAX(precio) AS maxi
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
AND f.nombre = 'Lenovo'
GROUP BY p.nombre
LIMIT 1;

SELECT * FROM salaries
