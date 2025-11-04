CREATE PROCEDURE [dbo].[InsertCreateStructure]
    @RecordDate      DATE,
    @RecordTime      TIME(3),
    @IPAddress       NVARCHAR(50),
    @User            NVARCHAR(50),
    @Company         NVARCHAR(50),
    @Role            NVARCHAR(50),
    @Action          NVARCHAR(50),
    @OrderBookID     NVARCHAR(50) = NULL,
    @Strategy        NVARCHAR(50) = NULL,
    @IsPriced        BIT          = NULL,
    @PremiumType     NVARCHAR(50) = NULL,
    @ImportDateTime  DATETIME,
    @ImportFile      NVARCHAR(512),
    @Identity        INT OUTPUT           -- Mapped to RecordID
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[CreateStructure]
    (
        [RecordDate],[RecordTime],[IPAddress],[User],[Company],[Role],[Action],
        [OrderBookID],[Strategy],[IsPriced],[PremiumType],
        [ImportDateTime],[ImportFile]
    )
    VALUES
    (
        @RecordDate,@RecordTime,@IPAddress,@User,@Company,@Role,@Action,
        @OrderBookID,@Strategy,@IsPriced,@PremiumType,
        @ImportDateTime,@ImportFile
    );

    SET @Identity = SCOPE_IDENTITY();

    -- Return full row if caller expects FirstReturnedRecord
    SELECT * FROM [dbo].[CreateStructure] WHERE [RecordID] = @Identity;
END;
GO
