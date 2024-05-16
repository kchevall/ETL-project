UPDATE [dbo].[DimCallInfos]
   SET 
      [CallType] = ?
      ,[CallCharges] = ?
WHERE [Year] = ? AND [CallTypeID] = ?