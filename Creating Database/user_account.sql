--Create User AccountTable
DROP TABLE IF EXISTS User Account;

--Create User Account
CREATE TABLE UserAccount(
    userID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
    additionalInfo VARCHAR(255),
    address VARCHAR(255),
    phoneNumber VARCHAR(20),
    gender VARCHAR(10),
    dateOfBirth DATE,
    createAt TIMESTAMP DEFAULT CURRENT TIMESTAMP, 
)

