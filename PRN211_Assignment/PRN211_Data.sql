USE [master]
GO
/****** Object:  Database [PRJ_Project]    Script Date: 7/25/2023 10:05:12 AM ******/
CREATE DATABASE [PRJ_Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PRJ_Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PRJ_Project.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PRJ_Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PRJ_Project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PRJ_Project] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PRJ_Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PRJ_Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PRJ_Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PRJ_Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PRJ_Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PRJ_Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [PRJ_Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PRJ_Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRJ_Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRJ_Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRJ_Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PRJ_Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRJ_Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRJ_Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRJ_Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRJ_Project] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PRJ_Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRJ_Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PRJ_Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PRJ_Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRJ_Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRJ_Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRJ_Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PRJ_Project] SET RECOVERY FULL 
GO
ALTER DATABASE [PRJ_Project] SET  MULTI_USER 
GO
ALTER DATABASE [PRJ_Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PRJ_Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PRJ_Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PRJ_Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PRJ_Project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PRJ_Project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PRJ_Project', N'ON'
GO
ALTER DATABASE [PRJ_Project] SET QUERY_STORE = OFF
GO
USE [PRJ_Project]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[aid] [int] IDENTITY(1,1) NOT NULL,
	[sid] [int] NOT NULL,
	[sesid] [int] NOT NULL,
	[status] [bit] NULL,
	[description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Attendance] PRIMARY KEY CLUSTERED 
(
	[aid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CName] [nvarchar](100) NOT NULL,
	[Code] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GName] [varchar](100) NOT NULL,
	[CourseID] [int] NOT NULL,
	[InstructorID] [int] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[InstructorID] [int] NOT NULL,
	[InstructorRollNumber] [nchar](10) NOT NULL,
	[InstructorName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[RName] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Session]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Session](
	[SessionID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[InstructorID] [int] NULL,
	[TimeSlotID] [int] NOT NULL,
	[RoomID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Lecture] PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentID] [int] NOT NULL,
	[StudentRollNumber] [nchar](10) NOT NULL,
	[FirstName] [nchar](10) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[Dob] [date] NOT NULL,
	[Gender] [bit] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentGroup]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentGroup](
	[StudentID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
 CONSTRAINT [PK_StudentGroup] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeSlot]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSlot](
	[TimeSlotID] [int] IDENTITY(1,1) NOT NULL,
	[TimeFrom] [nvarchar](5) NULL,
	[TimeTo] [nvarchar](5) NULL,
 CONSTRAINT [PK_TimeSlot] PRIMARY KEY CLUSTERED 
(
	[TimeSlotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 7/25/2023 10:05:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] NOT NULL,
	[Username] [varchar](20) NOT NULL,
	[Password] [varchar](20) NOT NULL,
	[Campus] [nvarchar](20) NOT NULL,
	[StudentID] [int] NULL,
	[InstructorID] [int] NULL,
	[isStudent] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Attendance] ON 

INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (1, 1, 1, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (2, 1, 2, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (3, 1, 3, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (4, 1, 4, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (5, 1, 5, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (6, 1, 6, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (7, 1, 7, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (8, 1, 8, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (9, 1, 9, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (10, 1, 10, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (11, 1, 11, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (12, 1, 12, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (13, 1, 13, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (14, 1, 14, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (15, 1, 15, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (16, 1, 16, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (17, 1, 17, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (18, 1, 18, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (19, 1, 19, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (20, 1, 20, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (21, 1, 21, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (22, 1, 24, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (23, 1, 25, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (24, 1, 26, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (25, 1, 27, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (26, 1, 28, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (27, 1, 29, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (28, 1, 30, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (29, 1, 31, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (30, 1, 32, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (31, 1, 33, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (32, 1, 34, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (33, 2, 1, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (34, 2, 2, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (35, 2, 3, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (36, 2, 4, 0, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (37, 2, 5, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (38, 2, 6, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (39, 2, 7, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (40, 2, 8, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (41, 2, 9, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (42, 2, 10, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (43, 2, 11, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (44, 2, 12, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (45, 2, 13, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (46, 2, 14, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (47, 2, 15, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (48, 2, 16, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (49, 2, 17, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (50, 2, 18, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (51, 2, 19, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (52, 2, 20, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (53, 2, 21, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (54, 2, 24, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (55, 2, 25, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (56, 2, 26, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (57, 2, 27, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (58, 2, 28, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (59, 2, 29, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (60, 2, 30, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (61, 2, 31, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (62, 2, 32, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (63, 2, 33, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (64, 2, 34, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (65, 3, 1, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (66, 3, 2, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (67, 3, 3, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (68, 3, 4, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (69, 3, 5, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (70, 3, 6, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (71, 3, 7, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (72, 3, 8, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (73, 3, 9, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (74, 3, 10, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (75, 3, 11, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (76, 3, 12, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (77, 3, 13, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (78, 3, 14, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (79, 3, 15, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (80, 3, 16, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (81, 3, 17, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (82, 3, 18, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (83, 3, 19, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (84, 3, 20, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (85, 3, 21, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (86, 3, 24, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (87, 3, 25, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (88, 3, 26, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (89, 3, 27, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (90, 3, 28, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (91, 3, 29, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (92, 3, 30, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (93, 3, 31, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (94, 3, 32, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (95, 3, 33, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (96, 3, 34, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (97, 4, 1, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (98, 4, 2, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (99, 4, 3, NULL, NULL)
GO
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (100, 4, 4, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (101, 4, 5, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (102, 4, 6, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (103, 4, 7, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (104, 4, 8, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (105, 4, 9, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (106, 4, 10, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (107, 4, 11, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (108, 4, 12, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (109, 4, 13, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (110, 4, 14, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (111, 4, 15, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (112, 4, 16, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (113, 4, 17, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (114, 4, 18, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (115, 4, 19, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (116, 4, 20, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (117, 4, 21, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (118, 4, 24, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (119, 4, 25, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (120, 4, 26, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (121, 4, 27, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (122, 4, 28, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (123, 4, 29, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (124, 4, 30, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (125, 4, 31, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (126, 4, 32, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (127, 4, 33, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (128, 4, 34, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (129, 5, 1, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (130, 5, 2, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (131, 5, 3, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (132, 5, 4, 0, N'Đi học muộn')
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (133, 5, 5, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (134, 5, 6, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (135, 5, 7, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (136, 5, 8, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (137, 5, 9, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (138, 5, 10, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (139, 5, 11, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (140, 5, 12, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (141, 5, 13, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (142, 5, 14, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (143, 5, 15, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (144, 5, 16, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (145, 5, 17, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (146, 5, 18, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (147, 5, 19, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (148, 5, 20, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (149, 5, 21, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (150, 5, 24, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (151, 5, 25, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (152, 5, 26, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (153, 5, 27, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (154, 5, 28, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (155, 5, 29, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (156, 5, 30, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (157, 5, 31, NULL, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (158, 5, 32, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (159, 5, 33, 1, NULL)
INSERT [dbo].[Attendance] ([aid], [sid], [sesid], [status], [description]) VALUES (160, 5, 34, 1, NULL)
SET IDENTITY_INSERT [dbo].[Attendance] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseID], [CName], [Code]) VALUES (1, N'Basic Cross-Platform Application Programming With C#', N'PRN211    ')
INSERT [dbo].[Course] ([CourseID], [CName], [Code]) VALUES (2, N'Software Testing', N'SWT301    ')
INSERT [dbo].[Course] ([CourseID], [CName], [Code]) VALUES (3, N'Application development project', N'SWP391    ')
INSERT [dbo].[Course] ([CourseID], [CName], [Code]) VALUES (4, N'Software Requirement', N'SWR301    ')
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[Group] ON 

INSERT [dbo].[Group] ([GroupID], [GName], [CourseID], [InstructorID]) VALUES (1, N'SE1710', 1, 1)
INSERT [dbo].[Group] ([GroupID], [GName], [CourseID], [InstructorID]) VALUES (2, N'SE1710', 2, 2)
INSERT [dbo].[Group] ([GroupID], [GName], [CourseID], [InstructorID]) VALUES (3, N'SE1710', 3, 2)
INSERT [dbo].[Group] ([GroupID], [GName], [CourseID], [InstructorID]) VALUES (4, N'SE1710', 4, 4)
SET IDENTITY_INSERT [dbo].[Group] OFF
GO
INSERT [dbo].[Instructor] ([InstructorID], [InstructorRollNumber], [InstructorName]) VALUES (1, N'PRN001    ', N'TienTD')
INSERT [dbo].[Instructor] ([InstructorID], [InstructorRollNumber], [InstructorName]) VALUES (2, N'SWT001    ', N'NangNTH')
INSERT [dbo].[Instructor] ([InstructorID], [InstructorRollNumber], [InstructorName]) VALUES (3, N'SWP001    ', N'NangNTH')
INSERT [dbo].[Instructor] ([InstructorID], [InstructorRollNumber], [InstructorName]) VALUES (4, N'SWR001    ', N'KienLTH')
GO
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([RoomID], [RName]) VALUES (1, N'BE-304')
INSERT [dbo].[Room] ([RoomID], [RName]) VALUES (2, N'DE-227')
SET IDENTITY_INSERT [dbo].[Room] OFF
GO
SET IDENTITY_INSERT [dbo].[Session] ON 

INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (1, 2, 2, 1, 2, CAST(N'2023-06-05' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (2, 4, 4, 2, 1, CAST(N'2023-06-05' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (3, 3, 2, 1, 1, CAST(N'2023-06-07' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (4, 1, 1, 2, 1, CAST(N'2023-06-07' AS Date), 1)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (5, 4, 4, 1, 1, CAST(N'2023-06-08' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (6, 2, 2, 2, 2, CAST(N'2023-06-08' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (7, 1, 1, 1, 1, CAST(N'2023-06-09' AS Date), 1)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (8, 3, 2, 2, 1, CAST(N'2023-06-09' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (9, 2, 2, 1, 2, CAST(N'2023-06-12' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (10, 4, 4, 2, 1, CAST(N'2023-06-12' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (11, 3, 2, 1, 1, CAST(N'2023-06-14' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (12, 1, 1, 2, 1, CAST(N'2023-06-14' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (13, 4, 4, 1, 1, CAST(N'2023-06-15' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (14, 2, 2, 2, 2, CAST(N'2023-06-15' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (15, 1, 1, 1, 1, CAST(N'2023-06-16' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (16, 3, 2, 2, 1, CAST(N'2023-06-16' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (17, 2, 2, 1, 2, CAST(N'2023-06-19' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (18, 4, 4, 2, 1, CAST(N'2023-06-19' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (19, 3, 2, 1, 1, CAST(N'2023-06-21' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (20, 1, 1, 2, 1, CAST(N'2023-06-21' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (21, 4, 4, 1, 1, CAST(N'2023-06-22' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (24, 2, 2, 2, 2, CAST(N'2023-06-22' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (25, 1, 1, 1, 1, CAST(N'2023-06-23' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (26, 3, 2, 2, 1, CAST(N'2023-06-23' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (27, 2, 2, 1, 2, CAST(N'2023-06-26' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (28, 4, 4, 2, 1, CAST(N'2023-06-26' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (29, 3, 2, 1, 1, CAST(N'2023-06-28' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (30, 1, 1, 2, 1, CAST(N'2023-07-26' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (31, 4, 4, 1, 1, CAST(N'2023-06-29' AS Date), 0)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (32, 1, 1, 2, 2, CAST(N'2023-07-25' AS Date), 1)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (33, 1, 1, 1, 1, CAST(N'2023-07-24' AS Date), 1)
INSERT [dbo].[Session] ([SessionID], [GroupID], [InstructorID], [TimeSlotID], [RoomID], [Date], [Status]) VALUES (34, 1, 1, 2, 1, CAST(N'2023-07-23' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Session] OFF
GO
INSERT [dbo].[Student] ([StudentID], [StudentRollNumber], [FirstName], [LastName], [Dob], [Gender]) VALUES (1, N'HE172039  ', N'Hieu      ', N'Vu Minh', CAST(N'2003-11-17' AS Date), 1)
INSERT [dbo].[Student] ([StudentID], [StudentRollNumber], [FirstName], [LastName], [Dob], [Gender]) VALUES (2, N'HE172041  ', N'Duy       ', N'Nguyen Minh', CAST(N'2003-10-22' AS Date), 1)
INSERT [dbo].[Student] ([StudentID], [StudentRollNumber], [FirstName], [LastName], [Dob], [Gender]) VALUES (3, N'HE172040  ', N'Tung      ', N'Bach Dang', CAST(N'2003-07-08' AS Date), 1)
INSERT [dbo].[Student] ([StudentID], [StudentRollNumber], [FirstName], [LastName], [Dob], [Gender]) VALUES (4, N'HE172042  ', N'Duong     ', N'Nguyen Quy', CAST(N'2003-12-25' AS Date), 1)
INSERT [dbo].[Student] ([StudentID], [StudentRollNumber], [FirstName], [LastName], [Dob], [Gender]) VALUES (5, N'HE172043  ', N'Dat       ', N'Dang Cong', CAST(N'2003-01-02' AS Date), 1)
GO
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (1, 1)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (1, 2)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (1, 3)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (1, 4)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (2, 1)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (2, 2)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (2, 3)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (2, 4)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (3, 1)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (3, 2)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (3, 3)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (3, 4)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (4, 1)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (4, 2)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (4, 3)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (4, 4)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (5, 1)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (5, 2)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (5, 3)
INSERT [dbo].[StudentGroup] ([StudentID], [GroupID]) VALUES (5, 4)
GO
SET IDENTITY_INSERT [dbo].[TimeSlot] ON 

INSERT [dbo].[TimeSlot] ([TimeSlotID], [TimeFrom], [TimeTo]) VALUES (1, N'07:30', N'09:50')
INSERT [dbo].[TimeSlot] ([TimeSlotID], [TimeFrom], [TimeTo]) VALUES (2, N'10:00', N'12:20')
INSERT [dbo].[TimeSlot] ([TimeSlotID], [TimeFrom], [TimeTo]) VALUES (4, N'12:50', N'15:10')
INSERT [dbo].[TimeSlot] ([TimeSlotID], [TimeFrom], [TimeTo]) VALUES (5, N'15:20', N'17:40')
SET IDENTITY_INSERT [dbo].[TimeSlot] OFF
GO
INSERT [dbo].[User] ([UserID], [Username], [Password], [Campus], [StudentID], [InstructorID], [isStudent]) VALUES (1, N'hieuvm', N'hieuvm', N'Hoa Lac', 1, NULL, 1)
INSERT [dbo].[User] ([UserID], [Username], [Password], [Campus], [StudentID], [InstructorID], [isStudent]) VALUES (2, N'tientd', N'tientd', N'Hoa Lac', NULL, 1, 0)
INSERT [dbo].[User] ([UserID], [Username], [Password], [Campus], [StudentID], [InstructorID], [isStudent]) VALUES (3, N'nangnth', N'nangnth', N'Hoa Lac', NULL, 2, 0)
INSERT [dbo].[User] ([UserID], [Username], [Password], [Campus], [StudentID], [InstructorID], [isStudent]) VALUES (4, N'kienlth', N'kienlth', N'Hoa Lac', NULL, 4, 0)
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Session] FOREIGN KEY([sesid])
REFERENCES [dbo].[Session] ([SessionID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_Session]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Student] FOREIGN KEY([sid])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_Student]
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_Course]
GO
ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_Instructor] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([InstructorID])
GO
ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_Instructor]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Group] ([GroupID])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Group]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Room] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Room] ([RoomID])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Room]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_TimeSlot] FOREIGN KEY([TimeSlotID])
REFERENCES [dbo].[TimeSlot] ([TimeSlotID])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_TimeSlot]
GO
ALTER TABLE [dbo].[StudentGroup]  WITH CHECK ADD  CONSTRAINT [FK_StudentGroup_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Group] ([GroupID])
GO
ALTER TABLE [dbo].[StudentGroup] CHECK CONSTRAINT [FK_StudentGroup_Group]
GO
ALTER TABLE [dbo].[StudentGroup]  WITH CHECK ADD  CONSTRAINT [FK_StudentGroup_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[StudentGroup] CHECK CONSTRAINT [FK_StudentGroup_Student]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Instructor] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([InstructorID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Instructor]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Student1] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Student1]
GO
USE [master]
GO
ALTER DATABASE [PRJ_Project] SET  READ_WRITE 
GO
