USE [master]
GO
/****** Object:  Database [NotesMarketPlace]    Script Date: 14-03-2021 12:18:04 ******/
CREATE DATABASE [NotesMarketPlace]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NotesMarketPlace', FILENAME = N'C:\Microsoft SQL Server\MSSQL14.MSSQLSERVER01\MSSQL\DATA\NotesMarketPlace.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NotesMarketPlace_log', FILENAME = N'C:\Microsoft SQL Server\MSSQL14.MSSQLSERVER01\MSSQL\DATA\NotesMarketPlace_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [NotesMarketPlace] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NotesMarketPlace].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NotesMarketPlace] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET ARITHABORT OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NotesMarketPlace] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NotesMarketPlace] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NotesMarketPlace] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NotesMarketPlace] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET RECOVERY FULL 
GO
ALTER DATABASE [NotesMarketPlace] SET  MULTI_USER 
GO
ALTER DATABASE [NotesMarketPlace] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NotesMarketPlace] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NotesMarketPlace] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NotesMarketPlace] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NotesMarketPlace] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NotesMarketPlace', N'ON'
GO
ALTER DATABASE [NotesMarketPlace] SET QUERY_STORE = OFF
GO
USE [NotesMarketPlace]
GO
/****** Object:  Table [dbo].[AdminTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminTable](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[SecondaryEmail] [varchar](100) NULL,
	[CountryCode] [varchar](10) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[ProfilePicture] [varbinary](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_AdminTable] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryTable](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Description] [varchar](200) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [int] NOT NULL,
 CONSTRAINT [PK_CategoryTable] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactUsTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactUsTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Subject] [varchar](100) NOT NULL,
	[Comments] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_ContactUsTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CountryTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryTable](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](20) NOT NULL,
	[CountryCode] [varchar](10) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_CountryTable] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotesAttachmentTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotesAttachmentTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NID] [int] NOT NULL,
	[FileName] [varchar](100) NOT NULL,
	[FilePath] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_NotesAttachmentTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteTable](
	[NID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [int] NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[DisplayPicture] [varchar](max) NULL,
	[TypeID] [int] NULL,
	[NumberOfPages] [int] NULL,
	[Description] [varchar](max) NOT NULL,
	[CountryID] [int] NULL,
	[InstituteName] [varchar](200) NULL,
	[CourseName] [varchar](100) NULL,
	[CourseCode] [varchar](100) NULL,
	[Professor] [varchar](100) NULL,
	[IsPaid] [bit] NOT NULL,
	[Price] [int] NOT NULL,
	[PreviewAttachment] [varchar](max) NULL,
	[Status] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_NoteTable] PRIMARY KEY CLUSTERED 
(
	[NID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReferenceDataTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferenceDataTable](
	[ID] [int] NOT NULL,
	[StatusName] [varchar](100) NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ReferenceDataTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RejectedTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RejectedTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NID] [int] NOT NULL,
	[RejectedBy] [int] NOT NULL,
	[Comments] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_RejectedTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NID] [int] NOT NULL,
	[ReviewBy] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comments] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_ReviewTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleTable](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_RoleTable] PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpamTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpamTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NID] [int] NOT NULL,
	[SpamBy] [int] NOT NULL,
	[Comments] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemConfigurationTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfigurationTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupportEmail] [varchar](100) NOT NULL,
	[SupportPhoneNumber] [varchar](15) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Facebook] [varchar](max) NULL,
	[Twitter] [varchar](max) NULL,
	[LinkedIn] [varchar](max) NULL,
	[DefaultNoteImage] [varbinary](max) NOT NULL,
	[DefaultProfilePicture] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_SystemConfigurationTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransectionTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransectionTable](
	[TID] [int] IDENTITY(1,1) NOT NULL,
	[NID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[Price] [int] NOT NULL,
	[BuyerID] [int] NOT NULL,
	[SellerID] [int] NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_TransectionTable] PRIMARY KEY CLUSTERED 
(
	[TID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeTable](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Description] [varchar](200) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TypeTable] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfileTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfileTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [int] NOT NULL,
	[DateOfBirth] [datetime] NULL,
	[Gender] [varchar](20) NULL,
	[CountryCode] [varchar](10) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[ProfilePicture] [varbinary](max) NULL,
	[AddressLine1] [varchar](100) NOT NULL,
	[AddressLine2] [varchar](100) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[ZipCode] [varchar](50) NOT NULL,
	[CountryID] [int] NOT NULL,
	[University] [varchar](100) NULL,
	[College] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_UserProfileTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTable]    Script Date: 14-03-2021 12:18:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTable](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[SecretCode] [uniqueidentifier] NULL,
 CONSTRAINT [PK_UserTable] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CategoryTable] ON 

INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Computer Science', N'Notes Related To Computer Science Study', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'IT', N'Notes Related To IT', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'CA', N'Notes Related To CA', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'MBA', N'Notes Related To MBA', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'History', N'Notes about History', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Story', N'Story Books', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, N'Biology', N'Notes for Medical and Biology Students', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, N'Self Help', N'Motivation, Meditation, Self Help Books', NULL, 1, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[CategoryTable] OFF
GO
SET IDENTITY_INSERT [dbo].[ContactUsTable] ON 

INSERT [dbo].[ContactUsTable] ([ID], [FullName], [Email], [Subject], [Comments], [CreatedDate]) VALUES (1, N'Yagnik', N'gohilyagnik3@gmail.com', N'Test', N'asdfg', NULL)
INSERT [dbo].[ContactUsTable] ([ID], [FullName], [Email], [Subject], [Comments], [CreatedDate]) VALUES (2, N'Yagnik', N'thisisemailofmine12345@gmail.com', N'subject is unknown', N'hi i am testing functionality', NULL)
SET IDENTITY_INSERT [dbo].[ContactUsTable] OFF
GO
SET IDENTITY_INSERT [dbo].[CountryTable] ON 

INSERT [dbo].[CountryTable] ([CountryID], [CountryName], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'India', N'+91', NULL, 1, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[CountryTable] OFF
GO
SET IDENTITY_INSERT [dbo].[NotesAttachmentTable] ON 

INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 11, N'Practical2.pdf;Practical3.pdf;', N'C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\11\Attachment\Attachment_1_05-03-2021_17-38-20_Practical2.pdf;C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\11\Attachment\Attachment_2_05-03-2021_17-38-20_Practical3.pdf;', CAST(N'2021-03-05T17:38:20.333' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 12, N'Practical2.pdf;Practical3.pdf;', N'C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\12\Attachment\Attachment_1_05-03-2021_18-07-45_Practical2.pdf;C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\12\Attachment\Attachment_2_05-03-2021_18-07-45_Practical3.pdf;', CAST(N'2021-03-05T18:07:45.333' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 13, N'Practical2.pdf;Practical3.pdf;', N'C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\13\Attachment\Attachment_1_06-03-2021_14-18-20_Practical2.pdf;C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\13\Attachment\Attachment_2_06-03-2021_14-18-20_Practical3.pdf;', CAST(N'2021-03-06T14:18:20.633' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, 14, N'Practical2.pdf;', N'C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\14\Attachment\Attachment_1_06-03-2021_14-21-28_Practical2.pdf;', CAST(N'2021-03-06T14:21:28.403' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (15, 15, N'Practical2.pdf;', N'C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\15\Attachment\Attachment_1_06-03-2021_14-25-39_Practical2.pdf;', CAST(N'2021-03-06T14:25:39.347' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (16, 16, N'Practical1.pdf;', N'C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\16\Attachment\Attachment_1_06-03-2021_15-18-56_Practical1.pdf;', CAST(N'2021-03-06T15:18:56.967' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (18, 18, N'Practical2.pdf;Practical3.pdf;', N'C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\18\Attachment\Attachment_1_07-03-2021_10-08-22_Practical2.pdf;C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\18\Attachment\Attachment_2_07-03-2021_10-08-22_Practical3.pdf;', CAST(N'2021-03-07T10:08:22.047' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (20, 20, N'Practical2.pdf;', N'C:\Users\gohil\source\repos\NotesMarketPlace\NotesMarketPlace\Members\2043\20\Attachment\Attachment_1_07-03-2021_10-36-13_Practical2.pdf;', CAST(N'2021-03-07T10:36:13.043' AS DateTime), 2043, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[NotesAttachmentTable] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteTable] ON 

INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 2043, N'Harry Potter', 6, N'~/Members/2043/11/05-03-2021_17-38-20.jpg', 4, 3000, N'All Parts of Harry Potter By J.K.Rowling. The Complete Collection', 1, NULL, NULL, NULL, NULL, 1, 1000, N'~/Members/2043/11/Practical2.pdf', 1, 3, CAST(N'2021-03-05T17:38:20.143' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 2043, N'Think And Grow Rich', 8, N'~/Members/2043/12/05-03-2021_18-07-45.jpeg', 6, 380, N'Think And Grow Rich is book about financial knowledge. Must read for students who are in College', NULL, NULL, NULL, NULL, NULL, 1, 150, N'~/Members/2043/12/Practical2.pdf', 1, 3, CAST(N'2021-03-05T18:07:45.093' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 2043, N'Lifes Amazing Secrets', 8, N'~/Members/2043/13/06-03-2021_14-18-20.jpg', 6, 380, N'Lifes Amazing Secrets: How to Find Balance and Purpose in Your Life is written by gaur gopal das. ', 1, NULL, NULL, NULL, NULL, 1, 150, N'~/Members/2043/13/Practical1.pdf', 1, 3, CAST(N'2021-03-06T14:18:20.453' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, 2043, N'C++ Programming', 1, N'~/Members/2043/14/06-03-2021_14-21-28.jpg', 2, 380, N'The C++ Programming Language Fourth Edition by Bjarne Stroustrup, The creator of C++.', 1, N'GTU', N'CE', N'003', N'KPK', 1, 300, N'~/Members/2043/14/Practical2.pdf', 1, 3, CAST(N'2021-03-06T14:21:28.383' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (15, 2043, N'Modern Indian History', 5, N'~/Members/2043/15/06-03-2021_14-25-39.jpg', 6, 1036, N'Modern Indian History From 1707 to the present year by V.D.Mahajan, S. Chand Publication', 1, N'GTU', N'Modern History', N'136', N'AGD', 1, 600, N'~/Members/2043/15/Practical1.pdf', 1, 3, CAST(N'2021-03-06T14:25:39.327' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (16, 2043, N'Biology Vol-1', 7, N'~/Members/2043/16/06-03-2021_15-18-56.jpg', 2, 1250, N'Study, Understand & Practice NCERT through MCQs. MASTER THE NCERT A Perfect Resource to Build Foundation for NEET.', 1, N'B J Medical College', N'MBBS', N'6548', N'SDF', 1, 540, N'~/Members/2043/16/Practical2.pdf', 1, 3, CAST(N'2021-03-06T15:18:56.927' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (18, 2043, N'Delete this book', 1, N'~/Members/2043/18/07-03-2021_10-08-22.jpg', 1, 2, N'Delete this book', 1, N'B J Medical College', N'CE', N'003', N'SDF', 1, 150, N'~/Members/2043/18/Practical1.pdf', 1, 3, CAST(N'2021-03-07T10:08:21.870' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (20, 2043, N'publish', 1, N'~/Members/2043/20/07-03-2021_10-36-13.jpg', 2, 1, N'publish', 1, N'GTU', N'CE', N'003', N'SDF', 0, 0, NULL, 1, 3, CAST(N'2021-03-07T10:36:13.033' AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[NoteTable] OFF
GO
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Draft', N'When User click on Save', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Submitted For Review', N'When User click on Publish', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'In Review', N'When Admin click on Review', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'Published', N'When Admin click on Approve', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'Rejected', N'When Admin click on Reject', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Removed ', N'When Admin click on Delete', NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[RoleTable] ON 

INSERT [dbo].[RoleTable] ([RID], [RoleName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Super Admin', N'This role is for super admin', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[RoleTable] ([RID], [RoleName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Admin', N'This role is for admin', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[RoleTable] ([RID], [RoleName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'User', N'This role is for User', NULL, 1, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[RoleTable] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeTable] ON 

INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Handwritten', N'Handwritten books', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'University note', N'university note', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'self write', N'Self Written note', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'Novel', N'Novel', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'Story', N'Story books', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Other', N'Other books', NULL, 1, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[TypeTable] OFF
GO
SET IDENTITY_INSERT [dbo].[UserTable] ON 

INSERT [dbo].[UserTable] ([UID], [RoleID], [FirstName], [LastName], [Email], [Password], [IsEmailVerified], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [SecretCode]) VALUES (2043, 3, N'Yagnik', N'Gohil', N'gohilyagnik3@gmail.com', N'AOosBd+bqnmbCGckusXwVbfomfVO+8gm7AsMJfr13wQ=', 1, NULL, NULL, NULL, NULL, 1, N'30b0b314-fede-446c-b383-66b40f2617bb')
SET IDENTITY_INSERT [dbo].[UserTable] OFF
GO
ALTER TABLE [dbo].[NotesAttachmentTable]  WITH CHECK ADD  CONSTRAINT [FK_NotesAttachmentTable_NoteTable] FOREIGN KEY([NID])
REFERENCES [dbo].[NoteTable] ([NID])
GO
ALTER TABLE [dbo].[NotesAttachmentTable] CHECK CONSTRAINT [FK_NotesAttachmentTable_NoteTable]
GO
ALTER TABLE [dbo].[NotesAttachmentTable]  WITH CHECK ADD  CONSTRAINT [FK_NotesAttachmentTable_UserTable] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[NotesAttachmentTable] CHECK CONSTRAINT [FK_NotesAttachmentTable_UserTable]
GO
ALTER TABLE [dbo].[NoteTable]  WITH CHECK ADD  CONSTRAINT [FK_NoteTable_CategoryTable] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CategoryTable] ([CategoryID])
GO
ALTER TABLE [dbo].[NoteTable] CHECK CONSTRAINT [FK_NoteTable_CategoryTable]
GO
ALTER TABLE [dbo].[NoteTable]  WITH CHECK ADD  CONSTRAINT [FK_NoteTable_CountryTable] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryTable] ([CountryID])
GO
ALTER TABLE [dbo].[NoteTable] CHECK CONSTRAINT [FK_NoteTable_CountryTable]
GO
ALTER TABLE [dbo].[NoteTable]  WITH CHECK ADD  CONSTRAINT [FK_NoteTable_ReferenceDataTable] FOREIGN KEY([Status])
REFERENCES [dbo].[ReferenceDataTable] ([ID])
GO
ALTER TABLE [dbo].[NoteTable] CHECK CONSTRAINT [FK_NoteTable_ReferenceDataTable]
GO
ALTER TABLE [dbo].[NoteTable]  WITH CHECK ADD  CONSTRAINT [FK_NoteTable_TypeTable] FOREIGN KEY([TypeID])
REFERENCES [dbo].[TypeTable] ([TypeID])
GO
ALTER TABLE [dbo].[NoteTable] CHECK CONSTRAINT [FK_NoteTable_TypeTable]
GO
ALTER TABLE [dbo].[NoteTable]  WITH CHECK ADD  CONSTRAINT [FK_NoteTable_UserTable] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[NoteTable] CHECK CONSTRAINT [FK_NoteTable_UserTable]
GO
ALTER TABLE [dbo].[NoteTable]  WITH CHECK ADD  CONSTRAINT [FK_NoteTable_UserTable1] FOREIGN KEY([UID])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[NoteTable] CHECK CONSTRAINT [FK_NoteTable_UserTable1]
GO
ALTER TABLE [dbo].[ReferenceDataTable]  WITH CHECK ADD  CONSTRAINT [FK_ReferenceDataTable_UserTable] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[ReferenceDataTable] CHECK CONSTRAINT [FK_ReferenceDataTable_UserTable]
GO
ALTER TABLE [dbo].[RejectedTable]  WITH CHECK ADD  CONSTRAINT [FK_RejectedTable_NoteTable] FOREIGN KEY([NID])
REFERENCES [dbo].[NoteTable] ([NID])
GO
ALTER TABLE [dbo].[RejectedTable] CHECK CONSTRAINT [FK_RejectedTable_NoteTable]
GO
ALTER TABLE [dbo].[RejectedTable]  WITH CHECK ADD  CONSTRAINT [FK_RejectedTable_UserTable] FOREIGN KEY([RejectedBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[RejectedTable] CHECK CONSTRAINT [FK_RejectedTable_UserTable]
GO
ALTER TABLE [dbo].[ReviewTable]  WITH CHECK ADD  CONSTRAINT [FK_ReviewTable_NoteTable] FOREIGN KEY([NID])
REFERENCES [dbo].[NoteTable] ([NID])
GO
ALTER TABLE [dbo].[ReviewTable] CHECK CONSTRAINT [FK_ReviewTable_NoteTable]
GO
ALTER TABLE [dbo].[ReviewTable]  WITH CHECK ADD  CONSTRAINT [FK_ReviewTable_UserTable] FOREIGN KEY([ReviewBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[ReviewTable] CHECK CONSTRAINT [FK_ReviewTable_UserTable]
GO
ALTER TABLE [dbo].[SpamTable]  WITH CHECK ADD  CONSTRAINT [FK_Table_1_NoteTable] FOREIGN KEY([NID])
REFERENCES [dbo].[NoteTable] ([NID])
GO
ALTER TABLE [dbo].[SpamTable] CHECK CONSTRAINT [FK_Table_1_NoteTable]
GO
ALTER TABLE [dbo].[SpamTable]  WITH CHECK ADD  CONSTRAINT [FK_Table_1_UserTable] FOREIGN KEY([SpamBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[SpamTable] CHECK CONSTRAINT [FK_Table_1_UserTable]
GO
ALTER TABLE [dbo].[TransectionTable]  WITH CHECK ADD  CONSTRAINT [FK_TransectionTable_NoteTable] FOREIGN KEY([NID])
REFERENCES [dbo].[NoteTable] ([NID])
GO
ALTER TABLE [dbo].[TransectionTable] CHECK CONSTRAINT [FK_TransectionTable_NoteTable]
GO
ALTER TABLE [dbo].[TransectionTable]  WITH CHECK ADD  CONSTRAINT [FK_TransectionTable_UserTable] FOREIGN KEY([BuyerID])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[TransectionTable] CHECK CONSTRAINT [FK_TransectionTable_UserTable]
GO
ALTER TABLE [dbo].[TransectionTable]  WITH CHECK ADD  CONSTRAINT [FK_TransectionTable_UserTable1] FOREIGN KEY([SellerID])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[TransectionTable] CHECK CONSTRAINT [FK_TransectionTable_UserTable1]
GO
ALTER TABLE [dbo].[UserProfileTable]  WITH CHECK ADD  CONSTRAINT [FK_UserProfileTable_CountryTable] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryTable] ([CountryID])
GO
ALTER TABLE [dbo].[UserProfileTable] CHECK CONSTRAINT [FK_UserProfileTable_CountryTable]
GO
ALTER TABLE [dbo].[UserProfileTable]  WITH CHECK ADD  CONSTRAINT [FK_UserProfileTable_UserTable] FOREIGN KEY([UID])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[UserProfileTable] CHECK CONSTRAINT [FK_UserProfileTable_UserTable]
GO
ALTER TABLE [dbo].[UserProfileTable]  WITH CHECK ADD  CONSTRAINT [FK_UserProfileTable_UserTable1] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[UserProfileTable] CHECK CONSTRAINT [FK_UserProfileTable_UserTable1]
GO
ALTER TABLE [dbo].[UserTable]  WITH CHECK ADD  CONSTRAINT [FK_UserTable_RoleTable] FOREIGN KEY([RoleID])
REFERENCES [dbo].[RoleTable] ([RID])
GO
ALTER TABLE [dbo].[UserTable] CHECK CONSTRAINT [FK_UserTable_RoleTable]
GO
ALTER TABLE [dbo].[UserTable]  WITH CHECK ADD  CONSTRAINT [FK_UserTable_UserTable] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[UserTable] CHECK CONSTRAINT [FK_UserTable_UserTable]
GO
USE [master]
GO
ALTER DATABASE [NotesMarketPlace] SET  READ_WRITE 
GO
