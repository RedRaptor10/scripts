:: Dragon Ball Z - Set Default Audio/Subtitle Track & Opening/Ending
::
:: Description:
:: This script sets the default audio/subtitle track and opening/ending for Dragon Ball Z when playing in VLC Player.
:: The purpose of this script is to provide a better viewing experience for users who prefer specific audio tracks and openings/endings.
::
:: Requirements:
:: - VLC Media Player
:: - The iKaos/SoM Dragon Ball Z v3 release
:: - Files renamed to Plex standards and organized in season folders (ie. Season 01\Dragon Ball Z - S01E01.mkv)
::
:: Instructions:
:: Configure settings below, then drag the episode file(s) onto this batch file.
::
:: Notes:
:: - This script assumes all episodes have the same audio/subtitles tracks and their opening/ending start at the same time.
:: - English Opening 3 actually starts on episode 200 (S07E06), but to keep it simple I set it to start on episode 195 (S07E01).
:: - This script can also work for other releases or shows, but the script would have to be modified.

@ECHO OFF
:: --------------------
:: Configuration
:: --------------------

:: Set VLC Media Player Path
SET vlc=C:\Program Files\VideoLAN\VLC\vlc.exe

:: Set Fullscreen [true|false]
SET fullscreen=true

:: Set Audio Tracks (ie. Audio Track 1 = 1) | Note: Audio tracks change after episode 67 (S02E28).
SET audio_track_e1_to_e67=4
SET audio_track_e68_to_e291=4

:: Set Subtitle Track (ie. Sub Track 1 = 1)
SET sub_track_e1_to_e67=3
SET sub_track_e68_to_e291=4

:: Use Custom Opening/Ending [true|false]
SET use_custom_opening_ending=true

:: Use Toonami Opening [true|false]
SET use_toonami_opening=false

:: Skip Opening/Ending [true|false] | Note: This overrides the custom opening/ending and Toonami opening
SET skip_opening_ending=false

:: Set Start/Stop Times [HH:mm:ss] | Note: In the Dragon Ball Z iKaos/SoM release, Start Time = 00:01:49, End Time = 00:22:32
SET start_time=00:01:50
SET stop_time=00:22:31

:: Set Opening/Ending Paths
SET opening_1=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\FUNi DBZ OP1 (1-107).mkv
SET opening_2=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\FUNi DBZ OP2 (108-199).mkv
SET opening_3=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\FUNi DBZ OP3 (200-291).mkv
SET ending_1=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\FUNi DBZ ED1 (1-107).mkv
SET ending_2=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\FUNi DBZ ED2 (108-199).mkv
SET ending_3=M:\Extras\Dragon Ball Z\English OPs, EDs, Promos\FUNi DBZ ED3 (200-291).mkv

:: Set Season Openings
SET season_1_opening=%opening_1%
SET season_2_opening=%opening_1%
SET season_3_opening=%opening_1%
SET season_4_opening=%opening_2%
SET season_5_opening=%opening_2%
SET season_6_opening=%opening_2%
SET season_7_opening=%opening_3%
SET season_8_opening=%opening_3%
SET season_9_opening=%opening_3%

:: Set Season Endings
SET season_1_ending=%ending_1%
SET season_2_ending=%ending_1%
SET season_3_ending=%ending_1%
SET season_4_ending=%ending_2%
SET season_5_ending=%ending_2%
SET season_6_ending=%ending_2%
SET season_7_ending=%ending_3%
SET season_8_ending=%ending_3%
SET season_9_ending=%ending_3%

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
SET toonami_season_3_opening_1=%toonami_opening_4%
SET toonami_season_3_opening_2=%toonami_opening_11%
SET toonami_season_4_opening_1=%toonami_opening_5%
SET toonami_season_4_opening_2=%toonami_opening_6%
SET toonami_season_4_opening_3=%toonami_opening_12%
SET toonami_season_5_opening=%toonami_opening_7%
SET toonami_season_6_opening=%toonami_opening_9%
SET toonami_season_7_opening=%toonami_opening_10%
SET toonami_season_8_opening=%toonami_opening_14%
SET toonami_season_9_opening=%toonami_opening_14%

:: --------------------
:: DO NOT MODIFY BELOW
:: --------------------

