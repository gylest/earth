--
-- Add error messages
--
IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100000)
BEGIN
   EXECUTE sp_dropmessage 100000
END
EXECUTE sp_addmessage
        @msgnum   = 100000,
        @severity = 16, 
        @msgtext  = N'No customer exists with an email of %s.',
        @lang     = 'us_english'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100001)
BEGIN
   EXECUTE sp_dropmessage 100001
END
EXECUTE sp_addmessage
        @msgnum   = 100001,
        @severity = 16, 
        @msgtext  = N'Existing customer %s, already has an address.',
        @lang     = 'us_english'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100002)
BEGIN
   EXECUTE sp_dropmessage 100002
END
EXECUTE sp_addmessage
        @msgnum   = 100002,
        @severity = 16, 
        @msgtext  = N'No order exists with an id of %i.',
        @lang     = 'us_english'
GO
    
IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100003)
BEGIN
   EXECUTE sp_dropmessage 100003
END
EXECUTE sp_addmessage
        @msgnum   = 100003,
        @severity = 16, 
        @msgtext  = N'No product exists with an id of %i.',
        @lang     = 'us_english'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100004)
BEGIN
   EXECUTE sp_dropmessage 100004
END
EXECUTE sp_addmessage
        @msgnum   = 100004,
        @severity = 16, 
        @msgtext  = N'No order detail exists with an id of %i.',
        @lang     = 'us_english'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100005)
BEGIN
   EXECUTE sp_dropmessage 100005
END
EXECUTE sp_addmessage
        @msgnum   = 100005,
        @severity = 16, 
        @msgtext  = N'Order %i cannot be deleted as it is not a quote.',
        @lang     = 'us_english'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100006)
BEGIN
   EXECUTE sp_dropmessage 100006
END
EXECUTE sp_addmessage
        @msgnum   = 100006,
        @severity = 16, 
        @msgtext  = N'No payment exists for order %i.',
        @lang     = 'us_english'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100007)
BEGIN
   EXECUTE sp_dropmessage 100007
END
EXECUTE sp_addmessage
        @msgnum   = 100007,
        @severity = 16, 
        @msgtext  = N'No product exists with a SKU %i.',
        @lang     = 'us_english'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100008)
BEGIN
   EXECUTE sp_dropmessage 100008
END
EXECUTE sp_addmessage
        @msgnum   = 100008,
        @severity = 16, 
        @msgtext  = N'No address exists with an address id %i.',
        @lang     = 'us_english'
GO
 
IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 100009)
BEGIN
   EXECUTE sp_dropmessage 100009
END
EXECUTE sp_addmessage
        @msgnum   = 100009,
        @severity = 16, 
        @msgtext  = N'Cannot delete order detail %i as the associated order has been sold.',
        @lang     = 'us_english'
GO   