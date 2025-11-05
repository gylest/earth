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
-- Populate Application_Lookup 
--
DELETE FROM Application_Lookup WHERE [Group] = 0
INSERT Application_Lookup VALUES ( 0, 'ZoneProcess',            '10')
INSERT Application_Lookup VALUES ( 0, 'PositionReference',      '20')
INSERT Application_Lookup VALUES ( 0, 'MeasuredSignal',         '30')
INSERT Application_Lookup VALUES ( 0, 'MeasurementProcess',     '40')
INSERT Application_Lookup VALUES ( 0, 'MeasurementMode',        '50')
INSERT Application_Lookup VALUES ( 0, 'TriggerCondition',       '60')
INSERT Application_Lookup VALUES ( 0, 'FibreBreakAlarm',        '70')
INSERT Application_Lookup VALUES ( 0, 'FibreLossAlarm',         '80')
INSERT Application_Lookup VALUES ( 0, 'MessageType',            '90')
INSERT Application_Lookup VALUES ( 0, 'Boolean',               '100')
INSERT Application_Lookup VALUES ( 0, 'LogType',               '110')
INSERT Application_Lookup VALUES ( 0, 'AgingRule',             '120')
INSERT Application_Lookup VALUES ( 0, 'ZoneMeasurementStatus', '130')
GO

DELETE FROM Application_Lookup WHERE [Group] = 10
INSERT Application_Lookup VALUES ( 10, '1', 'Maximum')
INSERT Application_Lookup VALUES ( 10, '2', 'Minimum')
INSERT Application_Lookup VALUES ( 10, '3', 'Average')
INSERT Application_Lookup VALUES ( 10, '4', 'Standard Deviation')
INSERT Application_Lookup VALUES ( 10, '5', 'Signal Loss')
INSERT Application_Lookup VALUES ( 10, '6', 'Rate of Rise')
INSERT Application_Lookup VALUES ( 10, '7', 'Rate of Fall')
INSERT Application_Lookup VALUES ( 10, '8', 'Length Above Level')
INSERT Application_Lookup VALUES ( 10, '9', 'Length Below Level')
GO

DELETE FROM Application_Lookup WHERE [Group] = 20
INSERT Application_Lookup VALUES ( 20, '1', 'Zone Start')
INSERT Application_Lookup VALUES ( 20, '2', 'User Datum Point')
GO

DELETE FROM Application_Lookup WHERE [Group] = 30
INSERT Application_Lookup VALUES ( 30, '0', 'Not Applicable')
INSERT Application_Lookup VALUES ( 30, '1', 'TTS')
INSERT Application_Lookup VALUES ( 30, '2', 'NTS')
INSERT Application_Lookup VALUES ( 30, '3', 'NTA')
INSERT Application_Lookup VALUES ( 30, '4', 'NTB')
INSERT Application_Lookup VALUES ( 30, '5', 'NTS or NTA')
GO

DELETE FROM Application_Lookup WHERE [Group] = 40
INSERT Application_Lookup VALUES ( 40, '0', 'Not Applicable')
INSERT Application_Lookup VALUES ( 40, '1', 'Raw')
INSERT Application_Lookup VALUES ( 40, '2', 'Cleaned')
INSERT Application_Lookup VALUES ( 40, '3', 'Raw Safe')
INSERT Application_Lookup VALUES ( 40, '4', 'Cleaned Safe')
GO

DELETE FROM Application_Lookup WHERE [Group] = 50
INSERT Application_Lookup VALUES ( 50,  '1', 'Temperature')
INSERT Application_Lookup VALUES ( 50,  '2', 'Loss Correction')
INSERT Application_Lookup VALUES ( 50,  '3', 'Post Processing 9')
INSERT Application_Lookup VALUES ( 50,  '4', 'Post Processing 10')
INSERT Application_Lookup VALUES ( 50,  '5', 'Post Processing 11')
INSERT Application_Lookup VALUES ( 50,  '6', 'Post Processing 12')
INSERT Application_Lookup VALUES ( 50,  '7', 'Post Processing 13')
INSERT Application_Lookup VALUES ( 50,  '8', 'Post Processing 14')
INSERT Application_Lookup VALUES ( 50,  '9', 'Post Processing 15')
INSERT Application_Lookup VALUES ( 50, '10', 'Backscatter')
INSERT Application_Lookup VALUES ( 50, '11', 'Background')
INSERT Application_Lookup VALUES ( 50, '12', 'Laser Delay Stabilisation 1')
INSERT Application_Lookup VALUES ( 50, '13', 'Laser Delay Stabilisation 2')
INSERT Application_Lookup VALUES ( 50, '14', 'PP9 or LDS1')
INSERT Application_Lookup VALUES ( 50, '15', 'PP12 or LDS2')
GO

