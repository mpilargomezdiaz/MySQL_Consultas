USE sakila;

SELECT * FROM actor;

-- 1. - Obtén una lista de todos los actores de Sakila, mostrando nombre y apellido, ordenados alfabéticamente por apellido.

SELECT first_name, last_name FROM actor ORDER BY last_name ASC;

-- 2.- Muestra el título, el año de lanzamiento y la duración de las películas de Sakila, ordenadas por duración de manera descendente.

SELECT title, release_year, rental_duration FROM film ORDER BY rental_duration DESC;

-- 3.- Encuentra el número total de películas por categoría en Sakila.

SELECT category_id, COUNT(*) AS
total_peliculas
FROM film_category
GROUP BY category_id;

-- 4.- Lista los clientes de Sakila junto con el número total de alquileres que han realizado.

  SELECT
    customer_id,
    count(*) as Numero_de_rentas
FROM
    rental
GROUP BY
  customer_id;

------------------------- COMPLETO -------------------------

  SELECT 
    c.first_name,
    c.last_name,
    COUNT(*) AS Numero_de_rentas
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 5.- Muestra el nombre y la población de las 10 ciudades más pobladas de World.

SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 10;

-- 6.- Encuentra los actores de Sakila que han aparecido en más de 20 películas, junto con el número de películas en las que han actuado.

 SELECT
    actor_id,
    count(*) as Numero_de_apariciones
FROM
    film_actor
GROUP BY
  actor_id
  HAVING Numero_de_apariciones >20;

------------------------- COMPLETO -------------------------

   SELECT 
    a.first_name,
    a.last_name,
    COUNT(*) AS Numero_de_apariciones
FROM film_actor fa
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
 HAVING Numero_de_apariciones >20;

-- 7.- Lista los países de World y sus capitales, mostrando también el nombre del continente.
 
    SELECT 
    co.Name AS Pais,
    ci.Name AS Capital,
    co.Continent AS Continente
FROM Country co, City ci
WHERE co.Capital = ci.ID;

-- 8.- Encuentra las películas de Sakila que tienen una duración superior al promedio.

SELECT title, length FROM film
WHERE length > (SELECT AVG(length) 
FROM film);

-- 9.- Muestra los clientes de Sakila que han gastado más de $100 en alquileres, junto con su gasto total.

SELECT
customer_id,
SUM(amount) AS alquiler
FROM
payment
GROUP BY
customer_id;

-------------------------------------------------------------------------

    SELECT
  customer_id,
    SUM(amount) AS alquiler
FROM
    payment
GROUP BY
    customer_id
    HAVING alquiler >100;

  ------------------------- COMPLETO -------------------------

SELECT 
c.first_name,
c.last_name,
SUM(amount) AS alquiler
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY  c.customer_id, c.first_name, c.last_name
HAVING alquiler >100;

-- 10.- Para cada país en World, muestra el idioma más hablado (excluyendo el idioma oficial).

SELECT 
    co.Name AS Pais,
    cl.Language AS Idioma,
    cl.Percentage AS Porcentaje
FROM country co
JOIN countrylanguage cl ON co.Code = cl.CountryCode
WHERE cl.IsOfficial = 'F'
AND cl.Percentage = (
    SELECT MAX(Percentage) 
    FROM countrylanguage 
    WHERE CountryCode = cl.CountryCode AND IsOfficial = 'F'
);

-- 11.- Encuentra las categorías de películas en Sakila que tienen un promedio de duración de película superior a 120 minutos.

SELECT
    category_id,
    count(*) as veces_categoria
FROM
    film_category
GROUP BY
   category_id;


----------------------------------------------------

   SELECT 
    c.name,
    COUNT(*) AS veces_categoria
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name;

----------------------------------------------------

SELECT
  c.name,
  f.length
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
JOIN film f ON fc.film_id = f.film_id;

------------------------- COMPLETO -------------------------

SELECT 
    c.name,
    AVG(f.length) AS duracion_categoria
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
HAVING AVG(f.length) > 120;