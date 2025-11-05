CREATE PROCEDURE [dbo].[ChangeFiber]
   @ID                   int,
   @WellboreID           int,
   @fiberNumber          int,
   @numSerial            str32,
   @correctionConstants  nvarchar(1000),
   @indexChannel         str32,
   @ProcessingMethod     strcatalog,
   @length               length,
   @dTim                 datetime,
   @retrievable          boolean,
   @offset               length,
   @DirectionRef         str32,
   @lossTwoWay           fiberLoss,
   @installationCompany  str64,
   @manufacturer         str64,
   @type                 str32,
   @diameter             cylinderDiameter  = NULL,
   @indexRef             str32             = NULL,
   @lossdiff             fiberLoss         = NULL,
   @lossLoop             fiberLoss         = NULL,
   @lossConnector        fiberLoss         = NULL,
   @lossOther            fiberLoss         = NULL,
   @settingLoss          fiberLoss         = NULL,
   @ModifyDate           datetime        OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int
   DECLARE @Count    int

   SET @Error = 0

   -- Update
   IF (@Error = 0)
   BEGIN
      UPDATE Fibers
         SET [WellboreID]          = @WellboreID,
             [fiberNumber]         = @fiberNumber,
             [numSerial]           = @numSerial,
             [correctionConstants] = @correctionConstants,
             [indexChannel]        = @indexChannel,
             [ProcessingMethod]    = @ProcessingMethod,
             [length]              = @length,
             [dTim]                = @dTim,
             [retrievable]         = @retrievable,
             [offset]              = @offset,
             [DirectionRef]        = @DirectionRef,
             [lossTwoWay]          = @lossTwoWay,             
             [installationCompany] = @installationCompany,
             [manufacturer]        = @manufacturer,
             [type]                = @type,
             [diameter]            = @diameter,
             [indexRef]            = @indexRef,
             [lossdiff]            = @lossdiff,
             [lossLoop]            = @lossLoop,
             [lossConnector]       = @lossConnector,
             [lossOther]           = @lossOther,
             [settingLoss]         = @settingLoss,
             [ModifyDate]          = DEFAULT
      WHERE  [ID] = @ID

      SET @Count = @@ROWCOUNT
      SET @Error = @@ERROR

      IF @Count <> 1
      BEGIN
         SET @Error = 60501
         RAISERROR ( @Error, 16, 1, @ID) WITH LOG
      END
   END

   -- Set output values
   IF (@Error = 0)
   BEGIN
      SELECT @ModifyDate = [ModifyDate] FROM Fibers WHERE [ID] = @ID
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ChangeFiber] TO PUBLIC
    AS [dbo];
GO

