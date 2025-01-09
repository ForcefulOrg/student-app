-- Create the database
CREATE DATABASE studentdb42
( 
    SERVICE_OBJECTIVE = 'GP_S_Gen5_2', 
    MAXSIZE = 5 GB, 
    AUTO_PAUSE_DELAY = 60 MINUTES 
);

-- Switch to the new database
USE studentdb42;

-- Create the Students table
CREATE TABLE Students (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Age INT NOT NULL
);

-- Insert sample data
INSERT INTO Students (Name, Age) VALUES ('John Doe', 20);
INSERT INTO Students (Name, Age) VALUES ('Jane Smith', 22);
INSERT INTO Students (Name, Age) VALUES ('Alice Johnson', 21);
INSERT INTO Students (Name, Age) VALUES ('Bob Brown', 23);
INSERT INTO Students (Name, Age) VALUES ('Charlie Davis', 24);
INSERT INTO Students (Name, Age) VALUES ('Diana Evans', 20);
INSERT INTO Students (Name, Age) VALUES ('Ethan Foster', 22);
INSERT INTO Students (Name, Age) VALUES ('Fiona Green', 21);
INSERT INTO Students (Name, Age) VALUES ('George Harris', 23);
INSERT INTO Students (Name, Age) VALUES ('Hannah White', 24);
INSERT INTO Students (Name, Age) VALUES ('Ian King', 20);
INSERT INTO Students (Name, Age) VALUES ('Julia Lee', 22);
INSERT INTO Students (Name, Age) VALUES ('Kevin Martin', 21);
INSERT INTO Students (Name, Age) VALUES ('Laura Nelson', 23);
INSERT INTO Students (Name, Age) VALUES ('Michael Scott', 24);
INSERT INTO Students (Name, Age) VALUES ('Nina Parker', 20);
INSERT INTO Students (Name, Age) VALUES ('Oliver Quinn', 22);
INSERT INTO Students (Name, Age) VALUES ('Paula Roberts', 21);
INSERT INTO Students (Name, Age) VALUES ('Quincy Turner', 23);
INSERT INTO Students (Name, Age) VALUES ('Rachel Walker', 24);
