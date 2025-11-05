/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


--
-- Populate Catalog 
--
DELETE FROM Catalog WHERE [Group] = 0
INSERT Catalog VALUES ( 0, 'AuditType',              '10', 0)
INSERT Catalog VALUES ( 0, 'PermanentDatum',         '20', 0)
INSERT Catalog VALUES ( 0, 'ProcessingMethod',       '30', 0)
INSERT Catalog VALUES ( 0, 'classPOSC',              '40', 0)
INSERT Catalog VALUES ( 0, 'uomLength',              '50', 0)
INSERT Catalog VALUES ( 0, 'uomTemperature',         '60', 0)
INSERT Catalog VALUES ( 0, 'WebServiceSecurity',     '70', 0)
GO

-- AuditType
DELETE FROM Catalog WHERE [Group] = 10
INSERT Catalog VALUES ( 10, '0', 'Information', 1)
INSERT Catalog VALUES ( 10, '1', 'Warning',     0)
INSERT Catalog VALUES ( 10, '2', 'Error',       0)
GO

-- PermanentDatum
DELETE FROM Catalog WHERE [Group] = 20
INSERT Catalog VALUES ( 20, '0', 'Least Astronomic Tide',  0)
INSERT Catalog VALUES ( 20, '1', 'Mean Higher High Water', 0)
INSERT Catalog VALUES ( 20, '2', 'Mean Higher Water',      0)
INSERT Catalog VALUES ( 20, '3', 'Mean Lower Low Water',   0)
INSERT Catalog VALUES ( 20, '4', 'Mean Lower Water',       0)
INSERT Catalog VALUES ( 20, '5', 'Mean Sea Level',         1)
INSERT Catalog VALUES ( 20, '6', 'Mean Tide Level',        0)
GO

-- ProcessingMethod
DELETE FROM Catalog WHERE [Group] = 30
INSERT Catalog VALUES ( 30, '0', 'SE',   1)
INSERT Catalog VALUES ( 30, '1', 'DE',   0)
GO

-- classPOSC
DELETE FROM Catalog WHERE [Group] = 40
INSERT Catalog VALUES ( 40, '0', 'Length',      0)
INSERT Catalog VALUES ( 40, '1', 'Temperature', 1)
GO

-- uomLength
DELETE FROM Catalog WHERE [Group] = 50
INSERT Catalog VALUES ( 50, '0', 'ft',   0)
INSERT Catalog VALUES ( 50, '1', 'mm',   0)
INSERT Catalog VALUES ( 50, '2', 'm',    1)
INSERT Catalog VALUES ( 50, '3', 'km',   0)
GO

-- uomTemperature
DELETE FROM Catalog WHERE [Group] = 60
INSERT Catalog VALUES ( 60, '0', 'C',    1)
INSERT Catalog VALUES ( 60, '1', 'F',    0)
INSERT Catalog VALUES ( 60, '2', 'K',    0)
GO

-- WebServiceSecurity
DELETE FROM Catalog WHERE [Group] = 70
INSERT Catalog VALUES ( 70, '0', 'None',               0)
INSERT Catalog VALUES ( 70, '1', 'Login Credentials',  1)
GO

--
-- Populate ChannelTypes
--
DELETE FROM ChannelTypes
INSERT ChannelTypes VALUES( 'Length',        0, 0, 0, 0)
INSERT ChannelTypes VALUES( 'Temperature',   1, 0, 0, 0)
INSERT ChannelTypes VALUES( 'Stokes1',      10, 2, 2, 1)
INSERT ChannelTypes VALUES( 'Stokes2',      10, 2, 2, 2)
INSERT ChannelTypes VALUES( 'Anti-Stokes1', 10, 1, 2, 1)
INSERT ChannelTypes VALUES( 'Anti-Stokes2', 10, 1, 2, 2)
GO


--
-- Messages
--
IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60001)
BEGIN
   EXECUTE sp_dropmessage 60001
END
EXECUTE sp_addmessage  60001, 16, N'Unable to set the WebService lastProfileDate or lastPostDate.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60002)
BEGIN
   EXECUTE sp_dropmessage 60002
END
EXECUTE sp_addmessage  60002, 16, N'Unable to update Web Service, ID %d.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60003)
BEGIN
   EXECUTE sp_dropmessage 60003
END
EXECUTE sp_addmessage  60003, 16, N'Unable to delete Web Service, ID %d not found.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60004)
BEGIN
   EXECUTE sp_dropmessage 60004
END
EXECUTE sp_addmessage  60004, 16, N'Unable to update Web Service as ID %d not found.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60005)
BEGIN
   EXECUTE sp_dropmessage 60005
END
EXECUTE sp_addmessage  60005, 16, N'Unable to update Web Service to active for ID %d as core parameters invalid'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60101)
BEGIN
   EXECUTE sp_dropmessage 60101
END
EXECUTE sp_addmessage  60101, 16, N'Unable to update Sensor, ID %d.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60102)
BEGIN
   EXECUTE sp_dropmessage 60102
END
EXECUTE sp_addmessage  60102, 16, N'Unable to delete Sensor, for ID %d.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60104)
BEGIN
   EXECUTE sp_dropmessage 60104
END
EXECUTE sp_addmessage  60104, 16, N'Unable to update Sensor as ID %d not found.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60105)
BEGIN
   EXECUTE sp_dropmessage 60105
