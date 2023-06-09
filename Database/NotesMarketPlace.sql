USE [master]
GO
/****** Object:  Database [NotesMarketPlace]    Script Date: 10-04-2021 15:24:47 ******/
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
/****** Object:  Table [dbo].[AdminTable]    Script Date: 10-04-2021 15:24:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [int] NOT NULL,
	[SecondaryEmail] [varchar](100) NULL,
	[CountryCode] [varchar](10) NULL,
	[PhoneNumber] [varchar](20) NULL,
	[ProfilePicture] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_AdminTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryTable]    Script Date: 10-04-2021 15:24:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryTable](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Description] [varchar](200) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_CategoryTable] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactUsTable]    Script Date: 10-04-2021 15:24:48 ******/
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
/****** Object:  Table [dbo].[CountryTable]    Script Date: 10-04-2021 15:24:48 ******/
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
/****** Object:  Table [dbo].[NotesAttachmentTable]    Script Date: 10-04-2021 15:24:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotesAttachmentTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NID] [int] NOT NULL,
	[FileName] [varchar](max) NOT NULL,
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
/****** Object:  Table [dbo].[NoteTable]    Script Date: 10-04-2021 15:24:48 ******/
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
	[Rating] [float] NULL,
	[TotalReviews] [int] NULL,
	[TotalSpams] [int] NULL,
	[RemarksByAdmin] [varchar](max) NULL,
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
/****** Object:  Table [dbo].[ReferenceDataTable]    Script Date: 10-04-2021 15:24:48 ******/
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
/****** Object:  Table [dbo].[RejectedTable]    Script Date: 10-04-2021 15:24:48 ******/
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
/****** Object:  Table [dbo].[ReviewTable]    Script Date: 10-04-2021 15:24:48 ******/
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
/****** Object:  Table [dbo].[RoleTable]    Script Date: 10-04-2021 15:24:48 ******/
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
/****** Object:  Table [dbo].[SpamTable]    Script Date: 10-04-2021 15:24:48 ******/
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
/****** Object:  Table [dbo].[SystemConfigurationTable]    Script Date: 10-04-2021 15:24:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfigurationTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupportEmail] [varchar](100) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[SupportPhoneNumber] [varchar](15) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Facebook] [varchar](max) NULL,
	[Twitter] [varchar](max) NULL,
	[LinkedIn] [varchar](max) NULL,
	[DefaultNoteImage] [varchar](max) NOT NULL,
	[DefaultProfilePicture] [varchar](max) NOT NULL,
 CONSTRAINT [PK_SystemConfigurationTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransectionTable]    Script Date: 10-04-2021 15:24:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransectionTable](
	[TID] [int] IDENTITY(1,1) NOT NULL,
	[NID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[IsPaid] [bit] NOT NULL,
	[Price] [int] NOT NULL,
	[BuyerID] [int] NOT NULL,
	[SellerID] [int] NOT NULL,
	[IsAllowed] [bit] NOT NULL,
	[IsDownloaded] [bit] NOT NULL,
	[DownloadedDate] [datetime] NULL,
	[Status] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_TransectionTable] PRIMARY KEY CLUSTERED 
(
	[TID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeTable]    Script Date: 10-04-2021 15:24:48 ******/
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
/****** Object:  Table [dbo].[UserProfileTable]    Script Date: 10-04-2021 15:24:48 ******/
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
	[ProfilePicture] [varchar](max) NULL,
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
/****** Object:  Table [dbo].[UserTable]    Script Date: 10-04-2021 15:24:48 ******/
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
SET IDENTITY_INSERT [dbo].[AdminTable] ON 

