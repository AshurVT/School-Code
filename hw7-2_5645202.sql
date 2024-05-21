--
-- Homework 7.2: SQL-DML
-- @author: Joshua Erikson, 5645202
-- NAU, CS 345, Spring 2024
--

--
-- DDL Statements
-- --------------
-- IMPORTANT NOTE: use the following DDL statements to create your initial 
-- database.

-- drop the database
DROP DATABASE IF EXISTS airline_db;
-- create the database
CREATE DATABASE IF NOT EXISTS airline_db;
-- select airline_db as the context
USE airline_db;
-- create the table Pilot
CREATE TABLE Pilot (
    identification INT PRIMARY KEY NOT NULL,
    pilot_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2),
    gratification DECIMAL(10, 2),
    airline_name VARCHAR(30),
    country VARCHAR(15)
);
-- create the table Airport
CREATE TABLE Airport(acronym VARCHAR(3) PRIMARY KEY NOT NULL,
                    airport_name VARCHAR(100) NOT NULL,
                    city VARCHAR(50),
                    country VARCHAR(15));
-- create the table Flight
CREATE TABLE Flight(flight_number VARCHAR(6) PRIMARY KEY NOT NULL,
                    departure_airport VARCHAR(3) NOT NULL,
                    destination_airport VARCHAR(3) NOT NULL,
                    departure_time TIME,
                    FOREIGN KEY (departure_airport) REFERENCES 
						Airport(acronym) ON DELETE CASCADE,
                    FOREIGN KEY (destination_airport) REFERENCES 
						Airport(acronym) ON DELETE CASCADE);
-- create the table Stopover
CREATE TABLE Stopover(flight_number VARCHAR(6) NOT NULL,
                    flight_date DATE NOT NULL,
                    pilot_id INT NOT NULL,
                    aircraft VARCHAR(30),
                    PRIMARY KEY(flight_number, flight_date),
                    FOREIGN KEY (flight_number) REFERENCES 
						Flight(flight_number) ON DELETE CASCADE,
                    FOREIGN KEY (pilot_id) REFERENCES Pilot(identification) ON 
						DELETE CASCADE
);

--
-- DML Statements
-- --------------
-- IMPORTANT NOTE: use the following DML statements to populate your initial
-- database.

insert into Pilot values
	(279, "Steven Grant Rogers", 30000.00, 500.00, "American Airlines", "USA"),
    (627, "Wanda Maximoff", 30000.00, 500.00, "American Airlines", "USA"),
    (947, "Natasha Romanoff", 25000.00, 800.00, "United", "USA"),
    (463, "Anthony Edward Stark", 20000.00, 800.00, "United", "USA"),
    (839, "Robert Bruce Banner", 35000.00, 500.00, "American Airlines", "USA"),
    (628, "Carol Susan Jane Danvers", 30000.00, 500.00, "Air France", "France"),
    (832, "Clinton Francis Barton", 20000.00, 800.00, "Air Canada", "Canada"),
    (602, "Stephen Vincent Strange", 25000.00, 800.00, "Air Canada", "Canada"),
    (633, "Victor Shade", 28000.00, 600.00, "Air France", "France"),
    (382, "Jessica Jones", 35000.00, 700.00, "Japan Airlines", "Japan"),
    (489, "Clark Joseph Kent", 29000.00, 500.00, "American Airlines", "USA"),
    (847, "Oliver Jonas Queen", 32000.00, 400.00, "Air Canada", "Canada"),
    (932, "Wade Winston Wilson", 35000.00, 200.00, "Air France", "France"),
    (887, "Stephen Vincent Strange", 29000.00, 500.00, "Japan Airlines", "Japan");

insert into Airport values
    ("LAS", "Harry Reid International Airport", "Las Vegas", "USA"),
    ("PHX", "Phoenix Sky Harbor Airport", "Phoenix", "USA"),
    ("DFW", "Dallas Fort Worth Airport", "Dallas", "USA"),
    ("IAH", "George Bush Intercontinental Airport", "Houston", "USA"),
    ("LAX", "Los Angeles International Airport", "Los Angeles", "USA"),
    ("GRU", "Guarulhos International Airport", "Guarulhos", "Brazil"),
    ("BSB", "Presidente Juscelino Kubitschek International Airport", "Brasilia",
		"Brazil"),
    ("MAO", "Eduardo Gomes International Airport", "Manaus", "Brazil"),
    ("CDG", "Aéroport Paris-Charles de Gaulle", "Paris", "France"),
    ("LYS", "Aéroport Lyon Saint-Exupéry", "Lyon", "France"),
    ("MRS", "Marseille Provence Airport", "Marselha", "France");

