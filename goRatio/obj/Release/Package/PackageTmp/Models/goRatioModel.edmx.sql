
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 11/30/2014 06:31:36
-- Generated from EDMX file: C:\Users\Ethan\documents\visual studio 2013\Projects\goRatio\goRatio\Models\goRatioModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [GoRatio];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[Bars]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Bars];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Location] geography  NOT NULL,
    [DeviceToken] nvarchar(max)  NOT NULL,
    [Gender] nvarchar(max)  NOT NULL,
    [DeviceType] nvarchar(max)  NOT NULL,
    [deviceForeground] bit  NOT NULL,
    [AllowPush] bit  NOT NULL,
    [DUID] nvarchar(max)  NOT NULL,
    [LastUpdatedLocation] datetime  NOT NULL,
    [Bar_Id] int  NULL
);
GO

-- Creating table 'Bars'
CREATE TABLE [dbo].[Bars] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Location] geography  NOT NULL,
    [MaleCount] int  NOT NULL,
    [FemaleCount] int  NOT NULL,
    [Vicinity] nvarchar(max)  NOT NULL,
    [PlaceId] nvarchar(max)  NOT NULL,
    [Rating] nvarchar(max)  NOT NULL,
    [Reference] nvarchar(max)  NOT NULL,
    [Icon] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Bars'
ALTER TABLE [dbo].[Bars]
ADD CONSTRAINT [PK_Bars]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Bar_Id] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [FK_UserBar]
    FOREIGN KEY ([Bar_Id])
    REFERENCES [dbo].[Bars]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserBar'
CREATE INDEX [IX_FK_UserBar]
ON [dbo].[Users]
    ([Bar_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------