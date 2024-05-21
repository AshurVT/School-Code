--
-- Homework 6: SQL-DML
-- @author: Joshua Erikson, 5645202
-- NAU, CS 345, Spring 2024
--

--
-- DDL Statements
-- --------------
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
FOREIGN KEY (departure_airport) REFERENCES Airport(acronym) ON
DELETE CASCADE,
FOREIGN KEY (destination_airport) REFERENCES Airport(acronym)
ON DELETE CASCADE);
-- create the table Stopover
CREATE TABLE Stopover(flight_number VARCHAR(6) NOT NULL,
flight_date DATE NOT NULL,
pilot_id INT NOT NULL,
aircraft VARCHAR(30),
PRIMARY KEY(flight_number, flight_date),
FOREIGN KEY (flight_number) REFERENCES Flight(flight_number) ON
DELETE CASCADE,
FOREIGN KEY (pilot_id) REFERENCES Pilot(identification) ON
DELETE CASCADE
);
--
-- end script

-- IMPORTANT NOTE: add the DDL statements here. After Module's 4 assignment 
-- deadline has passed, the statements to be added here will be provided on 
-- Canvas.

--
-- DML Statements (add your solutions here)
-- ----------------------------------------

--
-- Output 1: Pilot is populated with data
-- --------------------------------------
-- adds values into pilot table
INSERT INTO Pilot (identification, pilot_name, salary, gratification, airline_name, country)
VALUES 
(279, 'Steven Grant Rogers', 30000.00, 500.00, 'American Airlines', 'USA'),
(602, 'Steven Vincent Strange', 28000.00, 800.00, 'Westjet', 'Canada'),
(628, 'Carol Susan Jane Danvers', 30000.00, 500.00, 'Air France', 'France'),
(832, 'Clinton Francis Barton', 21000.00, NULL, NULL, 'CANADA'),
(947, 'Natasha Romanoff', 21000.00, NULL, 'United', 'USA');

--
-- Output 2: Airport is populated with data
-- ----------------------------------------
-- add values into Airport table
INSERT INTO Airport (acronym, airport_name, city, country)
VALUES
('CDG', 'Aéroport Paris-Charles de Gaulle', 'Paris', 'France'),
('DFW','Dallas Fort Worth Airport','Dallas','USA'),
('LAS','Las Vegas International Airport','Las Vegas',' USA'),
('LYS', 'Aéroport Lyon Saint-Exupéry','Lyon','France'),
('MRS','Marseille Provence Airport','Marselha','France'),
('PHX','Phoenix Sky Harbor Airport','Phoenix','USA'),
('YVR','Vancouver International Airport','Richmond', NULL),
('YYZ','Toronto Pearson International Airport','Toronto', NULL);

--
-- Output 3: Flight is populated with data
-- ---------------------------------------
-- add values into Flight table
INSERT INTO Flight (flight_number, departure_airport, destination_airport, departure_time)
VALUES
('AV431','YVR','LYS','02:10:00'),
('KI356','MRS','YVR','23:55:00'),
('PR231','PHX','LAS','12:15:00'),
('RG230','LAS','PHX','23:05:00'),
('TG331','LAS','YYZ','17:22:00');

--
-- Output 4: Stopover is populated with data
-- -----------------------------------------
-- populate stopover table
INSERT INTO Stopover
VALUES
('AV431', '2023-10-30', '832', 'Airbus A380'),
('KI356', '2023-09-07', '602', 'Embraer 195'),
('PR231', '2023-01-12', '947', 'Airbus A380'),
('PR231', '2023-10-15', '279', 'Airbus A380'),
('RG230', '2023-10-30', '279', 'Boeing 747'),
('TG331', '2023-01-12', '628', 'Airbus A380'),
('TG331', '2023-10-05', '947', 'Boeing 747');

--
-- Output 5: Las Vegas airport has changed
-- ---------------------------------------
-- update vegas airport
UPDATE Airport
SET airport_name = 'Harry Reid International Airport'
WHERE airport_name LIKE '%Las Vegas International Airport%';