DELETE FROM Application_Lookup WHERE [Group] = 60
INSERT Application_Lookup VALUES ( 60, '1', 'NoTrigger')
INSERT Application_Lookup VALUES ( 60, '2', 'Threshold')
GO

DELETE FROM Application_Lookup WHERE [Group] = 70
INSERT Application_Lookup VALUES ( 70, '1', 'SingleFibreBreak')
INSERT Application_Lookup VALUES ( 70, '2', 'MultipleFibreBreak')
INSERT Application_Lookup VALUES ( 70, '3', 'FibreBreakRepaired')
GO

DELETE FROM Application_Lookup WHERE [Group] = 80
INSERT Application_Lookup VALUES ( 80, '1', 'FibreLossThresholdAlarm')
INSERT Application_Lookup VALUES ( 80, '2', 'MaximumLossFluctuationAlarm')
GO

DELETE FROM Application_Lookup WHERE [Group] = 90
INSERT Application_Lookup VALUES ( 90, '0', 'Zone_Message')
INSERT Application_Lookup VALUES ( 90, '1', 'Alarm_Message')
INSERT Application_Lookup VALUES ( 90, '2', 'FibreBreak_Message')
INSERT Application_Lookup VALUES ( 90, '3', 'Profiles')
GO

DELETE FROM Application_Lookup WHERE [Group] = 100
INSERT Application_Lookup VALUES ( 100, '0', 'False')
INSERT Application_Lookup VALUES ( 100, '1', 'True')
GO

DELETE FROM Application_Lookup WHERE [Group] = 110
INSERT Application_Lookup VALUES ( 110, '0', 'Information')
INSERT Application_Lookup VALUES ( 110, '1', 'Warning')
INSERT Application_Lookup VALUES ( 110, '2', 'Error')
INSERT Application_Lookup VALUES ( 110, '3', 'Fatal')
GO

DELETE FROM Application_Lookup WHERE [Group] = 120
INSERT Application_Lookup VALUES ( 120, '0', 'Retention')
INSERT Application_Lookup VALUES ( 120, '1', 'Alarm')
GO

DELETE FROM Application_Lookup WHERE [Group] = 130
INSERT Application_Lookup VALUES ( 130, '1', 'ZoneMeasurementOK')
INSERT Application_Lookup VALUES ( 130, '2', 'ZoneMeasurementMissing')
INSERT Application_Lookup VALUES ( 130, '3', 'ZoneMeasurementDisabled')
GO

--
-- Populate Aging_Rules 
--
DELETE FROM Aging_Rules
INSERT Aging_Rules VALUES ( 0, 1, 'Full Logging',         14400,  100, NULL, NULL, DEFAULT, NULL, NULL)
INSERT Aging_Rules VALUES ( 0, 2, 'Archive Logging', 2147483647,   20, NULL, NULL, DEFAULT, NULL, NULL)
INSERT Aging_Rules VALUES ( 1, 1, 'Alarm Logging',         NULL, NULL,  120,   30, DEFAULT, NULL, NULL)
GO

--
-- Populate Config 
--
DELETE FROM Config
INSERT INTO Config ([Name],[Description],[Version],[Active],[CreateDT],[ModifyDT])
VALUES('FirstConfig','Initial configuration',1,1,GETDATE(),GETDATE())

GO

--
-- Messages
--
IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50001)
BEGIN
   EXECUTE sp_dropmessage 50001
END
EXECUTE sp_addmessage  50001, 16, N'A valid configuration was not found.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50002)
BEGIN
   EXECUTE sp_dropmessage 50002
END
EXECUTE sp_addmessage  50002, 16, N'Unable to modify record that does not exist.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50003)
BEGIN
   EXECUTE sp_dropmessage 50003
END
EXECUTE sp_addmessage  50003, 16, N'Unable to delete a record that does not exist.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50004)
BEGIN
   EXECUTE sp_dropmessage 50004
END
EXECUTE sp_addmessage  50004, 16, N'Unable to set config to active.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50005)
BEGIN
   EXECUTE sp_dropmessage 50005
END
EXECUTE sp_addmessage  50005, 16, N'Unable to determine zone record.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50006)
BEGIN
   EXECUTE sp_dropmessage 50006
END
EXECUTE sp_addmessage  50006, 16, N'Unable to determine alarm for alarm band.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50007)
BEGIN
   EXECUTE sp_dropmessage 50007
