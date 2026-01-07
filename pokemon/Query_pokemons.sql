/*Mostrar el nombre de todos los pokemon*/
SELECT  pk.nombre AS Nombre_Pokemons
FROM pokemon pk;

/*mostrar los pokemon que pesen menos de 10k*/
SELECT *
FROM pokemon pk
WHERE pk.peso < 10 
ORDER BY peso ASC 

/* mostrar los pokemon de tipo agua.*/
SELECT pk.numero_pokedex,
		 pk.nombre
FROM pokemon pk
	JOIN pokemon_tipo pt ON pk.numero_pokedex = pt.numero_pokedex
	JOIN tipo t ON t.id_tipo = pt.id_tipo
WHERE t.nombre = 'Agua'

/* solucion con subconsulta*/
SELECT pk.numero_pokedex,
		 pk.nombre
FROM pokemon pk, pokemon_tipo pt
	WHERE pk.numero_pokedex = pt.numero_pokedex
	AND pt.id_tipo = (SELECT t.id_tipo
							FROM tipo t
							WHERE LOWER(t.nombre) = 'agua');



/*Mostrar los pokemon que son de tipo fuego y volador*/
SELECT p.nombre
FROM pokemon p
WHERE p.numero_pokedex IN(SELECT pt.numero_pokedex 
								  FROM pokemon_tipo pt, tipo t
								  WHERE pt.id_tipo = t.id_tipo AND LOWER(t.nombre) = 'fuego')
AND   p.numero_pokedex IN(SELECT pt.numero_pokedex 
								  FROM pokemon_tipo pt, tipo t
								  WHERE pt.id_tipo = t.id_tipo AND LOWER(t.nombre) = 'volador')
								  
/*Mostrar los pokemon con una estadistica base de ps mayor que 200*/
SELECT  p.nombre
FROM pokemon p, estadisticas_base eb
WHERE p.numero_pokedex = eb.numero_pokedex
AND eb.ps > 200

/**mostrar los datos(nombre, peso, altura) de la prevolucion de Arbok.*/
SELECT  	p.nombre,
 			p.peso,
 			p.altura
FROM pokemon p, evoluciona_de e
WHERE p.numero_pokedex = e.pokemon_origen
AND e.pokemon_evolucionado = (SELECT pp.numero_pokedex
										FROM pokemon pp
										WHERE LOWER(pp.nombre) ='arbok');
							  
/* Mostrar aquellos pokemon que evolucionan por intercambio.*/								  
SELECT  pk.nombre
FROM pokemon pk 
	 JOIN pokemon_forma_evolucion pfe ON pk.numero_pokedex = pfe.numero_pokedex
	 JOIN forma_evolucion fe ON pfe.id_forma_evolucion = fe.id_forma_evolucion
	 JOIN tipo_evolucion te ON fe.tipo_evolucion= te.id_tipo_evolucion
WHERE te.tipo_evolucion ='Intercambio';

/*Mostrar el nombre del movimiento con mas prioridad.*/								  
SELECT m.nombre AS Nombre_Movimiento 
FROM movimiento m	
WHERE m.prioridad > 0;							
								  
/*Mostrar el pokemon mas pesado.*/
SELECT pk.nombre AS Pokemon_Mas_Pesado
FROM pokemon pk
ORDER BY pk.peso DESC 
LIMIT 1;								  
								  
/*Mostrar el nombre y tipo del ataque con mas potencia.*/								  
SELECT tp.nombre, MAX(eb.ataque) AS Maximo
FROM tipo tp
JOIN estadisticas_base eb ON tp.id_tipo_ataque = tp.id_tipo_ataque
GROUP BY tp.nombre
ORDER BY tp.nombre ASC;							  
					  
/*Mostrar el numero de movimientos de cada tipo.*/								  
SELECT t.nombre , COUNT(*) AS Numero_Movimientos
FROM	tipo t
JOIN movimiento mv ON t.id_tipo = mv.id_tipo
GROUP BY t.nombre				  
								  
/* Mostrar todos los movimientos que puedan envenenar.*/								  
SELECT mv.nombre
FROM movimiento mv
	JOIN movimiento_efecto_secundario mes ON mv.id_movimiento =mes.id_movimiento
	JOIN efecto_secundario es ON mes.id_efecto_secundario = es.id_efecto_secundario