--
-- Output 6: All the pilots whose salary is lower than 22,000.00 has changed
-- -------------------------------------------------------------------------
-- update pilot salary
UPDATE Pilot
SET salary = salary + 4000
WHERE salary < 22000;

--
-- Output 7: Pilot's gratification with NULL values have changed
-- -----------------------------------------------------
-- update pilot gratification
UPDATE Pilot
SET gratification = 500.00
WHERE gratification IS NULL;

--
-- Output 8: Pilot's from Canada have changed
-- -------------------------------------------
-- change pilot location
UPDATE Pilot
SET airline_name = 'Air Canada'
WHERE country LIKE '%Canada%';

--
-- Output 9: Airport's country have changed based on the city names
-- -----------------------------------------------------------------
-- update airport country
UPDATE Airport
SET country = 'Canada'
WHERE country IS NULL;

--
-- Output 10: Stopover's dates has changed based on their month (as a substring)
-- ---------------------------------------------------------------------------
--  update stopover
UPDATE Stopover
SET flight_date = '2023-09-07'
WHERE flight_date > '2023-10-01';


--
-- Output 11: Stopover's aircraft has changed based on the pilot's id
-- ------------------------------------------------------------------
-- update stopover again
UPDATE Stopover
SET aircraft = 'Embraer 195'
WHERE pilot_id = '279';

--
-- Output 12: Pilot's salary has changed based on a given range
-- ------------------------------------------------------------
-- more pilots gain moolah/dollar bills
UPDATE Pilot
SET salary = salary + 100
WHERE salary < 30000.00;

--
-- Output 13: the number of records in the Flight table has changed based on 
-- the departure_airport
-- -------------------------------------------------------------------------
-- Is anyone surprised of cancelled flights at airports
DELETE FROM Flight
WHERE departure_airport = 'LAS';

--
-- Output 14: the number of records in the Flight table has changed based on 
-- the departure_airport and destination_airport
-- -------------------------------------------------------------------------
-- more cancellations
DELETE FROM Flight
WHERE departure_airport = 'YVR';

--
-- Output 15: the number of records in the Pilot table has changed based on 
-- the gratification and country
-- ---------------------------------------------------------------
-- someone got fired
DELETE FROM Pilot
Where gratification = 800 AND country LIKE '%Canada%';

--
-- Output 16: the number of records in the Pilot table has changed based on 
-- pilot's names first character
-- ---------------------------------------------------------------
-- they are firing people based on names now!
DELETE FROM Pilot
Where pilot_name LIKE 'C%';

--
-- Output 17: the number of records in the Airport table has changed based on 
-- airport's acronym
-- --------------------------------------------------------------------------
-- update airport because of acromyns
DELETE FROM Airport
WHERE acronym LIKE 'L%' or acronym LIKE 'M%';

--
-- Output 18: the number of records in the Pilot table has changed with no
-- particular condition
-- -----------------------------------------------------------------------
-- everyone got fired 
DELETE FROM Pilot;


--
-- Output 19: the number of records in the Airport table has changed based
-- on country
-- -----------------------------------------------------------------------
-- deleting noncanada airports
DELETE FROM Airport
WHERE country <> 'Canada';

--
-- Output 20: the number of records in the Airport table has changed based
-- on the existence of the word International in their names
-- -----------------------------------------------------------------------
-- no more airports guess we adopted the green new deal
DELETE FROM Airport;

--
-- CHECK YOUR WORK: use the following statements to check if your tables
-- contains the expected output.
-- ---------------------------------------------------------------------
--
-- read data from table Pilot
SELECT * FROM Pilot;
-- read data from table Flight
SELECT * FROM Flight;
-- read data from table Stopover
SELECT * FROM Stopover;
-- read data from table Airport
SELECT * FROM Airport;

--
-- end script
-- 