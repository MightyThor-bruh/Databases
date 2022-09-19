USE [master]
GO

/****** Object:  Database [SH_MyBase]    Script Date: 03.03.2022 22:44:09 ******/
CREATE DATABASE [SH_MyBase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SH_MyBase', FILENAME = N'D:\temp\SH_MyBase.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
filegroup FG1 
(NAME = N'SH_MyBase_fg1', FILENAME = N'D:\temp\SH_MyBase_fgq-1.ndf', SIZE = 8192KB, MAXSIZE = 2048GB , FILEGROWTH = 65536KB)
 LOG ON 
( NAME = N'SH_MyBase_log', FILENAME = N'D:\temp\SH_MyBase_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SH_MyBase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [SH_MyBase] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [SH_MyBase] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [SH_MyBase] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [SH_MyBase] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [SH_MyBase] SET ARITHABORT OFF 
GO

ALTER DATABASE [SH_MyBase] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [SH_MyBase] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [SH_MyBase] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [SH_MyBase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [SH_MyBase] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [SH_MyBase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [SH_MyBase] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [SH_MyBase] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [SH_MyBase] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [SH_MyBase] SET  ENABLE_BROKER 
GO

ALTER DATABASE [SH_MyBase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [SH_MyBase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [SH_MyBase] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [SH_MyBase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [SH_MyBase] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [SH_MyBase] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [SH_MyBase] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [SH_MyBase] SET RECOVERY FULL 
GO

ALTER DATABASE [SH_MyBase] SET  MULTI_USER 
GO

ALTER DATABASE [SH_MyBase] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [SH_MyBase] SET DB_CHAINING OFF 
GO

ALTER DATABASE [SH_MyBase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [SH_MyBase] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [SH_MyBase] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [SH_MyBase] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [SH_MyBase] SET QUERY_STORE = OFF
GO

ALTER DATABASE [SH_MyBase] SET  READ_WRITE 
GO


