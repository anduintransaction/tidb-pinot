use test;

CREATE TABLE IF NOT EXISTS Persons (
    PersonID    int not null auto_increment,
    Name        varchar(255) not null,
    Primary Key (PersonID)
);

INSERT INTO Persons(Name) VALUES ("User 1");
INSERT INTO Persons(Name) VALUES ("User 2");
INSERT INTO Persons(Name) VALUES ("User 3");
INSERT INTO Persons(Name) VALUES ("User 4");

UPDATE Persons SET Name = "User 2 (updated)" WHERE PersonID = 2;

DELETE FROM Persons WHERE PersonID = 3;

SELECT * FROM Persons;
