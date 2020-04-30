@echo off
setlocal EnableExtensions EnableDelayedExpansion
REM Shadow Copy Disk, without \
	Set "VSV=D:"

REM Folders to backup from VSV disk. To backup all disk, just write \
	Set "DIRSOURCE[0]=\mimportant_data\"
	Set "DIRSOURCE[1]=\pictures_of_my_cat\"

REM Target folder
	Set "DIRDEST=\\backup-nas\"

REM Extension to backup, write *.* to backup all
	Set "EXT=*.db"

REM Shortcut name to access the Shadow Copy
    Set "Shortc=shadowcopy"

REM Delete or not the Shadow Copy
    Set "DELBCK=TRUE"

REM Number of backup to keep. Will create folder 1, 2, 3, 4 ... (no 0 folder) newest is 1, oldest is 4
    Set NBRBACKUP=3

REM Multithread for ROBOCOPY
    Set MTNB=8

REM Don't change X, don't touch, just look.
    set "x=0"

echo ===============================
echo = SCRIPT MADE BY orugari      =
echo = email: orugari@hotmail.com  =
echo = http://orugari.fr           =
echo =                             =
echo ===============================
echo.
echo = Starting                =====
echo Creating Shadow volume....

REM Moving to Hard drive
%VSV%
REM Creation of the shadow copy
vssadmin create shadow /for=%VSV%

REM Creation of the shortcut to access shadow volume
echo Shadow volume created... Making Shortcut.
for /f "tokens=2 delims=?" %%I in ('vssadmin list shadows ^| find "GLOBALROOT"') do (
    call Set "target=\\?%%I\"
)
mklink /d %VSV%\%Shortc% %target%

REM Oldest folder will be delete, then a new folder will be created.
FOR /L %%i IN (%NBRBACKUP%,-1,1) DO (
    IF EXIST %DIRDEST%%%i (
        IF %DIRDEST%%%i == %DIRDEST%%NBRBACKUP% (
            REM Deleting older folder
            rmdir "%DIRDEST%%NBRBACKUP%" /s /q
            echo Folder %DIRDEST%%NBRBACKUP% has been deleted
            echo.
        ) ELSE (
            REM Changin folder name to let newer folder to be created
            call Set "curdir=%%i"
            call Set /a newdir=curdir+1
            rename "%DIRDEST%!curdir!" "!newdir!"
            echo Folder %DIRDEST%!curdir! has been rename into !newdir!
            echo.
        )
    ) ELSE (
        REM Creation of all backup folder
        md "%DIRDEST%%%i"
        echo Folder %DIRDEST%%%i has been created
    )
)
echo. 
echo Starting copy ...
echo. 
REM Loop to check all directories given
:SymLoop
IF defined DIRSOURCE[%x%] (
    call Set "tmpdir=%%DIRSOURCE[!x!]%%"
    call echo Checking !tmpdir! ...
    call echo.
    call echo.

    REM Check if source directory exist
    IF EXIST !tmpdir! (
        echo.
        echo !tmpdir! exist ... 
        echo.

        REM Creation of the target dir in the newest backup folder (1)
        echo Creating target folder in the folder 1 ...
        IF NOT EXIST "%DIRDEST%1!tmpdir!" mkdir "%DIRDEST%1!tmpdir!"
        echo.
        echo Starting to copy ...
        ROBOCOPY %VSV%\%Shortc%\!tmpdir! %DIRDEST%1!tmpdir! %EXT% /S /E /MT:%MTNB%

    ) ELSE (
        echo Warning, the folder !tmpdir! does not exist !
        REM GOTO:eof
    )
    set /a "x+=1"
    GOTO :SymLoop
)
IF %DELBCK% == "TRUE" (
    echo Deleting Shadow Copy ... 
    vssadmin delete shadows /for=%VSV% /all /quiet
    echo Deleting Shortcut ... 
    rmdir %VSV%\%Shortc%
)

echo.
echo = Well done, everything is over !  =====
