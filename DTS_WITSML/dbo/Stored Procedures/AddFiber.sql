CREATE PROCEDURE [dbo].[AddFiber]
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
   @ID                   int        OUTPUT,
   @CreateDate           datetime   OUTPUT
WITH ENCRYPTION
AS
   DECLARE @Error    int

   SET @Error = 0

   -- Add new record
   IF (@Error=0)
   BEGIN
      INSERT INTO Fibers ( WellboreID,          fiberNumber,   numSerial,   correctionConstants, indexChannel, ProcessingMethod,
                           length,              dTim,          retrievable, offset,              DirectionRef, lossTwoWay,
                           installationCompany, manufacturer,  type,        diameter,            indexRef,     lossdiff,
                           lossLoop,            lossConnector, lossOther,   settingLoss,         CreateDate,   ModifyDate )
               
      VALUES             ( @WellboreID,         @fiberNumber,  @numSerial,  @correctionConstants,@indexChannel,@ProcessingMethod,
                           @length,             @dTim,         @retrievable,@offset,             @DirectionRef,@lossTwoWay,
                           @installationCompany,@manufacturer, @type,       @diameter,           @indexRef,    @lossdiff,
                           @lossLoop,           @lossConnector,@lossOther,  @settingLoss,        DEFAULT,      DEFAULT)                          
      SET @Error = @@Error
   END

   -- Set output values and audit 
   IF (@Error=0)
   BEGIN
      -- Set output values
      SET    @ID         = SCOPE_IDENTITY()
      SELECT @CreateDate = [CreateDate] FROM Fibers where [ID] = @ID

      -- Audit
      DECLARE @appname nvarchar(128)
      DECLARE @user    nvarchar(256)
      DECLARE @msg     nvarchar(1024)

      SET @appname = APP_NAME()
      SET @user    = USER_NAME()
      SET @msg     = 'Added a fiber (ID = ' + CAST(@ID as nvarchar) + ', FiberNumber = ' + CAST(@fiberNumber as nvarchar) + ')'
      EXECUTE AddAuditMessage 'Information', @appname, @msg, @user
   END

   -- Set return code
   RETURN @Error
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[AddFiber] TO PUBLIC
    AS [dbo];
GO

