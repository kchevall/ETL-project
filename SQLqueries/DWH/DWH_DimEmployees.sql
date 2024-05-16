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