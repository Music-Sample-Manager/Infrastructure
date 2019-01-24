-- ===== Configure user accounts =====
IF NOT EXISTS(SELECT 1
FROM sys.database_principals
WHERE [name] = 'daniel.neel@musicsamplemanager.org')
BEGIN
	CREATE USER [daniel.neel@musicsamplemanager.org] FROM EXTERNAL PROVIDER
END

IF NOT EXISTS(SELECT 1
FROM sys.database_principals
WHERE [name] = 'MusicSampleManager Database - Application Account')
BEGIN
	CREATE USER [MusicSampleManager Database - Application Account] FROM EXTERNAL PROVIDER
END

EXEC sp_addrolemember 'db_datareader', 'MusicSampleManager Database - Application Account'
EXEC sp_addrolemember 'db_datawriter', 'MusicSampleManager Database - Application Account'