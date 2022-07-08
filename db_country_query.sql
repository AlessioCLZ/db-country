-- Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq

SELECT *
FROM countries c 
WHERE c.name LIKE 'P%' AND c.area > 1000;

-- Selezionare le nazioni il cui national day è avvenuto più di 100 anni fa
SELECT *
FROM countries c 
WHERE TIMESTAMPDIFF(YEAR, c.national_day , CURDATE()) > 100;

-- Selezionare il nome delle regioni del continente europeo, in ordine alfabetico

SELECT *
FROM regions r 
WHERE r.name LIKE '%Europe%'
order by r.name;

-- Contare quante lingue sono parlate in Italia

SELECT COUNT(l.language_id) as spoken_languages
FROM languages l 
inner join country_languages cl 
on cl.language_id  = l.language_id 
inner JOIN countries c 
on cl.country_id = c.country_id 
where c.name = 'Italy';

-- Selezionare quali nazioni non hanno un national day
SELECT *
FROM countries c 
WHERE c.national_day IS NULL;

-- Per ogni nazione selezionare il nome, la regione e il continente

SELECT c.name as nazione, r.name as regione, c2.name as continente
FROM countries c 
JOIN regions r 
on c.region_id = r.region_id 
JOIN continents c2 
on c2.continent_id = r.continent_id
GROUP BY c.name , r.name , c2.name 
ORDER BY c.name ASC ;


-- Modificare la nazione Italy, inserendo come national day il 2 giugno 1946
UPDATE countries set national_day = '1946-06-02'
WHERE name LIKE  'Italy';

-- Per ogni regione mostrare il valore dell'area totale
SELECT r.name as regione , SUM(c.area) as  area_regione 
FROM regions r 
join countries c 
on c.region_id = r.region_id 
GROUP BY r.name 
ORDER BY r.name ;

-- Selezionare le lingue ufficiali dell'Albania
SELECT l.`language` as lingue_ufficiali_albania
FROM countries c 
join country_languages cl 
on cl.country_id = c.country_id 
join languages l 
on l.language_id = cl.language_id 
where c.name LIKE 'Albania' and cl.official IS TRUE ;

-- Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010

SELECT c.name as nazione , AVG(cs.gdp) as media_pil_2000_2010
from countries c 
join country_stats cs 
on cs.country_id = c.country_id 
where c.name LIKE 'United Kingdom' AND cs.`year` >=2000 and cs.`year` <= 2010
GROUP by c.name ;

-- Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa

SELECT c.name as nazioni_hindi
FROM countries c 
join country_languages cl 
on c.country_id =cl.country_id 
JOIN languages l 
on l.language_id =cl.language_id 
WHERE l.`language` like 'Hindi'
ORDER BY c.area DESC ;

-- Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq ordinando i risultati a partire dal continente che ne ha di più 
SELECT c.name as continente, count(c2.country_id) as numero_nazioni_con_area_superiore_a_10k
FROM continents c 
join regions r 
on c.continent_id = r.continent_id 
join countries c2 
on c2.region_id = r.region_id 
where c2.area > 10000
GROUP BY c.name 
ORDER BY numero_nazioni_con_area_superiore_a_10k DESC ;















