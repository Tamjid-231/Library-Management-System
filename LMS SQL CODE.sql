-- Department Table
CREATE TABLE Department (
    Department_ID NUMBER PRIMARY KEY,
    Department_Name VARCHAR2(100) NOT NULL,
    Faculty_Head VARCHAR2(100)
);

INSERT INTO Department VALUES (1, 'Computer Science', 'Dr. Ahsan Ullah');
INSERT INTO Department VALUES (2, 'Electrical Engineering', 'Dr. Farzana Rahman');
INSERT INTO Department VALUES (3, 'Business Administration', 'Dr. Kamal Hossain');
INSERT INTO Department VALUES (4, 'English Literature', 'Dr. Shamsul Alam');

-- Member Table
CREATE TABLE Member (
    Member_ID NUMBER PRIMARY KEY,
    Full_Name VARCHAR2(100) NOT NULL,
    Membership_Type VARCHAR2(10) CHECK (Membership_Type IN ('Student', 'Teacher')),
    Department_ID NUMBER,
    Email VARCHAR2(100),
    Phone VARCHAR2(20),
    Address VARCHAR2(4000),
    Membership_Expiry_Date DATE,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

INSERT INTO Member VALUES (101, 'Tariq Aziz', 'Student', 1, 'tariq@student.edu', '01711111111', 'Mirpur, Dhaka', TO_DATE('2026-12-31', 'YYYY-MM-DD'));
INSERT INTO Member VALUES (102, 'Rumana Kabir', 'Teacher', 4, 'rumana@univ.edu', '01722222222', 'Dhanmondi, Dhaka', TO_DATE('2027-12-31', 'YYYY-MM-DD'));
INSERT INTO Member VALUES (103, 'Hasibul Rahman', 'Student', 2, 'hasib@student.edu', '01733333333', 'Banani, Dhaka', TO_DATE('2026-06-30', 'YYYY-MM-DD'));
INSERT INTO Member VALUES (104, 'Nusrat Sultana', 'Teacher', 3, 'nusrat@univ.edu', '01744444444', 'Uttara, Dhaka', TO_DATE('2028-03-31', 'YYYY-MM-DD'));

-- Publisher Table
CREATE TABLE Publisher (
    Publisher_ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Address VARCHAR2(4000),
    Contact_Number VARCHAR2(20)
);

INSERT INTO Publisher VALUES (1, 'Pearson', 'New York, USA', '+1-212-1234567');
INSERT INTO Publisher VALUES (2, 'Tamjid Press', 'Nurarchalla, Dhaka', '+88-019-6382-1217');
INSERT INTO Publisher VALUES (3, 'Oxford University Press', 'London, UK', '+44-20-7654321');
INSERT INTO Publisher VALUES (4, 'Ananda Publishers', 'Kolkata, India', '+91-33-22876543');

-- Book Table
CREATE TABLE Book (
    Book_ID NUMBER PRIMARY KEY,
    Title VARCHAR2(150) NOT NULL,
    Author VARCHAR2(100),
    Publisher_ID NUMBER,
    ISBN VARCHAR2(30),
    Edition VARCHAR2(50),
    Category VARCHAR2(50),
    Quantity NUMBER DEFAULT 1,
    Shelf_Location VARCHAR2(50),
    Price NUMBER(10,2),
    Availability_Status VARCHAR2(10) DEFAULT 'Available',
    FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID),
    CONSTRAINT chk_quantity CHECK (Quantity >= 0),
    CONSTRAINT chk_status CHECK (Availability_Status IN ('Available', 'Issued', 'Reserved'))
);

INSERT INTO Book VALUES (1001, 'Database Systems', 'C.J. Date', 1, '978-0321197849', '6th', 'Computer Science', 5, 'A1-01', 850.00, 'Issued');
INSERT INTO Book VALUES (1002, 'Marketing Principles', 'Kotler', 2, '978-0132136848', '4th', 'Business', 3, 'B2-03', 500.00, 'Issued');
INSERT INTO Book VALUES (1003, 'Shakespeare Works', 'W. Shakespeare', 3, '978-0198328704', '2nd', 'English', 2, 'C3-05', 650.00, 'Available');
INSERT INTO Book VALUES (1004, 'Digital Logic Design', 'M. Morris Mano', 1, '978-0131989269', '3rd', 'Electrical', 4, 'D4-07', 700.00, 'Reserved');

