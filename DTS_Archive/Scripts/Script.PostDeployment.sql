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

--*************************************************************************************
--  File:        DTS_Archive_Jobs.sql
--  Purpose:     Create Jobs
--  Date:        16th September 2009
--  Version:     SQL Server 2008
--*************************************************************************************


--
-- Jobs
--

--
-- JOB: Backup DTS_Archive
--

-- Delete existing job & related entities
IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'Backup DTS_Archive')
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = 'Backup DTS_Archive'
END
GO

-- Set command based on location of database
DECLARE @DatabaseFile VARCHAR(250)
DECLARE @BackupFile   VARCHAR(250)
DECLARE @BackupCmd    VARCHAR(500)

SELECT  @DatabaseFile  = filename from master.dbo.sysdatabases WHERE name = 'DTS_Archive'
SET     @BackupFile    = Replace(@DatabaseFile, 'Data\DTS_Archive_Data.mdf', 'Backup\DTS_Archive.bak')
SET     @BackupCmd     = 'BACKUP DATABASE DTS_Archive TO DISK="DISKFILE" WITH NOINIT, MEDIANAME = ''Disk Backup Media Set'',NAME = ''Full Backup of DTS_Archive'',COMPRESSION'
SET     @BackupCmd     = Replace(@BackupCmd,'DISKFILE',@BackupFile)

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name              = 'Backup DTS_Archive', 
     @enabled               = 1,
     @description           = 'Backup of application database DTS_Archive',
     @start_step_id         = 1,
     @category_name         = 'Database Maintenance',
     @notify_level_eventlog = 2,
     @delete_level          = 0

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = 'Backup DTS_Archive',
     @step_id            = 1,
     @step_name          = 'Backup DTS_Archive Database',
     @subsystem          = 'TSQL',
     @command            = @BackupCmd,
     @database_name      = 'master',
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobschedule
     @job_name               = 'Backup DTS_Archive', 
     @name                   = 'ScheduledAppBackup',
     @freq_type              = 8,       -- weekly
     @freq_interval          = 64,      -- Saturday
     @freq_recurrence_factor = 1,       -- every week
     @active_start_time      = 113000   -- 11.30am

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = 'Backup DTS_Archive', 
     @server_name       = N'(LOCAL)'
GO

--
-- JOB: DTS_Archive Database Truncation
--
DECLARE @DatabaseName     NVARCHAR(250)
DECLARE @JobName          NVARCHAR(250)
DECLARE @ShrinkCmd        NVARCHAR(250)
DECLARE @DisableAlertCmd  NVARCHAR(250)
DECLARE @EnableAlertCmd   NVARCHAR(250)

SET @DatabaseName    = N'DTS_Archive'
SET @JobName         = @DatabaseName + N' Database Truncation'
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
     @description           = N'Truncate the database',
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
     @step_name          = N'Permanently remove oldest messages',
     @subsystem          = N'TSQL',
     @command            = N'EXECUTE sp_ProcessTruncateDB',
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
-- Alert: DTS_Archive Database is nearly full
--
DECLARE @DatabaseName  NVARCHAR(250)
DECLARE @JobName       NVARCHAR(250)
DECLARE @AlertName     NVARCHAR(250)
DECLARE @PerfCondition NVARCHAR(250)

SET @DatabaseName  = N'DTS_Archive'
SET @AlertName     = @DatabaseName + N' Size near Maximum'
SET @JobName       = @DatabaseName + N' Database Truncation'
SET @PerfCondition = N'SQLServer:Databases' + N'|Data File(s) Size (KB)|' + @DatabaseName + N'|>|1843200'

-- Delete existing alert
IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = @AlertName))
BEGIN
  EXECUTE msdb.dbo.sp_delete_alert @name = @AlertName 
END

-- Add Alert
EXECUTE msdb.dbo.sp_add_alert @name = @AlertName, @message_id = 0, @severity = 0, @enabled = 1, @delay_between_responses = 60, @performance_condition = @PerfCondition, @include_event_description_in = 5, @job_name = @JobName, @category_name = N'[Uncategorized]'
GO