WHERE LOWER(es.efecto_secundario) LIKE '%envenena%'

/* Mostrar todos los movimientos que aprende pikachu.*/
SELECT m.nombre 
FROM movimiento m
	JOIN pokemon_movimiento_forma pmf ON m.id_movimiento = pmf.id_movimiento
	JOIN pokemon p ON p.numero_pokedex = pmf.numero_pokedex
WHERE LOWER(p.nombre) = 'pikachu';

/*Mostrar todos los movimientos que aprende pikachu por MT.*/
SELECT m.nombre 
FROM movimiento m
	JOIN pokemon_movimiento_forma pmf ON m.id_movimiento = pmf.id_movimiento
	JOIN pokemon p ON p.numero_pokedex = pmf.numero_pokedex
	JOIN forma_aprendizaje fa ON fa.id_forma_aprendizaje = pmf.id_forma_aprendizaje
	JOIN tipo_forma_aprendizaje tfa ON fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje
WHERE LOWER(p.nombre) = 'pikachu' AND LOWER (tfa.tipo_aprendizaje) = 'mt';
								  
/*Mostrar todos los movimientos de tipo normal que aprende pikachu por nivel.*/								 						  
SELECT m.nombre 
FROM movimiento m
	JOIN pokemon_movimiento_forma pmf ON m.id_movimiento = pmf.id_movimiento
	JOIN pokemon p ON p.numero_pokedex = pmf.numero_pokedex
	JOIN forma_aprendizaje fa ON fa.id_forma_aprendizaje = pmf.id_forma_aprendizaje
	JOIN tipo_forma_aprendizaje tfa ON fa.id_tipo_aprendizaje = tfa.id_tipo_aprendizaje
	JOIN tipo t ON m.id_tipo = t.id_tipo
WHERE LOWER(p.nombre) = 'pikachu'
AND LOWER(t.nombre) = 'normal'
AND LOWER (tfa.tipo_aprendizaje) = 'nivel';
								  
								  
/* Mostrar todos los pokemon que evolucionan por piedra. Hacer una vista de ello.*/								  
CREATE OR REPLACE VIEW POKEMON_EVOLUCION_PIEDRA AS 
SELECT 
p.nombre AS Nombre_Pokemon 
FROM pokemon p 
JOIN pokemon_forma_evolucion pfe ON p.numero_pokedex = pfe.numero_pokedex
JOIN forma_evolucion fe ON pfe.id_forma_evolucion = fe.id_forma_evolucion 
JOIN tipo_evolucion te ON fe.tipo_evolucion = te.id_tipo_evolucion
WHERE LOWER(te.tipo_evolucion) = 'piedra'
								  
SELECT * FROM POKEMON_EVOLUCION_PIEDRA;								  

/*Mostrar todos los pokemon que no pueden evolucionar. Hacer una vista de ello.*/	
CREATE OR REPLACE VIEW POKEMONS_QUE_N0_EVOLUCIONAN	AS 				  
SELECT p.numero_pokedex, p.nombre 
FROM pokemon p						  					 
JOIN evoluciona_de ed ON p.numero_pokedex = ed.pokemon_evolucionado
AND NOT EXISTS(SELECT pokemon_origen 
											 FROM evoluciona_de WHERE pokemon_origen = p.numero_pokedex)
											 
UNION 
						  				  
SELECT p.numero_pokedex, p.nombre 
FROM pokemon p						  					 
WHERE NOT EXISTS(SELECT pokemon_evolucionado
					  FROM evoluciona_de 
					  WHERE pokemon_evolucionado = p.numero_pokedex) 
											 
/*Mostrar la cantidad de los pokemon de cada tipo. Hacer una vista de ello.*/											 
CREATE OR REPLACE VIEW CANTIDAD_POKEMONS_TIPO AS 
SELECT COUNT(*) AS Cantidad,t.id_tipo, t.nombre
FROM pokemon p	
JOIN pokemon_tipo pt ON p.numero_pokedex =pt.numero_pokedex
JOIN tipo t ON pt.id_tipo = t.id_tipo
GROUP BY t.nombre, t.id_tipo							
ORDER BY pt.id_tipo ASC; 

SELECT * FROM cantidad_pokemos_tipo;






































