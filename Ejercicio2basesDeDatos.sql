-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;

-- 3. Lista todas las columnas de la tabla producto.
SELECT * FROM producto;

-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre AS Producto, round(precio) AS Valor
FROM producto;

-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT fabricante.nombre AS Fabricante, codigo_fabricante AS Código 
FROM fabricante
INNER JOIN producto ON producto.codigo_fabricante = fabricante.codigo;

-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
 SELECT DISTINCT fabricante.codigo, codigo_fabricante
 FROM fabricante 
 INNER JOIN producto ON producto.codigo_fabricante = fabricante.codigo;
 
-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre AS Fabricante 
FROM fabricante ORDER BY nombre ASC;

-- 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre, precio
FROM producto ORDER BY nombre ASC;
SELECT nombre AS Producto, precio 
FROM producto ORDER BY precio DESC;

-- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;

-- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre AS Producto, precio
FROM producto
ORDER BY precio ASC LIMIT 1;

-- 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre AS Producto , precio
FROM producto
ORDER BY precio DESC LIMIT 1;

-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT nombre AS Producto , precio
FROM producto
WHERE precio <= 120;

-- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT nombre AS Producto , precio
FROM producto
WHERE precio BETWEEN 60 AND 200;

-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT nombre AS Producto, codigo_fabricante
FROM producto
WHERE codigo_fabricante IN(1, 3, 5);

-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre AS Producto 
FROM producto
WHERE nombre LIKE '%Portátil%';

-- CONSULTAS MULTITABLAS
-- 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, 
-- de todos los productos de la base de datos.
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre
FROM producto
INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
-- Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
LEFT JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante 
ORDER BY fabricante.nombre ASC;

-- 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT producto.nombre AS Producto, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante 
ORDER BY precio ASC LIMIT 1;

-- 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT producto.nombre AS Producto, fabricante.nombre
FROM fabricante
RIGHT JOIN producto ON fabricante.codigo = producto.codigo_fabricante 
WHERE fabricante.nombre LIKE 'Lenovo';

-- 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT producto.nombre AS Producto, fabricante.nombre
FROM producto
INNER JOIN fabricante on fabricante.codigo = producto.codigo_fabricante 
WHERE fabricante.nombre LIKE 'Crucial' AND precio > 200;

-- 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
SELECT producto.nombre AS Producto, fabricante.nombre
FROM producto
INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante 
WHERE fabricante.nombre IN('Asus', 'Hewlett-Packard');

-- 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. 
-- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT producto.nombre AS Producto, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.precio >= 180 
ORDER BY producto.precio DESC, producto.nombre ASC;

										-- CONSULTAS MULTITABLAS
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
-- 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
-- El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT fabricante.nombre AS Fabricante, producto.nombre AS Producto
FROM producto
RIGHT JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante;

-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT *
FROM fabricante
LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.codigo_fabricante IS NULL;

										-- SUBCONSULTAS (En la cláusula WHERE) Con operadores básicos de comparación
-- 1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT producto.nombre AS Producto
FROM producto 
WHERE producto.codigo_fabricante = 
	(SELECT fabricante.codigo  
	 FROM fabricante 
     WHERE fabricante.nombre LIKE 'Lenovo');

-- 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT *
FROM producto
WHERE precio = (select max(precio) FROM producto WHERE codigo_fabricante = 
(SELECT codigo from fabricante where nombre = 'Lenovo'));

-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT producto.nombre 
FROM producto 
WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = 
(SELECT codigo FROM fabricante WHERE nombre = 'Lenovo' ));

-- 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT * 
FROM producto
WHERE precio > (SELECT avg(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus')) 
AND codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus');

										-- SUBCONSULTAS con IN y NOT IN
-- 1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto);
-- 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);

										-- SUBCONSULTAS (En la cláusula HAVING)
-- 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
SELECT fabricante.nombre 
FROM fabricante 
WHERE codigo 
IN (SELECT producto.codigo_fabricante FROM producto GROUP BY producto.codigo_fabricante HAVING count(*) = 
(SELECT codigo FROM fabricante WHERE nombre = 'Lenovo' ));  

