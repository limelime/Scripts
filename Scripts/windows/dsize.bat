:: Description: Display current directory size and its subdirectories up to a given level deep.
:: Require: du.exe, sort.exe
:: Version: 1.0

@ECHO OFF

SET DIR_LEVEL=%1

:: Set Default level.
IF [%DIR_LEVEL%]==[] GOTO MISSING_ARGS
GOTO THE_END
:MISSING_ARGS
SET DIR_LEVEL=1
:THE_END

SET Unique=%date%_%time%
SET Unique=%Unique:/=.%
SET Unique=%Unique::=.%
SET Unique=%Unique: =%
SET Unique=%Unique:Mon=%
SET Unique=%Unique:Tue=%
SET Unique=%Unique:Wed=%
SET Unique=%Unique:Thu=%
SET Unique=%Unique:Fri=%
SET Unique=%Unique:Sat=%
SET Unique=%Unique:Sun=%
 

du --max-depth=%DIR_LEVEL% --human-readable | %UnxUpdates%\sort.exe -g -r > dsize_%Unique%.txt

echo Directory sizes(up to %DIR_LEVEL% level deep) are saved in dsize_%Unique%.txt.

SET Unique=&::
