UPDATE [dbo].[DimEmployees]
   SET 
      [FirstName] = ?
      ,[LastName] = ?
      ,[E-mail address] = ?
      ,[ManagerName] = ?
      ,[Site] = ?
      ,[StateCD] = ?
      ,[StateName] = ?
      ,[Region] = ?
WHERE [EmployeeID] = ?