END
EXECUTE sp_addmessage  50007, 16, N'Unable to determine alarm for zone.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50008)
BEGIN
   EXECUTE sp_dropmessage 50008
END
EXECUTE sp_addmessage  50008, 16, N'Unable to determine zone_process for zone.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50009)
BEGIN
   EXECUTE sp_dropmessage 50009
END
EXECUTE sp_addmessage  50009, 16, N'Unable to remove config as it is active.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50010)
BEGIN
   EXECUTE sp_dropmessage 50010
END
EXECUTE sp_addmessage  50010, 16, N'Unable to remove config as unexpected error occurred.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50011)
BEGIN
   EXECUTE sp_dropmessage 50011
END
EXECUTE sp_addmessage  50011, 16, N'Invalid percentage used to remove old transactions.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50012)
BEGIN
   EXECUTE sp_dropmessage 50012
END
EXECUTE sp_addmessage  50012, 16, N'The profile id passed was not a temperature profile.'
GO

IF EXISTS (SELECT * FROM master.dbo.sysmessages where error = 50013)
BEGIN
   EXECUTE sp_dropmessage 50013
END
EXECUTE sp_addmessage  50013, 16, N'The profile passed does not exist.'
GO


--
-- JOB: DTS Database Aging
--
DECLARE @DatabaseName     NVARCHAR(250)
DECLARE @JobName          NVARCHAR(250)

SET @DatabaseName  = N'DTS'
SET @JobName       = @DatabaseName + N' Database Aging'

-- Delete existing job
IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = @JobName)
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = @JobName
END

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name              = @JobName, 
     @enabled               = 0,
     @description           = N'Age the message data as specified by rules',
     @start_step_id         = 1,
     @category_name         = N'Database Maintenance',
     @notify_level_eventlog = 2,
     @delete_level          = 0

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = @JobName,
     @step_id            = 1,
     @step_name          = N'Alarm Retention',
     @subsystem          = N'TSQL',
     @command            = N'EXECUTE sp_ProcessAlarmRetention',
     @database_name      = @DatabaseName,
     @on_success_action  = 3,
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobstep 
     @job_name          = @JobName,
     @step_id           = 2,
     @step_name         = N'Age Retention',
     @subsystem         = N'TSQL',
     @command           = N'EXECUTE sp_ProcessAgeRetention',
     @database_name     = @DatabaseName, 
     @retry_attempts    = 1,
     @retry_interval    = 2

EXEC msdb.dbo.sp_add_jobschedule
     @job_name          = @JobName, 
     @name              = N'ScheduledAging',
     @freq_type         = 4,       -- daily
     @freq_interval     = 1,       -- once per day
     @active_start_time = 020000   -- 2am

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = @JobName, 
     @server_name       = N'(LOCAL)'
GO

--
-- JOB: Backup System Databases
--
DECLARE @MasterDatabaseFile NVARCHAR(250)
DECLARE @RootBackupFile     NVARCHAR(250)
DECLARE @RootBackupCmd      NVARCHAR(500)
DECLARE @JobName            NVARCHAR(250)
DECLARE @MasterBackupCmd    NVARCHAR(500)
DECLARE @MSDBBackupCmd      NVARCHAR(500)
DECLARE @ModelBackupCmd     NVARCHAR(500)

SELECT  @MasterDatabaseFile = filename from master.dbo.sysdatabases WHERE name = 'master'
SET     @RootBackupFile     = Replace(@MasterDatabaseFile, 'Data\master.mdf', 'Backup\Root-FileName.bak')
SET     @RootBackupCmd      = 'BACKUP DATABASE Root-DBName TO DISK="DISKFILE" WITH NOINIT, MEDIANAME = ''Disk Backup Media Set'',NAME = ''Full Backup of Root-Desc'',COMPRESSION'
SET     @RootBackupCmd      = Replace(@RootBackupCmd,'DISKFILE',@RootBackupFile)
SET     @JobName            = N'Backup System Databases'

-- Master database
SET @MasterBackupCmd = Replace(@RootBackupCmd,  'Root-DBName',  'master')
SET @MasterBackupCmd = Replace(@MasterBackupCmd,'Root-FileName','master')
SET @MasterBackupCmd = Replace(@MasterBackupCmd,'Root-Desc',    'master')

-- MSDB Database
SET @MSDBBackupCmd   = Replace(@RootBackupCmd,  'Root-DBName',  'msdb')
SET @MSDBBackupCmd   = Replace(@MSDBBackupCmd,  'Root-FileName','msdb')
SET @MSDBBackupCmd   = Replace(@MSDBBackupCmd,  'Root-Desc',    'msdb')