insert into Flight values
    ("RG230", "LAX", "PHX", "23:05"),
    ("PR231", "IAH", "LAS", "12:15"),
    ("TG331", "DFW", "LAX", "17:22"),
    ("AV431", "PHX", "GRU", "02:10"),
    ("KI356", "IAH", "MAO", "23:55"),
    ("OD468", "BSB", "LAX", "11:45"),
    ("PS324", "PHX", "GRU", "22:19"),
    ("OO677", "GRU", "DFW", "18:52"),
    ("TW873", "GRU", "LYS", "18:52"),
    ("IE832", "LYS", "MRS", "04:40"),
    ("JD646", "CDG", "LYS", "05:00"),
    ("MD342", "CDG", "BSB", "08:34"),
    ("UJ658", "LAS", "IAH", "08:34"),
    ("GF774", "LAS", "DFW", "08:34");

insert into Stopover values
    ("RG230", "2022-12-30", 279, "Boeing 747"),
    ("RG230", "2022-09-24", 628, "Boeing 747"),
    ("PR231", "2022-08-15", 279, "Airbus A380"),
    ("PR231", "2022-01-12", 947, "Airbus A380"),
    ("TG331", "2022-02-05", 947, "Boeing 747"),
    ("TG331", "2022-01-12", 627, "Airbus A380"),
    ("AV431", "2022-12-04", 463, "Embraer 195"),
    ("AV431", "2022-10-30", 839, "Airbus A380"),
    ("KI356", "2022-09-07", 463, "Embraer 195"),
    ("KI356", "2022-08-13", 463, "Embraer 175"),
    ("OD468", "2022-03-13", 839, "Airbus A330"),
    ("OD468", "2022-04-01", 839, "Airbus A330"),
    ("OD468", "2022-04-02", 839, "Airbus A330"),
    ("PS324", "2022-03-15", 627, "Airbus A320"),
    ("PS324", "2022-03-18", 627, "Embraer 195"),
    ("OO677", "2022-02-09", 832, "Embraer 195"),
    ("OO677", "2022-02-01", 832, "Boeing 797"),
    ("TW873", "2022-12-11", 602, "Boeing 797"),
    ("TW873", "2022-11-17", 633, "Boeing 797"),
    ("IE832", "2022-05-17", 633, "Embraer 195"),
    ("IE832", "2022-08-16", 602, "Embraer 175"),
    ("JD646", "2022-09-27", 602, "Embraer 175"),
    ("JD646", "2022-09-29", 832, "Airbus A320"),
    ("MD342", "2022-09-29", 382, "Airbus A320"),
    ("MD342", "2022-10-31", 382, "Airbus A330"),
    ("UJ658", "2022-03-30", 633, "Boeing 797"),
    ("UJ658", "2022-02-25", 279, "Boeing 797"),
    ("GF774", "2022-01-22", 602, "Boeing 747"),
    ("GF774", "2022-01-12", 633, "Boeing 747");
-- --------------
-- 

-- IMPORTANT NOTE: add the DML statements here. After Homework 6 deadline has 
-- passed, the statements to be added here will be provided on Canvas (same
-- script used in hw7-1).


--
-- DQL Statements
-- --------------

--
-- Output 1: pilot's total income (salary + gratification) for pilots with
-- flight date before 2022-11-14
-- ------------------------------------------------------------------------
--  pilot income before 22-11-14 using join
SELECT p.identification, p.pilot_name,
(p.salary + p.gratification) AS "(p.salary + p.gratification)"
FROM Pilot p
JOIN Stopover s ON p.identification = s.pilot_id
WHERE s.flight_date < '2022-11-14'
GROUP BY p.identification;

--
-- Output 2: airport info for flight RG230
-- ---------------------------------------
-- city and country for flight rg230
SELECT a.city, a.country
FROM Airport a
JOIN Flight f ON a.acronym = f.destination_airport
WHERE f.flight_number = 'RG230';

--
-- Output 3: airlines of pilots who flew on 2022-01-12
-- ---------------------------------------------------
-- airlines with pilots who flew prior to date provided
SELECT DISTINCT p.airline_name
FROM Pilot p
JOIN Stopover s ON p.identification = s.pilot_id
WHERE s.flight_date = '2022-01-12';

