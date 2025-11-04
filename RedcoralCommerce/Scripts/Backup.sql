DECLARE @DatabaseFile VARCHAR(250)
DECLARE @BackupFile   VARCHAR(250)

SELECT  @DatabaseFile  = filename from master.dbo.sysdatabases WHERE name = 'RedcoralCommerce'
SET     @BackupFile    = Replace(@DatabaseFile, 'Data\RedcoralCommerce_Data.mdf', 'Backup\RedcoralCommerce.bak')

BACKUP DATABASE RedcoralCommerce
TO DISK = @BackupFile
   WITH
   FORMAT,
   MEDIANAME = 'Disk Backup Media Set',
   NAME      = 'Full Backup of RedcoralCommerce',
   COMPRESSION;
GO
