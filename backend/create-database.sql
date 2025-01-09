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
    Age INT NOT NULL,
    Summary NVARCHAR(255)
);

-- Insert sample data
INSERT INTO Students (Name, Age, Summary) VALUES ('John Doe', 20, 'John loves Mathematics and Physics.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Jane Smith', 22, 'Jane enjoys Literature and History.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Alice Johnson', 21, 'Alice is passionate about Biology and Chemistry.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Bob Brown', 23, 'Bob excels in Computer Science and Mathematics.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Charlie Davis', 24, 'Charlie is interested in Art and Music.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Diana Evans', 20, 'Diana loves Geography and Environmental Science.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Ethan Foster', 22, 'Ethan enjoys Physical Education and Health.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Fiona Green', 21, 'Fiona is passionate about Economics and Business Studies.');
INSERT INTO Students (Name, Age, Summary) VALUES ('George Harris', 23, 'George excels in Political Science and Sociology.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Hannah White', 24, 'Hannah loves Psychology and Philosophy.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Ian King', 20, 'Ian enjoys Engineering and Technology.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Julia Lee', 22, 'Julia is passionate about Linguistics and Languages.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Kevin Martin', 21, 'Kevin excels in Astronomy and Astrophysics.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Laura Nelson', 23, 'Laura loves Anthropology and Archaeology.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Michael Scott', 24, 'Michael enjoys Law and Criminology.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Nina Parker', 20, 'Nina is passionate about Fashion and Design.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Oliver Quinn', 22, 'Oliver excels in Architecture and Urban Planning.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Paula Roberts', 21, 'Paula loves Veterinary Science and Animal Care.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Quincy Turner', 23, 'Quincy enjoys Marine Biology and Oceanography.');
INSERT INTO Students (Name, Age, Summary) VALUES ('Rachel Walker', 24, 'Rachel is passionate about Culinary Arts and Nutrition.');