--
-- Output 4: detailed stopover information
-- ---------------------------------------
-- flight number, pilot, aircraft, and airline name for stopovers
SELECT s.flight_number, p.pilot_name, s.aircraft, p.airline_name
FROM Stopover s
JOIN Pilot p ON s.pilot_id = p.identification
ORDER BY s.flight_number ASC, p.pilot_name DESC;

--
-- Output 5: detailed stopover information for airlines with pilots from
-- outside the USA
-- ---------------------------------------------------------------------
-- flight number depart time pilot name aircraft airline name for pilots not from usa
SELECT 
f.flight_number, f.departure_time, p.pilot_name, s.aircraft, p.airline_name
FROM Stopover s
JOIN Flight f ON s.flight_number = f.flight_number
JOIN Pilot p ON s.pilot_id = p.identification
WHERE p.country != 'USA'
ORDER BY f.flight_number ASC, p.pilot_name DESC;


--
-- Output 6: pilot's name with flight information, if any
-- ------------------------------------------------------
-- pilot name flight number and date from stopover
SELECT p.pilot_name, s.flight_number, s.flight_date
FROM Stopover s
JOIN Pilot p ON s.pilot_id = p.identification
ORDER BY p.identification;

--
-- Output 7: flights that departure in the morning (0-11) OR in January
-- (month 01)
-- --------------------------------------------------------------------
-- flights leaving in morning or jan
SELECT DISTINCT f.flight_number
FROM Flight f
JOIN Stopover s ON f.flight_number = s.flight_number
WHERE HOUR(f.departure_time) <12
OR MONTH(s.flight_date) = 1;

--
-- Output 8: Canadian pilots who have flown three or more flights in
-- order of salary
-- ------------------------------------------------------------------
-- pilot name, number of fights and average salary for canada pilots with 3+ flights
SELECT p.pilot_name, COUNT(s.flight_number) AS total_flights, p.salary AS avg_salary
FROM Pilot p
JOIN Stopover s ON p.identification = s.pilot_id
WHERE p.country = 'Canada'
GROUP BY p.pilot_name, p.salary
ORDER BY p.salary DESC;

-- ------------------------------------------------------
-- THE FOLLOWING STATEMENTS REQUIRE AT LEAST ONE SUBQUERY 
-- ------------------------------------------------------

--
-- Output 9: flight information for flights to Brazil or France
-- ------------------------------------------------------------
-- flgiht info for flights to and from france or brazil. 
-- AI prompt: where is the pattern here?
-- AI was not helpful. dang
SELECT f.flight_number, da.country AS destination_country, f.departure_time, s.flight_date
FROM Flight f
JOIN Airport a ON f.departure_airport = a.acronym
JOIN Stopover s ON f.flight_number = s.flight_number
JOIN Airport da ON f.destination_airport = da.acronym
WHERE da.country IN ('Brazil', 'France')
ORDER BY da.acronym;

--
-- Output 10: pilot information for pilots in Wanda Maximoff's
-- airline
-- -----------------------------------------------------------
-- pilot name and airline for wanda maximoff
SELECT p.pilot_name, p.airline_name
FROM Pilot p
WHERE p.airline_name = (SELECT p2.airline_name FROM Pilot p2 WHERE p2.pilot_name = 'Wanda Maximoff')
ORDER BY p.pilot_name;

--
-- Output 11: airlines that have France as a destination
-- -----------------------------------------------------
-- france destination by airline name
SELECT DISTINCT p.airline_name
FROM Pilot p
JOIN Stopover s ON p.identification = s.pilot_id
JOIN Flight f ON s.flight_number = f.flight_number
JOIN Airport a ON f.destination_airport = a.acronym
WHERE a.country = 'France';

--
-- Output 12: American Airlines' destination airports
-- --------------------------------------------------
-- american airlines destinations
SELECT DISTINCT s.flight_number, a.airport_name, a.city, a.country
FROM Airport a
JOIN Flight f ON a.acronym = f.destination_airport
JOIN Stopover s ON f.flight_number = s.flight_number
JOIN Pilot p ON s.pilot_id = p.identification
WHERE p.airline_name = 'American Airlines';

--
-- Output 13: destination of flights with more than two stopovers
-- --------------------------------------------------------------
-- >2 stopovers by airport name
SELECT a.airport_name
FROM Flight f
JOIN Airport a ON f.destination_airport = a.acronym
WHERE f.flight_number IN (
SELECT s.flight_number 
FROM Stopover s 
GROUP BY s.flight_number 
HAVING COUNT(*) >2
);

