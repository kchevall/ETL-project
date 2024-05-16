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
