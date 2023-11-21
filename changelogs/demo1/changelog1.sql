--liquibase formatted sql

--changeset Aravind:1 labesl:insert queries context:insert
--comment: Inserting a company with all information
INSERT INTO company (name, address1, address2, city) 
VALUES ('L&T', '123 Tech Lane', 'Tech Park', 'Tech City');
