:: Description: Delete the oldest file of a given path.
:: Author: Xuan Ngo
:: Version: 1.0

@ECHO OFF
SET FOLDER_PATH=%1

IF [%FOLDER_PATH%]==[] GOTO MISSING_ARGS

FOR /F "delims=" %%W IN ('dir /s/b/od %FOLDER_PATH%\*.rar') DO (
del /q %%W
EXIT /B 0
)
 
GOTO THE_END
:MISSING_ARGS
echo ERROR: FOLDER_PATH argument is missing! Supply FOLDER_PATH argument to the batch file.
 
:THE_END
@REM The end. Do nothing. There should be no other statement.