-- ============================================
-- Library Management System
-- ============================================

-- Drop tables if they exist
DROP TABLE IF EXISTS BookAuthor;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Category;

-- ============================================
-- Category Table
-- ============================================
CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT
);

-- ============================================
-- Author Table
-- ============================================
CREATE TABLE Author (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);

-- ============================================
-- Book Table
-- ============================================
CREATE TABLE Book (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    Title VARCHAR(255) NOT NULL,
    PublicationYear YEAR,
    CategoryID INT,
    CONSTRAINT fk_book_category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- ============================================
-- BookAuthor Junction Table (M-M)
-- ============================================
CREATE TABLE BookAuthor (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    CONSTRAINT fk_bookauthor_book FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE,
    CONSTRAINT fk_bookauthor_author FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID) ON DELETE CASCADE
);

-- ============================================
-- Member Table
-- ============================================
CREATE TABLE Member (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20)
);

-- ============================================
-- Loan Table
-- ============================================
CREATE TABLE Loan (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    LoanDate DATE NOT NULL,
    ReturnDate DATE,
    CONSTRAINT fk_loan_book FOREIGN KEY (BookID) REFERENCES Book(BookID),
    CONSTRAINT fk_loan_member FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

-- ============================================
-- Sample Data
-- ============================================
INSERT INTO Category (Name, Description) VALUES
('Fiction', 'Fictional works'),
('Science', 'Science related books'),
('History', 'Historical books');

INSERT INTO Author (FirstName, LastName) VALUES
('Jane', 'Austen'),
('Isaac', 'Asimov'),
('Yuval', 'Harari');

INSERT INTO Book (ISBN, Title, PublicationYear, CategoryID) VALUES
('978-0141439518', 'Pride and Prejudice', 1813, 1),
('978-0553293357', 'Foundation', 1951, 2),
('978-0062316110', 'Sapiens', 2015, 3);

INSERT INTO BookAuthor (BookID, AuthorID) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Member (FirstName, LastName, Email, Phone) VALUES
('John', 'Doe', 'john@example.com', '0712345678'),
('Mary', 'Smith', 'mary@example.com', '0723456789');

INSERT INTO Loan (BookID, MemberID, LoanDate, ReturnDate) VALUES
(1, 1, '2025-08-01', '2025-08-15'),
(2, 2, '2025-08-05', NULL);
