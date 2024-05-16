CREATE TABLE [DimCallInfos] (
	[CallInfosSurrKey] INT PRIMARY KEY IDENTITY(1,1),
	[Year] numeric(20,0),
    [CallTypeID] varchar(255),
    [CallType] varchar(50),
    [CallCharges] numeric(18,2)    
)