SET videos=%*
SET audio_track=%audio_track_e68_to_e291%
SET sub_track=%sub_track_e68_to_e291%
SET opening=%opening_1%
SET ending=%ending_1%
SET toonami_opening=%arrival_opening%
SET fullscreen_arg=
IF "%fullscreen%" == "true" SET "fullscreen_arg=--fullscreen"

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

	:: Set Audio Track by Episode
	ECHO.!video! | findstr /C:"Season 01">nul && SET audio_track=!audio_track_e1_to_e67!
	ECHO.!video! | findstr /C:"Season 02">nul && SET audio_track=!audio_track_e1_to_e67!
	ECHO.!video! | findstr /C:"S02E29">nul && SET audio_track=!audio_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E30">nul && SET audio_track=!audio_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E31">nul && SET audio_track=!audio_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E32">nul && SET audio_track=!audio_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E33">nul && SET audio_track=!audio_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E34">nul && SET audio_track=!audio_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E35">nul && SET audio_track=!audio_track_e68_to_e291!

	:: Set Subtitle Track by Episode
	ECHO.!video! | findstr /C:"Season 01">nul && SET sub_track=!sub_track_e1_to_e67!
	ECHO.!video! | findstr /C:"Season 02">nul && SET sub_track=!sub_track_e1_to_e67!
	ECHO.!video! | findstr /C:"S02E29">nul && SET sub_track=!sub_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E30">nul && SET sub_track=!sub_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E31">nul && SET sub_track=!sub_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E32">nul && SET sub_track=!sub_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E33">nul && SET sub_track=!sub_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E34">nul && SET sub_track=!sub_track_e68_to_e291!
	ECHO.!video! | findstr /C:"S02E35">nul && SET sub_track=!sub_track_e68_to_e291!

	:: Set Opening by Season
	IF "%use_custom_opening_ending%" == "true" (
		ECHO.!video! | findstr /C:"Season 01">nul && SET opening=!season_1_opening!
		ECHO.!video! | findstr /C:"Season 02">nul && SET opening=!season_2_opening!
		ECHO.!video! | findstr /C:"Season 03">nul && SET opening=!season_3_opening!
		ECHO.!video! | findstr /C:"Season 04">nul && SET opening=!season_4_opening!
		ECHO.!video! | findstr /C:"Season 05">nul && SET opening=!season_5_opening!
		ECHO.!video! | findstr /C:"Season 06">nul && SET opening=!season_6_opening!
		ECHO.!video! | findstr /C:"Season 07">nul && SET opening=!season_7_opening!
		ECHO.!video! | findstr /C:"Season 08">nul && SET opening=!season_8_opening!
		ECHO.!video! | findstr /C:"Season 09">nul && SET opening=!season_9_opening!

		:: Set Ending by Season
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
	IF "%use_toonami_opening%" == "true" (
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
		ECHO.!video! | findstr /C:"Season 03">nul && (
			:: Random number between 1 and 2
			SET /A num=!RANDOM! %% 2 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_3_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_3_opening_2!
		)
		ECHO.!video! | findstr /C:"Season 04">nul && (
			:: Random number between 1 and 3
			SET /A num=!RANDOM! %% 3 + 1
			IF !num! == 1 SET toonami_opening=!toonami_season_4_opening_1!
			IF !num! == 2 SET toonami_opening=!toonami_season_4_opening_2!
			IF !num! == 3 SET toonami_opening=!toonami_season_4_opening_3!
		)
		ECHO.!video! | findstr /C:"Season 05">nul && SET toonami_opening=!toonami_season_5_opening!
		ECHO.!video! | findstr /C:"Season 06">nul && SET toonami_opening=!toonami_season_6_opening!
		ECHO.!video! | findstr /C:"Season 07">nul && SET toonami_opening=!toonami_season_7_opening!
		ECHO.!video! | findstr /C:"Season 08">nul && SET toonami_opening=!toonami_season_8_opening!
		ECHO.!video! | findstr /C:"Season 09">nul && SET toonami_opening=!toonami_season_9_opening!
	)

	:: Decrement Audio and Subtitle Tracks as they are zero-based
	SET /A audio_track-=1
	SET /A sub_track-=1

	:: Create and append arguments
	IF "%skip_opening_ending%" == "true" (
		SET args=!args! !video! :audio-track=!audio_track! :sub-track=!sub_track! :start-time=%start_time% :stop-time=%stop_time%
	) ELSE (
		IF "%use_custom_opening_ending%" == "true" IF "%use_toonami_opening%" == "true" (
			SET args=!args! "!toonami_opening!" "!opening!" !video! :audio-track=!audio_track! :sub-track=!sub_track! :start-time=%start_time% :stop-time=%stop_time% "!ending!"
		)
		IF "%use_custom_opening_ending%" == "true" IF "%use_toonami_opening%" == "false" (
			SET args=!args! "!opening!" !video! :audio-track=!audio_track! :sub-track=!sub_track! :start-time=%start_time% :stop-time=%stop_time% "!ending!"
		)
		IF "%use_custom_opening_ending%" == "false" IF "%use_toonami_opening%" == "true" (
			SET args=!args! "!toonami_opening!" !video! :audio-track=!audio_track! :sub-track=!sub_track!
		)
		IF "%use_custom_opening_ending%" == "false" IF "%use_toonami_opening%" == "false" (
			SET args=!args! !video! :audio-track=!audio_track! :sub-track=!sub_track!
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
