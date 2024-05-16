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