INSERT [dbo].[AdminTable] ([ID], [UID], [SecondaryEmail], [CountryCode], [PhoneNumber], [ProfilePicture], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 2048, NULL, N'+91', N'9106810880', N'Members/2048/DP_08-04-2021_17-56-14.jpg', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[AdminTable] ([ID], [UID], [SecondaryEmail], [CountryCode], [PhoneNumber], [ProfilePicture], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 2049, NULL, N'+91', N'9106810880', N'Members/2049/DP_08-04-2021_18-14-13.jpg', CAST(N'2021-04-07T14:46:34.920' AS DateTime), NULL, CAST(N'2021-04-10T11:04:12.187' AS DateTime), 2048, 1)
SET IDENTITY_INSERT [dbo].[AdminTable] OFF
GO
SET IDENTITY_INSERT [dbo].[CategoryTable] ON 

INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Computer Science', N'Notes Related To Computer Science Study', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'IT', N'Notes Related To IT', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'CA', N'Notes Related To CA', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'MBA', N'Notes Related To MBA', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'History', N'Notes about History', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Story', N'Story Books', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, N'Biology', N'Notes for Medical and Biology Students', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, N'Self Help', N'Motivation, Meditation, Self Help Books', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, N'Chess', N'Books for learning chess', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, N'Law', N'Books about Law', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, N'Comedy', N'Books for learning comedy', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CategoryTable] ([CategoryID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, N'Other', N'Other Category', CAST(N'2021-04-08T12:34:37.927' AS DateTime), 2048, CAST(N'2021-04-08T13:11:10.617' AS DateTime), 2048, 1)
SET IDENTITY_INSERT [dbo].[CategoryTable] OFF
GO
SET IDENTITY_INSERT [dbo].[ContactUsTable] ON 

INSERT [dbo].[ContactUsTable] ([ID], [FullName], [Email], [Subject], [Comments], [CreatedDate]) VALUES (1, N'Yagnik', N'gohilyagnik3@gmail.com', N'Test', N'asdfg', NULL)
INSERT [dbo].[ContactUsTable] ([ID], [FullName], [Email], [Subject], [Comments], [CreatedDate]) VALUES (2, N'Yagnik', N'thisisemailofmine12345@gmail.com', N'subject is unknown', N'hi i am testing functionality', NULL)
SET IDENTITY_INSERT [dbo].[ContactUsTable] OFF
GO
SET IDENTITY_INSERT [dbo].[CountryTable] ON 

INSERT [dbo].[CountryTable] ([CountryID], [CountryName], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'India', N'+91', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CountryTable] ([CountryID], [CountryName], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Germany', N'+49', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CountryTable] ([CountryID], [CountryName], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'Japan', N'+81', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CountryTable] ([CountryID], [CountryName], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'Russia', N'+7', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CountryTable] ([CountryID], [CountryName], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'United Kingdom', N'+44', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CountryTable] ([CountryID], [CountryName], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Canada', N'+1', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CountryTable] ([CountryID], [CountryName], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, N'United States', N'+1', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[CountryTable] ([CountryID], [CountryName], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, N'Other', N'+00', CAST(N'2021-04-08T15:58:24.290' AS DateTime), 2048, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[CountryTable] OFF
GO
SET IDENTITY_INSERT [dbo].[NotesAttachmentTable] ON 

INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 12, N'Practical1.pdf;', N'Members/2043/12/Attachment/Attachment_2_20-03-2021_10-27-01_Practical1.pdf;', CAST(N'2021-03-05T18:07:45.333' AS DateTime), 2043, CAST(N'2021-03-20T10:27:01.387' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 13, N'Practical3.pdf;', N'Members/2043/13/Attachment/Attachment_1_15-03-2021_18-47-49_Practical3.pdf;', CAST(N'2021-03-06T14:18:20.633' AS DateTime), 2043, CAST(N'2021-03-15T18:47:49.383' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, 14, N'Practical2.pdf;', N'Members/2043/14/Attachment/Attachment_1_06-03-2021_14-21-28_Practical2.pdf;', CAST(N'2021-03-06T14:21:28.403' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (15, 15, N'Practical2.pdf;', N'Members/2043/15/Attachment/Attachment_1_06-03-2021_14-25-39_Practical2.pdf;', CAST(N'2021-03-06T14:25:39.347' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (16, 16, N'Practical1.pdf;', N'Members/2043/16/Attachment/Attachment_1_06-03-2021_15-18-56_Practical1.pdf;', CAST(N'2021-03-06T15:18:56.967' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (32, 31, N'Practical2.pdf;', N'Members/2043/31/Attachment/Attachment_1_15-03-2021_21-37-15_Practical2.pdf;', CAST(N'2021-03-15T19:58:36.217' AS DateTime), 2043, CAST(N'2021-03-15T21:37:15.860' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (33, 32, N'Practical3.pdf;', N'Members/2043/32/Attachment/Attachment_1_15-03-2021_20-26-07_Practical3.pdf;', CAST(N'2021-03-15T20:26:07.497' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (34, 33, N'Practical1.pdf;', N'Members/2043/33/Attachment/Attachment_1_15-03-2021_21-19-56_Practical1.pdf;', CAST(N'2021-03-15T21:19:56.360' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (35, 34, N'Practical2.pdf;', N'Members/2043/34/Attachment/Attachment_1_15-03-2021_21-22-18_Practical2.pdf;', CAST(N'2021-03-15T21:22:18.490' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (36, 35, N'Practical3.pdf;', N'Members/2043/35/Attachment/Attachment_1_15-03-2021_21-29-28_Practical3.pdf;', CAST(N'2021-03-15T21:29:28.113' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (37, 36, N'Practical2.pdf;', N'Members/2043/36/Attachment/Attachment_1_15-03-2021_21-32-58_Practical2.pdf;', CAST(N'2021-03-15T21:32:58.167' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (38, 37, N'Practical1.pdf;', N'Members/2043/37/Attachment/Attachment_1_15-03-2021_21-34-48_Practical1.pdf;', CAST(N'2021-03-15T21:34:48.347' AS DateTime), 2043, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (41, 40, N'Practical3.pdf;', N'Members/2045/40/Attachment/Attachment_1_16-03-2021_10-39-06_Practical3.pdf;', CAST(N'2021-03-16T10:19:53.180' AS DateTime), 2045, CAST(N'2021-03-16T10:39:06.983' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (43, 42, N'Practical1.pdf;Practical2.pdf;', N'Members/2045/42/Attachment/Attachment_2_20-03-2021_10-31-45_Practical1.pdf;Members/2045/42/Attachment/Attachment_3_20-03-2021_10-31-45_Practical2.pdf;', CAST(N'2021-03-16T10:30:51.720' AS DateTime), 2045, CAST(N'2021-03-20T10:31:45.457' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (44, 43, N'Practical3.pdf;', N'Members/2045/43/Attachment/Attachment_2_20-03-2021_10-32-39_Practical3.pdf;', CAST(N'2021-03-16T10:38:38.910' AS DateTime), 2045, CAST(N'2021-03-20T10:32:39.923' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (45, 44, N'Practical3.pdf;', N'Members/2045/44/Attachment/Attachment_2_20-03-2021_10-32-57_Practical3.pdf;', CAST(N'2021-03-16T10:44:11.410' AS DateTime), 2045, CAST(N'2021-03-20T10:32:57.253' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (46, 45, N'Practical2.pdf;', N'Members/2045/45/Attachment/Attachment_2_20-03-2021_10-33-37_Practical2.pdf;', CAST(N'2021-03-16T10:53:03.460' AS DateTime), 2045, CAST(N'2021-03-20T10:33:37.663' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (47, 46, N'Practical3.pdf;', N'Members/2045/46/Attachment/Attachment_2_20-03-2021_10-34-02_Practical3.pdf;', CAST(N'2021-03-16T11:03:16.253' AS DateTime), 2045, CAST(N'2021-03-20T10:34:02.407' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (48, 47, N'Practical3.pdf;', N'Members/2045/47/Attachment/Attachment_2_20-03-2021_10-34-24_Practical3.pdf;', CAST(N'2021-03-16T11:21:45.613' AS DateTime), 2045, CAST(N'2021-03-20T10:34:24.900' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (49, 48, N'Practical2.pdf;', N'Members/2045/48/Attachment/Attachment_1_16-03-2021_11-25-15_Practical2.pdf;', CAST(N'2021-03-16T11:25:15.960' AS DateTime), 2045, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (50, 49, N'Practical2.pdf;', N'Members/2045/49/Attachment/Attachment_1_16-03-2021_11-27-23_Practical2.pdf;', CAST(N'2021-03-16T11:27:23.343' AS DateTime), 2045, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (51, 50, N'Practical3.pdf;', N'Members/2045/50/Attachment/Attachment_1_16-03-2021_11-29-25_Practical3.pdf;', CAST(N'2021-03-16T11:29:25.393' AS DateTime), 2045, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (52, 51, N'Practical2.pdf;', N'Members/2045/51/Attachment/Attachment_1_16-03-2021_11-36-22_Practical2.pdf;', CAST(N'2021-03-16T11:31:39.040' AS DateTime), 2045, CAST(N'2021-03-16T11:36:22.333' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (53, 52, N'Practical1.pdf;', N'Members/2045/52/Attachment/Attachment_1_16-03-2021_11-33-41_Practical1.pdf;', CAST(N'2021-03-16T11:33:41.387' AS DateTime), 2045, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (54, 53, N'Practical2.pdf;', N'Members/2045/53/Attachment/Attachment_1_16-03-2021_11-35-35_Practical2.pdf;', CAST(N'2021-03-16T11:35:35.293' AS DateTime), 2045, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (55, 54, N'Practical1.pdf;Practical2.pdf;', N'Members/2045/54/Attachment/Attachment_2_22-03-2021_10-39-01_Practical1.pdf;Members/2045/54/Attachment/Attachment_3_22-03-2021_10-39-01_Practical2.pdf;', CAST(N'2021-03-16T15:23:43.130' AS DateTime), 2045, CAST(N'2021-03-22T10:39:01.020' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (66, 66, N'Practical1.pdf;Practical2.pdf;', N'Members/2043/66/Attachment/Attachment_2_21-03-2021_15-39-17_Practical1.pdf;Members/2043/66/Attachment/Attachment_3_21-03-2021_15-39-17_Practical2.pdf;', CAST(N'2021-03-21T15:23:51.010' AS DateTime), 2043, CAST(N'2021-03-21T15:39:17.220' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (67, 67, N'Practical1.pdf;Practical2.pdf;Practical3.pdf;', N'Members/2046/67/Attachment/Attachment_2_24-03-2021_12-46-06_Practical1.pdf;Members/2046/67/Attachment/Attachment_3_24-03-2021_12-46-06_Practical2.pdf;Members/2046/67/Attachment/Attachment_4_24-03-2021_12-46-06_Practical3.pdf;', CAST(N'2021-03-24T11:50:26.563' AS DateTime), 2046, CAST(N'2021-03-24T12:46:06.497' AS DateTime), NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (70, 68, N'Practical3.pdf;', N'Members/2046/68/Attachment/Attachment_2_04-04-2021_12-50-24_Practical3.pdf;', CAST(N'2021-04-04T12:50:24.580' AS DateTime), 2046, NULL, NULL, 1)
INSERT [dbo].[NotesAttachmentTable] ([ID], [NID], [FileName], [FilePath], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (71, 69, N'Practical1.pdf;Practical2.pdf;', N'Members/2043/69/Attachment/Attachment_2_09-04-2021_18-17-41_Practical1.pdf;Members/2043/69/Attachment/Attachment_3_09-04-2021_18-17-41_Practical2.pdf;', CAST(N'2021-04-09T18:17:41.670' AS DateTime), 2043, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[NotesAttachmentTable] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteTable] ON 

INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 2043, N'Think And Grow Rich', 8, N'Members/2043/12/DP_20-03-2021_10-27-01.jpeg', 6, 380, N'Think And Grow Rich is book about financial knowledge. Must read for students who are in College', 1, N'GTU', N'Other', NULL, NULL, 1, 150, N'Members/2043/12/Preview_20-03-2021_10-27-01_Practical2.pdf', 4, 2048, NULL, NULL, NULL, NULL, CAST(N'2021-03-06T14:19:20.450' AS DateTime), NULL, CAST(N'2021-04-01T16:25:29.333' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 2043, N'Lifes Amazing Secrets', 8, N'Members/2043/13/DP_15-03-2021_18-47-49.jpg', 6, 380, N'Lifes Amazing Secrets: How to Find Balance and Purpose in Your Life is written by gaur gopal das. ', 1, N'GTU', N'Other', NULL, NULL, 1, 150, N'Members/2043/13/Preview_15-03-2021_18-47-49_Practical1.pdf', 4, 2048, 100, 1, NULL, NULL, CAST(N'2021-03-06T14:21:25.307' AS DateTime), NULL, CAST(N'2021-04-01T17:28:16.493' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, 2043, N'C++ Programming', 1, N'Members/2043/14/DP_06-03-2021_14-21-28.jpg', 2, 380, N'The C++ Programming Language Fourth Edition by Bjarne Stroustrup, The creator of C++.', 1, N'GTU', N'CE', N'003', N'KPK', 1, 300, N'Members/2043/14/Preview_06-03-2021_14-21-28_Practical2.pdf', 4, 2048, NULL, NULL, NULL, N'Test Reject', CAST(N'2021-03-06T14:21:28.383' AS DateTime), NULL, CAST(N'2021-04-05T09:51:26.923' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (15, 2043, N'Modern Indian History', 5, N'Members/2043/15/DP_06-03-2021_14-25-39.jpg', 6, 1036, N'Modern Indian History From 1707 to the present year by V.D.Mahajan, S. Chand Publication', 1, N'GTU', N'Modern History', N'136', N'AGD', 1, 600, N'Members/2043/15/Preview_06-03-2021_14-25-39_Practical1.pdf', 4, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-06T14:25:39.327' AS DateTime), NULL, CAST(N'2021-04-10T12:17:41.883' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (16, 2043, N'Biology Vol-1', 7, N'Members/2043/16/DP_06-03-2021_15-18-56.jpg', 2, 1250, N'Study, Understand & Practice NCERT through MCQs. MASTER THE NCERT A Perfect Resource to Build Foundation for NEET.', 1, N'B J Medical College', N'MBBS', N'6548', N'SDF', 1, 540, N'Members/2043/16/Preview_06-03-2021_15-18-56_Practical2.pdf', 4, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-06T15:18:56.927' AS DateTime), NULL, CAST(N'2021-04-10T12:17:44.713' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (31, 2043, N'Java: A Beginner''s Guide', 2, N'Members/2043/31/DP_15-03-2021_21-37-15.jpg', 1, 1036, N'Fully updated for Java Platform, Standard Edition 8 (Java SE 8), Java: A Beginner''s Guide, Sixth Edition gets you started programming in Java right away.', 4, N'Institute of Russia', N'Computer Engineering', N'6625', N'HS', 1, 420, N'Members/2043/31/Preview_15-03-2021_21-37-15_Practical1.pdf', 4, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-15T20:44:59.727' AS DateTime), NULL, CAST(N'2021-04-10T12:17:59.790' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (32, 2043, N'Molecular Biology', 7, N'Members/2043/32/DP_15-03-2021_20-26-07.jpg', 2, 380, N'This textbook of Molecular Biology has been developed for B.Sc. students of all Russian Universities. But it will also serves the purpose of the students of B.Sc. (Hons.), M.Sc. Zoology, botany, Microbiology and biotechnology.', 4, N'Institute of Russia', N'Micro Biology', N'4862', N'K.G.Natsya', 1, 680, N'Members/2043/32/Preview_15-03-2021_20-26-07_Practical2.pdf', 4, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-15T20:26:07.183' AS DateTime), NULL, CAST(N'2021-04-10T12:17:49.833' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (33, 2043, N'Cryptography and Network Security', 1, N'Members/2043/33/DP_15-03-2021_21-19-56.jpg', 2, 1250, N'The aim of this course is to introduce the student to the areas of cryptography and cryptanalysis. This course develops a basic understanding of the algorithms used to protect users online and to understand some of the design choices behind these algorithms.', 5, N'Institute of UK', N'Computer Engineering', N'6625', N'KRP', 1, 680, N'Members/2043/33/Preview_15-03-2021_21-19-56_Practical2.pdf', 5, 2048, NULL, NULL, NULL, N'Test Reject 2', CAST(N'2021-03-15T21:19:56.100' AS DateTime), NULL, CAST(N'2021-04-05T09:54:17.880' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (34, 2043, N'Cryptography and Network Security', 1, N'Members/2043/34/DP_15-03-2021_21-22-18.jpg', 2, 800, N'A textbook for beginners in security. In this new first edition, well-known author Behrouz Forouzan uses his accessible writing style and visual approach to simplify the difficult concepts of cryptography and network security.', 7, N'Institute of US', N'Computer Engineering', N'6625', N'BAF', 1, 650, N'Members/2043/34/Preview_15-03-2021_21-22-18_Practical1.pdf', 3, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-15T21:22:18.460' AS DateTime), NULL, CAST(N'2021-04-10T12:18:03.147' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (35, 2043, N'C++: The Complete Reference, 4th Edition', 1, N'Members/2043/35/DP_15-03-2021_21-29-28.jpg', 2, 460, N'Best-selling genius Herb Schildt covers everything from keywords, syntax, and libraries, to advanced features such as overloading, inheritance, virtual functions, namespaces, templates, and RTTI—plus, a complete description of the Standard Template Library (STL).', 1, N'IIT Bombay', N'Computer Engineering', N'6625', N'HCV', 1, 420, N'Members/2043/35/Preview_15-03-2021_21-29-28_Practical1.pdf', 3, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-15T21:29:27.870' AS DateTime), NULL, CAST(N'2021-04-10T12:18:05.083' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (36, 2043, N'Bharat ka Prachin Itihas: -- (Hindi Edition)', 5, N'Members/2043/36/DP_15-03-2021_21-32-58.jpg', 2, 1250, N'Beginning with a discussion on frameworks of writing history, the volume sheds light on the origins and growth of civilizations, empires, and religions.', 1, N'JNU', N'Modern History', N'4862', N'RSS', 1, 140, N'Members/2043/36/Preview_15-03-2021_21-32-58_Practical2.pdf', 4, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-15T21:32:58.110' AS DateTime), NULL, CAST(N'2021-04-10T12:18:07.213' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (37, 2043, N'World History', 5, N'Members/2043/37/DP_15-03-2021_21-34-48.jpg', 2, 680, N'McGraw Hill Education is proud to present “World History” by their bestselling author Krishna Reddy who has written “Indian History”.', 1, N'JNU', N'Modern History', N'136', N'K Reddy', 1, 300, N'Members/2043/37/Preview_15-03-2021_21-34-48_Practical1.pdf', 4, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-15T21:34:48.303' AS DateTime), NULL, CAST(N'2021-04-10T12:18:11.820' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (40, 2045, N'Bharat ka Samvidhan - Hindi Edition', 10, N'Members/2045/40/DP_16-03-2021_10-39-06.jpg', 2, 480, N' Bharat Ka Samvidhan by Dr. B.R. Ambedkar. The Constitution of India Hindi Edition by Dr. B.R. Ambedkar', 1, N'JNU', N'Indian Laws', N'579', N'KK', 1, 130, N'Members/2045/40/Preview_16-03-2021_10-39-06_Practical3.pdf', 3, 2048, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T10:19:53.163' AS DateTime), NULL, CAST(N'2021-04-01T16:39:25.877' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (42, 2045, N'How to Write Funny', 11, N'Members/2045/42/DP_20-03-2021_10-31-45.jpg', 6, 160, N'Learn comedy writing and how to write a joke with a simple comedy-writing and joke-writing formula you can use right now to write your own jokes.', 1, N'Comedy Institute of India', N'Art of comedy', N'7779', N'BKR', 1, 160, N'Members/2045/42/Preview_20-03-2021_10-31-45_Practical3.pdf', 4, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T10:28:10.577' AS DateTime), NULL, CAST(N'2021-04-10T12:18:14.507' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (43, 2045, N'Bobby Fischer Teaches Chess', 9, N'Members/2045/43/DP_20-03-2021_10-32-39.jpg', 6, 410, N'Bobby Fischer Teaches Chess is a chess puzzle book written by Bobby Fischer and co-authored by Stuart Margulies and Donn Mosenfelder, originally published in 1966.', 1, N'IIT Bombay', N'Learn Chess', N'55', N'Magnus', 1, 300, N'Members/2045/43/Preview_20-03-2021_10-32-39_Practical3.pdf', 4, 2049, NULL, NULL, 1, NULL, CAST(N'2021-03-16T10:38:38.627' AS DateTime), NULL, CAST(N'2021-04-10T12:18:16.970' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (44, 2045, N'How to Reassess Your Chess', 9, N'Members/2045/44/DP_20-03-2021_10-32-57.jpeg', 6, 380, N'How to Reassess Your Chess has long been considered a modern classic. This 4th edition takes Silman''s groundbreaking concept of imbalances to a whole new level.', 1, N'IIT KGP', N'Learn Chess', N'55', N'Magnus', 1, 150, N'Members/2045/44/Preview_20-03-2021_10-32-57_Practical3.pdf', 4, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T10:44:11.060' AS DateTime), NULL, CAST(N'2021-04-10T12:18:29.770' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (45, 2045, N'Important Judgments that Transformed India', 10, N'Members/2045/45/DP_20-03-2021_10-33-37.jpg', 2, 1036, N'The book “Important Judgments that Transformed India” presents an easy understanding of the landmark Court cases that everyone needs to know about.', 1, N'JNU', N'Indian Laws', N'6625', N'KK', 1, 420, N'Members/2045/45/Preview_20-03-2021_10-33-37_Practical3.pdf', 2, 2045, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T10:53:03.193' AS DateTime), NULL, CAST(N'2021-04-10T11:56:56.927' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (46, 2045, N'Serious Guide to Joke Writing', 11, N'Members/2045/46/DP_20-03-2021_10-34-02.jpg', 6, 145, N'How To Write Jokes for Fun & Profit This comprehensive joke writing masterclass has been devised for beginners and experienced joke writers alike.', 1, N'Comedy Institute of India', N'Art of comedy', N'465', N'BKR', 1, 230, N'Members/2045/46/Preview_20-03-2021_10-34-02_Practical2.pdf', 4, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T11:00:57.787' AS DateTime), NULL, CAST(N'2021-04-10T12:18:35.627' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (47, 2045, N'Law for the Common Man', 10, N'Members/2045/47/DP_20-03-2021_10-34-24.jpeg', 2, 650, N'It has been generally believed among different sections and groups of the society that legal education is only for the law students, lawyers etc.', 1, N'JNU', N'Indian Laws', N'645', N'KK', 1, 340, N'Members/2045/47/Preview_20-03-2021_10-34-24_Practical2.pdf', 3, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T11:21:45.537' AS DateTime), NULL, CAST(N'2021-04-10T12:19:02.287' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (48, 2045, N'Garry Kasparov on My Great Predecessors, Part 1', 9, N'Members/2045/48/DP_16-03-2021_11-25-15.jpg', 6, 320, N'The battle for the World Chess Championship has witnessed numerous titanic struggles which have engaged the interest not only of chess enthusiasts but also of the public at large.', 1, N'IIT KGP', N'Learn Chess', N'55', N'VSG', 1, 240, N'Members/2045/48/Preview_16-03-2021_11-25-15_Practical1.pdf', 2, 2045, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T11:25:15.917' AS DateTime), NULL, CAST(N'2021-04-10T11:57:43.007' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (49, 2045, N'Garry Kasparov on My Great Predecessors, part 2', 9, N'Members/2045/49/DP_16-03-2021_11-27-23.jpeg', 6, 240, N'Part two features the play of champions Max Euwe (1935-1937) Mikhail Botvinnik (1946-1957, 1958-1961 and 1961-1963), Vassily Smyslov (1957-1958) and Mikhail Tal (1960-1961).', 1, N'IIT Bombay', N'Learn Chess', N'55', N'VSG', 1, 230, N'Members/2045/49/Preview_16-03-2021_11-27-23_Practical1.pdf', 2, 2045, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T11:27:23.307' AS DateTime), NULL, CAST(N'2021-04-10T11:59:13.903' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (50, 2045, N'Mind Master', 9, N'Members/2045/50/DP_16-03-2021_11-29-25.jpg', 6, 296, N'Few people know better than Viswanathan Anand how to think strategically at lightning speed and work under immense pressure to overcome the toughest odds.', 1, N'IIT KGP', N'Learn Chess', N'55', N'GM Viswanathan Anand', 1, 180, N'Members/2045/50/Preview_16-03-2021_11-29-25_Practical1.pdf', 2, 2045, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T11:29:25.357' AS DateTime), NULL, CAST(N'2021-03-31T10:54:22.327' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (51, 2045, N'Mastering Stand-Up', 11, N'Members/2045/51/DP_16-03-2021_11-36-22.jpg', 6, 350, N'Rosenfield''s book is sure to become the classic text on its subject. And it should help thousands who long to make others laugh to realize their fondest hopes.', 1, N'Comedy Institute of India', N'Art of comedy', N'7779', N'BKR', 1, 240, N'Members/2045/51/Preview_16-03-2021_11-36-22_Practical1.pdf', 1, 2045, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T11:31:39.000' AS DateTime), NULL, CAST(N'2021-03-16T11:36:22.290' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (52, 2045, N'The Comedy Bible', 11, N'Members/2045/52/DP_16-03-2021_11-33-41.jpg', 2, 380, N'If you’ve got a sense of humor, you can learn to make a career out of comedy, says Judy Carter.', 1, N'Comedy Institute of India', N'Art of comedy', N'7779', N'BKR', 1, 230, N'Members/2045/52/Preview_16-03-2021_11-33-41_Practical2.pdf', 1, 2045, NULL, NULL, NULL, NULL, CAST(N'2021-03-16T11:33:41.350' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (53, 2045, N'The NEW Comedy Bible', 11, N'Members/2045/53/DP_16-03-2021_11-35-35.jpg', 6, 160, N'The New Comedy Bible is a step-by-step, no excuses manual for writing, performing, and launching your career as a stand-up comic.', 1, N'Comedy Institute of India', N'Art of comedy', N'7779', N'BKR', 1, 150, N'Members/2045/53/Preview_16-03-2021_11-35-35_Practical2.pdf', 4, 2049, 0, 0, 1, NULL, CAST(N'2021-03-16T11:35:35.263' AS DateTime), NULL, CAST(N'2021-04-10T10:46:29.890' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (54, 2045, N'NCERT General Studies', 8, N'Members/2045/54/DP_22-03-2021_10-39-00.jpg', 6, 540, N'This comprehensively revised 3rd Edition of NCERT General Studies is exclusively created as per the latest NCERT syllabus.', 1, N'JNU', N'Other', NULL, NULL, 0, 0, NULL, 4, 2048, 90, 2, 1, NULL, CAST(N'2021-03-16T15:23:42.953' AS DateTime), NULL, CAST(N'2021-04-09T18:22:34.070' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (66, 2043, N'Harry Potter', 6, N'Members/2043/66/DP_21-03-2021_15-39-17.jpg', 4, 3000, N'A beautiful boxed set containing all seven Harry Potter novels in paperback. These new editions of the classic and internationally bestselling, multi-award-winning series feature instantly pick-up-able new jackets by Jonny Duddle, with huge child appeal, to bring Harry Potter to the next generation of readers. It''s time to PASS THE MAGIC ON .', 1, N'Institute of Arts', N'Other', NULL, NULL, 0, 0, NULL, 4, 2048, NULL, NULL, NULL, NULL, CAST(N'2021-03-21T15:23:50.613' AS DateTime), NULL, CAST(N'2021-04-01T12:50:25.297' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (67, 2046, N'The Mighty Knight', 6, N'Members/2046/67/DP_24-03-2021_12-46-06.jpg', 5, 500, N'The Knight is a fantasy novel written by American author Gene Wolfe. It depicts the journey of an American boy transported to a magical realm and aged to adulthood who soon thereafter becomes a knight.', 1, N'Institute of Arts', N'Art of comedy', N'55', N'AGD', 1, 150, N'Members/2046/67/Preview_24-03-2021_12-46-06_Practical2.pdf', 4, 2048, NULL, NULL, NULL, N'Test Unpublish', CAST(N'2021-03-24T11:50:26.253' AS DateTime), NULL, CAST(N'2021-04-04T10:05:36.187' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (68, 2046, N'The Mighty Knight 2', 6, N'Members/2046/68/DP_04-04-2021_12-50-24.jpg', 5, 380, N'The Knight is a fantasy novel written by American author Gene Wolfe. It depicts the journey of an American boy transported to a magical realm and aged to adulthood who soon thereafter becomes a knight.', 1, N'Institute of Arts', N'Art of comedy', N'003', N'AGD', 1, 150, N'Members/2046/68/Preview_04-04-2021_12-50-24_Practical2.pdf', 4, 2048, NULL, NULL, NULL, N'Checking functionality', CAST(N'2021-04-04T12:50:24.407' AS DateTime), NULL, CAST(N'2021-04-09T16:48:28.693' AS DateTime), NULL, 1)
INSERT [dbo].[NoteTable] ([NID], [UID], [Title], [CategoryID], [DisplayPicture], [TypeID], [NumberOfPages], [Description], [CountryID], [InstituteName], [CourseName], [CourseCode], [Professor], [IsPaid], [Price], [PreviewAttachment], [Status], [ActionBy], [Rating], [TotalReviews], [TotalSpams], [RemarksByAdmin], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (69, 2043, N'Cryptography and Network Security', 1, N'Members/2043/69/DP_09-04-2021_18-17-41.jpg', 2, 1250, N'The aim of this course is to introduce the student to the areas of cryptography and cryptanalysis. This course develops a basic understanding of the algorithms used to protect users online and to understand some of the design choices behind these algorithms.', 5, N'Institute of UK', N'Computer Engineering', N'6625', N'KRP', 1, 680, N'Members/2043/69/Preview_09-04-2021_18-17-41_Practical2.pdf', 3, 2049, NULL, NULL, NULL, NULL, CAST(N'2021-04-09T18:17:41.473' AS DateTime), NULL, CAST(N'2021-04-10T12:18:59.547' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[NoteTable] OFF
GO
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Draft', N'When User click on Save', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Submitted For Review', N'When User click on Publish', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'In Review', N'When Admin click on Review', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'Published', N'When Admin click on Approve', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'Rejected', N'When Admin click on Reject', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ReferenceDataTable] ([ID], [StatusName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Removed ', N'When Admin click on Delete', NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[ReviewTable] ON 

INSERT [dbo].[ReviewTable] ([ID], [NID], [ReviewBy], [Rating], [Comments], [CreatedDate]) VALUES (7, 13, 2045, 5, N'This book is simply and slowly make us realise what all wrong we are doing in life.', CAST(N'2021-03-26T17:52:57.140' AS DateTime))
INSERT [dbo].[ReviewTable] ([ID], [NID], [ReviewBy], [Rating], [Comments], [CreatedDate]) VALUES (8, 54, 2043, 5, N'Book is great to get a summary of NCERT''s.', CAST(N'2021-04-10T10:51:56.897' AS DateTime))
INSERT [dbo].[ReviewTable] ([ID], [NID], [ReviewBy], [Rating], [Comments], [CreatedDate]) VALUES (11, 54, 2046, 4, N'Almost accurate and updated as per NCERT.', CAST(N'2021-04-10T11:03:04.533' AS DateTime))
SET IDENTITY_INSERT [dbo].[ReviewTable] OFF
GO
SET IDENTITY_INSERT [dbo].[RoleTable] ON 

INSERT [dbo].[RoleTable] ([RID], [RoleName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Super Admin', N'This role is for super admin', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[RoleTable] ([RID], [RoleName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Admin', N'This role is for admin', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[RoleTable] ([RID], [RoleName], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'User', N'This role is for User', NULL, 1, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[RoleTable] OFF
GO
SET IDENTITY_INSERT [dbo].[SpamTable] ON 

INSERT [dbo].[SpamTable] ([ID], [NID], [SpamBy], [Comments], [CreatedDate]) VALUES (2, 43, 2043, N'First spam by Yagnik', CAST(N'2021-03-24T10:49:16.670' AS DateTime))
INSERT [dbo].[SpamTable] ([ID], [NID], [SpamBy], [Comments], [CreatedDate]) VALUES (3, 53, 2043, N'Spam for checking email by Yagnik', CAST(N'2021-03-24T14:12:42.833' AS DateTime))
SET IDENTITY_INSERT [dbo].[SpamTable] OFF
GO
SET IDENTITY_INSERT [dbo].[SystemConfigurationTable] ON 

INSERT [dbo].[SystemConfigurationTable] ([ID], [SupportEmail], [Password], [SupportPhoneNumber], [Email], [Facebook], [Twitter], [LinkedIn], [DefaultNoteImage], [DefaultProfilePicture]) VALUES (1, N'arachnophobetwo@gmail.com', N'NeverUseThisAccountForPersonalUse', N'9106810880', N'arachnophobeone@gmail.com', N'https://www.facebook.com/TatvaSoft', N'https://twitter.com/tatvasoft', N'https://in.linkedin.com/company/tatvasoft', N'Default/Book.jpg', N'Default/User.jpg')
SET IDENTITY_INSERT [dbo].[SystemConfigurationTable] OFF
GO
SET IDENTITY_INSERT [dbo].[TransectionTable] ON 

INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (19, 12, N'Think And Grow Rich', N'Self Help', 1, 150, 2045, 2043, 1, 1, CAST(N'2021-03-26T13:47:13.350' AS DateTime), N'Draft', CAST(N'2021-03-21T10:49:47.270' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (20, 13, N'Lifes Amazing Secrets', N'Self Help', 1, 150, 2045, 2043, 1, 1, CAST(N'2021-03-26T17:53:48.407' AS DateTime), N'Draft', CAST(N'2021-03-21T11:20:10.453' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (21, 14, N'C++ Programming', N'Computer Science', 1, 300, 2045, 2043, 0, 0, NULL, N'Draft', CAST(N'2021-03-21T11:20:29.073' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (22, 15, N'Modern Indian History', N'History', 1, 600, 2045, 2043, 0, 0, NULL, N'Draft', CAST(N'2021-03-21T11:20:41.757' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (24, 53, N'The NEW Comedy Bible', N'Comedy', 1, 150, 2043, 2045, 1, 1, CAST(N'2021-03-22T12:25:09.040' AS DateTime), N'Draft', CAST(N'2021-03-21T12:25:51.527' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (26, 54, N'NCERT General Studies', N'Self Help', 0, 0, 2043, 2045, 1, 1, CAST(N'2021-03-21T13:45:59.230' AS DateTime), N'Draft', CAST(N'2021-03-21T13:45:59.247' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (27, 43, N'Bobby Fischer Teaches Chess', N'Chess', 1, 300, 2043, 2045, 1, 1, CAST(N'2021-03-22T12:29:55.153' AS DateTime), N'Draft', CAST(N'2021-03-21T14:46:28.827' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (28, 51, N'Mastering Stand-Up', N'Comedy', 1, 240, 2043, 2045, 1, 0, NULL, N'Draft', CAST(N'2021-03-21T14:51:40.117' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (29, 42, N'How to Write Funny', N'Comedy', 1, 160, 2043, 2045, 1, 0, NULL, N'Draft', CAST(N'2021-03-21T15:46:36.303' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (30, 44, N'How to Reassess Your Chess', N'Chess', 1, 150, 2043, 2045, 1, 0, NULL, N'Draft', CAST(N'2021-03-21T15:48:40.550' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (31, 45, N'Important Judgments that Transformed India', N'Law', 1, 420, 2043, 2045, 1, 0, NULL, N'Draft', CAST(N'2021-03-21T15:50:21.763' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (32, 66, N'Harry Potter', N'Story', 0, 0, 2045, 2043, 1, 1, CAST(N'2021-03-22T10:59:38.417' AS DateTime), N'Draft', CAST(N'2021-03-22T10:59:38.437' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (33, 40, N'Bharat ka Samvidhan - Hindi Edition', N'Law', 1, 130, 2043, 2045, 1, 0, NULL, N'Draft', CAST(N'2021-03-22T13:35:45.993' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (46, 46, N'Serious Guide to Joke Writing', N'Comedy', 1, 230, 2043, 2045, 0, 0, NULL, N'Draft', CAST(N'2021-03-22T14:22:06.797' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (56, 47, N'Law for the Common Man', N'Law', 1, 340, 2043, 2045, 0, 0, NULL, N'Draft', CAST(N'2021-03-22T15:27:05.833' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (57, 54, N'NCERT General Studies', N'Self Help', 0, 0, 2046, 2045, 1, 1, CAST(N'2021-03-23T13:13:08.780' AS DateTime), N'Draft', CAST(N'2021-03-23T13:13:08.810' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (58, 33, N'Cryptography and Network Security', N'Computer Science', 1, 680, 2045, 2043, 0, 0, NULL, N'Draft', CAST(N'2021-03-25T14:08:35.303' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (59, 35, N'C++: The Complete Reference, 4th Edition', N'Computer Science', 1, 420, 2045, 2043, 0, 0, NULL, N'Draft', CAST(N'2021-03-25T14:09:27.350' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (60, 12, N'Think And Grow Rich', N'Self Help', 1, 150, 2046, 2043, 1, 1, CAST(N'2021-04-04T12:03:03.053' AS DateTime), N'Draft', CAST(N'2021-03-25T15:02:33.793' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (61, 13, N'Lifes Amazing Secrets', N'Self Help', 1, 150, 2046, 2043, 1, 1, CAST(N'2021-03-27T16:56:18.140' AS DateTime), N'Draft', CAST(N'2021-03-25T15:03:41.877' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (62, 14, N'C++ Programming', N'Computer Science', 1, 300, 2046, 2043, 0, 0, NULL, N'Draft', CAST(N'2021-03-25T15:04:59.847' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (63, 15, N'Modern Indian History', N'History', 1, 600, 2046, 2043, 0, 0, NULL, N'Draft', CAST(N'2021-03-25T15:07:10.030' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (64, 16, N'Biology Vol-1', N'Biology', 1, 540, 2046, 2043, 0, 0, NULL, N'Draft', CAST(N'2021-03-25T15:09:21.217' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (65, 31, N'Java: A Beginner''s Guide', N'IT', 1, 420, 2046, 2043, 0, 0, NULL, N'Draft', CAST(N'2021-03-25T15:18:05.200' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (66, 40, N'Bharat ka Samvidhan - Hindi Edition', N'Law', 1, 130, 2046, 2045, 1, 0, NULL, N'Draft', CAST(N'2021-03-25T15:37:54.627' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (67, 42, N'How to Write Funny', N'Comedy', 1, 160, 2046, 2045, 1, 0, NULL, N'Draft', CAST(N'2021-03-25T15:41:35.667' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (68, 43, N'Bobby Fischer Teaches Chess', N'Chess', 1, 300, 2046, 2045, 0, 0, NULL, N'Draft', CAST(N'2021-03-25T15:46:38.813' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (69, 44, N'How to Reassess Your Chess', N'Chess', 1, 150, 2046, 2045, 0, 0, NULL, N'Draft', CAST(N'2021-03-25T15:47:24.020' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (70, 45, N'Important Judgments that Transformed India', N'Law', 1, 420, 2046, 2045, 0, 0, NULL, N'Draft', CAST(N'2021-03-25T15:47:57.793' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (71, 67, N'The Mighty Knight', N'Story', 1, 150, 2045, 2046, 1, 1, CAST(N'2021-04-04T12:54:15.750' AS DateTime), N'Draft', CAST(N'2021-03-27T16:54:40.507' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (72, 50, N'Mind Master', N'Chess', 1, 180, 2046, 2045, 0, 0, NULL, N'Draft', CAST(N'2021-03-27T16:56:59.770' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (74, 67, N'The Mighty Knight', N'Story', 1, 150, 2043, 2046, 1, 1, CAST(N'2021-04-06T10:35:54.397' AS DateTime), N'Removed ', CAST(N'2021-04-04T12:03:49.553' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (75, 68, N'The Mighty Knight 2', N'Story', 1, 150, 2045, 2046, 1, 1, CAST(N'2021-04-04T12:54:17.423' AS DateTime), N'Published', CAST(N'2021-04-04T12:52:42.427' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (76, 66, N'Harry Potter', N'Story', 0, 0, 2046, 2043, 1, 1, CAST(N'2021-04-09T10:22:19.483' AS DateTime), N'Published', CAST(N'2021-04-09T10:22:19.503' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (78, 68, N'The Mighty Knight 2', N'Story', 1, 150, 2043, 2046, 0, 0, NULL, N'Published', CAST(N'2021-04-10T12:09:27.273' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (79, 42, N'How to Write Funny', N'Comedy', 1, 160, 2050, 2045, 1, 1, CAST(N'2021-04-10T13:17:38.980' AS DateTime), N'Published', CAST(N'2021-04-10T13:11:46.620' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (80, 43, N'Bobby Fischer Teaches Chess', N'Chess', 1, 300, 2050, 2045, 1, 1, CAST(N'2021-04-10T13:18:19.107' AS DateTime), N'Published', CAST(N'2021-04-10T13:17:55.373' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (81, 46, N'Serious Guide to Joke Writing', N'Comedy', 1, 230, 2050, 2045, 1, 0, NULL, N'Published', CAST(N'2021-04-10T13:18:32.923' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (82, 66, N'Harry Potter', N'Story', 0, 0, 2050, 2043, 1, 1, CAST(N'2021-04-10T13:19:18.000' AS DateTime), N'Published', CAST(N'2021-04-10T13:19:18.000' AS DateTime), NULL)
INSERT [dbo].[TransectionTable] ([TID], [NID], [Title], [Category], [IsPaid], [Price], [BuyerID], [SellerID], [IsAllowed], [IsDownloaded], [DownloadedDate], [Status], [CreatedDate], [ModifiedDate]) VALUES (83, 53, N'The NEW Comedy Bible', N'Comedy', 1, 150, 2050, 2045, 0, 0, NULL, N'Published', CAST(N'2021-04-10T13:19:28.523' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[TransectionTable] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeTable] ON 

INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Handwritten', N'Handwritten books', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'University note', N'university note', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'Self Write', N'Self Written note', NULL, 2048, CAST(N'2021-04-08T15:01:31.433' AS DateTime), 2048, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'Novel', N'Novel', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'Story', N'Story books', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Other', N'Other books', NULL, 2048, NULL, NULL, 1)
INSERT [dbo].[TypeTable] ([TypeID], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, N'New Type', N'New Type', CAST(N'2021-04-08T14:58:21.753' AS DateTime), 2048, CAST(N'2021-04-08T15:03:06.970' AS DateTime), 2048, 1)
SET IDENTITY_INSERT [dbo].[TypeTable] OFF
GO
SET IDENTITY_INSERT [dbo].[UserProfileTable] ON 

INSERT [dbo].[UserProfileTable] ([ID], [UID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [CountryID], [University], [College], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, 2043, CAST(N'2000-05-19T00:00:00.000' AS DateTime), N'Male', N'+91', N'9106810880', N'Members/2043/DP_17-03-2021_20-29-34.jpg', N'"Mateshree" - 179', N'Shivnagar', N'Bhavnagar', N'Gujarat', N'364002', 1, N'GTU', N'GEC Bhavnagar', CAST(N'2021-03-15T12:32:41.937' AS DateTime), 2043, CAST(N'2021-03-17T20:29:34.920' AS DateTime), 2043, 1)
INSERT [dbo].[UserProfileTable] ([ID], [UID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [CountryID], [University], [College], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, 2045, CAST(N'2000-01-19T00:00:00.000' AS DateTime), N'Male', N'+91', N'9106810880', N'Members/2045/DP_17-03-2021_20-32-00.jpg', N'Street', N'One', N'Hyderabad', N'Telangana', N'500001', 1, N'HTU', N'Pune Vidhyarthi Griha''s College Of Engineering And Technology', CAST(N'2021-03-16T09:48:16.970' AS DateTime), 2045, CAST(N'2021-03-17T20:32:00.677' AS DateTime), 2045, 1)
INSERT [dbo].[UserProfileTable] ([ID], [UID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [CountryID], [University], [College], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 2046, CAST(N'1986-07-09T00:00:00.000' AS DateTime), N'Male', N'+91', N'9106810880', N'Members/2046/DP_16-03-2021_18-49-54.jpg', N'A3/22', N'Janakpuri', N'New Delhi', N'Delhi', N'110001', 1, N'IIT', N'IIT Kharagpur', CAST(N'2021-03-16T18:08:01.217' AS DateTime), 2046, CAST(N'2021-03-16T18:49:54.863' AS DateTime), 2046, 1)
INSERT [dbo].[UserProfileTable] ([ID], [UID], [DateOfBirth], [Gender], [CountryCode], [PhoneNumber], [ProfilePicture], [AddressLine1], [AddressLine2], [City], [State], [ZipCode], [CountryID], [University], [College], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 2050, CAST(N'1990-05-19T00:00:00.000' AS DateTime), N'Male', N'+91', N'9106810880', N'Members/2050/DP_10-04-2021_13-02-21.JPG', N'New Delhi', N'New Delhi', N'New Delhi', N'Delhi', N'110001', 1, N'Panjab University', N'Panjab University', CAST(N'2021-04-10T13:02:21.047' AS DateTime), 2050, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[UserProfileTable] OFF
GO
SET IDENTITY_INSERT [dbo].[UserTable] ON 

INSERT [dbo].[UserTable] ([UID], [RoleID], [FirstName], [LastName], [Email], [Password], [IsEmailVerified], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [SecretCode]) VALUES (2043, 3, N'Yagnik', N'Gohil', N'gohilyagnik3@gmail.com', N'AOosBd+bqnmbCGckusXwVbfomfVO+8gm7AsMJfr13wQ=', 1, CAST(N'2021-02-12T20:29:34.920' AS DateTime), NULL, CAST(N'2021-03-17T20:29:34.920' AS DateTime), 2043, 1, N'30b0b314-fede-446c-b383-66b40f2617bb')
INSERT [dbo].[UserTable] ([UID], [RoleID], [FirstName], [LastName], [Email], [Password], [IsEmailVerified], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [SecretCode]) VALUES (2045, 3, N'Samay', N'Raina', N'urjabachavo@gmail.com', N'w2dbCQ8xQPdA14PsIoAue2eiK3htZK7R+VYsPhqho8E=', 1, CAST(N'2021-03-15T20:32:00.677' AS DateTime), NULL, CAST(N'2021-03-17T20:32:00.677' AS DateTime), 2045, 1, N'8df83bd6-6f3e-4cef-a03d-2dc35e10096a')
INSERT [dbo].[UserTable] ([UID], [RoleID], [FirstName], [LastName], [Email], [Password], [IsEmailVerified], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [SecretCode]) VALUES (2046, 3, N'Gaurav', N'Taneja', N'maibhiunknown003@gmail.com', N'vmAROQUkkolD+fx1+4yBSSfTpOxshawaGWeKGlOucmg=', 1, CAST(N'2021-03-20T10:28:40.667' AS DateTime), NULL, CAST(N'2021-03-30T10:28:40.667' AS DateTime), 2046, 1, N'031f6800-3b04-48f8-880f-7de45abef21f')
INSERT [dbo].[UserTable] ([UID], [RoleID], [FirstName], [LastName], [Email], [Password], [IsEmailVerified], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [SecretCode]) VALUES (2048, 1, N'Super', N'Admin', N'arachnophobeone@gmail.com', N'TkxW5KFfifBcL0xyYT2ioYyWZdTw1qzOFkFesG+b53Y=', 1, NULL, 2048, NULL, NULL, 1, N'07f6ba15-45c4-4fd8-8284-0c04fd0bb068')
INSERT [dbo].[UserTable] ([UID], [RoleID], [FirstName], [LastName], [Email], [Password], [IsEmailVerified], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [SecretCode]) VALUES (2049, 2, N'Admin', N'One', N'arachnophobe3@gmail.com', N'JAvlGPq9JyTdtvBO6x2llnRI1+gxwIyPqCKAn3THIKk=', 1, CAST(N'2021-04-07T14:46:34.920' AS DateTime), NULL, CAST(N'2021-04-10T11:04:12.187' AS DateTime), 2048, 1, NULL)
INSERT [dbo].[UserTable] ([UID], [RoleID], [FirstName], [LastName], [Email], [Password], [IsEmailVerified], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive], [SecretCode]) VALUES (2050, 3, N'Abhishek', N'Upmanyu', N'thehamojha@gmail.com', N'eKRj2Bh7eRz+AKxvTSbSfmw/5Z8f+siBfdyiXZUS76s=', 1, CAST(N'2021-04-10T13:02:21.047' AS DateTime), NULL, NULL, NULL, 1, N'2d535626-5ce9-4e5b-9073-061576f89249')
SET IDENTITY_INSERT [dbo].[UserTable] OFF
GO
ALTER TABLE [dbo].[AdminTable]  WITH CHECK ADD  CONSTRAINT [FK_AdminTable_UserTable] FOREIGN KEY([UID])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[AdminTable] CHECK CONSTRAINT [FK_AdminTable_UserTable]
GO
ALTER TABLE [dbo].[CategoryTable]  WITH CHECK ADD  CONSTRAINT [FK_CategoryTable_UserTable] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[CategoryTable] CHECK CONSTRAINT [FK_CategoryTable_UserTable]
GO
ALTER TABLE [dbo].[CountryTable]  WITH CHECK ADD  CONSTRAINT [FK_CountryTable_UserTable] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[CountryTable] CHECK CONSTRAINT [FK_CountryTable_UserTable]
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
ALTER TABLE [dbo].[NoteTable]  WITH CHECK ADD  CONSTRAINT [FK_NoteTable_UserTable2] FOREIGN KEY([ActionBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[NoteTable] CHECK CONSTRAINT [FK_NoteTable_UserTable2]
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
ALTER TABLE [dbo].[TypeTable]  WITH CHECK ADD  CONSTRAINT [FK_TypeTable_UserTable] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UserTable] ([UID])
GO
ALTER TABLE [dbo].[TypeTable] CHECK CONSTRAINT [FK_TypeTable_UserTable]
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
