:: Dragon Ball - Master Script
::
:: Description:
:: Takes an input batch file and runs a target script that plays an episode file with the same name.
:: This provides a "one-click" solution for the Dragon Ball script without having to drag files onto the script.
::
:: Requirements:
:: - Dragon Ball script that sets the default audio+subtitle track and opening/ending
:: - Batch (.bat) files using the same filename and folder structure as the episode files
::
:: 		Example:
:: 		Dragon Ball\Season 01\Dragon Ball - S01E01 - The Secret of the Dragon Balls.mkv
:: 		<some folder>\Season 01\Dragon Ball - S01E01 - The Secret of the Dragon Balls.bat
::
:: - The batch files should run a simple command that calls this master script:
::
:: 		Example:
:: 		"..\..\Dragon Ball - Master Script.bat" "%~n0"
::
:: Instructions:
:: Configure settings below, then open the episode batch file.
::
:: Notes:
:: - This script only works for playing 1 episode at a time. To play multiple episodes, you must drag the files onto the other script.

@ECHO OFF
:: --------------------
:: Configuration
:: --------------------

:: Set Script Path
SET script="M:\Extras\Dragon Ball\Batch Scripts\Dragon Ball - Set Default Audio+Subtitle Track & Opening+Ending.bat"

:: Set Show Folder Path
SET show_folder=M:\TV Shows\Dragon Ball

:: --------------------
:: DO NOT MODIFY BELOW
:: --------------------

SET filename=%~nx1
SET ext=mkv

SETLOCAL

:: Get Season folder name
FOR %%a IN ("%~dp1.") DO SET "season_folder=%%~nxa"

:: Run Script
%script% "%show_folder%\%season_folder%\%filename%.%ext%"

ENDLOCAL