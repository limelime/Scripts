@ECHO OFF
REM Description: Extract/Convert audio stream of a video file into MP3.
REM Author: Xuan Ngo
REM Usage:
REM   extractmp3.bat

REM --------------------------OPTIONS-------------------------------
REM mencoder %1 -of rawaudio -oac mp3lame -ovc copy -o "%~n1".mp3

REM Slow: Convert audio stream to MP3.
REM ffmpeg -i %1  -f mp3 "%~n1".mp3

REM Fast: Dump original audio stream to file.
REM mplayer -dumpaudio %1 -dumpfile "%~n1".mp3
REM ----------------------------------------------------------------
 
FOR /F "delims=" %%W IN ('dir /b *.avi') DO (
CALL :DO_WORK_IN_LOOP "%%W"
)
GOTO :EOF

REM shutdown -s -f -t 0
 
:DO_WORK_IN_LOOP
  ECHO %1 >> elapse.txt
  ECHO %time% >> elapse.txt
  ffmpeg -i %1  -f mp3 "%~n1".mp3
  ECHO %time% >> elapse.txt
  ECHO ------------------------>> elapse.txt
  GOTO :EOF