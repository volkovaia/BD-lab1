CREATE table Technic_Type(
id_type SERIAL PRIMARY KEY,
model UUID DEFAULT gen_random_uuid(),
date_of_production DATE,
speed DOUBLE PRECISION);

CREATE table view(
id_view SERIAL PRIMARY KEY,
landscape TEXT CHECK(landscape ~ '^[^ ]* [^ ]* [^ ]*$'),
angle_of_curvature NUMERIC);


CREATE table Technic(
id_tehnic SERIAL PRIMARY KEY,
type SERIAL REFERENCES Technic_Type,
name TEXT CHECK(name ~ '^[a-zA-Zа-яА-Я0-9]+$'));

CREATE table Monitor(
id_monitor SERIAL PRIMARY KEY,
data BYTEA);

CREATE table transmission(
id_view SERIAL REFERENCES view(id_view),
id_monitor SERIAL REFERENCES monitor(id_monitor));

CREATE table people(
id_people SERIAL PRIMARY KEY,
condition BOOLEAN,
role TEXT CHECK(role ~ '^[a-zA-Zа-яА-Я]+$'));

CREATE table action(
	id_monitor SERIAL REFERENCES monitor(id_monitor),
	id_people SERIAL REFERENCES people(id_people));

CREATE table general_location(
	id_general_location SERIAL PRIMARY KEY REFERENCES location(id_location),
	id_view SERIAL REFERENCES view(id_view),
	name_of_area TEXT CHECK(name_of_area ~ '^[a-zA-Zа-яА-Я]+$'),
	height NUMERIC);

CREATE table location(
	id_location SERIAL PRIMARY KEY,
	id_tehnic SERIAL REFERENCES technic(id_tehnic),
	coordinates POINT,
	location_time TIMESTAMP,
	repetition INTEGER,
	interval TIME);



INSERT INTO Technic_Type(id_type, model, date_of_production, speed) VALUES
(1, default,  '2022-10-13', 50.3),
(2, default,  '2010-09-12',	40),
(3, default, '2009-12-05',	20),
(4, default, '2015-02-01',	41),
(5, default, '2023-05-03', 60),
(6, default,  '2004-10-21', 20),
(7, default,  '2021-10-09',	10);


INSERT INTO view(id_view, landscape, angle_of_curvature) VALUES
(default, 'меньшая грань области', 12.3),
(default, 'большая грань области', 40.9),
(default, 'гладкая однородная поверхность', 38.2),
(default, 'самая большая грань', 50.2);


INSERT INTO Monitor(id_monitor, data) VALUES
(default, '89 50 4e 47 0d 0a 1a 0a 00 00 00 0d 49 48 44'),
(default, '00 00 00 fb 00 00 00 7d 08 06 00 00 00 64 9b'),
(default, '63 00 00 00 01 73 52 47 42 00 ae ce 1c e9 00'),
(default, '00 09 70 48 59 73 00 00 0e c3 00 00 0e c3 01'),
(default, 'f0 65 e7 71 18 f8 73 27 e7 9c 33 26 21 07 92 ');

INSERT INTO transmission(id_view, id_monitor) VALUES
(1, 2), 
(2, 4),
(3, 1),
(4, 5);


INSERT INTO Technic(id_tehnic, type, name) VALUES
(1,	1,	'Нина'),
(2,	4,	'К9'),
(3,	6,	'K23'),
(4,	2,	'Open');

INSERT INTO general_location(id_general_location, id_view, height, name_of_area) VALUES
(1,	1, 50, 'Каньон'),
(2,	4, 5, 'Горы'),
(3,	3, 34, 'Равнина'),
(4,	2, 12б 'Плато');

INSERT INTO location(id_location, id_tehnic, coordinates, location_time) VALUES
(1,	1, POINT(49.234, 2.5273),	'2024-04-04 20:12:32.001'),
(2,	2, POINT(50.1, 3.8),	'2024-03-14 12:30:21.054'),
(3,	3, POINT(49.345, 3.5),	'2024-11-09 21:43:21.030'),
(4,	4, POINT(49.9, 3),	'2024-08-08 17:04:00.009');

INSERT INTO action(id_monitor, id_people) VALUES
(1, 3),
(4, 2),
(2, 1),
(5, 4);

INSERT INTO people (id_people, condition, role) VALUES
(1, 'TRUE', 'зритель'),
(2, 'FALSE', 'зритель'),
(3, 'TRUE', 'исследователь'),
(4, 'FALSE', 'исследователь');
