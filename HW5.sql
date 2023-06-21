CREATE DATABASE IF NOT EXISTS HW5;
USE HW5;
DROP TABLE IF EXISTS cars;
CREATE TABLE IF NOT EXISTS cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
-- SELECT *
-- FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
CREATE OR REPLACE VIEW expensive_cars 
AS SELECT 
    name,
    cost
FROM cars 
WHERE cost < 25000
ORDER BY cost;

SELECT * 
FROM expensive_cars;

-- 2. Изменить в существующем представлении порог
-- для стоимости: пусть цена будет до 30 000 долларов
-- (используя оператор ALTER VIEW) 

ALTER VIEW expensive_cars 
AS SELECT 
    name,
    cost
FROM cars 
WHERE cost < 30000
ORDER BY cost;

SELECT * 
FROM expensive_cars;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE OR REPLACE VIEW skoda_n_audi 
AS SELECT 
	name,
    cost
FROM cars 
WHERE name = 'Skoda' OR name = 'Audi'
ORDER BY name;

SELECT * 
FROM skoda_n_audi;

DROP TABLE IF EXISTS trains;
CREATE TABLE IF NOT EXISTS trains
(
	train_id INT,
    station_character_varying VARCHAR(20),
    station_time_without_time_zone TIME
);

INSERT INTO trains
VALUES
	(110, 'San Francisco', '10:00:00'),
	(110, 'Redwood City', '10:54:00'),
	(110, 'Palo Alto', '11:02:00'),
	(110, 'San Jose', '12:35:00'),
	(120, 'San Francisco', '11:00:00'),
	(120, 'Palo Alto', '12:49:00'),
	(120, 'San Jose', '13:30:00');    

SELECT * FROM trains;

CREATE OR REPLACE VIEW trains_plus AS
SELECT *,
TIMEDIFF(LEAD(station_time_without_time_zone)
    OVER (PARTITION BY train_id
    ORDER BY station_time_without_time_zone), station_time_without_time_zone) 'time_to_next_station' 
from trains;

SELECT *
FROM trains_plus
