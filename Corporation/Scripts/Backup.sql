-- Write your own SQL object definition here, and it'll be included in your package.
DECLARE @DatabaseFile VARCHAR(250)
DECLARE @BackupFile   VARCHAR(250)

SELECT  @DatabaseFile  = filename from master.dbo.sysdatabases WHERE name = 'Corporation'
SET     @BackupFile    = Replace(@DatabaseFile, 'Data\Corporation_Data.mdf', 'Backup\Corporation.bak')

BACKUP DATABASE Corporation
TO DISK = @BackupFile
   WITH
   FORMAT,
   MEDIANAME = 'Disk Backup Media Set',
   NAME      = 'Full Backup of Corporation',
   COMPRESSION;
GO