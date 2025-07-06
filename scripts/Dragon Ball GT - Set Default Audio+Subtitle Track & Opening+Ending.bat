:: Dragon Ball GT - Set Default Audio/Subtitle Track & Opening/Ending
::
:: Description:
:: This script sets the default audio/subtitle track and opening/ending for Dragon Ball GT when playing in VLC Player.
:: The purpose of this script is to provide a better viewing experience for users who prefer specific audio tracks and openings/endings.
::
:: Requirements:
:: - VLC Media Player
:: - The SoM Dragon Ball GT Color Corrected release
:: - Files renamed to Plex standards and organized in season folders (ie. Season 01\Dragon Ball GT - S01E01.mkv)
::
:: Instructions:
:: Configure settings below, then drag the episode file(s) onto this batch file.
::
:: Notes:
:: - This script assumes all episodes have the same audio/subtitles tracks and their opening/ending start at the same time.
:: - This script can also work for other releases or shows, but the script would have to be modified.

@ECHO OFF
:: --------------------
:: Configuration
:: --------------------

:: Set VLC Media Player Path
SET vlc=C:\Program Files\VideoLAN\VLC\vlc.exe

:: Set Fullscreen [true|false]
SET fullscreen=true

:: Set Audio Tracks (ie. Audio Track 1 = 1)
SET audio_track=3

:: Set Subtitle Track (ie. Sub Track 1 = 1)
SET sub_track=4

:: Use Toonami Opening [true|false]
SET use_toonami_opening=true

:: Use Custom Opening/Ending [true|false]
SET use_custom_opening=true
SET use_custom_ending=true

:: Skip Opening/Ending [true|false] | Note: This overrides the custom opening/ending
SET skip_opening=false
SET skip_ending=false

:: Set Start/Stop Times [HH:mm:ss] | Note: In the Dragon Ball GT SoM release, Start Time = 00:01:48, End Time = 00:22:31
SET start_time=00:01:49
SET stop_time=00:22:30

:: Set Opening/Ending Paths
SET opening_1=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\FUNi DBGT OP.mkv
SET ending_1=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\FUNi DBGT ED.mkv

:: Set Season Openings
SET season_1_opening=%opening_1%
SET season_2_opening=%opening_1%
SET season_3_opening=%opening_1%
SET season_4_opening=%opening_1%

:: Set Season Endings
SET season_1_ending=%ending_1%
SET season_2_ending=%ending_1%
SET season_3_ending=%ending_1%
SET season_4_ending=%ending_1%

:: Set Toonami Openings
SET toonami_opening_1=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\Toonami USA OP1.mkv
SET toonami_opening_2=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\Toonami USA OP2.mkv
SET toonami_opening_3=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\Toonami USA OP3 - Lost Episodes.mkv
SET toonami_opening_4=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\Toonami Lost Episodes Promo.mkv
SET toonami_opening_5=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\Toonami S2 Promo.mkv
SET toonami_opening_6=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\Toonami S1 Promo.mp4
SET toonami_opening_7=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\Toonami S2 Short Promo.mp4
SET toonami_opening_8=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\Toonami S3 Promo.mp4
SET toonami_opening_9=M:\Extras\Dragon Ball GT\English OPs, EDs, and Promos\Toonami Lost Episodes Short Promo.mp4

:: Set Toonami Season Openings | Note: Seasons with multiple openings will play one opening at random.
SET toonami_season_1_opening_1=%toonami_opening_1%
SET toonami_season_1_opening_2=%toonami_opening_6%
SET toonami_season_1_opening_3=%toonami_opening_4%
SET toonami_season_1_opening_4=%toonami_opening_9%
SET toonami_season_2_opening_1=%toonami_opening_2%
SET toonami_season_2_opening_2=%toonami_opening_5%
SET toonami_season_2_opening_3=%toonami_opening_7%
SET toonami_season_2_opening_4=%toonami_opening_4%
SET toonami_season_2_opening_5=%toonami_opening_9%
SET toonami_season_3_opening_1=%toonami_opening_3%
SET toonami_season_3_opening_2=%toonami_opening_8%
SET toonami_season_3_opening_3=%toonami_opening_4%
SET toonami_season_3_opening_4=%toonami_opening_9%
SET toonami_season_4_opening_1=%toonami_opening_4%
SET toonami_season_4_opening_2=%toonami_opening_9%

:: --------------------
:: DO NOT MODIFY BELOW
:: --------------------

