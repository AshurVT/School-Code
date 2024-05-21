--
-- Extra-credit: SQL-DDL/DML
-- @author: Joshua Erikson, 5645202
-- NAU, CS 345, Spring 2024
--

--
-- Output 1: start fresh
-- ---------------------
-- dropping db to start fresh
DROP DATABASE IF EXISTS movie_db;

--
-- Output 2: initialization
-- ------------------------
-- create new db
CREATE DATABASE movie_db;

--
-- Output 3: inspect the database
-- ------------------------------
-- select/inspect the database
USE movie_db;

--
-- Output 4: the Movie table
-- -------------------------
-- create Movie table
CREATE TABLE Movie (movie_id INT PRIMARY KEY NOT NULL,
title VARCHAR(255) NOT NULL,
genre VARCHAR(50),
release_date DATE,
duration INT,
director VARCHAR (100));
--
-- Output 5: the Room table
-- ------------------------
--  create room table
CREATE TABLE Room (room_id INT PRIMARY KEY NOT NULL,
theater_name VARCHAR(100) NOT NULL,
seating_capacity INT);

--
-- Output 6: the Showtime table
-- ----------------------------
-- create showtime table
CREATE TABLE Showtime (showtime_id INT PRIMARY KEY NOT NULL,
movie_id INT,
room_id INT,
start_time TIME,
end_time TIME,
show_date DATE,
FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
FOREIGN KEY (room_id) REFERENCES Room(room_id));

--
-- Output 7: the Customer table
-- ----------------------------
-- create customer table
CREATE TABLE Customer (customer_id INT PRIMARY KEY NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100),
address VARCHAR(255),
membership_status ENUM('Gold','Silver','Bronze'));

--
-- Output 8: the Ticket table
-- --------------------------
-- create ticket table
CREATE TABLE Ticket (ticket_id INT PRIMARY KEY NOT NULL,
showtime_id INT,
customer_id INT,
room_id INT,
ticket_type ENUM('Standard','VIP'),
purchase_date DATE,
seat_number INT,
purchase_price DECIMAL(10,2),
FOREIGN KEY (showtime_id) REFERENCES Showtime(showtime_id),
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id));

--
-- Output 9: check the work so far
-- -------------------------------
-- inspect tables to ensure correctness
SHOW TABLES;

--
-- Output 10: change Room
-- ----------------------
-- alter room table
ALTER TABLE Room CHANGE COLUMN theater_name room_name VARCHAR(255);

-- 
-- Output 11: change Ticket
-- ------------------------
-- ALTER TICKET TABLE
ALTER TABLE Ticket ADD CONSTRAINT fk_room_id FOREIGN KEY (room_id) REFERENCES Room(room_id);

--
-- Output 12: change Ticket
-- ------------------------
-- remove seat number
ALTER TABLE Ticket DROP COLUMN seat_number;

--
-- Output 13: Movie is populated with data
-- ---------------------------------------
-- POPULATE MOVIE TABLE
INSERT INTO Movie (movie_id, title, genre, release_date, duration, director)
VALUES
(1, 'The Shawshank Redemption', 'Drama', '1994-09-23', 142, 'Frank Darabont'),
(2, 'The Godfather', 'Crime', '1972-03-24', 175, 'Francis Ford Coppola'),
(3, 'Pulp Fiction', 'Crime', '1994-10-14', 154, 'Quentin Tarantino'),
(4, 'The Dark Knight', 'Action', '2008-07-18', 152, 'Christopher Nolan');

--
-- Output 14: Customer is populated with data
-- ------------------------------------------
-- populate customer table
INSERT INTO Customer (customer_id, first_name, last_name, email, address, membership_status)
VALUES
(1, 'Natasha', 'Romanoff', 'natasha@email.com', '123 Main St', 'Gold'),
(2, 'Diana', 'Prince', 'diana@email.com', '456 Elm St', 'Silver'),
(3, 'Peter', 'Parker', 'peter@email.com', '42 Web St', 'Silver'),
(4, 'Clark', 'Kent', 'clark@email.com', '1 Superman Way', 'Gold'),
(5, 'Jean', 'Grey', 'jean@email.com', '789 Oak St', 'Bronze'),
(6, 'Bruce', 'Wayne', 'bruce@email.com', '33 Batcave Rd', 'Bronze');

--
-- Output 15: Room is populated with data
-- --------------------------------------
-- populate Room
INSERT INTO Room (room_id, room_name, seating_capacity)
Values
(1, 'Main Theater', 150),
(2, '3D Theater', 60),
(3, 'Comfort Theater', 70);
--
-- Output 16: Showtime is populated with data
-- ------------------------------------------
-- populate Showtime
INSERT INTO Showtime (showtime_id, movie_id, room_id, start_time, end_time, show_date)
VALUES
(1, 1, 1, '15:00:00', '17:00:00', '2023-11-01'),
(2, 2, 2, '18:30:00', '20:30:00', '2023-11-01'),
(3, 3, 3, '14:15:00', '16:15:00', '2023-11-02'),
(4, 4, 3, '19:00:00', '21:00:00', '2023-11-02'),
(5, 1, 2, '16:30:00', '18:30:00', '2023-11-03'),
(6, 2, 1, '20:00:00', '22:00:00', '2023-11-03');
--
-- Output 17: Ticket is populated with data
-- ----------------------------------------
-- populate Ticket
INSERT INTO Ticket (ticket_id, showtime_id, customer_id, room_id, ticket_type, purchase_date, purchase_price)
VALUES
(1, 1, 2, 1, 'Standard', '2023-11-01', '12.99'),
(2, 1, 6, 2, 'VIP', '2023-11-01', '25.99'),
(3, 3, 3, 3, 'Standard', '2023-11-02', '11.99'),
(4, 2, 1, 2, 'VIP', '2023-11-02', '24.99'),
(5, 3, 2, 3, 'Standard', '2023-11-03', '13.99');
--
-- Output 18: VIP tickets have changed
-- -----------------------------------
-- update vip ticket to 26.99
UPDATE Ticket
SET purchase_price = 26.99
WHERE ticket_type LIKE '%VIP%';

--
-- Output 19: clean up
-- -------------------
--  DROP THE TABLES
DROP TABLE Customer, Movie, Room, Showtime, Ticket;
SHOW TABLES;


--
-- Output 20: clean up
-- -------------------
-- time to drop the database DATABASE
DROP DATABASE movie_db;

--
-- end script
-- 