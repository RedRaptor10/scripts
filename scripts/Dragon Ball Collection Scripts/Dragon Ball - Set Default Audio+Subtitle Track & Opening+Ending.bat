:: Dragon Ball - Set Default Audio/Subtitle Track & Opening/Ending
::
:: Description:
:: This script sets the default audio/subtitle track and opening/ending for Dragon Ball when playing in VLC Player.
:: The purpose of this script is to provide a better viewing experience for users who prefer specific audio tracks and openings/endings.
::
:: Requirements:
:: - VLC Media Player
:: - The SoM Dragon Ball Color Corrected release
:: - Files renamed to Plex standards and organized in season folders (ie. Season 01\Dragon Ball - S01E01.mkv)
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

:: Set Audio Tracks (ie. Audio Track 1 = 1) | Note: Audio tracks change after episode 13 (S01E13).
SET audio_track_e1_to_e13=2
SET audio_track_e14_to_e153=2

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

:: Set Start/Stop Times [HH:mm:ss] | Note: In the Dragon Ball SoM release, Start Time = 00:01:48, End Time = 00:22:32
SET start_time=00:01:49
SET stop_time=00:22:31

:: Set Opening/Ending Paths
SET opening_1=M:\Extras\Dragon Ball\English OPs, EDs, Promos\BLT Dub OP [DVD].mkv
SET opening_2=M:\Extras\Dragon Ball\English OPs, EDs, Promos\Harmony Gold Dub OP [Tom_Servo].mkv
SET ending_1=M:\Extras\Dragon Ball\English OPs, EDs, Promos\BLT Dub ED [DVD].mkv
SET ending_2=M:\Extras\Dragon Ball\English OPs, EDs, Promos\Harmony Gold Dub ED [Tom_Servo].mkv

:: Set Season Openings
SET season_1_opening=%opening_1%
SET season_2_opening=%opening_1%
SET season_3_opening=%opening_1%
SET season_4_opening=%opening_1%
SET season_5_opening=%opening_1%
SET season_6_opening=%opening_1%
SET season_7_opening=%opening_1%
SET season_8_opening=%opening_1%
SET season_9_opening=%opening_1%

:: Set Season Endings
SET season_1_ending=%ending_1%
SET season_2_ending=%ending_1%
SET season_3_ending=%ending_1%
SET season_4_ending=%ending_1%
SET season_5_ending=%ending_1%
SET season_6_ending=%ending_1%
SET season_7_ending=%ending_1%
SET season_8_ending=%ending_1%
SET season_9_ending=%ending_1%

:: Set Toonami Openings
SET toonami_opening_1=M:\Extras\Dragon Ball\English OPs, EDs, Promos\Toonami USA OP1.mkv
SET toonami_opening_2=M:\Extras\Dragon Ball\English OPs, EDs, Promos\Toonami USA OP2.mkv
SET toonami_opening_3=M:\Extras\Dragon Ball\English OPs, EDs, Promos\Toonami USA Promo 1.mkv
SET toonami_opening_4=M:\Extras\Dragon Ball\English OPs, EDs, Promos\Toonami USA Short Promo.mp4
SET toonami_opening_5=M:\Extras\Dragon Ball\English OPs, EDs, Promos\Toonami USA Promo 3.mkv

:: Set Toonami Season Openings | Note: Seasons with multiple openings will play one opening at random.
SET toonami_season_1_opening_1=%toonami_opening_1%
SET toonami_season_1_opening_2=%toonami_opening_2%
SET toonami_season_1_opening_3=%toonami_opening_3%
SET toonami_season_1_opening_4=%toonami_opening_4%
SET toonami_season_1_opening_5=%toonami_opening_5%
SET toonami_season_2_opening_1=%toonami_opening_1%
SET toonami_season_2_opening_2=%toonami_opening_2%
SET toonami_season_2_opening_3=%toonami_opening_3%
SET toonami_season_2_opening_4=%toonami_opening_4%
SET toonami_season_2_opening_5=%toonami_opening_5%
SET toonami_season_3_opening_1=%toonami_opening_1%
SET toonami_season_3_opening_2=%toonami_opening_2%
SET toonami_season_3_opening_3=%toonami_opening_3%
SET toonami_season_3_opening_4=%toonami_opening_4%
SET toonami_season_3_opening_5=%toonami_opening_5%
SET toonami_season_4_opening_1=%toonami_opening_1%
SET toonami_season_4_opening_2=%toonami_opening_2%
SET toonami_season_4_opening_3=%toonami_opening_3%
SET toonami_season_4_opening_4=%toonami_opening_4%
SET toonami_season_4_opening_5=%toonami_opening_5%
SET toonami_season_5_opening_1=%toonami_opening_1%
SET toonami_season_5_opening_2=%toonami_opening_2%
SET toonami_season_5_opening_3=%toonami_opening_3%
SET toonami_season_5_opening_4=%toonami_opening_4%
SET toonami_season_5_opening_5=%toonami_opening_5%
SET toonami_season_6_opening_1=%toonami_opening_1%
SET toonami_season_6_opening_2=%toonami_opening_2%
SET toonami_season_6_opening_3=%toonami_opening_3%
SET toonami_season_6_opening_4=%toonami_opening_4%
SET toonami_season_6_opening_5=%toonami_opening_5%
SET toonami_season_7_opening_1=%toonami_opening_1%
SET toonami_season_7_opening_2=%toonami_opening_2%
SET toonami_season_7_opening_3=%toonami_opening_3%
SET toonami_season_7_opening_4=%toonami_opening_4%
SET toonami_season_7_opening_5=%toonami_opening_5%
SET toonami_season_8_opening_1=%toonami_opening_1%
SET toonami_season_8_opening_2=%toonami_opening_2%
SET toonami_season_8_opening_3=%toonami_opening_3%
SET toonami_season_8_opening_4=%toonami_opening_4%
SET toonami_season_8_opening_5=%toonami_opening_5%
SET toonami_season_9_opening_1=%toonami_opening_1%
SET toonami_season_9_opening_2=%toonami_opening_2%
SET toonami_season_9_opening_3=%toonami_opening_3%
SET toonami_season_9_opening_4=%toonami_opening_4%
SET toonami_season_9_opening_5=%toonami_opening_5%