-- Model Database
SET @ModelBackupCmd  = Replace(@RootBackupCmd,  'Root-DBName',  'model')
SET @ModelBackupCmd  = Replace(@ModelBackupCmd, 'Root-FileName','model')
SET @ModelBackupCmd  = Replace(@ModelBackupCmd, 'Root-Desc',    'model')

-- Delete existing job & related entities
IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = @JobName)
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = @JobName
END

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name              = @JobName, 
     @enabled               = 1,
     @description           = N'Backup of system databases master, msdb & model',
     @start_step_id         = 1,
     @category_name         = N'Database Maintenance',
     @notify_level_eventlog = 2,
     @delete_level          = 0

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = @JobName,
     @step_id            = 1,
     @step_name          = N'Backup Master Database',
     @subsystem          = N'TSQL',
     @command            = @MasterBackupCmd,
     @database_name      = N'master',
     @on_success_action  = 3,
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = @JobName,
     @step_id            = 2,
     @step_name          = N'Backup Msdb Database',
     @subsystem          = N'TSQL',
     @command            = @MSDBBackupCmd,
     @database_name      = N'master',
     @on_success_action  = 3,
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = @JobName,
     @step_id            = 3,
     @step_name          = N'Backup Model Database',
     @subsystem          = N'TSQL',
     @command            = @ModelBackupCmd,
     @database_name      = N'master', 
     @on_success_action  = 1,
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobschedule
     @job_name               = @JobName, 
     @name                   = N'ScheduledSysBackup',
     @freq_type              = 8,       -- weekly
     @freq_interval          = 1,       -- Sunday
     @freq_recurrence_factor = 1,       -- every week
     @active_start_time      = 140000   -- 2pm

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = @JobName, 
     @server_name       = N'(LOCAL)'
GO


--
-- JOB: Backup DTS
--

-- Delete existing job & related entities
IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'Backup DTS')
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = 'Backup DTS'
END
GO

-- Set command based on location of database
DECLARE @DatabaseFile VARCHAR(250)
DECLARE @BackupFile   VARCHAR(250)
DECLARE @BackupCmd    VARCHAR(500)

SELECT  @DatabaseFile  = filename from master.dbo.sysdatabases WHERE name = 'DTS'
SET     @BackupFile    = Replace(@DatabaseFile, 'Data\DTS_Data.mdf', 'Backup\DTS.bak')
SET     @BackupCmd     = 'BACKUP DATABASE DTS TO DISK="DISKFILE" WITH NOINIT, MEDIANAME = ''Disk Backup Media Set'',NAME = ''Full Backup of DTS'',COMPRESSION'
SET     @BackupCmd     = Replace(@BackupCmd,'DISKFILE',@BackupFile)

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name              = 'Backup DTS', 
     @enabled               = 1,
     @description           = 'Backup of application database DTS',
     @start_step_id         = 1,
     @category_name         = 'Database Maintenance',
     @notify_level_eventlog = 2,
     @delete_level          = 0

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = 'Backup DTS',
     @step_id            = 1,
     @step_name          = 'Backup DTS Database',
     @subsystem          = 'TSQL',
     @command            = @BackupCmd,
     @database_name      = 'master',
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobschedule
     @job_name               = 'Backup DTS', 
     @name                   = 'ScheduledAppBackup',
     @freq_type              = 8,       -- weekly
     @freq_interval          = 64,      -- Saturday
     @freq_recurrence_factor = 1,       -- every week
     @active_start_time      = 113000   -- 11.30am

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = 'Backup DTS', 
     @server_name       = N'(LOCAL)'
GO


--
-- JOB: Maintain DTS
--

-- Delete existing job & related entities
IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'Maintain DTS')
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = 'Maintain DTS'
END
GO

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name              = 'Maintain DTS', 
     @enabled               = 1,
     @description           = 'Invoke maintenance tasks on DTS database',
     @start_step_id         = 1,
     @category_name         = 'Database Maintenance',
     @notify_level_eventlog = 2,
     @delete_level          = 0

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = 'Maintain DTS',
     @step_id            = 1,
     @step_name          = 'Check DTS Database',
     @subsystem          = 'TSQL',
     @command            = 'DBCC CHECKDB(DTS)',
     @database_name      = 'master',
     @on_success_action  = 3,
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = 'Maintain DTS',
     @step_id            = 2,
     @step_name          = 'Shrink Database DTS',
     @subsystem          = 'TSQL',
     @command            = 'DBCC SHRINKDATABASE (DTS, 2)',
     @database_name      = 'master',
     @on_success_action  = 1,
     @retry_attempts     = 1,
     @retry_interval     = 2
     
