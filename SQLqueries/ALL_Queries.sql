USE [SS_ADM]

GO

CREATE TABLE [TechnicalRejects] (
    [RejectDate] datetime,
    [RejectPackageAndTask] nvarchar(255),
    [RejectColumn] nvarchar(255),
    [RejectValue] nvarchar(255)
)

CREATE TABLE [FunctionalRejects] (
    [RejectDate] datetime,
    [RejectPackageAndTask] nvarchar(205),
    [RejectColumn] nvarchar(255),
    [RejectDescription] nvarchar(255),
    [Number_of_cases] numeric(20,0)
)

GO


USE [SS_STA]

GO

CREATE TABLE [USStates] (
    [StateCD] varchar(255),
    [Name] varchar(255),
    [Region] varchar(255)
)

CREATE TABLE [CallTypes] (
    [CallTypeID] varchar(255),
    [CallTypeLabel] varchar(255)
)

CREATE TABLE [CallCharges] (
    [Year] nvarchar(255),
    [CallType] varchar(255),
    [CallCharges] varchar(255)
)

CREATE TABLE [Employees] (
    [EmployeeID] varchar(255),
    [EmployeeName] varchar(255),
    [Site] varchar(255),
    [ManagerName] varchar(255)
)

CREATE TABLE [Data] (
    [CallTimestamp] varchar(255),
    [CallType] varchar(255),
    [EmployeeID] varchar(255),
    [CallDuration] varchar(255),
    [WaitTime] varchar(255),
    [CallAbandoned] varchar(255)
)

GO


USE [SS_ODS]

GO

CREATE TABLE [CallInfos] (
	[Year] numeric(20,0),
    [CallTypeID] varchar(255),
    [CallType] varchar(50),
    [CallCharges] numeric(18,2)    
)

CREATE TABLE [Employees] (
    [EmployeeID] varchar(10),
    [FirstName] nvarchar(50),
    [LastName] nvarchar(50),
    [E-mail address] nvarchar(110),
    [ManagerName] varchar(100),
    [Site] varchar(50),
    [StateCD] varchar(10),
    [StateName] varchar(50),
    [Region] varchar(50)
)

CREATE TABLE [Data] (
	[Year] numeric(20,0),
    [CallDate] date,  
    [CallTimestamp] time(0),
    [EmployeeID] varchar(10),
    [CallType] varchar(10),
    [DurationMinutes] int,
    [DurationSeconds] tinyint,
    [WaitTime] int,
    [WithinSLA] bit,
    [CallAbandoned] bit
)

GO


USE [SS_DWH]

GO

CREATE TABLE [DimCallInfos] (
	[CallInfosSurrKey] INT PRIMARY KEY IDENTITY(1,1),
	[Year] numeric(20,0),
    [CallTypeID] varchar(255),
    [CallType] varchar(50),
    [CallCharges] numeric(18,2)    
)

CREATE TABLE [DimEmployees] (
	[EmployeeSurrKey] INT PRIMARY KEY IDENTITY(1,1),
    [EmployeeID] varchar(10),
    [FirstName] varchar(50),
    [LastName] varchar(50),
    [E-mail address] nvarchar(110),
    [ManagerName] varchar(100),
    [Site] varchar(50),
    [StateCD] varchar(10),
    [StateName] varchar(50),
    [Region] varchar(50)
)

CREATE TABLE [FactData] (
    [EmployeeSurrogateKey] int,
    [CallInfosSurrogateKey] int,
    [CallDateKey] int,
	[CallTimestamp] time(0),
    [DurationMinutes] int,
    [DurationSeconds] tinyint,
    [WaitTime] int,
    [WithinSLA] bit,
    [CallAbandoned] bit
)

