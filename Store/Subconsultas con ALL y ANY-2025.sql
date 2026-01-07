-- Subconsultas con ALL y ANY:

/*7. Subconsultas (En la cláusula HAVING). Devuelve un listado con todos los nombres de los fabricantes que
 tienen el mismo número de productos que el fabricante Lenovo.*/
SELECT f.nombre, COUNT(*) AS conteo
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo
GROUP BY f.nombre
HAVING COUNT(*) = (SELECT COUNT(*) 
						FROM producto 
						WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE UPPER(nombre)='LENOVO'));
						
/*8. Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.*/
SELECT * FROM producto WHERE precio >= ALL(SELECT precio FROM producto);

/*Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT*/
SELECT * FROM producto WHERE precio <= ALL(SELECT precio FROM producto);

/*Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).*/
SELECT nombre FROM fabricante
 WHERE codigo = ANY(SELECT codigo_fabricante FROM producto);
 
 /*Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).*/
 SELECT nombre FROM fabricante
 WHERE codigo <> ALL(SELECT codigo_fabricante FROM producto);
 
 
 
 -- Subconsultas con IN y NOT IN:

/*12. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT f.nombre FROM fabricante f WHERE f.codigo IN(SELECT p.codigo_fabricante FROM producto p);

/*13. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT f.nombre FROM fabricante f WHERE f.codigo  NOT IN(SELECT p.codigo_fabricante FROM producto p);

 
 -- Subconsultas con EXISTS y NOT EXISTS:

/*14. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT * FROM fabricante f WHERE EXISTS (SELECT codigo_fabricante FROM producto p WHERE p.codigo_fabricante = f.codigo);

/*15. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).*/
SELECT * FROM fabricante f WHERE NOT EXISTS (SELECT codigo_fabricante FROM producto p WHERE p.codigo_fabricante = f.codigo);


-- Subconsultas relacionadas:

/*16. Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.*/
SELECT f.nombre, p.nombre, p.precio 
FROM fabricante f, producto p
WHERE p.codigo_fabricante =f.codigo AND p.precio=  (SELECT MAX(precio) FROM producto WHERE p.codigo_fabricante = f.codigo);
	
/*17. Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.*/
SELECT * FROM producto p
WHERE p.precio >= (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = p.codigo_fabricante);

/*18. Lista el nombre del producto más caro del fabricante Lenovo.*/
select nombre from producto 
where precio = (select max(precio) 
                from producto 
                where codigo_fabricante = (select codigo from fabricante where upper(nombre) = 'LENOVO'))
and codigo_fabricante = (select codigo from fabricante where upper(nombre) = 'LENOVO');


 