EXEC msdb.dbo.sp_add_jobschedule
     @job_name               = 'Maintain DTS', 
     @name                   = 'ScheduledAppCheck',
     @freq_type              = 8,       -- weekly
     @freq_interval          = 32,      -- Friday
     @freq_recurrence_factor = 1,       -- every week
     @active_start_time      = 200000   -- 8pm

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = 'Maintain DTS', 
     @server_name       = N'(LOCAL)'
GO


--
-- JOB: DTS Database Archiving
--
DECLARE @DatabaseName     NVARCHAR(250)
DECLARE @JobName          NVARCHAR(250)
DECLARE @ShrinkCmd        NVARCHAR(250)
DECLARE @DisableAlertCmd  NVARCHAR(250)
DECLARE @EnableAlertCmd   NVARCHAR(250)

SET @DatabaseName    = N'DTS'
SET @JobName         = @DatabaseName + N' Database Archiving'
SET @ShrinkCmd       = N'DBCC SHRINKDATABASE (' + @DatabaseName +N', 2)'
SET @DisableAlertCmd = N'EXECUTE sp_update_alert @name = ''' + @DatabaseName + N' Size near Maximum'', @enabled = 0'
SET @EnableAlertCmd  = N'EXECUTE sp_update_alert @name = ''' + @DatabaseName + N' Size near Maximum'', @enabled = 1'

-- Delete existing job
IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = @JobName)
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = @JobName
END

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name              = @JobName, 
     @enabled               = 1,
     @description           = N'Archive the database',
     @start_step_id         = 1,
     @category_name         = N'Database Maintenance',
     @notify_level_eventlog = 2,
     @delete_level          = 0

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = @JobName,
     @step_id            = 1,
     @step_name          = N'Disable alert which schedules this job',
     @subsystem          = N'TSQL',
     @command            = @DisableAlertCmd,
     @database_name      = N'msdb',
     @on_success_action  = 3,
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = @JobName,
     @step_id            = 2,
     @step_name          = N'Transfer Old Messages to Archive',
     @subsystem          = N'TSQL',
     @command            = N'EXECUTE sp_ProcessTransfer',
     @database_name      = @DatabaseName,
     @on_success_action  = 3,
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = @JobName,
     @step_id            = 3,
     @step_name          = N'Shrink Database',
     @subsystem          = N'TSQL',
     @command            = @ShrinkCmd,
     @database_name      = N'master',
     @on_success_action  = 3,
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = @JobName,
     @step_id            = 4,
     @step_name          = N'Enable alert which schedules this job',
     @subsystem          = N'TSQL',
     @command            = @EnableAlertCmd,
     @database_name      = N'msdb',
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = @JobName, 
     @server_name       = N'(LOCAL)'
GO



--
-- Alerts
--


--
-- Alert: DTS Database is nearly full
--
DECLARE @DatabaseName  NVARCHAR(250)
DECLARE @JobName       NVARCHAR(250)
DECLARE @AlertName     NVARCHAR(250)
DECLARE @SQLVersion    NVARCHAR(250)
DECLARE @PerfCondition NVARCHAR(250)
DECLARE @PosDesktop    INT

SET @DatabaseName  = N'DTS'
SET @AlertName     = @DatabaseName + N' Size near Maximum'
SET @JobName       = @DatabaseName + N' Database Archiving'
SET @SQLVersion    = UPPER(@@VERSION)
SET @PosDesktop    = CHARINDEX(N'DESKTOP ENGINE',@SQLVersion)
SET @PerfCondition = N'SQLServer:Databases' + N'|Data File(s) Size (KB)|' + @DatabaseName + N'|>|1843200'

-- Delete existing alert
IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = @AlertName))
BEGIN
  EXECUTE msdb.dbo.sp_delete_alert @name = @AlertName 
END

-- Add Alert
EXECUTE msdb.dbo.sp_add_alert @name = @AlertName, @message_id = 0, @severity = 0, @enabled = 1, @delay_between_responses = 60, @performance_condition = @PerfCondition, @include_event_description_in = 5, @job_name = @JobName, @category_name = N'[Uncategorized]'

--
-- Disable archive job & alert if using SQL Server Standard Edition
--
IF (@PosDesktop = 0)
BEGIN
   EXECUTE msdb.dbo.sp_update_job   @job_name = @JobName,    @enabled=0
   EXECUTE msdb.dbo.sp_update_alert @name     = @AlertName,  @enabled=0
END
GO
