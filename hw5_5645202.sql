--
-- Homework 5: SQL-DDL
-- @author: Joshua Erikson, 5645202
-- NAU, CS 345, Spring 2024
--

--
-- Output 1: start fresh
-- ---------------------
-- dropping db to start fresh
DROP DATABASE IF EXISTS airline_db;

--
-- Output 2: initialization
-- ------------------------
--  creates the new db -airline_db
CREATE DATABASE airline_db;

--
-- Output 3: inspect the database
-- ---------------------------
-- selects the new db to use
USE airline_db;

--
-- Output 4: the Pilot table
-- -------------------------
--  creating pilot table with required fields
-- AI prompt: Provide a MySQL statement to create a table for pilots including ID, name, and license number
CREATE TABLE pilot (pilot_id INT PRIMARY KEY NOT NULL, 
pilot_name VARCHAR(100) NOT NULL, 
salary DECIMAL (10,2), 
gratification DECIMAL (10,2), 
airline_name VARCHAR (30), 
airline_address VARCHAR (255), 
country VARCHAR(15));

--
-- Output 5: the Airport table
-- ---------------------------
-- Create the airport table
CREATE TABLE airport (acronym VARCHAR (3) PRIMARY KEY NOT NULL, 
airport_name VARCHAR(100) NOT NULL, 
city VARCHAR(50), 
country VARCHAR (15));

--
-- Output 6: the Flight table
-- --------------------------
-- AI prompt: Provide a MySQL statement to create a table for flights including flight number, pilot ID, origin, destination, and times
-- create the flight table
CREATE TABLE flight (flight_number VARCHAR(6) PRIMARY KEY NOT NULL, 
departure_airport VARCHAR(3) NOT NULL, 
destination_airport varchar(3) NOT NULL, 
teparture_time TIME, 
FOREIGN KEY (departure_airport) REFERENCES Airport(acronym),
FOREIGN KEY (destination_airport) REFERENCES Airport(acronym));

--
-- Output 7: the Connect table
-- ---------------------------
-- Table for connection between flights
CREATE TABLE connect (flight_number VARCHAR(6) PRIMARY KEY NOT NULL, 
flight_date DATE PRIMARY KEY NOT NULL, 
aircraft VARCHAR(30));

--
-- Output 8: check the work so far
-- -------------------------------
-- inspecting the table to ensure correctness
SHOW TABLES;

--
-- Output 9: change Connect
-- ------------------------
-- add pilot_identification as a column
ALTER TABLE connect ADD COLUMN pilot_identification VARCHAR(10) NOT NULL;

-- 
-- Output 10: change Connect
-- -------------------------
-- AI prompt: Provide a MySQL statement to change the column name
-- change name from pilot identification to pilot_id
ALTER TABLE connect CHANGE COLUMN pilot_identification pilot_id VARCHAR(10);

--
-- Output 11: change Connect
-- -------------------------
-- CHANGE PILOT ID TO INT AND NOT NULL
ALTER TABLE connect MODIFY COLUMN pilot_id INT NOT NULL;

--
-- Output 12: change Connect
-- -------------------------
-- CHANGE PILOT ID TO FORIEGN KEY
ALTER TABLE connect ADD CONSTRAINT fk_pilot_id FOREIGN KEY (pilot_id) REFERENCES pilot(pilot_id);

--
-- Output 13: change Pilot
-- ----------------------------
-- remove airline_address
ALTER TABLE pilot DROP COLUMN airline_address;

--
-- Output 14: change Connect
-- -------------------------
-- RENAME CONNECT TO STOPVOER
RENAME TABLE connect TO stopover;

--
-- Output 15: clean up
-- -------------------
-- clears tables for fresh run
DELETE FROM stopover;
DELETE FROM flight;
DELETE FROM airport;
DELETE FROM pilot;

--
-- Output 16: clean up
-- -------------------
-- AI prompt: Provide a MySQL statement to drop the db
-- drops the DB to start fresh
DROP DATABASE airline_db;

--
-- end script
-- 