--
-- Output 14: airports for flights on 2022-01-12
-- ---------------------------------------------
-- flights on specified date
SELECT DISTINCT f.flight_number, de.airport_name AS 'departure', da.airport_name AS 'destination'
FROM Flight f
INNER JOIN Stopover s ON f.flight_number = s.flight_number
INNER JOIN Airport de ON f.departure_airport = de.acronym
INNER JOIN Airport da ON f.destination_airport = da.acronym
WHERE s.flight_date = '2022-01-12';

--
-- Output 15: destination of United operated flights in Embraer
-- aircrafts
-- ------------------------------------------------------------
-- united flights using embraer aircrafts
SELECT DISTINCT f.flight_number, a.airport_name, a.city
FROM Flight f
JOIN Stopover s ON f.flight_number = s.flight_number
JOIN Pilot p ON s.pilot_id = p.identification
JOIN Airport a ON f.destination_airport = a.acronym
WHERE p.airline_name = 'United' AND s.aircraft LIKE 'Embraer%';

--
-- Output 16: domestic flights
-- ---------------------------
-- flights from and to same country
SELECT DISTINCT f.flight_number, f.departure_time, de.country AS departureCountry, da.country AS destinationCountry
FROM Flight f
INNER JOIN Airport de ON f.departure_airport = de.acronym
INNER JOIN Airport da ON f.destination_airport = da.acronym
WHERE de.country = da.country
ORDER BY f.flight_number;

--
-- Output 17: airports where American Airlines operates
-- ----------------------------------------------------
-- airports wher american airlines comes and goes
SELECT DISTINCT a.airport_name
FROM Airport a
JOIN Flight f ON a.acronym = f.departure_airport OR a.acronym = f.destination_airport
JOIN STOPOVER s ON f.flight_number = s.flight_number
JOIN Pilot p ON s.pilot_id = p.identification
WHERE p.airline_name = 'American Airlines';


--
-- Output 18: total income for pilots with the lowest gratification
-- -------------------------------------------------------------------
-- income for lowest grat pilot
SELECT p.identification AS 'identification', (p.salary + p.gratification) AS '(salary + gratification)'
FROM Pilot p
WHERE p.gratification = (SELECT MIN(gratification) FROM Pilot);

--
-- Output 19: pilots who fly to their own country in Boing aircrafts
-- -------------------------------------------------------------------
--  domestic pilots in boeings
SELECT DISTINCT p.identification AS 'identification', p.pilot_name AS 'pilot_name'
FROM Pilot p 
JOIN Stopover s ON p.identification = s.pilot_id
JOIN Flight f ON s.flight_number = f.flight_number
JOIN Airport a ON f.destination_airport = a.acronym
WHERE p.country = a.country AND s.aircraft LIKE 'Boeing%';

--
-- Output 20: international flights departing from the pilot's country
-- -------------------------------------------------------------------
-- flights to another country from pilots home
SELECT DISTINCT f.flight_number AS 'flight_number'
FROM Flight f
INNER JOIN Airport de ON f.departure_airport = de.acronym
INNER JOIN Airport da ON f.destination_airport = da.acronym
INNER JOIN Stopover s ON f.flight_number = s.flight_number
INNER JOIN Pilot p ON s.pilot_id = p.identification
WHERE p.country = de.country AND p.country != da.country
ORDER BY f.flight_number;

--
-- Output 21:flight information for flights by American pilots with
-- greater salary than the average salaries of American pilots
-- -----------------------------------------------------------------
-- pilots making more than average
SELECT DISTINCT f.flight_number, f.departure_time, s.aircraft
FROM Pilot p
JOIN Stopover s ON p.identification = s.pilot_id
JOIN Flight f ON s.flight_number = f.flight_number
WHERE p.country = 'USA' AND p.salary > (SELECT AVG(salary) FROM Pilot WHERE country = 'USA');

--
-- Output 22: salaries per airlines who have pilots who have not flown
-- -------------------------------------------------------------------
-- airlines with lazy pilots average salaries
SELECT p.airline_name, AVG(p.salary) AS 'AVG(salary)'
FROM Pilot p
WHERE p.airline_name IN ( SELECT DISTINCT p2.airline_name 
FROM Pilot p2 
LEFT JOIN Stopover s ON p2.identification = s.pilot_id 
WHERE s.flight_number IS NULL)
GROUP BY p.airline_name;

--
-- Output 23: airlines with the highest salary's average
-- -----------------------------------------------------
-- airline with highest salary
SELECT p.airline_name, AVG (p.salary) AS 'average_salary'
FROM Pilot p
GROUP BY p.airline_name
ORDER BY average_salary DESC LIMIT 1

--
-- end script
-- 