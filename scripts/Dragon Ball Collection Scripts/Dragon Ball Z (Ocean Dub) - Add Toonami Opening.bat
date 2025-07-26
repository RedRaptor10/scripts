:: Dragon Ball Z (Ocean Dub) - Add Toonami Opening
::
:: Description:
:: This script adds the Toonami opening for Dragon Ball Z (Ocean Dub) when playing in VLC Player.
:: The purpose of this script is to provide a better viewing experience for users.
::
:: Requirements:
:: - VLC Media Player
:: - The Dragon Ball Z Ocean Dub
:: - Files renamed to Plex standards and organized in season folders (ie. Season 01\Dragon Ball Z (Ocean Dub) - S01E01.mkv)
::
:: Instructions:
:: Configure settings below, then drag the episode file(s) onto this batch file.

@ECHO OFF
:: --------------------
:: Configuration
:: --------------------

:: Set VLC Media Player Path
SET vlc=C:\Program Files\VideoLAN\VLC\vlc.exe

:: Set Fullscreen [true|false]
SET fullscreen=true

:: Use Toonami Opening [true|false]
SET use_toonami_opening=true

:: Set Toonami Openings
SET toonami_opening_1=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP01 - Moltar 1 [YT].mp4
SET toonami_opening_2=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP02 - Moltar 2 [RetroCCN].mkv
SET toonami_opening_3=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP03 - Tom 1 [RetroCCN].mkv
SET toonami_opening_4=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP04 - Tom S3 [Arian].mkv
SET toonami_opening_5=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP05 - Tom Rising Sun [Arian].mkv
SET toonami_opening_6=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP06 - Tom S4 [Arian].mkv
SET toonami_opening_7=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP07 - Tom S5 [YT].mkv
SET toonami_opening_8=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP08 - Tom S1-S2 Rerun [YT].mp4
SET toonami_opening_9=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP09 - Tom S6 [TC].mkv
SET toonami_opening_10=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP10 - Tom S7 [RetroCCN].mkv
SET toonami_opening_11=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP11 - Tom S3 Rerun [ToonamiRecording].mkv
SET toonami_opening_12=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP12 - Tom S4 Rerun [ToonamiRecording].mkv
SET toonami_opening_13=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami USA OP13 - Tom UUE [YT].mp4
SET toonami_opening_14=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\Toonami Kid Buu 30 sec Promo.mkv
SET arrival_opening=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\DBZ Pioneer Arrival Intro.mkv

:: Set Toonami Season Openings | Note: Seasons with multiple openings will play one opening at random.
SET toonami_season_1_opening_1=%toonami_opening_2%
SET toonami_season_1_opening_2=%toonami_opening_8%
SET toonami_season_1_opening_3=%toonami_opening_13%
SET toonami_season_1_opening_4=%arrival_opening%
SET toonami_season_2_opening_1=%toonami_opening_1%
SET toonami_season_2_opening_2=%toonami_opening_3%
SET toonami_season_2_opening_3=%toonami_opening_8%

:: --------------------
:: DO NOT MODIFY BELOW
:: --------------------

SET videos=%*
SET toonami_opening=%arrival_opening%
SET fullscreen_arg=
IF %fullscreen% == true SET "fullscreen_arg=--fullscreen"

:: Set VLC Media Player arguments
SET args=
FOR /f "delims=" %%a IN ('cmd /c ^"FOR %%i IN ^(%videos%^) DO @ECHO %%~i^"^|sort') DO (
	SET video="%%a"

	SETLOCAL EnableDelayedExpansion

	:: Set Toonami Opening by Season | TODO: Improve randomization
	IF %use_toonami_opening% == true (
		ECHO.!video! | findstr /C:"Season 01">nul && (
			:: Random number between 1 and 4
			SET /A num=!RANDOM! %% 4 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_1_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_1_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_1_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_1_opening_4!
		)
		ECHO.!video! | findstr /C:"Season 02">nul && (
			:: Random number between 1 and 3
			SET /A num=!RANDOM! %% 3 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_2_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_2_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_2_opening_3!
		)
		ECHO.!video! | findstr /C:"Specials">nul && (
			:: Random number between 1 and 7
			SET /A num=!RANDOM! %% 7 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_1_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_1_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_1_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_1_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_2_opening_1!
			IF !num! == 6 SET toonami_opening=!toonami_season_2_opening_2!
			IF !num! == 7 SET toonami_opening=!toonami_season_2_opening_3!
		)
	)

	:: Create and append arguments
	IF %use_toonami_opening% == true (
		SET args=!args! "!toonami_opening!" !video!
	)
	IF %use_toonami_opening% == false (
		SET args=!args! !video!
	)
)

:: Start VLC Media Player
"%vlc%" %fullscreen_arg% !args! --play-and-exit

ENDLOCAL