SET videos=%*
SET audio_track=%audio_track%
SET sub_track=%sub_track%
SET opening=%opening_1%
SET ending=%ending_1%
SET toonami_opening=%toonami_opening_1%
SET fullscreen_arg=
IF %fullscreen% == true SET "fullscreen_arg=--fullscreen"

SETLOCAL EnableDelayedExpansion

:: Convert start_time and stop_time timestamps to seconds
FOR /L %%i IN (1,1,2) DO (
	IF %%i==1 SET timestamp=!start_time!
	IF %%i==2 SET timestamp=!stop_time!

	FOR /F "tokens=1-3 delims=:" %%a IN ("!timestamp!") DO (
		SET HOUR=%%a
		SET MIN=%%b
		SET SEC=%%c
	)

	:: Remove leading zeros
	IF "!HOUR:~0,1!"=="0" SET HOUR=!HOUR:~1!
	IF "!MIN:~0,1!"=="0" SET MIN=!MIN:~1!
	IF "!SEC:~0,1!"=="0" SET SEC=!SEC:~1!

	IF %%i==1 SET /A "start_time = (!HOUR! * 3600) + (!MIN! * 60) + !SEC!"
	IF %%i==2 SET /A "stop_time = (!HOUR! * 3600) + (!MIN! * 60) + !SEC!"
)

:: Disable Delayed Expansion before loop to prevent issues with filenames containing exclamation marks
SETLOCAL DisableDelayedExpansion

:: Set VLC Media Player arguments
SET args=
FOR /f "delims=" %%a IN ('cmd /c ^"FOR %%i IN ^(%videos%^) DO @ECHO %%~i^"^|sort') DO (
	SET video="%%a"

	SETLOCAL EnableDelayedExpansion

	:: Set Opening by Season
	IF %use_custom_opening% == true IF %skip_opening% == false (
		ECHO.!video! | findstr /C:"Season 01">nul && SET opening=!season_1_opening!
		ECHO.!video! | findstr /C:"Season 02">nul && SET opening=!season_2_opening!
		ECHO.!video! | findstr /C:"Season 03">nul && SET opening=!season_3_opening!
		ECHO.!video! | findstr /C:"Season 04">nul && SET opening=!season_4_opening!
	)

	:: Set Ending by Season
	IF %use_custom_ending% == true IF %skip_ending% == false (
		ECHO.!video! | findstr /C:"Season 01">nul && SET ending=!season_1_ending!
		ECHO.!video! | findstr /C:"Season 02">nul && SET ending=!season_2_ending!
		ECHO.!video! | findstr /C:"Season 03">nul && SET ending=!season_3_ending!
		ECHO.!video! | findstr /C:"Season 04">nul && SET ending=!season_4_ending!
	)

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
			:: Random number between 1 and 5
			SET /A num=!RANDOM! %% 5 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_2_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_2_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_2_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_2_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_2_opening_5!
		)
		ECHO.!video! | findstr /C:"Season 03">nul && (
			:: Random number between 1 and 4
			SET /A num=!RANDOM! %% 4 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_3_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_3_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_3_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_3_opening_4!
		)
		ECHO.!video! | findstr /C:"Season 04">nul && (
			:: Random number between 1 and 2
			SET /A num=!RANDOM! %% 2 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_4_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_4_opening_2!
		)
	)

	:: Decrement Audio and Subtitle Tracks as they are zero-based
	SET /A audio_track-=1
	SET /A sub_track-=1

	:: Create and append arguments
	IF %use_toonami_opening% == true (
		SET args=!args! "!toonami_opening!"
	)

	IF NOT %skip_opening% == true (
		IF %use_custom_opening% == true (
			SET args=!args! "!opening!"
		)
	)

	SET args=!args! !video! :audio-track=!audio_track! :sub-track=!sub_track!

	IF %skip_opening% == true (
		SET args=!args! :start-time=%start_time%
	) ELSE (
		IF %use_custom_opening% == true (
			SET args=!args! :start-time=%start_time%
		)
	)

	IF %skip_ending% == true (
		SET args=!args! :stop-time=%stop_time%
	) ELSE (
		IF %use_custom_ending% == true (
			SET args=!args! :stop-time=%stop_time% "!ending!"
		)
	)
)

:: Start VLC Media Player
"%vlc%" %fullscreen_arg% !args! --play-and-exit

:: VLC Media Player - Command Line
:: Usage: vlc [options] [stream] ...
:: Option-styles:
:: --option		A global option that is set for the duration of the program.
::  -option		A single letter version of a global --option.
::  :option		An option that only applies to the stream directly before it and that overrides previous settings.

ENDLOCAL
