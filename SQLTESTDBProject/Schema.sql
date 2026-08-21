-- 1. Create Users Table
CREATE TABLE [dbo].[Users] (
    [UserID]    INT            IDENTITY (1, 1) NOT NULL,
    [FirstName] NVARCHAR (50)  NOT NULL,
    [LastName]  NVARCHAR (50)  NOT NULL,
    [Email]     NVARCHAR (100) NOT NULL,
    [CreatedAt] DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC),
    CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED ([Email] ASC)
);

-- 2. Create Products Table
CREATE TABLE [dbo].[Products] (
    [ProductID]   INT             IDENTITY (1, 1) NOT NULL,
    [ProductName] NVARCHAR (100)  NOT NULL,
    [Price]       DECIMAL (18, 2) NOT NULL,
    [StockCount]  INT             DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ProductID] ASC)
);

-- 3. Create Orders Table (Linked to Users)
CREATE TABLE [dbo].[Orders] (
    [OrderID]   INT      IDENTITY (1, 1) NOT NULL,
    [UserID]    INT      NOT NULL,
    [OrderDate] DATETIME DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [FK_Orders_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

-- 4. Create OrderDetails Table (Linked to Orders and Products)
CREATE TABLE [dbo].[OrderDetails] (
    [OrderDetailID] INT             IDENTITY (1, 1) NOT NULL,
    [OrderID]       INT             NOT NULL,
    [ProductID]     INT             NOT NULL,
    [Quantity]      INT             NOT NULL,
    [UnitPrice]     DECIMAL (18, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([OrderDetailID] ASC),
    CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]) ON DELETE CASCADE,
    CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);-- Write your own SQL object definition here, and it'll be included in your package.