:: --------------------
:: DO NOT MODIFY BELOW
:: --------------------

SET videos=%*
SET audio_track=%audio_track_e14_to_e153%
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

	:: Set Audio Track by Season
	ECHO.!video! | findstr /C:"Season 01">nul && SET audio_track=!audio_track_e1_to_e13!

	:: Set Opening by Season
	IF %use_custom_opening% == true IF %skip_opening% == false (
		ECHO.!video! | findstr /C:"Season 01">nul && SET opening=!season_1_opening!
		ECHO.!video! | findstr /C:"Season 02">nul && SET opening=!season_2_opening!
		ECHO.!video! | findstr /C:"Season 03">nul && SET opening=!season_3_opening!
		ECHO.!video! | findstr /C:"Season 04">nul && SET opening=!season_4_opening!
		ECHO.!video! | findstr /C:"Season 05">nul && SET opening=!season_5_opening!
		ECHO.!video! | findstr /C:"Season 06">nul && SET opening=!season_6_opening!
		ECHO.!video! | findstr /C:"Season 07">nul && SET opening=!season_7_opening!
		ECHO.!video! | findstr /C:"Season 08">nul && SET opening=!season_8_opening!
		ECHO.!video! | findstr /C:"Season 09">nul && SET opening=!season_9_opening!
	)

	:: Set Ending by Season
	IF %use_custom_ending% == true IF %skip_ending% == false (
		ECHO.!video! | findstr /C:"Season 01">nul && SET ending=!season_1_ending!
		ECHO.!video! | findstr /C:"Season 02">nul && SET ending=!season_2_ending!
		ECHO.!video! | findstr /C:"Season 03">nul && SET ending=!season_3_ending!
		ECHO.!video! | findstr /C:"Season 04">nul && SET ending=!season_4_ending!
		ECHO.!video! | findstr /C:"Season 05">nul && SET ending=!season_5_ending!
		ECHO.!video! | findstr /C:"Season 06">nul && SET ending=!season_6_ending!
		ECHO.!video! | findstr /C:"Season 07">nul && SET ending=!season_7_ending!
		ECHO.!video! | findstr /C:"Season 08">nul && SET ending=!season_8_ending!
		ECHO.!video! | findstr /C:"Season 09">nul && SET ending=!season_9_ending!
	)

	:: Set Toonami Opening by Season | TODO: Improve randomization
	IF %use_toonami_opening% == true (
		ECHO.!video! | findstr /C:"Season 01">nul && (
			:: Random number between 1 and 5
			SET /A num=!RANDOM! %% 5 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_1_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_1_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_1_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_1_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_1_opening_5!
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
			:: Random number between 1 and 5
			SET /A num=!RANDOM! %% 5 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_3_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_3_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_3_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_3_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_3_opening_5!
		)
		ECHO.!video! | findstr /C:"Season 04">nul && (
			:: Random number between 1 and 5
			SET /A num=!RANDOM! %% 5 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_4_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_4_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_4_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_4_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_4_opening_5!
		)
		ECHO.!video! | findstr /C:"Season 05">nul && (
			:: Random number between 1 and 5
			SET /A num=!RANDOM! %% 5 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_5_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_5_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_5_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_5_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_5_opening_5!
		)
		ECHO.!video! | findstr /C:"Season 06">nul && (
			:: Random number between 1 and 5
			SET /A num=!RANDOM! %% 5 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_6_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_6_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_6_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_6_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_6_opening_5!
		)
		ECHO.!video! | findstr /C:"Season 07">nul && (
			:: Random number between 1 and 5
			SET /A num=!RANDOM! %% 5 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_7_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_7_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_7_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_7_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_7_opening_5!
		)
		ECHO.!video! | findstr /C:"Season 08">nul && (
			:: Random number between 1 and 5
			SET /A num=!RANDOM! %% 5 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_8_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_8_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_8_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_8_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_8_opening_5!
		)
		ECHO.!video! | findstr /C:"Season 09">nul && (
			:: Random number between 1 and 5
			SET /A num=!RANDOM! %% 5 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_9_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_9_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_9_opening_3!
			IF !num! == 4 SET toonami_opening=!toonami_season_9_opening_4!
			IF !num! == 5 SET toonami_opening=!toonami_season_9_opening_5!
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
