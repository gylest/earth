-- Delete existing job & related entities
IF exists (SELECT * FROM msdb.dbo.sysjobs WHERE name = 'Backup RedcoralCommerce')
BEGIN
     EXEC msdb.dbo.sp_delete_job @job_name = 'Backup RedcoralCommerce'
END
GO

-- Set command based on location of database
DECLARE @DatabaseFile VARCHAR(250)
DECLARE @BackupFile   VARCHAR(250)
DECLARE @BackupCmd    VARCHAR(500)

SELECT  @DatabaseFile  = filename from master.dbo.sysdatabases WHERE name = 'RedcoralCommerce'
SET     @BackupFile    = Replace(@DatabaseFile, 'Data\RedcoralCommerce_Data.mdf', 'Backup\RedcoralCommerce.bak')

SET     @BackupCmd  = 'BACKUP DATABASE RedcoralCommerce TO DISK="DISKFILE" WITH NOINIT, MEDIANAME = ''Disk Backup Media Set'',NAME = ''Full Backup of RedcoralCommerce'',COMPRESSION'
SET     @BackupCmd  = Replace(@BackupCmd,'DISKFILE',@BackupFile)

-- Add Job, Job Steps and schedule for execution
EXEC msdb.dbo.sp_add_job 
     @job_name              = 'Backup RedcoralCommerce', 
     @enabled               = 1,
     @description           = 'Backup of application database RedcoralCommerce',
     @start_step_id         = 1,
     @category_name         = 'Database Maintenance',
     @notify_level_eventlog = 2,
     @delete_level          = 0

EXEC msdb.dbo.sp_add_jobstep 
     @job_name           = 'Backup RedcoralCommerce',
     @step_id            = 1,
     @step_name          = 'Backup RedcoralCommerce Database',
     @subsystem          = 'TSQL',
     @command            = @BackupCmd,
     @database_name      = 'master',
     @retry_attempts     = 1,
     @retry_interval     = 2

EXEC msdb.dbo.sp_add_jobschedule
     @job_name               = 'Backup RedcoralCommerce', 
     @name                   = 'ScheduledAppBackup',
     @freq_type              = 8,       -- weekly
     @freq_interval          = 64,      -- Saturday
     @freq_recurrence_factor = 1,       -- every week
     @active_start_time      = 113000   -- 11.30am

EXEC msdb.dbo.sp_add_jobserver 
     @job_name          = 'Backup RedcoralCommerce', 
     @server_name       = N'(LOCAL)'
GO
