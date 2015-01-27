:: Description: Delete the oldest file of a given path.
:: Author: Xuan Ngo
:: Version: 1.0
:: Usage:
::  delOldest.bat c:\temp

@ECHO OFF
SET FOLDER_PATH=%1

IF [%FOLDER_PATH%]==[] GOTO MISSING_ARGS

FOR /F "delims=" %%W IN ('dir /b/a-d/od %FOLDER_PATH%\*.*') DO (
del /q %FOLDER_PATH%\%%W
echo Deleted %FOLDER_PATH%\%%W. 
EXIT /B 0
)
 
GOTO THE_END
:MISSING_ARGS
echo ERROR: Folder path argument is missing!
echo Example: 
echo         delOldest.bat c:\temp\
 
:THE_END
@REM The end. Do nothing. There should be no other statement.