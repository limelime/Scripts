:: Description: Display current directory size and its subdirectories up to 4 level deep.
:: Require: du.exe, sort.exe
:: Version: 1.0

@ECHO OFF

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
 

du --max-depth=%1 --human-readable | %UnxUpdates%\sort.exe -g -r > dsize_%Unique%.txt

SET Unique=&::