CREATE TABLE dbo.DimDate (
   DateKey INT NOT NULL PRIMARY KEY,
   [Date] DATE NOT NULL,
   [Day] TINYINT NOT NULL,
   [DaySuffix] CHAR(2) NOT NULL,
   [Weekday] TINYINT NOT NULL,
   [WeekDayName] VARCHAR(10) NOT NULL,
   [WeekDayName_Short] CHAR(3) NOT NULL,
   [WeekDayName_FirstLetter] CHAR(1) NOT NULL,
   [DOWInMonth] TINYINT NOT NULL,
   [DayOfYear] SMALLINT NOT NULL,
   [WeekOfMonth] TINYINT NOT NULL,
   [WeekOfYear] TINYINT NOT NULL,
   [Month] TINYINT NOT NULL,
   [MonthName] VARCHAR(10) NOT NULL,
   [MonthName_Short] CHAR(3) NOT NULL,
   [MonthName_FirstLetter] CHAR(1) NOT NULL,
   [Quarter] TINYINT NOT NULL,
   [QuarterName] VARCHAR(6) NOT NULL,
   [Year] INT NOT NULL,
   [MMYYYY] CHAR(6) NOT NULL,
   [MonthYear] CHAR(7) NOT NULL,
   IsWeekend BIT NOT NULL,
   )

  
   GO


   SET NOCOUNT ON

TRUNCATE TABLE DimDate

DECLARE @CurrentDate DATE = '2018-01-01'
DECLARE @EndDate DATE = '2023-12-31'

WHILE @CurrentDate < @EndDate
BEGIN
   INSERT INTO [dbo].[DimDate] (
      [DateKey],
      [Date],
      [Day],
      [DaySuffix],
      [Weekday],
      [WeekDayName],
      [WeekDayName_Short],
      [WeekDayName_FirstLetter],
      [DOWInMonth],
      [DayOfYear],
      [WeekOfMonth],
      [WeekOfYear],
      [Month],
      [MonthName],
      [MonthName_Short],
      [MonthName_FirstLetter],
      [Quarter],
      [QuarterName],
      [Year],
      [MMYYYY],
      [MonthYear],
      [IsWeekend]
      )
   SELECT DateKey = YEAR(@CurrentDate) * 10000 + MONTH(@CurrentDate) * 100 + DAY(@CurrentDate),
      DATE = @CurrentDate,
      Day = DAY(@CurrentDate),
      [DaySuffix] = CASE 
         WHEN DAY(@CurrentDate) = 1
            OR DAY(@CurrentDate) = 21
            OR DAY(@CurrentDate) = 31
            THEN 'st'
         WHEN DAY(@CurrentDate) = 2
            OR DAY(@CurrentDate) = 22
            THEN 'nd'
         WHEN DAY(@CurrentDate) = 3
            OR DAY(@CurrentDate) = 23
            THEN 'rd'
         ELSE 'th'
         END,
      WEEKDAY = DATEPART(dw, @CurrentDate),
      WeekDayName = DATENAME(dw, @CurrentDate),
      WeekDayName_Short = UPPER(LEFT(DATENAME(dw, @CurrentDate), 3)),
      WeekDayName_FirstLetter = LEFT(DATENAME(dw, @CurrentDate), 1),
      [DOWInMonth] = DAY(@CurrentDate),
      [DayOfYear] = DATENAME(dy, @CurrentDate),
      [WeekOfMonth] = DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1,
      [WeekOfYear] = DATEPART(wk, @CurrentDate),
      [Month] = MONTH(@CurrentDate),
      [MonthName] = DATENAME(mm, @CurrentDate),
      [MonthName_Short] = UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)),
      [MonthName_FirstLetter] = LEFT(DATENAME(mm, @CurrentDate), 1),
      [Quarter] = DATEPART(q, @CurrentDate),
      [QuarterName] = CASE 
         WHEN DATENAME(qq, @CurrentDate) = 1
            THEN 'First'
         WHEN DATENAME(qq, @CurrentDate) = 2
            THEN 'second'
         WHEN DATENAME(qq, @CurrentDate) = 3
            THEN 'third'
         WHEN DATENAME(qq, @CurrentDate) = 4
            THEN 'fourth'
         END,
      [Year] = YEAR(@CurrentDate),
      [MMYYYY] = RIGHT('0' + CAST(MONTH(@CurrentDate) AS VARCHAR(2)), 2) + CAST(YEAR(@CurrentDate) AS VARCHAR(4)),
      [MonthYear] = CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)),
      [IsWeekend] = CASE 
         WHEN DATENAME(dw, @CurrentDate) = 'Sunday'
            OR DATENAME(dw, @CurrentDate) = 'Saturday'
            THEN 1
         ELSE 0
         END

   SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END


GO