END
EXECUTE sp_addmessage  60105, 16, N'Unable to make Sensor with ID %d active as incomplete.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60201)
BEGIN
   EXECUTE sp_dropmessage 60201
END
EXECUTE sp_addmessage  60201, 16, N'Unable to update well, ID %d not found.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60202)
BEGIN
   EXECUTE sp_dropmessage 60202
END
EXECUTE sp_addmessage  60202, 16, N'Unable to delete well, for ID %d.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60301)
BEGIN
   EXECUTE sp_dropmessage 60301
END
EXECUTE sp_addmessage  60301, 16, N'Unable to update well bore, ID %d not found.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60302)
BEGIN
   EXECUTE sp_dropmessage 60302
END
EXECUTE sp_addmessage  60302, 16, N'Unable to delete well bore, for ID %d.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60401)
BEGIN
   EXECUTE sp_dropmessage 60401
END
EXECUTE sp_addmessage  60401, 16, N'Unable to update unit acquisition, ID %d not found.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60402)
BEGIN
   EXECUTE sp_dropmessage 60402
END
EXECUTE sp_addmessage  60402, 16, N'Unable to delete unit acquisition, for ID %d.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60501)
BEGIN
   EXECUTE sp_dropmessage 60501
END
EXECUTE sp_addmessage  60501, 16, N'Unable to update fiber, ID %d not found.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60502)
BEGIN
   EXECUTE sp_dropmessage 60502
END
EXECUTE sp_addmessage  60502, 16, N'Unable to delete fiber, for ID %d.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60601)
BEGIN
   EXECUTE sp_dropmessage 60601
END
EXECUTE sp_addmessage  60601, 16, N'Unable to update channel, ID %d not found.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 60602)
BEGIN
   EXECUTE sp_dropmessage 60602
END
EXECUTE sp_addmessage  60602, 16, N'Unable to delete channel, for ID %d.'
GO


--
-- Jobs
--

--
-- JOB: Backup DTS_WITSML
--

-- Delete existing job & related entities
IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'Backup DTS_WITSML')
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = 'Backup DTS_WITSML'
END
GO

-- Set command based on location of database
DECLARE @DatabaseFile VARCHAR(250)
DECLARE @BackupFile   VARCHAR(250)
DECLARE @BackupCmd    VARCHAR(500)

SELECT  @DatabaseFile  = filename from master.dbo.sysdatabases WHERE name = 'DTS_WITSML'
SET     @BackupFile    = Replace(@DatabaseFile, 'Data\DTS_WITSML_Data.mdf', 'Backup\DTS_WITSML.bak')
SET     @BackupCmd     = 'BACKUP DATABASE DTS_WITSML TO DISK="DISKFILE" WITH NOINIT, MEDIANAME = ''Disk Backup Media Set'',NAME = ''Full Backup of DTS_WITSML'',COMPRESSION'
SET     @BackupCmd     = Replace(@BackupCmd,'DISKFILE',@BackupFile)

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name              = 'Backup DTS_WITSML', 
     @enabled               = 1,
     @description           = 'Backup of application database DTS_WITSML',
     @start_step_id         = 1,
     @category_name         = 'Database Maintenance',
     @notify_level_eventlog = 2,
     @delete_level          = 0

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = 'Backup DTS_WITSML',
     @step_id            = 1,
     @step_name          = 'Backup DTS_WITSML Database',
     @subsystem          = 'TSQL',
     @command            = @BackupCmd,
     @database_name      = 'master',
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobschedule
     @job_name               = 'Backup DTS_WITSML', 
     @name                   = 'ScheduledAppBackup',
     @freq_type              = 8,       -- weekly
     @freq_interval          = 64,      -- Saturday
     @freq_recurrence_factor = 1,       -- every week
     @active_start_time      = 113000   -- 11.30am

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = 'Backup DTS_WITSML', 
     @server_name       = N'(LOCAL)'
GO


--
-- JOB: Maintain DTS_WITSML
--

-- Delete existing job & related entities
IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'Maintain DTS_WITSML')
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = 'Maintain DTS_WITSML'
END
GO

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name              = 'Maintain DTS_WITSML', 
     @enabled               = 1,
     @description           = 'Invoke maintenance tasks on DTS_WITSML database',
     @start_step_id         = 1,
     @category_name         = 'Database Maintenance',
     @notify_level_eventlog = 2,
     @delete_level          = 0

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = 'Maintain DTS_WITSML',
     @step_id            = 1,
     @step_name          = 'Check DTS_WITSML Database',
     @subsystem          = 'TSQL',
     @command            = 'DBCC CHECKDB(DTS_WITSML)',
     @database_name      = 'master',
     @on_success_action  = 3,
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = 'Maintain DTS_WITSML',
     @step_id            = 2,
     @step_name          = 'Shrink Database DTS_WITSML',
     @subsystem          = 'TSQL',
     @command            = 'DBCC SHRINKDATABASE (DTS_WITSML, 2)',
     @database_name      = 'master',
     @on_success_action  = 1,
     @retry_attempts     = 1,
     @retry_interval     = 2
     
EXEC msdb.dbo.sp_add_jobschedule
     @job_name               = 'Maintain DTS_WITSML', 
     @name                   = 'ScheduledAppCheck',
     @freq_type              = 8,       -- weekly
     @freq_interval          = 32,      -- Friday
     @freq_recurrence_factor = 1,       -- every week
     @active_start_time      = 200000   -- 8pm

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = 'Maintain DTS_WITSML', 
     @server_name       = N'(LOCAL)'
GO
