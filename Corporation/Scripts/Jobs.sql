-- Delete existing job & related entities
DECLARE @JobName      NVARCHAR(128)
SET     @JobName      = N'Backup Corporation'

IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = @JobName)
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = @JobName
END
GO

-- Set command based on location of database
DECLARE @DatabaseFile NVARCHAR(250)
DECLARE @BackupFile   NVARCHAR(250)
DECLARE @BackupCmd    NVARCHAR(500)
DECLARE @JobName      NVARCHAR(128)

SELECT  @DatabaseFile  = filename from master.dbo.sysdatabases WHERE name = N'Corporation'
SET     @BackupFile    = Replace(@DatabaseFile, N'Data\Corporation_Data.mdf', N'Backup\Corporation.bak')

SET     @BackupCmd     = N'BACKUP DATABASE Corporation TO DISK="DISKFILE" WITH NOINIT, MEDIANAME = ''Disk Backup Media Set'',NAME = ''Full Backup of Corporation'',COMPRESSION'
SET     @BackupCmd     = Replace(@BackupCmd,N'DISKFILE',@BackupFile)

SET     @JobName       = N'Backup Corporation'

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name               = @JobName, 
     @enabled                = 1,
     @description            = N'Backup of application database Corporation',
     @start_step_id          = 1,
     @category_name          = N'Database Maintenance',
     @notify_level_eventlog  = 2,
     @delete_level           = 0
GO

EXEC msdb.dbo.sp_add_jobstep 
     @job_name               = @JobName,
     @step_id                = 1,
     @step_name              = N'Backup Corporation Database',
     @subsystem              = N'TSQL',
     @command                = @BackupCmd,
     @database_name          = N'master',
     @retry_attempts         = 1,
     @retry_interval         = 2
GO

EXEC msdb.dbo.sp_add_jobschedule
     @job_name               = @JobName, 
     @name                   = N'ScheduledAppBackup',
     @freq_type              = 8,       -- weekly
     @freq_interval          = 64,      -- Saturday
     @freq_recurrence_factor = 1,       -- every week
     @active_start_time      = 110000   -- 11am
GO

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = @JobName, 
     @server_name       = N'(LOCAL)'
GO