-- Library Table
CREATE TABLE Library (
    Library_ID NUMBER PRIMARY KEY,
    Library_Name VARCHAR2(100) NOT NULL,
    Location VARCHAR2(100),
    Contact_Number VARCHAR2(20)
);

INSERT INTO Library VALUES (1, 'Central Library', 'Main Campus', '01788888888');
INSERT INTO Library VALUES (2, 'Science Library', 'Building 3', '01799999999');
INSERT INTO Library VALUES (3, 'Arts Library', 'Building 5', '01888888888');
INSERT INTO Library VALUES (4, 'Business Library', 'Business Block', '01899999999');

-- Librarian Table
CREATE TABLE Librarian (
    Librarian_ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100),
    Phone VARCHAR2(20),
    Username VARCHAR2(50) UNIQUE NOT NULL,
    Password VARCHAR2(100) NOT NULL
);

INSERT INTO Librarian VALUES (201, 'Mahmud Hossain', 'mahmud@lib.edu', '01611111111', 'mahmud_h', 'pass123');
INSERT INTO Librarian VALUES (202, 'Sharmin Akter', 'sharmin@lib.edu', '01622222222', 'sharmin_a', 'pass456');
INSERT INTO Librarian VALUES (203, 'Amit Chowdhury', 'amit@lib.edu', '01633333333', 'amit_c', 'pass789');
INSERT INTO Librarian VALUES (204, 'Sadia Islam', 'sadia@lib.edu', '01644444444', 'sadia_i', 'pass000');

-- Borrow Table
CREATE TABLE Borrow (
    Borrow_ID NUMBER PRIMARY KEY,
    Member_ID NUMBER,
    Book_ID NUMBER,
    Borrow_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Return_Date DATE,
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID)
);

INSERT INTO Borrow VALUES (301, 101, 1001, TO_DATE('2025-08-01', 'YYYY-MM-DD'), TO_DATE('2025-08-15', 'YYYY-MM-DD'), NULL);
INSERT INTO Borrow VALUES (302, 102, 1003, TO_DATE('2025-07-15', 'YYYY-MM-DD'), TO_DATE('2025-08-14', 'YYYY-MM-DD'), TO_DATE('2025-07-29', 'YYYY-MM-DD'));
INSERT INTO Borrow VALUES (303, 103, 1002, TO_DATE('2025-08-03', 'YYYY-MM-DD'), TO_DATE('2025-08-17', 'YYYY-MM-DD'), NULL);
INSERT INTO Borrow VALUES (304, 104, 1004, TO_DATE('2025-07-25', 'YYYY-MM-DD'), TO_DATE('2025-08-24', 'YYYY-MM-DD'), TO_DATE('2025-08-09', 'YYYY-MM-DD'));

-- Fine Table
CREATE TABLE Fine (
    Fine_ID NUMBER PRIMARY KEY,
    Borrow_ID NUMBER,
    Amount NUMBER(10,2),
    Status VARCHAR2(10) DEFAULT 'Unpaid',
    FOREIGN KEY (Borrow_ID) REFERENCES Borrow(Borrow_ID),
    CONSTRAINT chk_amount CHECK (Amount >= 0),
    CONSTRAINT chk_status_fine CHECK (Status IN ('Paid', 'Unpaid'))
);

INSERT INTO Fine VALUES (401, 301, 100.00, 'Unpaid');
INSERT INTO Fine VALUES (402, 302, 0.00, 'Paid');
INSERT INTO Fine VALUES (403, 303, 50.00, 'Unpaid');
INSERT INTO Fine VALUES (404, 304, 0.00, 'Paid');