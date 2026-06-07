CREATE DATABASE ProleBlog;
GO
USE ProleBlog;
GO

CREATE TABLE Role (
	RoleID VARCHAR(50) PRIMARY KEY,
	RoleName NVARCHAR(255) NOT NULL
);

CREATE TABLE Users (
	Username VARCHAR(20) PRIMARY KEY,
	Fullname NVARCHAR(200) NOT NULL,
	RoleID VARCHAR(50) REFERENCES Role(RoleID),
	Born_date DATE DEFAULT '2000-01-01',
	Email VARCHAR(50) UNIQUE NOT NULL,
	Password BINARY(255) NOT NULL,
	Created DATETIME NOT NULL
);

CREATE TABLE Posts (
	PostID INT IDENTITY(1, 1) PRIMARY KEY,
	Title NVARCHAR(255) NOT NULL,
	Content NVARCHAR(MAX) NOT NULL,
	Hidden BIT DEFAULT 0,
	Created DATETIME NOT NULL
);

CREATE TABLE Comments (
	CommentID INT IDENTITY(1,1) PRIMARY KEY,
	Username VARCHAR(20) REFERENCES Users(Username),
	Content NVARCHAR(MAX) NOT NULL,
	Post_references INT,
	Comment_references INT,
	Hidden BIT DEFAULT 0,
	Created DATETIME NOT NULL
);

CREATE TABLE SavePost (
	SaveID INT IDENTITY(1, 1) PRIMARY KEY,
	Username VARCHAR(20) REFERENCES Users(Username),
	PostID INT REFERENCES Posts(PostID)
);

CREATE TABLE Logs (
	LogID INT IDENTITY(1, 1) PRIMARY KEY,
	LogText NVARCHAR(MAX) NOT NULL, 
	Created DATETIME NOT NULL
);

GO

CREATE PROCEDURE Register
	@Username VARCHAR(20),
	@Fullname NVARCHAR(200),
	@RoleID VARCHAR(50),
	@Born_date DATE,
	@Email VARCHAR(20),
	@Password VARCHAR(255)
AS
BEGIN 
	INSERT INTO Users VALUES (
		@Username, @Fullname, @RoleID, @Born_date, @Email, HASHBYTES('md5', @Password), GETDATE()
	);
END
GO

CREATE PROCEDURE Login
	@Username VARCHAR(20),
	@Password VARCHAR(255)
AS
BEGIN
	SELECT * 
	FROM Users
	WHERE Username = @Username AND Password = HASHBYTES('md5', @Password);
END
GO

CREATE PROCEDURE AddRole
	@RoleID VARCHAR(50),
	@RoleName NVARCHAR(255)
AS 
BEGIN
	INSERT INTO Role VALUES (@RoleID, @RoleName);
END 
GO

CREATE PROCEDURE GetUserByUsername
	@Username VARCHAR(20)
AS
BEGIN
	SELECT * FROM Users WHERE Username = @Username;
END
GO

CREATE PROCEDURE AddLog 
	@LogText NVARCHAR(MAX)
AS
BEGIN 
	INSERT INTO Log (LogText, Created) VALUES (@LogText, GETDATE());
END
GO

EXECUTE AddRole 'ADMIN', N'Quản trị viên';
EXECUTE AddRole 'USER', N'Người dùng';
EXECUTE AddRole 'EDITOR', 'Biên tập viên';


EXECUTE Register 'Admin', 'Admin', 'ADMIN', '2008-05-23', 'baovn1179@gmail.com', 'root';

