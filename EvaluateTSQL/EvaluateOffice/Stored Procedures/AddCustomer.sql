CREATE PROCEDURE [EvaluateOffice].[AddCustomer]
	@FirstName        NVARCHAR(100),
	@LastName         NVARCHAR(100),
	@MiddleName       NVARCHAR(50),
	@AddressLine1     NVARCHAR(60),
	@AddressLine2     NVARCHAR(60),
    @City             NVARCHAR(30),
    @PostCode         NVARCHAR(15),
    @Telephone        NVARCHAR(25),
    @Email            NVARCHAR(25),
	@ErrorNumber      INTEGER       OUTPUT,
	@ErrorDescription NVARCHAR(100) OUTPUT
AS
BEGIN

	SET @ErrorNumber = 0
	SET @ErrorDescription = ''

	INSERT INTO [EvaluateOffice].[Customer]
			([FirstName],[LastName],[MiddleName],[AddressLine1],[AddressLine2],[City],[PostCode],[Telephone],[Email],[RecordModified])
		 VALUES
			(@FirstName,@LastName,@MiddleName,@AddressLine1,@AddressLine2,@City,@PostCode,@Telephone,@Email,DEFAULT)

	IF (@@ERROR <> 0)
	BEGIN
		SET @ErrorNumber = @@ERROR
		SET @ErrorDescription = 'Cannot insert customer'
	END

	RETURN @ErrorNumber
END